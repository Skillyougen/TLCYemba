<%@ Page Title="Résultats — TLC Yemba" Language="C#" MasterPageFile="~/Site.master"
         AutoEventWireup="true" CodeBehind="Resultat.aspx.cs"
         Inherits="TLC_Yemba.Pages.Resultat" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Résultats — TLC Yemba
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        /* ── LAYOUT ──────────────────────────────────────────── */
        .resultat-wrapper {
            max-width: 860px;
            margin: 0 auto;
            padding: 40px 24px;
        }

        /* ── HERO SCORE ──────────────────────────────────────── */
        .score-hero {
            background: linear-gradient(135deg, #1E3A14, #2D5016);
            border: 1px solid rgba(201,150,58,0.35);
            border-radius: 16px;
            padding: 48px 40px;
            text-align: center;
            margin-bottom: 32px;
            position: relative;
            overflow: hidden;
        }
        .score-hero::before {
            content: '';
            position: absolute;
            top: -60px; right: -60px;
            width: 240px; height: 240px;
            border-radius: 50%;
            background: rgba(201,150,58,0.07);
        }
        .score-hero-label {
            font-family: 'Space Mono', monospace;
            font-size: 11px;
            letter-spacing: 3px;
            color: var(--vert2);
            text-transform: uppercase;
            margin-bottom: 12px;
        }
        .score-hero-valeur {
            font-family: 'Playfair Display', serif;
            font-size: 80px;
            font-weight: 700;
            color: var(--or);
            line-height: 1;
            margin-bottom: 4px;
        }
        .score-hero-max {
            font-family: 'Space Mono', monospace;
            font-size: 18px;
            color: rgba(255,255,255,0.4);
            margin-bottom: 20px;
        }
        .score-hero-niveau {
            display: inline-block;
            background: rgba(201,150,58,0.15);
            border: 1px solid rgba(201,150,58,0.4);
            border-radius: 30px;
            padding: 8px 28px;
            font-family: 'Space Mono', monospace;
            font-size: 14px;
            color: var(--or);
            letter-spacing: 1px;
            margin-bottom: 16px;
        }
        .score-hero-typetest {
            font-size: 13px;
            color: rgba(255,255,255,0.5);
            font-family: 'Source Sans 3', sans-serif;
        }

        /* ── CARDS SECTIONS ──────────────────────────────────── */
        .sections-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 16px;
            margin-bottom: 32px;
        }
        .section-card {
            background: var(--fond2);
            border: 1px solid rgba(74,124,47,0.2);
            border-radius: 12px;
            padding: 24px 20px;
            text-align: center;
        }
        .section-card-icone {
            font-size: 28px;
            margin-bottom: 10px;
        }
        .section-card-nom {
            font-family: 'Space Mono', monospace;
            font-size: 11px;
            letter-spacing: 2px;
            color: #6B7280;
            text-transform: uppercase;
            margin-bottom: 10px;
        }
        .section-card-score {
            font-family: 'Playfair Display', serif;
            font-size: 38px;
            font-weight: 700;
            color: var(--vert2);
            line-height: 1;
        }
        .section-card-brut {
            font-family: 'Space Mono', monospace;
            font-size: 12px;
            color: #6B7280;
            margin-top: 6px;
        }
        .section-card.absent {
            opacity: 0.3;
        }

        /* ── BARRE DE PERFORMANCE ────────────────────────────── */
        .perf-barre-wrap {
            background: var(--fond2);
            border: 1px solid rgba(74,124,47,0.2);
            border-radius: 12px;
            padding: 24px 28px;
            margin-bottom: 32px;
        }
        .perf-barre-label {
            display: flex;
            justify-content: space-between;
            font-family: 'Space Mono', monospace;
            font-size: 11px;
            color: #6B7280;
            margin-bottom: 10px;
        }
        .perf-bg {
            background: rgba(74,124,47,0.12);
            border-radius: 6px;
            height: 12px;
            overflow: hidden;
        }
        .perf-fill {
            height: 100%;
            border-radius: 6px;
            background: linear-gradient(90deg, var(--vert), var(--or));
            transition: width 1.2s ease;
        }
        .perf-seuils {
            display: flex;
            justify-content: space-between;
            margin-top: 8px;
        }
        .perf-seuil {
            font-family: 'Space Mono', monospace;
            font-size: 10px;
            color: rgba(255,255,255,0.25);
        }

        /* ── ACTIONS ─────────────────────────────────────────── */
        .resultat-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 14px;
            justify-content: center;
            margin-bottom: 40px;
        }
        .btn-certif {
            background: linear-gradient(135deg, var(--or), #A8782A);
            color: #1A0F00;
            font-family: 'Space Mono', monospace;
            font-size: 13px;
            font-weight: 700;
            border: none;
            border-radius: 8px;
            padding: 14px 32px;
            cursor: pointer;
            letter-spacing: 1px;
        }
        .btn-certif:hover { opacity: 0.9; }

        /* ── CORRECTION DÉTAILLÉE ────────────────────────────── */
        .correction-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            cursor: pointer;
            background: var(--fond2);
            border: 1px solid rgba(74,124,47,0.2);
            border-radius: 10px;
            padding: 16px 24px;
            margin-bottom: 12px;
        }
        .correction-header-titre {
            font-family: 'Space Mono', monospace;
            font-size: 13px;
            color: var(--vert2);
            letter-spacing: 1px;
        }
        .correction-toggle { color: var(--or); font-size: 18px; }
        .correction-body { display: none; }
        .correction-body.open { display: block; }

        .correction-item {
            display: grid;
            grid-template-columns: 32px 1fr auto;
            gap: 14px;
            align-items: start;
            padding: 14px 16px;
            border-bottom: 1px solid rgba(255,255,255,0.04);
        }
        .correction-item:last-child { border-bottom: none; }
        .correction-icone {
            font-size: 18px;
            text-align: center;
            padding-top: 2px;
        }
        .correction-enonce {
            font-size: 14px;
            color: var(--creme);
            line-height: 1.5;
        }
        .correction-enonce small {
            display: block;
            font-family: 'Space Mono', monospace;
            font-size: 11px;
            color: #6B7280;
            margin-top: 4px;
        }
        .correction-reponses {
            text-align: right;
            white-space: nowrap;
        }
        .badge-rep {
            display: inline-block;
            font-family: 'Space Mono', monospace;
            font-size: 12px;
            font-weight: 700;
            border-radius: 4px;
            padding: 2px 8px;
            margin: 2px 0;
        }
        .badge-rep.correct  { background: rgba(74,124,47,0.2); color: var(--vert2); }
        .badge-rep.incorrect { background: rgba(224,112,80,0.15); color: #E07050; }
        .badge-rep.bonne    { background: rgba(139,195,74,0.15); color: var(--vert2); border: 1px solid rgba(139,195,74,0.3); }
        .badge-rep.vide     { background: rgba(255,255,255,0.05); color: #6B7280; }

        @media (max-width: 600px) {
            .score-hero-valeur { font-size: 56px; }
            .resultat-actions  { flex-direction: column; align-items: stretch; }
            .correction-item   { grid-template-columns: 28px 1fr; }
            .correction-reponses { grid-column: 2; }
        }
    </style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="resultat-wrapper">

        <!-- ─── HÉRO SCORE TOTAL ───────────────────────────────────── -->
        <div class="score-hero">
            <div class="score-hero-label">🌿 Score TLC Yemba</div>
            <div class="score-hero-valeur">
                <asp:Literal ID="litScoreTotal" runat="server" Text="—" />
            </div>
            <div class="score-hero-max">/ 677 points</div>
            <div class="score-hero-niveau">
                <asp:Literal ID="litNiveau" runat="server" Text="—" />
            </div>
            <div class="score-hero-typetest">
                Test : <asp:Literal ID="litTypeTest" runat="server" />
                &nbsp;·&nbsp;
                Durée : <asp:Literal ID="litDuree" runat="server" />
            </div>
        </div>

        <!-- ─── SCORES PAR SECTION ────────────────────────────────── -->
        <asp:Panel ID="pnlSections" runat="server">
            <div class="sections-grid">

                <asp:Panel ID="pnlListening" runat="server" CssClass="section-card">
                    <div class="section-card-icone">👂</div>
                    <div class="section-card-nom">Listening</div>
                    <div class="section-card-score">
                        <asp:Literal ID="litScoreListening" runat="server" Text="—" />
                    </div>
                    <div class="section-card-brut">
                        <asp:Literal ID="litBrutListening" runat="server" /> bonnes rép.
                    </div>
                </asp:Panel>

                <asp:Panel ID="pnlStructure" runat="server" CssClass="section-card">
                    <div class="section-card-icone">📐</div>
                    <div class="section-card-nom">Structure</div>
                    <div class="section-card-score">
                        <asp:Literal ID="litScoreStructure" runat="server" Text="—" />
                    </div>
                    <div class="section-card-brut">
                        <asp:Literal ID="litBrutStructure" runat="server" /> bonnes rép.
                    </div>
                </asp:Panel>

                <asp:Panel ID="pnlReading" runat="server" CssClass="section-card">
                    <div class="section-card-icone">📖</div>
                    <div class="section-card-nom">Reading</div>
                    <div class="section-card-score">
                        <asp:Literal ID="litScoreReading" runat="server" Text="—" />
                    </div>
                    <div class="section-card-brut">
                        <asp:Literal ID="litBrutReading" runat="server" /> bonnes rép.
                    </div>
                </asp:Panel>

            </div>
        </asp:Panel>

        <!-- ─── BARRE DE PERFORMANCE ─────────────────────────────── -->
        <div class="perf-barre-wrap">
            <div class="perf-barre-label">
                <span>Performance globale</span>
                <span><asp:Literal ID="litPourcentage" runat="server" />%</span>
            </div>
            <div class="perf-bg">
                <div class="perf-fill" id="perfFill" style="width:0%"></div>
            </div>
            <div class="perf-seuils">
                <span class="perf-seuil">0</span>
                <span class="perf-seuil">300 Élémentaire</span>
                <span class="perf-seuil">500 Interm.</span>
                <span class="perf-seuil">600 Avancé</span>
                <span class="perf-seuil">677</span>
            </div>
        </div>

        <!-- ─── BOUTONS D'ACTION ─────────────────────────────────── -->
        <div class="resultat-actions">
            <asp:Button ID="btnCertificat"   runat="server" Text="🏆 Obtenir le Certificat"
                CssClass="btn-certif"      OnClick="btnCertificat_Click"   CausesValidation="false" />
            <asp:Button ID="btnLeaderboard"  runat="server" Text="🏅 Voir le Classement"
                CssClass="btn btn-outline" OnClick="btnLeaderboard_Click"  CausesValidation="false" />
            <asp:Button ID="btnNouveauTest"  runat="server" Text="↩ Nouveau Test"
                CssClass="btn btn-outline" OnClick="btnNouveauTest_Click"  CausesValidation="false" />
        </div>

        <!-- ─── CORRECTION DÉTAILLÉE (accordéon) ────────────────── -->
        <asp:Panel ID="pnlCorrection" runat="server">
            <div class="correction-header" onclick="toggleCorrection()">
                <span class="correction-header-titre">📋 Correction détaillée question par question</span>
                <span class="correction-toggle" id="corrToggle">▼</span>
            </div>
            <div class="correction-body" id="corrBody">
                <asp:Repeater ID="rptCorrection" runat="server">
                    <ItemTemplate>
                        <div class="correction-item">
                            <div class="correction-icone">
                                <%# (bool)Eval("EstCorrecte") ? "✅" : "❌" %>
                            </div>
                            <div class="correction-enonce">
                                <%# Server.HtmlEncode(Eval("Enonce").ToString()) %>
                                <small><%# Eval("Section") %></small>
                            </div>
                            <div class="correction-reponses">
                                <div>
                                    <span class="badge-rep <%# string.IsNullOrEmpty(Eval("ReponseCandidat").ToString()) ? "vide" : (bool)Eval("EstCorrecte") ? "correct" : "incorrect" %>">
                                        <%# string.IsNullOrEmpty(Eval("ReponseCandidat").ToString()) ? "—" : Eval("ReponseCandidat").ToString() %>
                                    </span>
                                </div>
                                <%# !(bool)Eval("EstCorrecte") ? "<div><span class=\"badge-rep bonne\">" + Eval("BonneReponse") + "</span></div>" : "" %>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </asp:Panel>

    </div><!-- /resultat-wrapper -->

</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
    <script>
        // Barre de performance animée
        (function () {
            var pct = parseInt('<asp:Literal ID="litPourcentageJS" runat="server" />') || 0;
            setTimeout(function () {
                document.getElementById('perfFill').style.width = pct + '%';
            }, 200);
        })();

        // Accordéon correction
        function toggleCorrection() {
            var body = document.getElementById('corrBody');
            var tog  = document.getElementById('corrToggle');
            body.classList.toggle('open');
            tog.textContent = body.classList.contains('open') ? '▲' : '▼';
        }
    </script>
</asp:Content>
