// ═══════════════════════════════════════════════════════════════════════
//  TLC YEMBA — Models
//  Fichier  : Models/Question.cs
//  Namespace: TLC_Yemba.Models
//  Couche   : Models — partagés par toutes les couches, aucune logique
// ═══════════════════════════════════════════════════════════════════════
namespace TLC_Yemba.Models
{
    /// <summary>
    /// Représente une question QCM de la table Questions.
    /// Pas de logique métier ici — uniquement des propriétés.
    /// </summary>
    public class Question
    {
        public int    QuestionID   { get; set; }
        public int    TestID       { get; set; }
        public string Section      { get; set; }  // Listening | Structure | Reading
        public string Enonce       { get; set; }
        public string ChoixA       { get; set; }
        public string ChoixB       { get; set; }
        public string ChoixC       { get; set; }
        public string ChoixD       { get; set; }
        public string BonneReponse { get; set; }  // "A", "B", "C" ou "D"
        public int    Ordre        { get; set; }
    }
}
