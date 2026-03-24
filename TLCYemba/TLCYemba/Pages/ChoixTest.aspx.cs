using System;
using TLCYemba.BLL;

namespace TLCYemba
{
    /// <summary>
    /// Page de sélection du type de test — Couche UI.
    /// Règle d'or : la UI appelle uniquement la BLL, jamais la DAL directement.
    /// </summary>
    public partial class ChoixTest : System.Web.UI.Page
    {
        // ── Service BLL ──
        private readonly ChoixTestService _service = new ChoixTestService();

        // ────────────────────────────────────────────────
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Pré-sélectionner depuis QueryString si l'utilisateur vient
                // de la page d'accueil avec un ?section=Listening, etc.
                string section = Request.QueryString["section"];
                if (!string.IsNullOrEmpty(section))
                {
                    PreselectionnerDepuisQueryString(section);
                }
            }
        }

        // ────────────────────────────────────────────────
        /// <summary>
        /// Clic sur « Commencer le Test ».
        /// Délègue la validation et le stockage en session à la BLL.
        /// </summary>
        protected void btnCommencer_Click(object sender, EventArgs e)
        {
            // Récupérer la valeur du radio sélectionné
            string typeTest = GetSelectedRadioValue();

            // Valider via BLL
            string erreur = _service.ValiderChoix(typeTest);
            if (!string.IsNullOrEmpty(erreur))
            {
                AfficherErreur(erreur);
                return;
            }

            // Stocker le choix en session via BLL
            _service.EnregistrerChoixEnSession(Session, typeTest);

            // Redirection vers la page de test
            Response.Redirect("Test.aspx");
        }

        // ── Helpers privés ──────────────────────────────

        /// <summary>
        /// Lit la valeur du groupe de radios côté serveur.
        /// Les radios sont nommés "typeTest" (attribut name en HTML).
        /// </summary>
        private string GetSelectedRadioValue()
        {
            return Request.Form["typeTest"];
        }

        /// <summary>
        /// Pré-coche le radio correspondant au paramètre QueryString
        /// et marque le bouton comme actif.
        /// </summary>
        private void PreselectionnerDepuisQueryString(string section)
        {
            string[] valides = { "Listening", "Structure", "Reading", "FullTest" };
            foreach (string v in valides)
            {
                if (string.Equals(v, section, StringComparison.OrdinalIgnoreCase))
                {
                    // Injecter un script JS pour déclencher selectCard côté client
                    string[] labels = {
                        "Listening — Compréhension Orale",
                        "Structure — Grammaire",
                        "Reading — Compréhension Écrite",
                        "Test Complet TLC"
                    };
                    string[] icons = { "🎧", "📝", "📖", "🏆" };
                    string[] cardIds = { "cardListening", "cardStructure", "cardReading", "cardFullTest" };

                    int idx = Array.IndexOf(valides, v);
                    string script = string.Format(
                        "window.addEventListener('DOMContentLoaded', function(){{ selectCard('{0}','{1}','{2}','{3}'); }});",
                        v, cardIds[idx], icons[idx], labels[idx]
                    );
                    ClientScript.RegisterStartupScript(GetType(), "preselectSection", script, true);
                    break;
                }
            }
        }

        /// <summary>
        /// Affiche le message d'erreur côté serveur.
        /// </summary>
        private void AfficherErreur(string message)
        {
            //lblErreur.Text    = "⚠️ " + message;
            //lblErreur.Visible = true;
        }
    }
}
