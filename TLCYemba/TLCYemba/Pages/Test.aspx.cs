// ═══════════════════════════════════════════════════════════════════════
//  TLC YEMBA — PARTIE 3 : Test QCM + Chronomètre
//  Fichier  : Pages/Test.aspx.cs
//  Namespace: TLC_Yemba.Pages
//  Couche   : UI — n'appelle que la BLL, jamais la DAL directement
// ═══════════════════════════════════════════════════════════════════════
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using TLC_Yemba.BLL;
using TLC_Yemba.Models;

namespace TLC_Yemba.Pages
{
    public partial class Test : Page
    {
        // ── Clés Session ─────────────────────────────────────────────
        private const string SESS_QUESTIONS  = "Test_Questions";
        private const string SESS_INDEX      = "Test_IndexCourant";
        private const string SESS_REPONSES   = "Test_Reponses";
        private const string SESS_HEURE_DEB  = "HeureDebutTest";
        private const string SESS_TYPE_TEST  = "TypeTest";
        private const string SESS_TEST_ID    = "TestID";
        private const string SESS_USER_ID    = "UtilisateurID";

        // ── Propriétés helpers ────────────────────────────────────────
        private List<Question> Questions
        {
            get => Session[SESS_QUESTIONS] as List<Question>;
            set => Session[SESS_QUESTIONS] = value;
        }

        private int IndexCourant
        {
            get => Session[SESS_INDEX] is int i ? i : 0;
            set => Session[SESS_INDEX] = value;
        }

        private Dictionary<int, string> Reponses
        {
            get
            {
                if (Session[SESS_REPONSES] == null)
                    Session[SESS_REPONSES] = new Dictionary<int, string>();
                return (Dictionary<int, string>)Session[SESS_REPONSES];
            }
        }

        // ─────────────────────────────────────────────────────────────
        // PAGE LOAD
        // ─────────────────────────────────────────────────────────────
        protected void Page_Load(object sender, EventArgs e)
        {
            // Vérifier qu'un type de test a été sélectionné
            if (Session[SESS_TYPE_TEST] == null)
            {
                Response.Redirect("~/Pages/ChoixTest.aspx");
                return;
            }

            if (!IsPostBack)
            {
                ChargerQuestions();
                InitialiserChronometre();
                IndexCourant = 0;
            }

            AfficherQuestion(IndexCourant);
        }

        // ─────────────────────────────────────────────────────────────
        // CHARGEMENT DES QUESTIONS via BLL
        // UI → BLL.TestService.ChargerQuestions() → DAL.QuestionRepository
        // ─────────────────────────────────────────────────────────────
        private void ChargerQuestions()
        {
            string typeTest = Session[SESS_TYPE_TEST]?.ToString();
            int testId      = Session[SESS_TEST_ID] is int id ? id : 1;

            // === APPEL BLL (jamais DAL directement) ===
            var questions = TestService.ChargerQuestions(typeTest, testId);

            if (questions == null || questions.Count == 0)
            {
                // Fallback : rediriger si aucune question
                Session["ErreurTest"] = "Aucune question disponible pour ce test.";
                Response.Redirect("~/Pages/ChoixTest.aspx");
                return;
            }

            Questions = questions;
        }

        // ─────────────────────────────────────────────────────────────
        // INITIALISATION DU CHRONOMÈTRE
        // ─────────────────────────────────────────────────────────────
        private void InitialiserChronometre()
        {
            string typeTest = Session[SESS_TYPE_TEST]?.ToString();

            // Durée en secondes via BLL
            int dureeSecondes = TestService.ObtenirDureeSecondes(typeTest);
            hdnSecondesRestantes.Value = dureeSecondes.ToString();

            // Heure de début si pas encore définie
            if (Session[SESS_HEURE_DEB] == null)
                Session[SESS_HEURE_DEB] = DateTime.Now;
        }

        // ─────────────────────────────────────────────────────────────
        // AFFICHAGE D'UNE QUESTION
        // ─────────────────────────────────────────────────────────────
        private void AfficherQuestion(int index)
        {
            var questions = Questions;
            if (questions == null || questions.Count == 0) return;

            // Sécuriser les bornes
            index = Math.Max(0, Math.Min(index, questions.Count - 1));
            IndexCourant = index;

            var q = questions[index];

            // ── Labels de navigation ──────────────────────────────────
            litSection.Text      = Session[SESS_TYPE_TEST]?.ToString() ?? "Test";
            litTitreTest.Text    = Session[SESS_TYPE_TEST]?.ToString() ?? "Test";
            litIndexAffiche.Text = (index + 1).ToString();
            litTotal.Text        = questions.Count.ToString();
            litNumQuestion.Text  = (index + 1).ToString();
            litEnonce.Text       = Server.HtmlEncode(q.Enonce);

            // ── Injecter données pour le JS ───────────────────────────
            litSecondes.Text      = hdnSecondesRestantes.Value;
            litTotalJS.Text       = questions.Count.ToString();
            litIndexJS.Text       = (index + 1).ToString();
            litReponsesCount.Text = Reponses.Count.ToString();

            // ── Options QCM ───────────────────────────────────────────
            phOptions.Controls.Clear();
            var choix = new[] {
                ("A", q.ChoixA),
                ("B", q.ChoixB),
                ("C", q.ChoixC),
                ("D", q.ChoixD)
            };

            string reponseExistante = Reponses.ContainsKey(q.QuestionID)
                                      ? Reponses[q.QuestionID]
                                      : "";

            foreach (var (lettre, texte) in choix)
            {
                bool selected = reponseExistante == lettre;

                // Label cliquable
                var label = new HtmlGenericControl("label");
                label.Attributes["class"] = "option-label" + (selected ? " selected" : "");

                // Radio input caché
                var radio = new HtmlInputRadioButton();
                radio.Name     = "qcm_reponse";
                radio.Value    = lettre;
                radio.Checked  = selected;
                radio.Attributes["class"] = "option-radio-input";

                // Cercle custom
                var cercle = new HtmlGenericControl("span");
                cercle.Attributes["class"] = "option-radio-custom";

                // Lettre
                var spanLettre = new HtmlGenericControl("span");
                spanLettre.Attributes["class"] = "option-lettre";
                spanLettre.InnerText = lettre + ".";

                // Texte
                var spanTexte = new HtmlGenericControl("span");
                spanTexte.Attributes["class"] = "option-texte";
                spanTexte.InnerText = texte;

                label.Controls.Add(radio);
                label.Controls.Add(cercle);
                label.Controls.Add(spanLettre);
                label.Controls.Add(spanTexte);
                phOptions.Controls.Add(label);
            }

            // ── Points de navigation (nav dots) ──────────────────────
            phNavDots.Controls.Clear();
            for (int i = 0; i < questions.Count; i++)
            {
                var dot = new HtmlGenericControl("span");
                string css = "nav-dot";
                if (i == index)                                   css += " current";
                else if (Reponses.ContainsKey(questions[i].QuestionID)) css += " answered";
                dot.Attributes["class"] = css;
                dot.Attributes["title"] = $"Question {i + 1}";
                phNavDots.Controls.Add(dot);
            }

            // ── Boutons navigation ────────────────────────────────────
            btnPrecedent.Visible = (index > 0);
            btnSuivant.Text      = (index == questions.Count - 1) ? "Dernière →" : "Suivant →";
        }

        // ─────────────────────────────────────────────────────────────
        // SAUVEGARDER LA RÉPONSE DE LA QUESTION COURANTE
        // ─────────────────────────────────────────────────────────────
        private void SauvegarderReponse()
        {
            string valeur = hdnReponseSelectionnee.Value?.Trim().ToUpper();
            if (string.IsNullOrEmpty(valeur)) return;

            var questions = Questions;
            if (questions == null || IndexCourant >= questions.Count) return;

            int questionId = questions[IndexCourant].QuestionID;
            var reponses   = Reponses;

            if (valeur == "A" || valeur == "B" || valeur == "C" || valeur == "D")
                reponses[questionId] = valeur;

            Session[SESS_REPONSES] = reponses;

            // Mettre à jour le chrono depuis le hidden field
            if (int.TryParse(hdnSecondesRestantes.Value, out int sec))
                hdnSecondesRestantes.Value = sec.ToString();
        }

        // ─────────────────────────────────────────────────────────────
        // BOUTON SUIVANT
        // ─────────────────────────────────────────────────────────────
        protected void btnSuivant_Click(object sender, EventArgs e)
        {
            SauvegarderReponse();
            var questions = Questions;
            if (questions != null && IndexCourant < questions.Count - 1)
                IndexCourant++;
            AfficherQuestion(IndexCourant);
        }

        // ─────────────────────────────────────────────────────────────
        // BOUTON PRÉCÉDENT
        // ─────────────────────────────────────────────────────────────
        protected void btnPrecedent_Click(object sender, EventArgs e)
        {
            SauvegarderReponse();
            if (IndexCourant > 0)
                IndexCourant--;
            AfficherQuestion(IndexCourant);
        }

        // ─────────────────────────────────────────────────────────────
        // BOUTON TERMINER (bouton caché + confirmation JS)
        // ─────────────────────────────────────────────────────────────
        protected void btnTerminer_Click(object sender, EventArgs e)
        {
            SauvegarderReponse();

            // Calculer la durée réelle en secondes
            DateTime heureDebut = Session[SESS_HEURE_DEB] is DateTime hd ? hd : DateTime.Now;
            int dureeReelle     = (int)(DateTime.Now - heureDebut).TotalSeconds;

            // Stocker les données pour Resultat.aspx (Partie 4)
            Session["Test_Reponses"]    = Reponses;
            Session["Test_DureeReelle"] = dureeReelle;

            // Redirection vers la page de résultats (Partie 4)
            Response.Redirect("~/Pages/Resultat.aspx");
        }
    }
}
