// ═══════════════════════════════════════════════════════════════════════
//  TLC YEMBA — PARTIE 4 : Models
//  Fichier  : Models/ScoreResult.cs
//  Namespace: TLC_Yemba.Models
// ═══════════════════════════════════════════════════════════════════════
using System.Collections.Generic;

namespace TLC_Yemba.Models
{
    /// <summary>
    /// DTO (Data Transfer Object) contenant le résultat complet d'un test
    /// après correction automatique. Produit par ScoreService, consommé
    /// par Resultat.aspx.cs et Certificat.aspx.cs.
    /// </summary>
    public class ScoreResult
    {
        // ── Scores convertis (échelle TLC) ───────────────────────────
        public int?   ScoreListening { get; set; }   // 31–68, null si section absente
        public int?   ScoreStructure { get; set; }   // 31–68, null si section absente
        public int?   ScoreReading   { get; set; }   // 31–67, null si section absente
        public int    ScoreTotal     { get; set; }   // Somme des sections (max 677)

        // ── Scores bruts (nombre de bonnes réponses) ─────────────────
        public int    BrutListening  { get; set; }
        public int    BrutStructure  { get; set; }
        public int    BrutReading    { get; set; }

        // ── Niveau et contexte ────────────────────────────────────────
        public string Niveau         { get; set; }   // Débutant / Élémentaire / … / Avancé
        public string TypeTest       { get; set; }   // Listening | Structure | Reading | Full Test
        public int    TotalQuestions { get; set; }   // Nombre total de questions répondues

        // ── Correction détaillée (bonus) ─────────────────────────────
        public List<CorrectionItem> CorrectionDetaillee { get; set; }
            = new List<CorrectionItem>();
    }

    /// <summary>
    /// Détail de correction pour une question (utilisé dans rptCorrection).
    /// </summary>
    public class CorrectionItem
    {
        public int    QuestionID       { get; set; }
        public string Section          { get; set; }
        public string Enonce           { get; set; }
        public string ReponseCandidat  { get; set; }  // "" si non répondu
        public string BonneReponse     { get; set; }
        public bool   EstCorrecte      { get; set; }
    }
}
