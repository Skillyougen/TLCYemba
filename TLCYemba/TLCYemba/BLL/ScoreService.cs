// ═══════════════════════════════════════════════════════════════════════
//  TLC YEMBA — PARTIE 4 : Business Logic Layer
//  Fichier  : BLL/ScoreService.cs
//  Namespace: TLC_Yemba.BLL
//  Couche   : BLL — aucun SQL, aucun accès Session/Request
// ═══════════════════════════════════════════════════════════════════════
using System;
using System.Collections.Generic;
using TLC_Yemba.DAL;
using TLC_Yemba.Models;

namespace TLC_Yemba.BLL
{
    /// <summary>
    /// Service de correction et calcul des scores TLC Yemba.
    /// Architecture : UI → ScoreService → ResultatRepository / ReponseRepository
    /// </summary>
    public static class ScoreService
    {
        // ── Grille de conversion : échelle TLC par section ───────────
        private static readonly Dictionary<string, (int min, int max, int total)> Grille
            = new Dictionary<string, (int, int, int)>(StringComparer.OrdinalIgnoreCase)
        {
            { "Listening", (31, 68, 50) },
            { "Structure", (31, 68, 40) },
            { "Reading",   (31, 67, 50) },
        };

        // ── Seuils de niveaux ─────────────────────────────────────────
        private static readonly (int seuil, string niveau)[] Niveaux = {
            (600, "Avancé"),
            (500, "Intermédiaire avancé"),
            (400, "Intermédiaire"),
            (300, "Élémentaire"),
            (  0, "Débutant"),
        };

        // ─────────────────────────────────────────────────────────────
        // CALCULER LE SCORE
        // ─────────────────────────────────────────────────────────────
        /// <summary>
        /// Corrige les réponses, calcule les scores convertis et le niveau.
        /// </summary>
        /// <param name="reponses">Dictionary QuestionID → lettre (A/B/C/D)</param>
        /// <param name="questions">Liste complète des questions avec BonneReponse</param>
        public static ScoreResult CalculerScore(
            Dictionary<int, string> reponses,
            List<Question> questions)
        {
            if (reponses   == null) reponses   = new Dictionary<int, string>();
            if (questions  == null) questions  = new List<Question>();

            int brutL = 0, brutS = 0, brutR = 0;
            int totL  = 0, totS  = 0, totR  = 0;
            var corrections = new List<CorrectionItem>();

            foreach (var q in questions)
            {
                string rep = reponses.ContainsKey(q.QuestionID)
                             ? (reponses[q.QuestionID] ?? "").ToUpper()
                             : "";
                bool ok = !string.IsNullOrEmpty(rep) && rep == q.BonneReponse;

                corrections.Add(new CorrectionItem
                {
                    QuestionID      = q.QuestionID,
                    Section         = q.Section,
                    Enonce          = q.Enonce,
                    ReponseCandidat = rep,
                    BonneReponse    = q.BonneReponse,
                    EstCorrecte     = ok
                });

                switch (q.Section)
                {
                    case "Listening": totL++; if (ok) brutL++; break;
                    case "Structure": totS++; if (ok) brutS++; break;
                    case "Reading":   totR++; if (ok) brutR++; break;
                }
            }

            int? sL = totL > 0 ? ConvertirGrilleTLC(brutL, "Listening", totL) : (int?)null;
            int? sS = totS > 0 ? ConvertirGrilleTLC(brutS, "Structure",  totS) : (int?)null;
            int? sR = totR > 0 ? ConvertirGrilleTLC(brutR, "Reading",    totR) : (int?)null;
            int  total = (sL ?? 0) + (sS ?? 0) + (sR ?? 0);

            return new ScoreResult
            {
                ScoreListening       = sL,
                ScoreStructure       = sS,
                ScoreReading         = sR,
                ScoreTotal           = total,
                Niveau               = DeterminerNiveau(total),
                BrutListening        = brutL,
                BrutStructure        = brutS,
                BrutReading          = brutR,
                TotalQuestions       = questions.Count,
                CorrectionDetaillee  = corrections
            };
        }

        // ─────────────────────────────────────────────────────────────
        // CONVERSION GRILLE TLC
        // ─────────────────────────────────────────────────────────────
        /// <summary>
        /// Convertit un score brut en score échelonné TLC.
        /// Formule : min + Round((brut / totalReel) * (max - min))
        /// </summary>
        public static int ConvertirGrilleTLC(int brut, string section, int totalReel = 0)
        {
            if (!Grille.TryGetValue(section, out var g)) return 31;

            int denominateur = totalReel > 0 ? totalReel : g.total;
            if (denominateur == 0) return g.min;

            brut = Math.Max(0, Math.Min(brut, denominateur));
            int score = g.min + (int)Math.Round((brut / (double)denominateur) * (g.max - g.min));
            return Math.Max(g.min, Math.Min(g.max, score));
        }

        // ─────────────────────────────────────────────────────────────
        // DÉTERMINER LE NIVEAU
        // ─────────────────────────────────────────────────────────────
        public static string DeterminerNiveau(int scoreTotal)
        {
            foreach (var (seuil, niveau) in Niveaux)
                if (scoreTotal >= seuil) return niveau;
            return "Débutant";
        }

        // ─────────────────────────────────────────────────────────────
        // ENREGISTRER LE RÉSULTAT EN BASE
        // UI → ScoreService.EnregistrerResultat → DAL (Repositories)
        // ─────────────────────────────────────────────────────────────
        /// <summary>
        /// Persiste le résultat dans Resultats puis chaque réponse dans Reponses.
        /// Retourne le ResultatID inséré.
        /// </summary>
        public static int EnregistrerResultat(
            ScoreResult score,
            Dictionary<int, string> reponsesCandidat,
            List<Question> questions,
            int utilisateurId,
            int testId,
            int? dureeReelle)
        {
            // === INSERT dans Resultats ===
            int resultatId = ResultatRepository.Insert(
                utilisateurId,
                testId,
                score.ScoreListening,
                score.ScoreStructure,
                score.ScoreReading,
                score.ScoreTotal,
                dureeReelle);

            // === INSERT batch dans Reponses ===
            var lignesReponses = new List<Reponse>();
            foreach (var q in questions)
            {
                string rep = reponsesCandidat.ContainsKey(q.QuestionID)
                             ? reponsesCandidat[q.QuestionID] : "";
                lignesReponses.Add(new Reponse
                {
                    ResultatID      = resultatId,
                    QuestionID      = q.QuestionID,
                    ReponseCandidat = rep,
                    EstCorrecte     = rep == q.BonneReponse
                });
            }
            ReponseRepository.InsertBatch(lignesReponses);

            return resultatId;
        }
    }
}
