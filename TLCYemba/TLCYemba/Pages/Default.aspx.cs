using System;

namespace TLCYemba
{
    /// <summary>
    /// Page d'accueil — TLC Yemba Online Test
    /// Couche UI : aucune logique métier ici, uniquement la navigation.
    /// </summary>
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Rien à charger côté serveur pour la page d'accueil.
            // La navigation vers ChoixTest.aspx / Historique.aspx 
            // est gérée via des liens <a> côté HTML.
        }
    }
}