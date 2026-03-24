// ═══════════════════════════════════════════════════════════════════════
//  TLC YEMBA — PARTIE 4 : Data Access Layer
//  Fichier  : DAL/ReponseRepository.cs
//  Namespace: TLC_Yemba.DAL
// ═══════════════════════════════════════════════════════════════════════
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using TLC_Yemba.Models;
using TLC_Yemba.Helpers;

namespace TLC_Yemba.DAL
{
    public static class ReponseRepository
    {
        // ─────────────────────────────────────────────────────────────
        // INSERT BATCH — toutes les réponses d'un test en une transaction
        // ─────────────────────────────────────────────────────────────
        public static void InsertBatch(List<Reponse> reponses)
        {
            if (reponses == null || reponses.Count == 0) return;

            string connStr = ConfigurationManager
                .ConnectionStrings["TLCYembaDB"].ConnectionString;

            using (var conn = new SqlConnection(connStr))
            {
                conn.Open();
                using (var tx = conn.BeginTransaction())
                {
                    try
                    {
                        string sql = @"
                            INSERT INTO Reponses
                                (ResultatID, QuestionID, ReponseCandidat, EstCorrecte)
                            VALUES
                                (@rid, @qid, @rep, @ok)";

                        foreach (var r in reponses)
                        {
                            using (var cmd = new SqlCommand(sql, conn, tx))
                            {
                                cmd.Parameters.AddWithValue("@rid", r.ResultatID);
                                cmd.Parameters.AddWithValue("@qid", r.QuestionID);
                                cmd.Parameters.AddWithValue("@rep",
                                    string.IsNullOrEmpty(r.ReponseCandidat)
                                    ? (object)DBNull.Value : r.ReponseCandidat);
                                cmd.Parameters.AddWithValue("@ok",  r.EstCorrecte);
                                cmd.ExecuteNonQuery();
                            }
                        }
                        tx.Commit();
                    }
                    catch
                    {
                        tx.Rollback();
                        throw;
                    }
                }
            }
        }

        // ─────────────────────────────────────────────────────────────
        // GET BY RESULTAT (pour historique détaillé)
        // ─────────────────────────────────────────────────────────────
        public static List<Reponse> GetByResultat(int resultatId)
        {
            string sql = @"
                SELECT ReponseID, ResultatID, QuestionID,
                       ReponseCandidat, EstCorrecte
                FROM   Reponses
                WHERE  ResultatID = @rid
                ORDER  BY QuestionID ASC";

            DataTable dt = DBHelper.GetDataTable(sql,
                new SqlParameter("@rid", resultatId));

            var liste = new List<Reponse>();
            foreach (DataRow row in dt.Rows)
            {
                liste.Add(new Reponse
                {
                    ReponseID       = Convert.ToInt32(row["ReponseID"]),
                    ResultatID      = Convert.ToInt32(row["ResultatID"]),
                    QuestionID      = Convert.ToInt32(row["QuestionID"]),
                    ReponseCandidat = row["ReponseCandidat"] != DBNull.Value
                                      ? row["ReponseCandidat"].ToString() : "",
                    EstCorrecte     = Convert.ToBoolean(row["EstCorrecte"])
                });
            }
            return liste;
        }
    }
}
