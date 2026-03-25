using System;
using System.Collections.Generic;
using System.Web.UI;
using TLCYemba.BLL;
using TLCYemba.Models;
using TLCYemba.BLL;
using TLC_Yemba.Pages;

namespace TLCYemba
{
    /// <summary>
    /// Page de test QCM chronométré — Couche UI.
    /// Respecte la règle d'or : UI appelle uniquement la BLL.
    /// </summary>
    public partial class Test : Page
    {
        // ── Propriétés exposées au JavaScript via <%= %> ──
        public int    NbQuestions  { get; private set; }
        public int    IndexCourant { get; private set; }
        public int    DureeMinutes { get; private set; }
        public string AnsweredJSON { get; private set; }

        // ── BLL ──
        private readonly TestService _service = new TestService();

        // ── Clé de session pour l'index courant ──
        private const string SK_INDEX = "QuestionActuelle";

        // ────────────────────────────────────────────────────
        protected void Page_Load(object sender, EventArgs e)
        {
            // Vérifier que le type de test est en session
            if (Session["TypeTest"] == null)
            {
                Response.Redirect("ChoixTest.aspx");
                return;
            }

            string typeTest = Session["TypeTest"].ToString();
            NbQuestions  = Session["NbQuestions"] != null ? (int)Session["NbQuestions"] : 0;
            DureeMinutes = Session["DureeMinutes"] != null ? (int)Session["DureeMinutes"] : 30;

            if (!IsPostBack)
            {
                // Premier chargement : initialiser l'index à 0
                Session[SK_INDEX] = 0;
                InitialiserReponses();
            }

            // Lire l'index courant
            IndexCourant = Session[SK_INDEX] != null ? (int)Session[SK_INDEX] : 0;

            // Charger la question via BLL
            var q = _service.GetQuestion(typeTest, IndexCourant);
            if (q == null)
            {
                Response.Redirect("Resultat.aspx");
                return;
            }

            // Remplir l'UI
            AfficherQuestion(q, IndexCourant, NbQuestions, typeTest);

            // JSON des index déjà répondus (pour les dots JS)
            AnsweredJSON = BuildAnsweredJSON();

            // Label info navigation
            lblQInfo.Text = string.Format(
                "<i class='fa-solid fa-flag' style='margin-right:5px;color:var(--teal)'></i>" +
                "Question {0} sur {1}", IndexCourant + 1, NbQuestions);
        }

        // ────────────────────────────────────────────────────
        protected void btnSuivant_Click(object sender, EventArgs e)
        {
            SauvegarderReponse();
            int idx = (int)Session[SK_INDEX];
            if (idx < NbQuestions - 1)
                Session[SK_INDEX] = idx + 1;
            else
                Response.Redirect("Resultat.aspx");
        }

        protected void btnPrecedent_Click(object sender, EventArgs e)
        {
            SauvegarderReponse();
            int idx = (int)Session[SK_INDEX];
            if (idx > 0)
                Session[SK_INDEX] = idx - 1;
        }

        protected void btnTerminer_Click(object sender, EventArgs e)
        {
            SauvegarderReponse();
            Response.Redirect("Resultat.aspx");
        }

        // ── Helpers privés ────────────────────────────────

        private void InitialiserReponses()
        {
            if (Session["Reponses"] == null)
                Session["Reponses"] = new Dictionary<int, string>();
        }

        private void SauvegarderReponse()
        {
            // Lire la valeur du HiddenField
            string val = hfReponse.Value;
            if (!string.IsNullOrEmpty(val))
            {
                int idx = (int)Session[SK_INDEX];
                var rep = (Dictionary<int, string>)Session["Reponses"];
                rep[idx] = val;
                Session["Reponses"] = rep;
            }
        }

        private void AfficherQuestion(
            Models.Question q, int index, int total, string typeTest)
        {
            // Numero et section
            litNumero.Text    = (index + 1).ToString();
            litSection.Text   = typeTest;
            litSectionTag.Text = q.Section;
            litTotalModal.Text = total.ToString();

            // Libelle section badge icon
            string icon = q.Section == "Listening" ? "fa-headphones" :
                          q.Section == "Structure"  ? "fa-pen-nib" : "fa-book-open";
            lblSectionBadge.Text = string.Format(
                "<i class='fa-solid {0}'></i>&nbsp;{1}", icon, q.Section);

            // Audio (Listening)
            if (q.HasAudio)
            {
                pnlAudio.CssClass = "audio-panel";
                string audioUrl = ResolveUrl("~/" + q.FichierAudio);
                ClientScript.RegisterStartupScript(GetType(), "loadAudio",
                    string.Format(
                        "document.getElementById('audioSrc').src='{0}';" +
                        "document.getElementById('audioPlayer').load();",
                        audioUrl), true);
            }
            else
            {
                pnlAudio.CssClass = "audio-panel hidden";
            }

            // Texte de la question
            litEnonce.Text  = q.Enonce;
            litChoixA.Text  = q.ChoixA;
            litChoixB.Text  = q.ChoixB;
            litChoixC.Text  = q.ChoixC;
            litChoixD.Text  = q.ChoixD;

            // Restaurer la réponse déjà saisie
            var rep = (Dictionary<int, string>)Session["Reponses"];
            if (rep != null && rep.ContainsKey(index))
            {
                string prev = rep[index];
                rdA.Checked = (prev == "A");
                rdB.Checked = (prev == "B");
                rdC.Checked = (prev == "C");
                rdD.Checked = (prev == "D");
                hfReponse.Value = prev;
            }
            else
            {
                rdA.Checked = rdB.Checked = rdC.Checked = rdD.Checked = false;
                hfReponse.Value = "";
            }

            // Boutons navigation
            btnPrecedent.Enabled = (index > 0);
            bool isLast = (index == total - 1);
            btnSuivant.Visible = !isLast;
            btnTerminer.Visible = isLast;
        }

        private string BuildAnsweredJSON()
        {
            var rep = Session["Reponses"] as Dictionary<int, string>;
            if (rep == null || rep.Count == 0) return "[]";
            var sb = new System.Text.StringBuilder("[");
            bool first = true;
            foreach (var k in rep.Keys)
            {
                if (!first) sb.Append(",");
                sb.Append(k);
                first = false;
            }
            sb.Append("]");
            return sb.ToString();
        }
    }
}
