namespace TLCYemba.Models
{
    /// <summary>
    /// Modèle représentant une question QCM du test TLC Yemba.
    /// Couche Models : aucune logique, que des propriétés.
    /// </summary>
    public class Question
    {
        public int QuestionID { get; set; }
        public string Section { get; set; }   // Listening | Structure | Reading
        public string Enonce { get; set; }
        public string FichierAudio { get; set; }   // null si pas d'audio
        public string ChoixA { get; set; }
        public string ChoixB { get; set; }
        public string ChoixC { get; set; }
        public string ChoixD { get; set; }
        public string BonneReponse { get; set; }   // "A" | "B" | "C" | "D"

        /// <summary>True si la question dispose d'un fichier audio.</summary>
        public bool HasAudio => !string.IsNullOrEmpty(FichierAudio);
    }
}
