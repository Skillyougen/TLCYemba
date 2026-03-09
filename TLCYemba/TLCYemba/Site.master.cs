using System;
using System.Web.UI;

namespace TLC_Yemba
{
    /// <summary>
    /// Code-behind de la MasterPage Site.master
    /// Fournit les fonctionnalités communes à toutes les pages :
    ///   - Détection de la page courante (menu actif)
    ///   - Vérification de la session utilisateur
    /// </summary>
    public partial class Site : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Forcer le data-binding pour les expressions <%# %> dans le markup
            // (nécessaire pour la classe "active" du menu)
            if (!IsPostBack)
            {
                DataBind();
            }
        }

        /// <summary>
        /// Retourne true si le nom de fichier correspond à la page courante.
        /// Utilisé pour appliquer la classe CSS "active" sur le lien de navigation.
        ///
        /// Exemple dans le markup :
        ///   class='<%# IsCurrentPage("Default.aspx") ? "active" : "" %>'
        /// </summary>
        public bool IsCurrentPage(string pageName)
        {
            string currentPage = System.IO.Path.GetFileName(Request.FilePath);
            return string.Equals(currentPage, pageName, StringComparison.OrdinalIgnoreCase);
        }

        /// <summary>
        /// Vérifie si un utilisateur est connecté (Session active).
        /// Peut être appelé depuis n'importe quelle page enfant via Master.
        /// </summary>
        public bool IsUserConnected()
        {
            return Session["UtilisateurID"] != null;
        }

        /// <summary>
        /// Redirige vers la page de connexion si l'utilisateur n'est pas authentifié.
        /// Appeler en Page_Load des pages protégées.
        ///
        /// Exemple :
        ///   protected void Page_Load(...) {
        ///       ((Site)this.Master).RequireLogin();
        ///   }
        /// </summary>
        public void RequireLogin()
        {
            if (Session["UtilisateurID"] == null)
            {
                Response.Redirect("~/Auth/Login.aspx?redirect=" +
                    Server.UrlEncode(Request.RawUrl));
            }
        }
    }
}
