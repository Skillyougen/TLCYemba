using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using TLCYemba.Models;

namespace TLCYemba.DAL
{
    /// <summary>
    /// Accès aux données — Table Questions.
    /// Seule couche autorisée à écrire du SQL.
    /// </summary>
    public class QuestionRepository
    {
        private string ConnStr =>
            ConfigurationManager.ConnectionStrings["TLCYembaDB"].ConnectionString;

        /// <summary>Retourne toutes les questions d'une section, ordre aléatoire.</summary>
        public List<Question> GetBySection(string section)
        {
            var list = new List<Question>();
            const string sql = @"
                SELECT QuestionID, Section, Enonce, FichierAudio,
                       ChoixA, ChoixB, ChoixC, ChoixD, BonneReponse
                FROM   Questions
                WHERE  Section = @Section
                ORDER  BY NEWID()";   //-- ordre aléatoire

            using (var conn = new SqlConnection(ConnStr))
            using (var cmd  = new SqlCommand(sql, conn))
            {
                cmd.Parameters.Add("@Section", SqlDbType.NVarChar, 20).Value = section;
                conn.Open();
                using (var rdr = cmd.ExecuteReader())
                {
                    while (rdr.Read())
                    {
                        list.Add(new Question
                        {
                            QuestionID   = (int)rdr["QuestionID"],
                            Section      = rdr["Section"].ToString(),
                            Enonce       = rdr["Enonce"].ToString(),
                            FichierAudio = rdr["FichierAudio"] == DBNull.Value
                                             ? null
                                             : rdr["FichierAudio"].ToString(),
                            ChoixA       = rdr["ChoixA"].ToString(),
                            ChoixB       = rdr["ChoixB"].ToString(),
                            ChoixC       = rdr["ChoixC"].ToString(),
                            ChoixD       = rdr["ChoixD"].ToString(),
                            BonneReponse = rdr["BonneReponse"].ToString()
                        });
                    }
                }
            }
            return list;
        }

        /// <summary>Retourne une seule question par ID.</summary>
        public Question GetById(int id)
        {
            const string sql = @"
                SELECT QuestionID, Section, Enonce, FichierAudio,
                       ChoixA, ChoixB, ChoixC, ChoixD, BonneReponse
                FROM   Questions WHERE QuestionID = @ID";

            using (var conn = new SqlConnection(ConnStr))
            using (var cmd  = new SqlCommand(sql, conn))
            {
                cmd.Parameters.Add("@ID", SqlDbType.Int).Value = id;
                conn.Open();
                using (var rdr = cmd.ExecuteReader())
                {
                    if (rdr.Read())
                    {
                        return new Question
                        {
                            QuestionID   = (int)rdr["QuestionID"],
                            Section      = rdr["Section"].ToString(),
                            Enonce       = rdr["Enonce"].ToString(),
                            FichierAudio = rdr["FichierAudio"] == DBNull.Value
                                             ? null
                                             : rdr["FichierAudio"].ToString(),
                            ChoixA       = rdr["ChoixA"].ToString(),
                            ChoixB       = rdr["ChoixB"].ToString(),
                            ChoixC       = rdr["ChoixC"].ToString(),
                            ChoixD       = rdr["ChoixD"].ToString(),
                            BonneReponse = rdr["BonneReponse"].ToString()
                        };
                    }
                }
            }
            return null;
        }
    }
}
