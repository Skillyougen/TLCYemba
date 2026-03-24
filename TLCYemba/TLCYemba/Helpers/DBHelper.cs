using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;

namespace TLC_Yemba.Helpers
{
    /// <summary>
    /// Classe utilitaire centralisée pour tous les accès à la base de données.
    /// Utilise ADO.NET (SqlConnection, SqlCommand, SqlDataReader, SqlDataAdapter).
    /// 
    /// Cours DPW – Partie 1 : Base de données & Architecture
    /// Partagée par tous les membres du groupe.
    /// </summary>
    public static class DBHelper
    {
        // ============================================================
        // CHAÎNE DE CONNEXION
        // ============================================================

        /// <summary>
        /// Récupère la chaîne de connexion depuis Web.config.
        /// Clé attendue dans <connectionStrings> : "TLCYembaDB"
        /// </summary>
        private static string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["TLCYembaDB"].ConnectionString;
        }

        // ============================================================
        // 1. OBTENIR UNE CONNEXION
        // ============================================================

        /// <summary>
        /// Crée et retourne une SqlConnection ouverte.
        /// TOUJOURS utiliser dans un bloc using pour libérer les ressources.
        /// 
        /// Exemple d'utilisation :
        ///     using (SqlConnection conn = DBHelper.GetConnection())
        ///     {
        ///         // utiliser conn...
        ///     }
        /// </summary>
        public static SqlConnection GetConnection()
        {
            SqlConnection conn = new SqlConnection(GetConnectionString());
            conn.Open();
            return conn;
        }

        // ============================================================
        // 2. EXÉCUTER UN SELECT → SqlDataReader
        // ============================================================

        /// <summary>
        /// Exécute une requête SELECT et retourne un SqlDataReader.
        /// 
        /// ATTENTION : Fermer le reader ET la connexion après utilisation.
        /// Utiliser CommandBehavior.CloseConnection pour fermeture automatique.
        /// 
        /// Exemple :
        ///     SqlDataReader reader = DBHelper.ExecuteReader(
        ///         "SELECT * FROM Questions WHERE Section = @sec",
        ///         new SqlParameter("@sec", "Structure")
        ///     );
        ///     while (reader.Read()) { ... }
        ///     reader.Close();
        /// </summary>
        public static SqlDataReader ExecuteReader(string query, params SqlParameter[] parameters)
        {
            SqlConnection conn = new SqlConnection(GetConnectionString());
            conn.Open();

            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddRange(parameters);

            // CloseConnection : la connexion est fermée quand le reader est fermé
            return cmd.ExecuteReader(CommandBehavior.CloseConnection);
        }

        // ============================================================
        // 3. EXÉCUTER UN SELECT → DataTable (via SqlDataAdapter)
        // ============================================================

        /// <summary>
        /// Exécute une requête SELECT et retourne un DataTable complet.
        /// Idéal pour remplir un GridView ou une liste.
        /// 
        /// Exemple :
        ///     DataTable dt = DBHelper.GetDataTable(
        ///         "SELECT * FROM Resultats WHERE UtilisateurID = @uid",
        ///         new SqlParameter("@uid", userId)
        ///     );
        ///     GridView1.DataSource = dt;
        ///     GridView1.DataBind();
        /// </summary>
        public static DataTable GetDataTable(string query, params SqlParameter[] parameters)
        {
            DataTable dt = new DataTable();

            using (SqlConnection conn = GetConnection())
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddRange(parameters);
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                adapter.Fill(dt);
            }

            return dt;
        }

        // ============================================================
        // 4. EXÉCUTER INSERT / UPDATE / DELETE → nombre de lignes
        // ============================================================

        /// <summary>
        /// Exécute une requête INSERT, UPDATE ou DELETE.
        /// Retourne le nombre de lignes affectées.
        /// 
        /// Exemple :
        ///     int rows = DBHelper.ExecuteNonQuery(
        ///         "UPDATE Utilisateurs SET EstActif = 0 WHERE UtilisateurID = @id",
        ///         new SqlParameter("@id", userId)
        ///     );
        /// </summary>
        public static int ExecuteNonQuery(string query, params SqlParameter[] parameters)
        {
            using (SqlConnection conn = GetConnection())
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddRange(parameters);
                return cmd.ExecuteNonQuery();
            }
        }

        // ============================================================
        // 5. RÉCUPÉRER UNE VALEUR UNIQUE → ExecuteScalar
        // ============================================================

        /// <summary>
        /// Exécute une requête et retourne la première colonne de la première ligne.
        /// Idéal pour COUNT(*), MAX(), ou récupérer un ID après INSERT.
        /// 
        /// Exemple :
        ///     int total = (int)DBHelper.ExecuteScalar(
        ///         "SELECT COUNT(*) FROM Questions WHERE Section = @sec",
        ///         new SqlParameter("@sec", "Listening")
        ///     );
        /// </summary>
        public static object ExecuteScalar(string query, params SqlParameter[] parameters)
        {
            using (SqlConnection conn = GetConnection())
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddRange(parameters);
                return cmd.ExecuteScalar();
            }
        }

        // ============================================================
        // 6. APPELER UNE PROCÉDURE STOCKÉE → DataTable
        // ============================================================

        /// <summary>
        /// Exécute une procédure stockée et retourne un DataTable.
        /// 
        /// Exemple :
        ///     DataTable dt = DBHelper.ExecuteStoredProcedure(
        ///         "sp_GetLeaderboard"
        ///     );
        /// </summary>
        public static DataTable ExecuteStoredProcedure(string procedureName, params SqlParameter[] parameters)
        {
            DataTable dt = new DataTable();

            using (SqlConnection conn = GetConnection())
            using (SqlCommand cmd = new SqlCommand(procedureName, conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddRange(parameters);
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                adapter.Fill(dt);
            }

            return dt;
        }

        // ============================================================
        // 7. TRANSACTION (pour les opérations multiples atomiques)
        // ============================================================

        /// <summary>
        /// Exécute plusieurs requêtes dans une transaction SQL.
        /// Si l'une échoue, tout est annulé (ROLLBACK automatique).
        /// 
        /// Exemple :
        ///     var queries = new List<(string, SqlParameter[])> {
        ///         ("INSERT INTO Resultats (...) VALUES (...)", paramsResultat),
        ///         ("INSERT INTO Reponses (...) VALUES (...)", paramsReponse1),
        ///     };
        ///     DBHelper.ExecuteTransaction(queries);
        /// </summary>
        public static void ExecuteTransaction(List<(string query, SqlParameter[] parameters)> operations)
        {
            using (SqlConnection conn = GetConnection())
            using (SqlTransaction transaction = conn.BeginTransaction())
            {
                try
                {
                    foreach (var (query, parameters) in operations)
                    {
                        using (SqlCommand cmd = new SqlCommand(query, conn, transaction))
                        {
                            if (parameters != null)
                                cmd.Parameters.AddRange(parameters);
                            cmd.ExecuteNonQuery();
                        }
                    }

                    transaction.Commit();
                }
                catch (Exception)
                {
                    transaction.Rollback();
                    throw; // Re-lancer l'exception pour la gérer en amont
                }
            }
        }

        // ============================================================
        // 8. MÉTHODES MÉTIER TLC – QUESTIONS
        // ============================================================

        /// <summary>
        /// Récupère toutes les questions d'une section donnée.
        /// Utilisée dans Test.aspx pour charger les questions en Session.
        /// </summary>
        public static DataTable GetQuestionsBySection(string section)
        {
            string query = @"SELECT QuestionID, Section, Enonce, ChoixA, ChoixB, ChoixC, ChoixD, BonneReponse, Ordre
                             FROM   Questions
                             WHERE  Section = @Section
                             ORDER  BY Ordre ASC";
            return GetDataTable(query, new SqlParameter("@Section", section));
        }

        /// <summary>
        /// Récupère toutes les questions pour un test complet (toutes sections).
        /// </summary>
        public static DataTable GetAllQuestionsForFullTest()
        {
            string query = @"SELECT QuestionID, Section, Enonce, ChoixA, ChoixB, ChoixC, ChoixD, BonneReponse, Ordre
                             FROM   Questions
                             ORDER  BY Section ASC, Ordre ASC";
            return GetDataTable(query);
        }

        // ============================================================
        // 9. MÉTHODES MÉTIER TLC – RÉSULTATS
        // ============================================================

        /// <summary>
        /// Enregistre un résultat de test en base de données.
        /// Retourne l'ID du nouveau résultat créé (pour le certificat).
        /// </summary>
        public static int InsertResultat(int utilisateurId, int testId,
            int? scoreListening, int? scoreStructure, int? scoreReading,
            int scoreTotal, int? dureeReelle)
        {
            string query = @"INSERT INTO Resultats 
                                (UtilisateurID, TestID, ScoreListening, ScoreStructure, ScoreReading, ScoreTotal, DureeReelle)
                             VALUES 
                                (@UID, @TID, @SL, @SS, @SR, @ST, @DR);
                             SELECT SCOPE_IDENTITY();";

            object result = ExecuteScalar(query,
                new SqlParameter("@UID", utilisateurId),
                new SqlParameter("@TID", testId),
                new SqlParameter("@SL",  scoreListening  ?? (object)DBNull.Value),
                new SqlParameter("@SS",  scoreStructure  ?? (object)DBNull.Value),
                new SqlParameter("@SR",  scoreReading    ?? (object)DBNull.Value),
                new SqlParameter("@ST",  scoreTotal),
                new SqlParameter("@DR",  dureeReelle     ?? (object)DBNull.Value)
            );

            return Convert.ToInt32(result);
        }

        /// <summary>
        /// Récupère l'historique des résultats d'un utilisateur.
        /// Utilisée dans Historique.aspx.
        /// </summary>
        public static DataTable GetHistoriqueUtilisateur(int utilisateurId)
        {
            string query = @"SELECT r.ResultatID, t.TypeTest, r.DateTest,
                                    r.ScoreListening, r.ScoreStructure, r.ScoreReading,
                                    r.ScoreTotal, r.DureeReelle
                             FROM   Resultats r
                             INNER JOIN Tests t ON r.TestID = t.TestID
                             WHERE  r.UtilisateurID = @UID
                             ORDER  BY r.DateTest DESC";
            return GetDataTable(query, new SqlParameter("@UID", utilisateurId));
        }

        /// <summary>
        /// Récupère le top 10 pour le classement.
        /// Utilisée dans Leaderboard.aspx.
        /// </summary>
        public static DataTable GetLeaderboard()
        {
            string query = @"SELECT TOP 10
                                ROW_NUMBER() OVER (ORDER BY MAX(r.ScoreTotal) DESC) AS Rang,
                                u.Nom + ' ' + u.Prenom                              AS Candidat,
                                MAX(r.ScoreTotal)                                   AS MeilleurScore,
                                COUNT(r.ResultatID)                                 AS NombreTests,
                                MAX(r.DateTest)                                     AS DernierTest
                             FROM   Resultats r
                             INNER  JOIN Utilisateurs u ON r.UtilisateurID = u.UtilisateurID
                             GROUP  BY u.UtilisateurID, u.Nom, u.Prenom
                             ORDER  BY MeilleurScore DESC";
            return GetDataTable(query);
        }

        // ============================================================
        // 10. MÉTHODES MÉTIER TLC – UTILISATEURS
        // ============================================================

        /// <summary>
        /// Vérifie les identifiants de connexion.
        /// Le mot de passe doit être passé déjà hashé en SHA-256.
        /// Retourne null si échec, sinon le DataRow de l'utilisateur.
        /// </summary>
        public static DataRow VerifierConnexion(string email, string motDePasseHashe)
        {
            string query = @"SELECT UtilisateurID, Nom, Prenom, Email
                             FROM   Utilisateurs
                             WHERE  Email = @Email 
                               AND  MotDePasse = @MDP
                               AND  EstActif = 1";

            DataTable dt = GetDataTable(query,
                new SqlParameter("@Email", email),
                new SqlParameter("@MDP",   motDePasseHashe)
            );

            return (dt.Rows.Count > 0) ? dt.Rows[0] : null;
        }

        /// <summary>
        /// Vérifie si un email est déjà utilisé (pour l'inscription).
        /// </summary>
        public static bool EmailExiste(string email)
        {
            object result = ExecuteScalar(
                "SELECT COUNT(*) FROM Utilisateurs WHERE Email = @Email",
                new SqlParameter("@Email", email)
            );
            return Convert.ToInt32(result) > 0;
        }

        // ============================================================
        // 11. UTILITAIRE – HASH MOT DE PASSE
        // ============================================================

        /// <summary>
        /// Hash un mot de passe en SHA-256 (hex lowercase).
        /// Utiliser lors de l'inscription ET de la connexion.
        /// 
        /// Exemple : string hash = DBHelper.HashPassword("monMotDePasse");
        /// </summary>
        public static string HashPassword(string motDePasse)
        {
            using (System.Security.Cryptography.SHA256 sha256 =
                   System.Security.Cryptography.SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(System.Text.Encoding.UTF8.GetBytes(motDePasse));
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                foreach (byte b in bytes)
                    sb.Append(b.ToString("x2"));
                return sb.ToString();
            }
        }

        // ============================================================
        // 12. UTILITAIRE – TEST DE CONNEXION (diagnostic)
        // ============================================================

        /// <summary>
        /// Teste si la connexion à la base de données est opérationnelle.
        /// Appeler sur Default.aspx en développement pour vérifier la config.
        /// </summary>
        public static bool TestConnexion(out string messageErreur)
        {
            messageErreur = string.Empty;
            try
            {
                using (SqlConnection conn = GetConnection())
                {
                    return conn.State == ConnectionState.Open;
                }
            }
            catch (Exception ex)
            {
                messageErreur = ex.Message;
                return false;
            }
        }
    }
}
