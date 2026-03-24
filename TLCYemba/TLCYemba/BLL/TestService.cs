// ═══════════════════════════════════════════════════════════════════════
//  TLC YEMBA — PARTIE 3 : Business Logic Layer
//  Fichier  : BLL/TestService.cs
//  Namespace: TLC_Yemba.BLL
//  Couche   : BLL — appelle DAL.QuestionRepository, ne touche jamais SQL
// ═══════════════════════════════════════════════════════════════════════
using System;
using System.Collections.Generic;
using TLC_Yemba.DAL;
using TLC_Yemba.Models;

namespace TLC_Yemba.BLL
{
    /// <summary>
    /// Service métier pour la gestion du test QCM.
    /// Contient : chargement des questions, durées, validation.
    /// N'écrit jamais de SQL — délègue tout à QuestionRepository.
    /// </summary>
    public static class TestService
    {
        // ─── Durées des tests (en minutes) ──────────────────────────
        private static readonly Dictionary<string, int> DureesMinutes = new Dictionary<string, int>(
            StringComparer.OrdinalIgnoreCase)
        {
            { "Listening",  35 },
            { "Structure",  25 },
            { "Reading",    55 },
            { "Full Test", 115 }
        };

        // ─────────────────────────────────────────────────────────────
        // CHARGER LES QUESTIONS
        // UI appelle cette méthode → BLL appelle DAL
        // ─────────────────────────────────────────────────────────────
        /// <summary>
        /// Charge les questions depuis la base via la DAL.
        /// Pour un Full Test, charge les 3 sections dans l'ordre.
        /// </summary>
        public static List<Question> ChargerQuestions(string typeTest, int testId)
        {
            if (string.IsNullOrEmpty(typeTest))
                throw new ArgumentException("Le type de test est obligatoire.");

            if (typeTest.Equals("Full Test", StringComparison.OrdinalIgnoreCase))
            {
                return QuestionRepository.GetAllForFullTest();
            }
            else
            {
                return QuestionRepository.GetBySection(typeTest);
            }
        }

        // ─────────────────────────────────────────────────────────────
        // DURÉE DU TEST
        // ─────────────────────────────────────────────────────────────
        /// <summary>
        /// Retourne la durée allouée en minutes pour un type de test.
        /// </summary>
        public static int ObtenirDureeMinutes(string typeTest)
        {
            if (DureesMinutes.TryGetValue(typeTest ?? "", out int duree))
                return duree;
            return 30; // défaut sécurisé
        }

        /// <summary>
        /// Retourne la durée allouée en secondes (pour le chronomètre JS).
        /// </summary>
        public static int ObtenirDureeSecondes(string typeTest)
        {
            return ObtenirDureeMinutes(typeTest) * 60;
        }

        // ─────────────────────────────────────────────────────────────
        // VALIDATION DU CHOIX DE TEST
        // ─────────────────────────────────────────────────────────────
        /// <summary>
        /// Vérifie que le type de test choisi est valide.
        /// </summary>
        public static bool ValiderChoixTest(string typeTest)
        {
            return DureesMinutes.ContainsKey(typeTest ?? "");
        }

        /// <summary>
        /// Retourne la liste des types de tests disponibles.
        /// </summary>
        public static List<string> ObtenirTypesTest()
        {
            return new List<string>
            {
                "Listening",
                "Structure",
                "Reading",
                "Full Test"
            };
        }

        // ─────────────────────────────────────────────────────────────
        // INFORMATIONS D'AFFICHAGE
        // ─────────────────────────────────────────────────────────────
        /// <summary>
        /// Retourne le nombre de questions attendu pour un type de test.
        /// </summary>
        public static int ObtenirNombreQuestions(string typeTest)
        {
            switch (typeTest?.ToLower())
            {
                case "listening":  return 50;
                case "structure":  return 40;
                case "reading":    return 50;
                case "full test":  return 140;
                default:           return 0;
            }
        }

        /// <summary>
        /// Retourne l'icône associée à une section.
        /// </summary>
        public static string ObtenirIconeSection(string typeTest)
        {
            switch (typeTest?.ToLower())
            {
                case "listening":  return "👂";
                case "structure":  return "📐";
                case "reading":    return "📖";
                case "full test":  return "⭐";
                default:           return "📋";
            }
        }
    }
}
