// ═══════════════════════════════════════════════════════════════════════
//  TLC YEMBA — PARTIE 4 : UI
//  Fichier  : Pages/Resultat.aspx.cs
//  Namespace: TLC_Yemba.Pages
//  Couche   : UI — n'appelle que ScoreService (BLL), jamais la DAL
// ═══════════════════════════════════════════════════════════════════════
using System;
using System.Collections.Generic;
using System.Web.UI;
using TLC_Yemba.BLL;
using TLC_Yemba.Models;

namespace TLC_Yemba.Pages
{
    public partial class Resultat : Page
    {
        // ── Clés Session ─────────────────────────────────────────────
        private const string SESS_REPONSES    = "Test_Reponses";
        private const string SESS_QUESTIONS   = "Test_Questions";
        private const string SESS_DUREE       = "Test_DureeReelle";
        private const string SESS_TYPE        = "TypeTest";
        private const string SESS_TEST_ID     = "TestID";
        private const string SESS_USER_ID     = "UtilisateurID";
        private const string SESS_SCORE       = "DernierScore";
        private const string SESS_RESULTAT_ID = "DernierResultatID";

        // ─────────────────────────────────────────────────────────────
        // PAGE LOAD
        // ─────────────────────────────────────────────────────────────
        protected void Page_Load(object sender, EventArgs e)
        {
            // Vérifier que le test a bien été passé
            if (Session[SESS_REPONSES] == null || Session[SESS_QUESTIONS] == null)
            {
                Response.Redirect("~/Pages/ChoixTest.aspx");
                return;
            }

            if (!IsPostBack)
            {
                CalculerEtAfficher();
            }
        }

        // ─────────────────────────────────────────────────────────────
        // CALCULER ET AFFICHER
        // ─────────────────────────────────────────────────────────────
        private void CalculerEtAfficher()
        {
            var reponses  = Session[SESS_REPONSES]  as Dictionary<int, string>
                            ?? new Dictionary<int, string>();
            var questions = Session[SESS_QUESTIONS] as List<Question>
                            ?? new List<Question>();

            // === BLL : correction + calcul scores ===
            ScoreResult score = ScoreService.CalculerScore(reponses, questions);
            score.TypeTest = Session[SESS_TYPE]?.ToString() ?? "Test";

            // === BLL : persistance en base ===
            int utilisateurId = Session[SESS_USER_ID] is int uid ? uid : 1;
            int testId        = Session[SESS_TEST_ID]  is int tid ? tid : 1;
            int? duree        = Session[SESS_DUREE]    is int dur ? dur : (int?)null;

            int resultatId = ScoreService.EnregistrerResultat(
                score, reponses, questions, utilisateurId, testId, duree);

            // Stocker pour Parties 5 & 6
            Session[SESS_SCORE]       = score;
            Session[SESS_RESULTAT_ID] = resultatId;

            // Afficher
            AfficherScores(score);
            AfficherCorrection(score);
        }

        // ─────────────────────────────────────────────────────────────
        // AFFICHER LES SCORES
        // ─────────────────────────────────────────────────────────────
        private void AfficherScores(ScoreResult score)
        {
            litScoreTotal.Text = score.ScoreTotal.ToString();
            litNiveau.Text     = score.Niveau;
            litTypeTest.Text   = score.TypeTest;

            // Durée formatée
            int? duree = Session[SESS_DUREE] as int?;
            if (duree.HasValue)
            {
                int min = duree.Value / 60;
                int sec = duree.Value % 60;
                litDuree.Text = $"{min} min {sec:D2} sec";
            }
            else
            {
                litDuree.Text = "—";
            }

            // Pourcentage pour la barre (sur 677)
            int pct = score.ScoreTotal > 0
                      ? (int)Math.Round((score.ScoreTotal / 677.0) * 100)
                      : 0;
            litPourcentage.Text   = pct.ToString();
            litPourcentageJS.Text = pct.ToString();

            // ── Listening ──────────────────────────────────────────
            if (score.ScoreListening.HasValue)
            {
                litScoreListening.Text = score.ScoreListening.Value.ToString();
                litBrutListening.Text  = score.BrutListening.ToString();
            }
            else
            {
                pnlListening.CssClass += " absent";
                litScoreListening.Text = "—";
                litBrutListening.Text  = "0";
            }

            // ── Structure ─────────────────────────────────────────
            if (score.ScoreStructure.HasValue)
            {
                litScoreStructure.Text = score.ScoreStructure.Value.ToString();
                litBrutStructure.Text  = score.BrutStructure.ToString();
            }
            else
            {
                pnlStructure.CssClass += " absent";
                litScoreStructure.Text = "—";
                litBrutStructure.Text  = "0";
            }

            // ── Reading ───────────────────────────────────────────
            if (score.ScoreReading.HasValue)
            {
                litScoreReading.Text = score.ScoreReading.Value.ToString();
                litBrutReading.Text  = score.BrutReading.ToString();
            }
            else
            {
                pnlReading.CssClass += " absent";
                litScoreReading.Text = "—";
                litBrutReading.Text  = "0";
            }

            // Masquer les sections absentes pour un test partiel
            // (garder uniquement les sections présentes)
            bool isFullTest = score.TypeTest
                .Equals("Full Test", StringComparison.OrdinalIgnoreCase);

            if (!isFullTest)
            {
                pnlListening.Visible = score.ScoreListening.HasValue;
                pnlStructure.Visible = score.ScoreStructure.HasValue;
                pnlReading.Visible   = score.ScoreReading.HasValue;
            }
        }

        // ─────────────────────────────────────────────────────────────
        // AFFICHER LA CORRECTION DÉTAILLÉE
        // ─────────────────────────────────────────────────────────────
        private void AfficherCorrection(ScoreResult score)
        {
            if (score.CorrectionDetaillee == null
                || score.CorrectionDetaillee.Count == 0)
            {
                pnlCorrection.Visible = false;
                return;
            }

            rptCorrection.DataSource = score.CorrectionDetaillee;
            rptCorrection.DataBind();
        }

        // ─────────────────────────────────────────────────────────────
        // BOUTONS
        // ─────────────────────────────────────────────────────────────
        protected void btnCertificat_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/Certificat.aspx");
        }

        protected void btnLeaderboard_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/Leaderboard.aspx");
        }

        protected void btnNouveauTest_Click(object sender, EventArgs e)
        {
            // Nettoyer la session du test (garder l'utilisateur connecté)
            Session.Remove(SESS_REPONSES);
            Session.Remove(SESS_QUESTIONS);
            Session.Remove(SESS_DUREE);
            Session.Remove("Test_IndexCourant");
            Response.Redirect("~/Pages/ChoixTest.aspx");
        }
    }
}
