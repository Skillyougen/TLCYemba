// ═══════════════════════════════════════════════════════════════════════
//  TLC YEMBA — PARTIE 4 : Models
//  Fichier  : Models/Resultat.cs
//  Namespace: TLC_Yemba.Models
// ═══════════════════════════════════════════════════════════════════════
using System;

namespace TLC_Yemba.Models
{
    /// <summary>
    /// Représente une ligne de la table Resultats.
    /// Utilisé par ResultatRepository et Historique.aspx (Partie 5).
    /// </summary>
    public class Resultat
    {
        public int      ResultatID     { get; set; }
        public int      UtilisateurID  { get; set; }
        public int      TestID         { get; set; }
        public int?     ScoreListening { get; set; }
        public int?     ScoreStructure { get; set; }
        public int?     ScoreReading   { get; set; }
        public int      ScoreTotal     { get; set; }
        public int?     DureeReelle    { get; set; }  // secondes
        public DateTime DateTest       { get; set; }
        public string   TypeTest       { get; set; }  // jointure avec Tests (optionnel)
    }
}
