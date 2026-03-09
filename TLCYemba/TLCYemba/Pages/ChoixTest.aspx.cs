using System;
using System.Data;
using TLC_Yemba.Helpers;

namespace TLC_Yemba.Pages
{
    /// <summary>
    /// Code-behind de ChoixTest.aspx
    /// Responsabilités :
    ///   - Lire le type de test choisi par l'utilisateur
    ///   - Valider le choix
    ///   - Stocker le choix en Session
    ///   - Rediriger vers Test.aspx
    /// </summary>
    public partial class ChoixTest : System.Web.UI.Page
    {
        // Durées affichées dans le résumé (cohérent avec la BDD)
        private readonly System.Collections.Generic.Dictionary<string, string> _durees =
            new System.Collections.Generic.Dictionary<string, string>
            {
                { "Listening", "35 minutes · 50 questions" },
                { "Structure", "25 minutes · 40 questions" },
                { "Reading",   "55 minutes · 50 questions" },
                { "Full Test", "115 minutes · 140 questions" }
            };

        // TestID correspondants dans la BDD (table Tests)
        private readonly System.Collections.Generic.Dictionary<string, int> _testIds =
            new System.Collections.Generic.Dictionary<string, int>
            {
                { "Listening", 1 },
                { "Structure", 2 },
                { "Reading",   3 },
                { "Full Test", 4 }
            };

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Pré-sélection via QueryString : ChoixTest.aspx?type=Structure
                string typeParam = Request.QueryString["type"];
                if (!string.IsNullOrEmpty(typeParam) && _durees.ContainsKey(typeParam))
                {
                    hdnTypeTest.Value = typeParam;
                    AfficherResume(typeParam);
                }
            }
        }

        /// <summary>
        /// Gestionnaire du bouton "Démarrer le test".
        /// Valide le choix, stocke en Session et redirige vers Test.aspx.
        /// </summary>
        protected void btnDemarrer_Click(object sender, EventArgs e)
        {
            string typeChoisi = hdnTypeTest.Value?.Trim();

            // ── Validation ────────────────────────────────────────
            if (string.IsNullOrEmpty(typeChoisi) || !_durees.ContainsKey(typeChoisi))
            {
                pnlErreur.Visible  = true;
                lblErreur.Text     = "Veuillez sélectionner un type de test avant de continuer.";
                pnlResume.Visible  = false;
                return;
            }

            pnlErreur.Visible = false;

            // ── Stockage en Session ───────────────────────────────
            Session["TypeTest"] = typeChoisi;
            Session["TestID"]   = _testIds[typeChoisi];

            // Initialiser les variables de test pour la Partie 3
            Session["IndexQuestion"]  = 0;
            Session["ReponsesTest"]   = null; // sera initialisé dans Test.aspx
            Session["HeureDebutTest"] = DateTime.Now;

            // ── Afficher le résumé (feedback visuel avant redirect) ─
            AfficherResume(typeChoisi);

            // ── Redirection vers Test.aspx ────────────────────────
            Response.Redirect("~/Pages/Test.aspx");
        }

        /// <summary>
        /// Affiche le panneau de résumé avec le type et la durée sélectionnés.
        /// </summary>
        private void AfficherResume(string typeTest)
        {
            if (_durees.ContainsKey(typeTest))
            {
                pnlResume.Visible     = true;
                lblResumeType.Text    = typeTest;
                lblResumeDuree.Text   = _durees[typeTest];
            }
        }
    }
}
