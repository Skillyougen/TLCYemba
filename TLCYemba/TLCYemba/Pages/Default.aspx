<%@ Page Title="Accueil | TLC Yemba Online Test" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TLC_Yemba.Default" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Accueil | TLC Yemba Online Test
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <%-- ══════════════════════════════════════════════
         HERO SECTION
         ══════════════════════════════════════════════ --%>
    <section class="hero">
        <div class="container">

            <div class="hero-badge">Test de Langue du Camerounais</div>

            <h1 class="hero-title">
                Maîtrisez la Langue
                <span>Yemba</span>
            </h1>

            <p class="hero-subtitle">
                Évaluez et améliorez votre niveau en langue Yemba grâce à des tests
                réalistes inspirés du TOEFL. Listening, Structure, Reading.
            </p>

            <div class="hero-actions">
                <a href="~/Pages/ChoixTest.aspx" runat="server" class="btn btn-gold btn-lg">
                    ▶ Commencer un test
                </a>
                <a href="~/Pages/Historique.aspx" runat="server" class="btn btn-outline btn-lg">
                    📋 Voir mes résultats
                </a>
            </div>

            <%-- Stats --%>
            <div class="hero-stats">
                <div>
                    <div class="hero-stat-num">
                        <asp:Label ID="lblNbQuestions" runat="server" Text="60" />
                    </div>
                    <div class="hero-stat-label">Questions Yemba</div>
                </div>
                <div>
                    <div class="hero-stat-num">3</div>
                    <div class="hero-stat-label">Sections TLC</div>
                </div>
                <div>
                    <div class="hero-stat-num">677</div>
                    <div class="hero-stat-label">Score maximum</div>
                </div>
                <div>
                    <div class="hero-stat-num">
                        <asp:Label ID="lblNbCandidats" runat="server" Text="—" />
                    </div>
                    <div class="hero-stat-label">Candidats inscrits</div>
                </div>
            </div>

        </div>
    </section>

    <%-- ══════════════════════════════════════════════
         MESSAGE DE BIENVENUE (si connecté)
         ══════════════════════════════════════════════ --%>
    <asp:Panel ID="pnlBienvenue" runat="server" Visible="false" CssClass="container" style="padding-top:28px;">
        <div class="alert alert-success">
            👋 Bienvenue,
            <strong><asp:Label ID="lblNomUtilisateur" runat="server" /></strong> !
            Votre dernier score :
            <strong><asp:Label ID="lblDernierScore" runat="server" Text="—" /></strong>
            <a href="~/Pages/Historique.aspx" runat="server" style="margin-left:12px; color:var(--vert-clair);">
                Voir l'historique →
            </a>
        </div>
    </asp:Panel>

    <%-- ══════════════════════════════════════════════
         SECTIONS TLC
         ══════════════════════════════════════════════ --%>
    <section class="py-5" style="background: var(--vert-tres-fonce);">
        <div class="container">

            <div class="section-header">
                <div class="section-eyebrow">Les sections du TLC</div>
                <h2 class="section-title">Que teste le TLC Yemba ?</h2>
                <p class="section-desc">
                    Le Test de Langue du Camerounais évalue trois compétences fondamentales
                    en langue Yemba, sur un score total de 677 points.
                </p>
            </div>

            <div class="sections-grid">

                <%-- Listening --%>
                <div class="section-card">
                    <div class="section-card-icon">👂</div>
                    <h3 class="section-card-title">Listening</h3>
                    <p class="section-card-desc">
                        Compréhension orale. Identifiez des mots, expressions et phrases
                        prononcées en Yemba dans différents contextes quotidiens.
                    </p>
                    <div class="section-card-meta">⏱ 35 min &nbsp;·&nbsp; 50 questions &nbsp;·&nbsp; Score : 31–68</div>
                </div>

                <%-- Structure --%>
                <div class="section-card">
                    <div class="section-card-icon">📐</div>
                    <h3 class="section-card-title">Structure</h3>
                    <p class="section-card-desc">
                        Grammaire et structure linguistique. Maîtrisez les tons, les classes
                        nominales, les conjugaisons et la syntaxe de la langue Yemba.
                    </p>
                    <div class="section-card-meta">⏱ 25 min &nbsp;·&nbsp; 40 questions &nbsp;·&nbsp; Score : 31–68</div>
                </div>

                <%-- Reading --%>
                <div class="section-card">
                    <div class="section-card-icon">📖</div>
                    <h3 class="section-card-title">Reading</h3>
                    <p class="section-card-desc">
                        Compréhension écrite. Lisez et analysez des phrases et courts textes
                        en Yemba pour en saisir le sens, les personnages et les actions.
                    </p>
                    <div class="section-card-meta">⏱ 55 min &nbsp;·&nbsp; 50 questions &nbsp;·&nbsp; Score : 31–67</div>
                </div>

                <%-- Full Test --%>
                <div class="section-card" style="border-color: rgba(201,150,58,0.3);">
                    <div class="section-card-icon">⭐</div>
                    <h3 class="section-card-title" style="color: var(--or);">Full Test</h3>
                    <p class="section-card-desc">
                        Passez les trois sections en une seule session. Obtenez votre score
                        TLC global et un certificat numérique à l'issue du test complet.
                    </p>
                    <div class="section-card-meta" style="color: var(--or);">⏱ 115 min &nbsp;·&nbsp; 140 questions &nbsp;·&nbsp; Score : /677</div>
                </div>

            </div>

        </div>
    </section>

    <%-- ══════════════════════════════════════════════
         COMMENT ÇA MARCHE
         ══════════════════════════════════════════════ --%>
    <section class="how-it-works">
        <div class="container">

            <div class="section-header">
                <div class="section-eyebrow">Déroulement</div>
                <h2 class="section-title">Comment passer le test ?</h2>
            </div>

            <div class="steps-row">
                <div class="step-item">
                    <div class="step-num">1</div>
                    <div class="step-title">Choisir un test</div>
                    <p class="step-desc">Sélectionnez Listening, Structure, Reading ou le Full Test.</p>
                </div>
                <div class="step-item">
                    <div class="step-num">2</div>
                    <div class="step-title">Répondre aux QCM</div>
                    <p class="step-desc">Une question à la fois, avec chronomètre visible.</p>
                </div>
                <div class="step-item">
                    <div class="step-num">3</div>
                    <div class="step-title">Obtenir le score</div>
                    <p class="step-desc">Correction automatique selon la grille TLC.</p>
                </div>
                <div class="step-item">
                    <div class="step-num">4</div>
                    <div class="step-title">Certificat & Classement</div>
                    <p class="step-desc">Téléchargez votre certificat et consultez le classement.</p>
                </div>
            </div>

        </div>
    </section>

    <%-- ══════════════════════════════════════════════
         CTA FINAL
         ══════════════════════════════════════════════ --%>
    <section class="py-5 text-center" style="background: linear-gradient(160deg, #162B10, #0D1F0A);">
        <div class="container-sm">
            <h2 class="section-title">Prêt à tester votre Yemba ?</h2>
            <p class="section-desc mb-4">
                Des centaines de candidats ont déjà évalué leur niveau. À vous de jouer.
            </p>
            <a href="~/Pages/ChoixTest.aspx" runat="server" class="btn btn-gold btn-lg">
                ▶ Commencer maintenant
            </a>
        </div>
    </section>

</asp:Content>
