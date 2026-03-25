using System.Collections.Generic;
using System.Web;
using TLCYemba.DAL;
using TLCYemba.Models;

namespace TLCYemba.BLL
{
    /// <summary>
    /// Service BLL pour la logique du test QCM.
    /// Ne contient aucun accès direct à la base de données.
    /// </summary>
    public class TestService
    {
        private readonly QuestionRepository _repo = new QuestionRepository();

        /// <summary>
        /// Retourne la question à l'index donné pour le type de test.
        /// Gère le passage multi-sections (FullTest).
        /// </summary>
        public Question GetQuestion(string typeTest, int globalIndex)
        {
            var questions = GetAllQuestions(typeTest);
            if (globalIndex < 0 || globalIndex >= questions.Count)
                return null;
            return questions[globalIndex];
        }

        /// <summary>
        /// Retourne toutes les questions pour un type de test.
        /// Pour FullTest, concatène Listening + Structure + Reading.
        /// </summary>
        public List<Question> GetAllQuestions(string typeTest)
        {
            if (typeTest == "FullTest")
            {
                var all = new List<Question>();
                all.AddRange(_repo.GetBySection("Listening"));
                all.AddRange(_repo.GetBySection("Structure"));
                all.AddRange(_repo.GetBySection("Reading"));
                return all;
            }
            return _repo.GetBySection(typeTest);
        }

        /// <summary>
        /// Valide que le type de test est reconnu.
        /// </summary>
        public bool TypeTestValide(string typeTest)
        {
            var valides = new HashSet<string>
                { "Listening", "Structure", "Reading", "FullTest" };
            return valides.Contains(typeTest);
        }
    }
}
