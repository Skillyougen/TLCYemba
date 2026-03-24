// ═══════════════════════════════════════════════════════════════════════
//  TLC YEMBA — PARTIE 4 : Models
//  Fichier  : Models/Reponse.cs
//  Namespace: TLC_Yemba.Models
// ═══════════════════════════════════════════════════════════════════════
namespace TLC_Yemba.Models
{
    /// <summary>
    /// Représente une ligne de la table Reponses.
    /// Enregistre la réponse donnée par un candidat pour une question.
    /// </summary>
    public class Reponse
    {
        public int    ReponseID        { get; set; }
        public int    ResultatID       { get; set; }  // FK → Resultats
        public int    QuestionID       { get; set; }  // FK → Questions
        public string ReponseCandidat  { get; set; }  // "A", "B", "C" ou "D"
        public bool   EstCorrecte      { get; set; }  // true si = BonneReponse
    }
}
