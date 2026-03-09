using System;
using System.Data;
using TLC_Yemba.Helpers;

namespace TLC_Yemba
{
    /// <summary>
    /// Code-behind de Default.aspx – Page d'accueil
    /// Responsabilités :
    ///   - Afficher les statistiques globales (nb questions, nb candidats)
    ///   - Afficher un message de bienvenue si l'utilisateur est connecté
    ///   - Afficher le dernier score obtenu
    /// </summary>
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ChargerStatistiques();
                AfficherBienvenue();
            }
        }

        /// <summary>
        /// Charge et affiche les statistiques globales de la plateforme.
        /// </summary>
        private void ChargerStatistiques()
        {
            try
            {
                // Nombre total de questions dans la BDD
                object nbQ = DBHelper.ExecuteScalar("SELECT COUNT(*) FROM Questions");
                lblNbQuestions.Text = Convert.ToInt32(nbQ).ToString();

                // Nombre de candidats inscrits (utilisateurs actifs)
                object nbC = DBHelper.ExecuteScalar("SELECT COUNT(*) FROM Utilisateurs WHERE EstActif = 1");
                int nbCandidats = Convert.ToInt32(nbC);
                lblNbCandidats.Text = nbCandidats > 0 ? nbCandidats.ToString() : "—";
            }
            catch (Exception ex)
            {
                // En cas d'erreur BDD, on garde les valeurs par défaut
                System.Diagnostics.Debug.WriteLine("Erreur stats accueil : " + ex.Message);
                lblNbQuestions.Text  = "60";
                lblNbCandidats.Text  = "—";
            }
        }

        /// <summary>
        /// Affiche le panneau de bienvenue si l'utilisateur est connecté en Session.
        /// Récupère aussi son dernier score.
        /// </summary>
        private void AfficherBienvenue()
        {
            if (Session["UtilisateurID"] != null)
            {
                pnlBienvenue.Visible = true;

                // Afficher le prénom / nom
                string nom = Session["NomUtilisateur"]?.ToString() ?? "Candidat";
                lblNomUtilisateur.Text = nom;

                // Récupérer le dernier score
                try
                {
                    int userId = (int)Session["UtilisateurID"];
                    object dernierScore = DBHelper.ExecuteScalar(
                        @"SELECT TOP 1 ScoreTotal
                          FROM Resultats
                          WHERE UtilisateurID = @uid
                          ORDER BY DateTest DESC",
                        new System.Data.SqlClient.SqlParameter("@uid", userId)
                    );

                    lblDernierScore.Text = dernierScore != null
                        ? Convert.ToInt32(dernierScore).ToString() + " / 677"
                        : "Pas encore de test";
                }
                catch
                {
                    lblDernierScore.Text = "—";
                }
            }
        }
    }
}
