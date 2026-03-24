<%@ Page Title="Test TLC Yemba" Language="C#" MasterPageFile="~/Site.master" 
         AutoEventWireup="true" CodeBehind="Test.aspx.cs" 
         Inherits="TLC_Yemba.Pages.Test" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Test TLC Yemba — <asp:Literal ID="litTitreTest" runat="server" />
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        /* ── ZONE TEST ────────────────────────────────────── */
        .test-wrapper {
            max-width: 820px;
            margin: 0 auto;
            padding: 32px 24px;
        }

        /* ── BARRE SUPÉRIEURE ─────────────────────────────── */
        .test-topbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: var(--fond2);
            border: 1px solid rgba(74,124,47,0.25);
            border-radius: 10px;
            padding: 14px 24px;
            margin-bottom: 20px;
        }
        .test-section-badge {
            font-family: 'Space Mono', monospace;
            font-size: 12px;
            letter-spacing: 2px;
            color: var(--vert2);
            text-transform: uppercase;
        }
        .test-timer-display {
            font-family: 'Space Mono', monospace;
            font-size: 22px;
            font-weight: 700;
            color: var(--creme);
            background: rgba(74,124,47,0.2);
            border: 1px solid rgba(74,124,47,0.4);
            border-radius: 6px;
            padding: 6px 18px;
            transition: color 0.3s, border-color 0.3s, background 0.3s;
        }
        .test-timer-display.warning {
            color: #E8C060;
            border-color: rgba(232,192,96,0.5);
            background: rgba(232,192,96,0.1);
        }
        .test-timer-display.critical {
            color: #E07050;
            border-color: rgba(224,112,80,0.5);
            background: rgba(224,112,80,0.1);
            animation: timerPulse 1s infinite;
        }
        @keyframes timerPulse {
            0%, 100% { opacity: 1; }
            50%       { opacity: 0.65; }
        }
        .test-counter {
            font-family: 'Space Mono', monospace;
            font-size: 12px;
            color: #6B7280;
        }

        /* ── BARRE DE PROGRESSION ─────────────────────────── */
        .progress-wrap {
            margin-bottom: 24px;
        }
        .progress-info {
            display: flex;
            justify-content: space-between;
            font-family: 'Space Mono', monospace;
            font-size: 11px;
            color: #6B7280;
            margin-bottom: 6px;
        }
        .progress-bar-bg {
            background: rgba(74,124,47,0.12);
            border-radius: 4px;
            height: 6px;
            overflow: hidden;
        }
        .progress-bar-fill {
            height: 100%;
            background: linear-gradient(90deg, var(--vert), var(--vert2));
            border-radius: 4px;
            transition: width 0.4s ease;
        }

        /* ── CARTE QUESTION ───────────────────────────────── */
        .question-card {
            background: var(--fond2);
            border: 1px solid rgba(74,124,47,0.2);
            border-radius: 12px;
            padding: 28px 32px;
            margin-bottom: 24px;
        }
        .question-num {
            font-family: 'Space Mono', monospace;
            font-size: 11px;
            color: var(--or);
            letter-spacing: 2px;
            text-transform: uppercase;
            margin-bottom: 12px;
        }
        .question-enonce {
            font-family: 'Playfair Display', serif;
            font-size: 18px;
            color: var(--creme);
            line-height: 1.6;
            margin-bottom: 28px;
        }

        /* ── OPTIONS QCM ──────────────────────────────────── */
        .options-list {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        .option-label {
            display: flex;
            align-items: flex-start;
            gap: 14px;
            background: rgba(255,255,255,0.03);
            border: 1px solid rgba(74,124,47,0.15);
            border-radius: 8px;
            padding: 14px 18px;
            cursor: pointer;
            transition: border-color 0.2s, background 0.2s;
        }
        .option-label:hover {
            border-color: rgba(74,124,47,0.45);
            background: rgba(74,124,47,0.08);
        }
        .option-label.selected {
            border-color: var(--vert2);
            background: rgba(139,195,74,0.08);
        }
        /* Masquer le radio natif */
        .option-label input[type="radio"] {
            position: absolute;
            opacity: 0;
            width: 0;
            height: 0;
        }
        .option-radio-custom {
            width: 18px;
            height: 18px;
            border-radius: 50%;
            border: 2px solid rgba(74,124,47,0.4);
            flex-shrink: 0;
            margin-top: 2px;
            transition: border-color 0.2s, background 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .option-label.selected .option-radio-custom {
            border-color: var(--vert2);
            background: var(--vert);
        }
        .option-radio-custom::after {
            content: '';
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background: var(--creme);
            display: none;
        }
        .option-label.selected .option-radio-custom::after {
            display: block;
        }
        .option-lettre {
            font-family: 'Space Mono', monospace;
            font-size: 11px;
            font-weight: 700;
            color: var(--vert2);
            min-width: 20px;
            flex-shrink: 0;
        }
        .option-texte {
            font-size: 15px;
            color: var(--creme);
            line-height: 1.5;
        }

        /* ── ALERTE NON RÉPONDU ───────────────────────────── */
        .alerte-validation {
            background: rgba(232,192,96,0.1);
            border: 1px solid rgba(232,192,96,0.4);
            color: #E8C060;
            border-radius: 8px;
            padding: 10px 16px;
            font-size: 13px;
            margin-top: 12px;
            display: none;
        }

        /* ── NAVIGATION ───────────────────────────────────── */
        .test-navigation {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
        }
        .nav-dots {
            display: flex;
            flex-wrap: wrap;
            gap: 5px;
            flex: 1;
            justify-content: center;
        }
        .nav-dot {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background: rgba(74,124,47,0.2);
            border: 1px solid rgba(74,124,47,0.3);
            cursor: pointer;
            transition: background 0.2s;
        }
        .nav-dot.answered   { background: var(--vert); border-color: var(--vert2); }
        .nav-dot.current    { background: var(--or);   border-color: var(--or2); }

        /* ── BOUTON TERMINER ──────────────────────────────── */
        .btn-terminer {
            background: linear-gradient(135deg, var(--or), #A8782A);
            color: #1A0F00;
            font-family: 'Space Mono', monospace;
            font-size: 13px;
            font-weight: 700;
            border: none;
            border-radius: 8px;
            padding: 12px 24px;
            cursor: pointer;
            letter-spacing: 1px;
            transition: opacity 0.2s;
        }
        .btn-terminer:hover { opacity: 0.9; }

        /* ── MODAL CONFIRMATION ───────────────────────────── */
        .modal-overlay {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.6);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }
        .modal-overlay.active { display: flex; }
        .modal-box {
            background: var(--fond2);
            border: 1px solid rgba(201,150,58,0.4);
            border-radius: 14px;
            padding: 36px 40px;
            max-width: 440px;
            width: 90%;
            text-align: center;
        }
        .modal-icon { font-size: 40px; margin-bottom: 16px; }
        .modal-title {
            font-family: 'Playfair Display', serif;
            font-size: 22px;
            color: var(--or);
            margin-bottom: 10px;
        }
        .modal-text { font-size: 14px; color: #9CA3AF; line-height: 1.6; margin-bottom: 24px; }
        .modal-stats { 
            display: flex; gap: 16px; justify-content: center; 
            margin-bottom: 24px;
        }
        .modal-stat {
            background: rgba(74,124,47,0.1);
            border: 1px solid rgba(74,124,47,0.25);
            border-radius: 8px;
            padding: 10px 20px;
            text-align: center;
        }
        .modal-stat-num  { font-family: 'Space Mono', monospace; font-size: 22px; color: var(--vert2); }
        .modal-stat-lbl  { font-size: 11px; color: #6B7280; margin-top: 2px; }
        .modal-btns { display: flex; gap: 12px; justify-content: center; }

        @media (max-width: 640px) {
            .test-topbar { flex-wrap: wrap; gap: 10px; }
            .question-card { padding: 20px 18px; }
            .nav-dots { max-width: 200px; }
        }
    </style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="test-wrapper">

        <!-- ─── BARRE SUPÉRIEURE ──────────────────────────────── -->
        <div class="test-topbar">
            <div class="test-section-badge">
                🌿 <asp:Literal ID="litSection" runat="server" />
            </div>
            <div class="test-timer-display" id="timerDisplay">--:--</div>
            <div class="test-counter">
                Q&nbsp;<asp:Literal ID="litIndexAffiche" runat="server" />&nbsp;/&nbsp;<asp:Literal ID="litTotal" runat="server" />
            </div>
        </div>

        <!-- ─── BARRE DE PROGRESSION ─────────────────────────── -->
        <div class="progress-wrap">
            <div class="progress-info">
                <span>Progression</span>
                <span id="progressPct">0%</span>
            </div>
            <div class="progress-bar-bg">
                <div class="progress-bar-fill" id="progressFill" style="width:0%"></div>
            </div>
        </div>

        <!-- ─── CARTE QUESTION ────────────────────────────────── -->
        <asp:Panel ID="pnlQuestion" runat="server">
            <div class="question-card">
                <div class="question-num">
                    Question <asp:Literal ID="litNumQuestion" runat="server" />
                </div>
                <div class="question-enonce">
                    <asp:Literal ID="litEnonce" runat="server" />
                </div>

                <!-- Options QCM (rendu par le code-behind) -->
                <div class="options-list" id="optionsList">
                    <asp:PlaceHolder ID="phOptions" runat="server" />
                </div>

                <div class="alerte-validation" id="alerteValidation">
                    ⚠️ Veuillez sélectionner une réponse avant de continuer.
                </div>
            </div>

            <!-- ─── NAVIGATION ─────────────────────────────────── -->
            <div class="test-navigation">
                <asp:Button ID="btnPrecedent" runat="server" Text="← Précédent"
                    CssClass="btn btn-outline" OnClick="btnPrecedent_Click"
                    CausesValidation="false" />

                <div class="nav-dots" id="navDots">
                    <asp:PlaceHolder ID="phNavDots" runat="server" />
                </div>

                <asp:Button ID="btnSuivant" runat="server" Text="Suivant →"
                    CssClass="btn btn-primary" OnClick="btnSuivant_Click"
                    CausesValidation="false" />
            </div>

            <div style="text-align:center; margin-top:20px;">
                <button type="button" class="btn-terminer" onclick="demanderTerminer()">
                    ✓ Terminer le test
                </button>
            </div>
        </asp:Panel>

        <!-- ─── HIDDEN FIELDS ────────────────────────────────── -->
        <asp:HiddenField ID="hdnReponseSelectionnee" runat="server" />
        <asp:HiddenField ID="hdnDureeEcoulee"        runat="server" Value="0" />
        <asp:HiddenField ID="hdnSecondesRestantes"   runat="server" />
        <asp:HiddenField ID="hdnActionTerminer"      runat="server" Value="false" />

        <!-- Bouton submit caché pour soumission automatique (timer) -->
        <asp:Button ID="btnTerminerHidden" runat="server" style="display:none;"
            Text="Terminer" OnClick="btnTerminer_Click" CausesValidation="false" />

    </div><!-- /test-wrapper -->

    <!-- ─── MODAL CONFIRMATION ───────────────────────────────── -->
    <div class="modal-overlay" id="modalTerminer">
        <div class="modal-box">
            <div class="modal-icon">📋</div>
            <div class="modal-title">Terminer le test ?</div>
            <div class="modal-text">
                Vous êtes sur le point de soumettre vos réponses.<br>
                Cette action est <strong style="color:var(--or)">irréversible</strong>.
            </div>
            <div class="modal-stats">
                <div class="modal-stat">
                    <div class="modal-stat-num" id="modalRepondues">0</div>
                    <div class="modal-stat-lbl">Répondues</div>
                </div>
                <div class="modal-stat">
                    <div class="modal-stat-num" id="modalRestantes">0</div>
                    <div class="modal-stat-lbl">Sans réponse</div>
                </div>
            </div>
            <div class="modal-btns">
                <button type="button" class="btn btn-outline" onclick="fermerModal()">
                    ← Continuer
                </button>
                <button type="button" class="btn-terminer" onclick="confirmerTerminer()">
                    Soumettre ✓
                </button>
            </div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
    <script>
        // ── Données injectées par le code-behind ────────────────────
        var TLC = {
            secondesRestantes: parseInt('<asp:Literal ID="litSecondes" runat="server" />') || 0,
            totalQuestions:    parseInt('<asp:Literal ID="litTotalJS" runat="server" />') || 0,
            indexCourant:      parseInt('<asp:Literal ID="litIndexJS" runat="server" />') || 0,
            reponsesCount:     parseInt('<asp:Literal ID="litReponsesCount" runat="server" />') || 0
        };
    </script>
    <script src="<%= ResolveUrl("~/Scripts/timer.js") %>"></script>
    <script>
        // ── Gestion du clic sur les options ─────────────────────────
        document.querySelectorAll('.option-label').forEach(function(label) {
            label.addEventListener('click', function() {
                var radio = this.querySelector('input[type="radio"]');
                radio.checked = true;
                document.querySelectorAll('.option-label').forEach(function(l) {
                    l.classList.remove('selected');
                });
                this.classList.add('selected');
                document.getElementById('<%= hdnReponseSelectionnee.ClientID %>').value = radio.value;
                document.getElementById('alerteValidation').style.display = 'none';
            });
        });

        // ── Barre de progression ─────────────────────────────────────
        (function() {
            var idx   = TLC.indexCourant;
            var total = TLC.totalQuestions;
            var pct   = total > 0 ? Math.round(((idx) / total) * 100) : 0;
            document.getElementById('progressFill').style.width = pct + '%';
            document.getElementById('progressPct').textContent  = pct + '%';
        })();

        // ── Modal Terminer ───────────────────────────────────────────
        function demanderTerminer() {
            var repondues = TLC.reponsesCount;
            var restantes = TLC.totalQuestions - repondues;
            document.getElementById('modalRepondues').textContent = repondues;
            document.getElementById('modalRestantes').textContent = restantes;
            document.getElementById('modalTerminer').classList.add('active');
        }
        function fermerModal() {
            document.getElementById('modalTerminer').classList.remove('active');
        }
        function confirmerTerminer() {
            document.getElementById('<%= hdnActionTerminer.ClientID %>').value = 'true';
            document.getElementById('<%= btnTerminerHidden.ClientID %>').click();
        }

        // ── Soumission auto au clic Suivant/Précédent ────────────────
        function validerEtSoumettre(btnId) {
            var hdn = document.getElementById('<%= hdnReponseSelectionnee.ClientID %>');
            // Pas d'obligation — on autorise de passer sans répondre
            document.getElementById(btnId).click();
        }
    </script>
</asp:Content>
