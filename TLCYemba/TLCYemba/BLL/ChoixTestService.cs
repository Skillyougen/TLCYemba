using System;
using System.Web;
using System.Web.SessionState;

namespace TLCYemba.BLL
{
    /// <summary>
    /// Service BLL pour la sélection du type de test.
    /// Couche Logique Métier : validation des règles + gestion de la session.
    /// Cette couche ne contient aucun accès direct à la base de données.
    /// </summary>
    public class ChoixTestService
    {
        // ── Clé de session (partagée avec les autres parties) ──
        public const string SESSION_TYPE_TEST    = "TypeTest";
        public const string SESSION_SECTIONS     = "Sections";       // liste des sections à passer
        public const string SESSION_NB_QUESTIONS = "NbQuestions";    // nb total de questions

        // ── Types de tests valides ──
        private static readonly string[] TypesValides =
        {
            "Listening",
            "Structure",
            "Reading",
            "FullTest"
        };

        // ── Métadonnées par type ──
        private static readonly System.Collections.Generic.Dictionary<string, TestMetadata> Metadata =
            new System.Collections.Generic.Dictionary<string, TestMetadata>
            {
                { "Listening",  new TestMetadata("Listening",  new[]{ "Listening" },              50, 30) },
                { "Structure",  new TestMetadata("Structure",  new[]{ "Structure" },              40, 25) },
                { "Reading",    new TestMetadata("Reading",    new[]{ "Reading"   },              50, 55) },
                { "FullTest",   new TestMetadata("FullTest",   new[]{ "Listening","Structure","Reading" }, 140, 110) },
            };

        // ────────────────────────────────────────────────────────────
        /// <summary>
        /// Valide le choix de l'utilisateur.
        /// Retourne null si valide, sinon le message d'erreur à afficher.
        /// </summary>
        public string ValiderChoix(string typeTest)
        {
            if (string.IsNullOrWhiteSpace(typeTest))
                return "Veuillez sélectionner un type de test avant de continuer.";

            bool estValide = false;
            foreach (var t in TypesValides)
            {
                if (string.Equals(t, typeTest, StringComparison.OrdinalIgnoreCase))
                {
                    estValide = true;
                    break;
                }
            }

            if (!estValide)
                return "Le type de test sélectionné n'est pas reconnu. Veuillez réessayer.";

            return null; // valide
        }

        // ────────────────────────────────────────────────────────────
        /// <summary>
        /// Enregistre le choix du test dans la session ASP.NET.
        /// Stocke : TypeTest, Sections, NbQuestions, DuréeMinutes.
        /// </summary>
        public void EnregistrerChoixEnSession(HttpSessionState session, string typeTest)
        {
            if (session == null) throw new ArgumentNullException("session");
            if (string.IsNullOrWhiteSpace(typeTest)) throw new ArgumentException("typeTest vide");

            // Normaliser la casse
            string key = NormaliserTypeTest(typeTest);

            var meta = Metadata[key];

            session[SESSION_TYPE_TEST]    = meta.TypeTest;
            session[SESSION_SECTIONS]     = meta.Sections;       // string[]
            session[SESSION_NB_QUESTIONS] = meta.NbQuestions;
            session["DureeMinutes"]       = meta.DureeMinutes;

            // Réinitialiser les données d'un éventuel test précédent
            session.Remove("Reponses");
            session.Remove("QuestionActuelle");
            session.Remove("DernierResultatID");
            session.Remove("DernierScore");
        }

        // ────────────────────────────────────────────────────────────
        /// <summary>
        /// Retourne le libellé affiché pour un type de test donné.
        /// </summary>
        public string GetLibelle(string typeTest)
        {
            switch (NormaliserTypeTest(typeTest))
            {
                case "Listening": return "Listening — Compréhension Orale";
                case "Structure": return "Structure — Grammaire";
                case "Reading":   return "Reading — Compréhension Écrite";
                case "FullTest":  return "Test Complet TLC";
                default:          return typeTest;
            }
        }

        // ── Helpers ─────────────────────────────────────────────────
        private string NormaliserTypeTest(string typeTest)
        {
            foreach (var t in TypesValides)
            {
                if (string.Equals(t, typeTest, StringComparison.OrdinalIgnoreCase))
                    return t;
            }
            throw new ArgumentException("Type de test inconnu : " + typeTest);
        }

        // ────────────────────────────────────────────────────────────
        /// <summary>Métadonnées immuables d'un type de test.</summary>
        private class TestMetadata
        {
            public string   TypeTest    { get; }
            public string[] Sections    { get; }
            public int      NbQuestions { get; }
            public int      DureeMinutes{ get; }

            public TestMetadata(string typeTest, string[] sections, int nbQuestions, int duree)
            {
                TypeTest     = typeTest;
                Sections     = sections;
                NbQuestions  = nbQuestions;
                DureeMinutes = duree;
            }
        }
    }
}
