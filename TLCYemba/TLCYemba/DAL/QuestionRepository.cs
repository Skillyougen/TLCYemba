// ═══════════════════════════════════════════════════════════════════════
//  TLC YEMBA — PARTIE 3 : Data Access Layer
//  Fichier  : DAL/QuestionRepository.cs
//  Namespace: TLC_Yemba.DAL
//  Couche   : DAL — seule couche autorisée à écrire du SQL
// ═══════════════════════════════════════════════════════════════════════
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using TLC_Yemba.Models;
using TLC_Yemba.Helpers;

namespace TLC_Yemba.DAL
{
    /// <summary>
    /// Repository des questions — tout le SQL lié à la table Questions est ici.
    /// La BLL appelle ces méthodes, jamais les pages .aspx directement.
    /// </summary>
    public static class QuestionRepository
    {
        // ─────────────────────────────────────────────────────────────
        // GET BY SECTION
        // ─────────────────────────────────────────────────────────────
        /// <summary>
        /// Charge toutes les questions d'une section (Listening, Structure ou Reading).
        /// Triées par Ordre ASC.
        /// </summary>
        public static List<Question> GetBySection(string section)
        {
            var questions = new List<Question>();
            string sql = @"
                SELECT QuestionID, TestID, Section, Enonce,
                       ChoixA, ChoixB, ChoixC, ChoixD, BonneReponse, Ordre
                FROM   Questions
                WHERE  Section = @Section
                ORDER  BY Ordre ASC";

            var param = new SqlParameter("@Section", section);
            DataTable dt = DBHelper.GetDataTable(sql, param);

            foreach (DataRow row in dt.Rows)
                questions.Add(MapperQuestion(row));

            return questions;
        }

        // ─────────────────────────────────────────────────────────────
        // GET ALL FOR FULL TEST
        // ─────────────────────────────────────────────────────────────
        /// <summary>
        /// Charge toutes les questions pour un Full Test.
        /// Ordre : Listening → Structure → Reading, puis Ordre ASC dans chaque section.
        /// </summary>
        public static List<Question> GetAllForFullTest()
        {
            var questions = new List<Question>();
            string sql = @"
                SELECT QuestionID, TestID, Section, Enonce,
                       ChoixA, ChoixB, ChoixC, ChoixD, BonneReponse, Ordre
                FROM   Questions
                ORDER  BY
                    CASE Section
                        WHEN 'Listening'  THEN 1
                        WHEN 'Structure'  THEN 2
                        WHEN 'Reading'    THEN 3
                        ELSE 4
                    END,
                    Ordre ASC";

            DataTable dt = DBHelper.GetDataTable(sql);

            foreach (DataRow row in dt.Rows)
                questions.Add(MapperQuestion(row));

            return questions;
        }

        // ─────────────────────────────────────────────────────────────
        // GET BY ID
        // ─────────────────────────────────────────────────────────────
        /// <summary>
        /// Récupère une question par son ID.
        /// Utilisée par ScoreService pour la correction.
        /// </summary>
        public static Question GetById(int questionId)
        {
            string sql = @"
                SELECT QuestionID, TestID, Section, Enonce,
                       ChoixA, ChoixB, ChoixC, ChoixD, BonneReponse, Ordre
                FROM   Questions
                WHERE  QuestionID = @QuestionID";

            var param = new SqlParameter("@QuestionID", questionId);
            DataTable dt = DBHelper.GetDataTable(sql, param);

            if (dt.Rows.Count == 0) return null;
            return MapperQuestion(dt.Rows[0]);
        }

        // ─────────────────────────────────────────────────────────────
        // MAPPER DataRow → Question (Model)
        // ─────────────────────────────────────────────────────────────
        private static Question MapperQuestion(DataRow row)
        {
            return new Question
            {
                QuestionID   = Convert.ToInt32(row["QuestionID"]),
                TestID       = Convert.ToInt32(row["TestID"]),
                Section      = row["Section"].ToString(),
                Enonce       = row["Enonce"].ToString(),
                ChoixA       = row["ChoixA"].ToString(),
                ChoixB       = row["ChoixB"].ToString(),
                ChoixC       = row["ChoixC"].ToString(),
                ChoixD       = row["ChoixD"].ToString(),
                BonneReponse = row["BonneReponse"].ToString(),
                Ordre        = row["Ordre"] != DBNull.Value
                               ? Convert.ToInt32(row["Ordre"]) : 0
            };
        }
    }
}
