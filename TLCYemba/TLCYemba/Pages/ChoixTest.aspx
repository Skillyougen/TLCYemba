<%@ Page Title="Choisir un test | TLC Yemba" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="ChoixTest.aspx.cs" Inherits="TLC_Yemba.Pages.ChoixTest" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Choisir un test | TLC Yemba
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <section class="choix-test-section">
        <div class="container-sm">

            <%-- En-tête --%>
            <div class="section-header">
                <div class="section-eyebrow">Étape 1 / 3</div>
                <h1 class="section-title">Quel test voulez-vous passer ?</h1>
                <p class="section-desc">
                    Choisissez une section ou passez le test complet TLC Yemba.
                </p>
            </div>

            <%-- Message d'erreur (validation) --%>
            <asp:Panel ID="pnlErreur" runat="server" Visible="false" CssClass="alert alert-error mb-3">
                ⚠️ <asp:Label ID="lblErreur" runat="server" Text="Veuillez sélectionner un type de test avant de continuer." />
            </asp:Panel>

            <%-- Champ hidden pour stocker le choix (alimenté par JS) --%>
            <asp:HiddenField ID="hdnTypeTest" runat="server" Value="" />

            <%-- Grille des 4 choix --%>
            <div class="choix-grid" id="choixGrid">

                <%-- Listening --%>
                <div class="choix-card" id="card_Listening" onclick="selectionnerTest('Listening', this)">
                    <div class="choix-card-check" id="chk_Listening">✓</div>
                    <span class="choix-card-icon">👂</span>
                    <h2 class="choix-card-title">Listening</h2>
                    <p class="choix-card-desc">
                        Compréhension orale en Yemba. Identifiez mots, expressions
                        et contextes à partir de phrases prononcées.
                    </p>
                    <div class="choix-card-info">
                        <span class="choix-info-badge">⏱ 35 min</span>
                        <span class="choix-info-badge">❓ 50 questions</span>
                    </div>
                </div>

                <%-- Structure --%>
                <div class="choix-card" id="card_Structure" onclick="selectionnerTest('Structure', this)">
                    <div class="choix-card-check" id="chk_Structure">✓</div>
                    <span class="choix-card-icon">📐</span>
                    <h2 class="choix-card-title">Structure</h2>
                    <p class="choix-card-desc">
                        Grammaire et structure de la langue Yemba. Tons, classes
                        nominales, conjugaisons et ordre des mots.
                    </p>
                    <div class="choix-card-info">
                        <span class="choix-info-badge">⏱ 25 min</span>
                        <span class="choix-info-badge">❓ 40 questions</span>
                    </div>
                </div>

                <%-- Reading --%>
                <div class="choix-card" id="card_Reading" onclick="selectionnerTest('Reading', this)">
                    <div class="choix-card-check" id="chk_Reading">✓</div>
                    <span class="choix-card-icon">📖</span>
                    <h2 class="choix-card-title">Reading</h2>
                    <p class="choix-card-desc">
                        Compréhension écrite de textes Yemba. Sens des phrases,
                        identification de personnages et d'actions.
                    </p>
                    <div class="choix-card-info">
                        <span class="choix-info-badge">⏱ 55 min</span>
                        <span class="choix-info-badge">❓ 50 questions</span>
                    </div>
                </div>

                <%-- Full Test --%>
                <div class="choix-card" id="card_Full Test" onclick="selectionnerTest('Full Test', this)">
                    <div class="choix-card-check" id="chk_FullTest">✓</div>
                    <span class="choix-card-icon">⭐</span>
                    <h2 class="choix-card-title" style="color:var(--or);">Full Test</h2>
                    <p class="choix-card-desc">
                        Test complet TLC : toutes les sections enchaînées. Obtenez
                        votre score global sur 677 et un certificat numérique.
                    </p>
                    <div class="choix-card-info">
                        <span class="choix-info-badge" style="color:var(--or);">⏱ 115 min</span>
                        <span class="choix-info-badge" style="color:var(--or);">❓ 140 questions</span>
                    </div>
                </div>

            </div>

            <%-- Résumé de la sélection + bouton Démarrer --%>
            <div class="mt-4 text-center">

                <asp:Panel ID="pnlResume" runat="server" Visible="false"
                    CssClass="alert alert-info mb-3" style="justify-content:center; text-align:left; max-width:500px; margin:0 auto 20px;">
                    ✅ Test sélectionné :
                    <strong><asp:Label ID="lblResumeType" runat="server" /></strong>
                    &nbsp;—&nbsp;
                    <asp:Label ID="lblResumeDuree" runat="server" />
                </asp:Panel>

                <asp:Button ID="btnDemarrer"
                    runat="server"
                    Text="▶ Démarrer le test"
                    CssClass="btn btn-gold btn-lg"
                    OnClick="btnDemarrer_Click" />

                <a href="~/Default.aspx" runat="server" class="btn btn-outline btn-lg" style="margin-left:16px;">
                    ← Retour à l'accueil
                </a>

            </div>

        </div>
    </section>

</asp:Content>

<%-- ══════════ SCRIPTS ══════════ --%>
<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
    var typeSelectionne = '';
    var durees = {
        'Listening': '35 min · 50 questions',
        'Structure': '25 min · 40 questions',
        'Reading':   '55 min · 50 questions',
        'Full Test': '115 min · 140 questions'
    };

    function selectionnerTest(type, card) {
        // Retirer la sélection de toutes les cartes
        document.querySelectorAll('.choix-card').forEach(function(c) {
            c.classList.remove('selected');
        });

        // Sélectionner la carte cliquée
        card.classList.add('selected');
        typeSelectionne = type;

        // Stocker dans le champ caché (lu par le code-behind C#)
        document.getElementById('<%= hdnTypeTest.ClientID %>').value = type;

        // Mettre à jour le résumé visible
        // (Le panneau devient visible au postback, mais on peut aussi l'afficher en JS)
        console.log('Test sélectionné :', type);
    }

    // Pré-sélectionner si un paramètre est passé dans l'URL
    window.onload = function() {
        var params = new URLSearchParams(window.location.search);
        var type = params.get('type');
        if (type) {
            var card = document.getElementById('card_' + type);
            if (card) selectionnerTest(type, card);
        }

        // Restaurer la sélection si la page a été rechargée (postback)
        var hdnVal = document.getElementById('<%= hdnTypeTest.ClientID %>').value;
        if (hdnVal) {
            var cardExistant = document.getElementById('card_' + hdnVal);
            if (cardExistant) cardExistant.classList.add('selected');
        }
    };
</script>
</asp:Content>
