// ═══════════════════════════════════════════════════════════════════════
//  TLC YEMBA — PARTIE 4 : Data Access Layer
//  Fichier  : DAL/ResultatRepository.cs
//  Namespace: TLC_Yemba.DAL
//  Couche   : DAL — seule couche autorisée à écrire du SQL pour Resultats
// ═══════════════════════════════════════════════════════════════════════
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using TLC_Yemba.Models;
using TLC_Yemba.Helpers;

namespace TLC_Yemba.DAL
{
    public static class ResultatRepository
    {
        // ─────────────────────────────────────────────────────────────
        // INSERT — Nouveau résultat, retourne l'ID inséré
        // ─────────────────────────────────────────────────────────────
        public static int Insert(
            int utilisateurId, int testId,
            int? scoreListening, int? scoreStructure, int? scoreReading,
            int scoreTotal, int? dureeReelle)
        {
            string sql = @"
                INSERT INTO Resultats
                    (UtilisateurID, TestID, ScoreListening, ScoreStructure,
                     ScoreReading, ScoreTotal, DureeReelle, DateTest)
                VALUES
                    (@uid, @tid, @sl, @ss, @sr, @st, @dur, GETDATE());
                SELECT SCOPE_IDENTITY();";

            object id = DBHelper.ExecuteScalar(sql,
                new SqlParameter("@uid", utilisateurId),
                new SqlParameter("@tid", testId),
                new SqlParameter("@sl",  scoreListening.HasValue ? (object)scoreListening.Value : DBNull.Value),
                new SqlParameter("@ss",  scoreStructure.HasValue ? (object)scoreStructure.Value : DBNull.Value),
                new SqlParameter("@sr",  scoreReading.HasValue   ? (object)scoreReading.Value   : DBNull.Value),
                new SqlParameter("@st",  scoreTotal),
                new SqlParameter("@dur", dureeReelle.HasValue    ? (object)dureeReelle.Value    : DBNull.Value));

            return id != null ? Convert.ToInt32(id) : 0;
        }

        // ─────────────────────────────────────────────────────────────
        // GET BY ID
        // ─────────────────────────────────────────────────────────────
        public static Resultat GetById(int resultatId)
        {
            string sql = @"
                SELECT ResultatID, UtilisateurID, TestID,
                       ScoreListening, ScoreStructure, ScoreReading,
                       ScoreTotal, DureeReelle, DateTest
                FROM   Resultats
                WHERE  ResultatID = @id";

            DataTable dt = DBHelper.GetDataTable(sql,
                new SqlParameter("@id", resultatId));

            if (dt.Rows.Count == 0) return null;
            return MapperResultat(dt.Rows[0]);
        }

        // ─────────────────────────────────────────────────────────────
        // GET BY UTILISATEUR (pour Historique)
        // ─────────────────────────────────────────────────────────────
        public static List<Resultat> GetByUtilisateur(int utilisateurId)
        {
            string sql = @"
                SELECT r.ResultatID, r.UtilisateurID, r.TestID,
                       r.ScoreListening, r.ScoreStructure, r.ScoreReading,
                       r.ScoreTotal, r.DureeReelle, r.DateTest,
                       t.TypeTest
                FROM   Resultats r
                JOIN   Tests t ON r.TestID = t.TestID
                WHERE  r.UtilisateurID = @uid
                ORDER  BY r.DateTest DESC";

            DataTable dt = DBHelper.GetDataTable(sql,
                new SqlParameter("@uid", utilisateurId));

            var liste = new List<Resultat>();
            foreach (DataRow row in dt.Rows)
                liste.Add(MapperResultat(row));
            return liste;
        }

        // ─────────────────────────────────────────────────────────────
        // GET LEADERBOARD (via procédure stockée Partie 1)
        // ─────────────────────────────────────────────────────────────
        public static DataTable GetLeaderboard(int top = 10)
        {
            string sql = "EXEC sp_GetLeaderboard @Top";
            return DBHelper.GetDataTable(sql,
                new SqlParameter("@Top", top));
        }

        // ─────────────────────────────────────────────────────────────
        // MAPPER DataRow → Resultat
        // ─────────────────────────────────────────────────────────────
        private static Resultat MapperResultat(DataRow row)
        {
            return new Resultat
            {
                ResultatID      = Convert.ToInt32(row["ResultatID"]),
                UtilisateurID   = Convert.ToInt32(row["UtilisateurID"]),
                TestID          = Convert.ToInt32(row["TestID"]),
                ScoreListening  = row["ScoreListening"]  != DBNull.Value ? (int?)Convert.ToInt32(row["ScoreListening"])  : null,
                ScoreStructure  = row["ScoreStructure"]  != DBNull.Value ? (int?)Convert.ToInt32(row["ScoreStructure"])  : null,
                ScoreReading    = row["ScoreReading"]    != DBNull.Value ? (int?)Convert.ToInt32(row["ScoreReading"])    : null,
                ScoreTotal      = Convert.ToInt32(row["ScoreTotal"]),
                DureeReelle     = row["DureeReelle"]     != DBNull.Value ? (int?)Convert.ToInt32(row["DureeReelle"])     : null,
                DateTest        = Convert.ToDateTime(row["DateTest"]),
                TypeTest        = row.Table.Columns.Contains("TypeTest") ? row["TypeTest"].ToString() : ""
            };
        }
    }
}
