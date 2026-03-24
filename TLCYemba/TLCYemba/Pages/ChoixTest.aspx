<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChoixTest.aspx.cs" Inherits="TLCYemba.ChoixTest" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="fr">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Choisir un Test — TLC Yemba</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800;900&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet" />
    <style>
        /* ── CSS Variables (identiques à Default.aspx) ── */
        :root {
            --teal:       #3AAFA9;
            --teal-dark:  #2B8F8A;
            --teal-light: #DEF2F1;
            --teal-pale:  #EAF8F7;
            --text-dark:  #2D3748;
            --text-mid:   #4A5568;
            --text-soft:  #718096;
            --white:      #FFFFFF;
            --shadow:     0 4px 24px rgba(58,175,169,.13);
            --radius:     20px;
            --radius-sm:  12px;
        }

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        html { scroll-behavior: smooth; }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(145deg, #C8EDEA 0%, #EAF8F7 40%, #DEF5F3 70%, #B8E8E4 100%);
            min-height: 100vh;
            color: var(--text-dark);
        }

        /* ── Background Waves ── */
        .bg-wave {
            position: fixed; inset: 0; z-index: 0; pointer-events: none;
        }
        .bg-wave svg { width: 100%; height: 100%; }

        /* ── Page wrapper ── */
        .page-wrapper {
            position: relative; z-index: 1;
            max-width: 1280px;
            margin: 32px auto;
            background: rgba(255,255,255,0.82);
            backdrop-filter: blur(18px);
            border-radius: 32px;
            box-shadow: 0 8px 64px rgba(58,175,169,.18);
            overflow: hidden;
        }

        /* ══════════ NAVBAR ══════════ */
        nav {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 22px 52px;
            background: rgba(255,255,255,0.95);
            border-bottom: 1.5px solid rgba(58,175,169,.10);
        }
        .nav-logo {
            display: flex; align-items: center; gap: 12px; text-decoration: none;
        }
        .logo-icon {
            width: 42px; height: 42px;
            background: var(--teal);
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-family: 'Nunito', sans-serif;
            font-weight: 900; font-size: 18px; color: white;
            box-shadow: 0 3px 12px rgba(58,175,169,.4);
        }
        .logo-text {
            font-family: 'Nunito', sans-serif;
            font-weight: 800; font-size: 18px; color: var(--text-dark);
        }
        .logo-text span { color: var(--teal); }
        .nav-links { display: flex; gap: 36px; list-style: none; }
        .nav-links a {
            text-decoration: none; color: var(--text-mid);
            font-size: 14.5px; font-weight: 500; transition: color .2s;
        }
        .nav-links a:hover, .nav-links a.active { color: var(--teal); font-weight: 600; }
        .btn-signup {
            background: var(--teal); color: white; border: none;
            padding: 11px 28px; border-radius: 50px;
            font-size: 14.5px; font-weight: 600; cursor: pointer;
            font-family: 'Poppins', sans-serif;
            transition: background .2s, transform .15s, box-shadow .2s;
            box-shadow: 0 4px 16px rgba(58,175,169,.35); text-decoration: none;
        }
        .btn-signup:hover {
            background: var(--teal-dark); transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(58,175,169,.45);
        }

        /* ══════════ BREADCRUMB ══════════ */
        .breadcrumb {
            padding: 18px 52px 0;
            font-size: 12.5px;
            color: var(--text-soft);
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .breadcrumb a { color: var(--teal); text-decoration: none; font-weight: 500; }
        .breadcrumb a:hover { text-decoration: underline; }
        .breadcrumb-sep { color: var(--text-soft); }

        /* ══════════ PAGE HEADER ══════════ */
        .page-header {
            padding: 40px 52px 28px;
            text-align: center;
            animation: fadeSlideUp .45s ease both;
        }
        .page-header-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: var(--teal-pale);
            border: 1.5px solid rgba(58,175,169,.25);
            color: var(--teal-dark);
            padding: 6px 18px;
            border-radius: 50px;
            font-size: 12.5px;
            font-weight: 600;
            margin-bottom: 16px;
        }
        .page-header h1 {
            font-family: 'Nunito', sans-serif;
            font-size: clamp(1.7rem, 3vw, 2.4rem);
            font-weight: 900;
            color: var(--text-dark);
            margin-bottom: 10px;
        }
        .page-header h1 span { color: var(--teal); }
        .page-header p {
            font-size: 14.5px;
            color: var(--text-soft);
            max-width: 520px;
            margin: 0 auto;
            line-height: 1.7;
        }

        /* ══════════ ERROR MESSAGE ══════════ */
        .error-msg {
            display: none;
            background: #FFF5F5;
            border: 1.5px solid #FEB2B2;
            color: #C53030;
            padding: 12px 24px;
            border-radius: var(--radius-sm);
            font-size: 13.5px;
            font-weight: 500;
            margin: 0 52px 16px;
            text-align: center;
            animation: shake .35s ease;
        }
        .error-msg.visible { display: block; }
        @keyframes shake {
            0%,100% { transform: translateX(0); }
            25%      { transform: translateX(-6px); }
            75%      { transform: translateX(6px); }
        }

        /* Server-side error label */
        .server-error {
            color: #C53030;
            font-size: 13px;
            font-weight: 500;
            text-align: center;
            margin: 0 52px 12px;
            display: block;
        }

        /* ══════════ CARDS GRID ══════════ */
        .cards-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 24px;
            padding: 0 52px 20px;
        }

        /* Individual test card */
        .test-card {
            position: relative;
            background: var(--white);
            border-radius: var(--radius);
            padding: 36px 32px;
            box-shadow: var(--shadow);
            cursor: pointer;
            border: 2.5px solid transparent;
            transition: border-color .22s, transform .22s, box-shadow .22s;
            display: flex;
            flex-direction: column;
            gap: 16px;
            animation: fadeSlideUp .5s ease both;
            user-select: none;
        }
        .test-card:nth-child(1) { animation-delay: .08s; }
        .test-card:nth-child(2) { animation-delay: .16s; }
        .test-card:nth-child(3) { animation-delay: .24s; }
        .test-card:nth-child(4) { animation-delay: .32s; }

        .test-card:hover {
            border-color: var(--teal);
            transform: translateY(-6px);
            box-shadow: 0 14px 40px rgba(58,175,169,.2);
        }
        .test-card.selected {
            border-color: var(--teal);
            background: linear-gradient(135deg, rgba(58,175,169,.06) 0%, rgba(255,255,255,1) 100%);
            box-shadow: 0 8px 32px rgba(58,175,169,.22);
        }

        /* Hidden radio inside each card */
        .test-card input[type="radio"] {
            position: absolute;
            opacity: 0;
            width: 0; height: 0;
        }

        /* Check circle top-right */
        .card-check {
            position: absolute;
            top: 18px; right: 18px;
            width: 26px; height: 26px;
            border-radius: 50%;
            border: 2px solid #CBD5E0;
            background: white;
            display: flex; align-items: center; justify-content: center;
            transition: all .2s;
        }
        .test-card.selected .card-check {
            background: var(--teal);
            border-color: var(--teal);
        }
        .card-check svg {
            width: 14px; height: 14px;
            fill: none;
            stroke: white;
            stroke-width: 2.5;
            stroke-linecap: round;
            stroke-linejoin: round;
            opacity: 0;
            transition: opacity .2s;
        }
        .test-card.selected .card-check svg { opacity: 1; }

        /* Card icon */
        .card-icon {
            width: 68px; height: 68px;
            border-radius: 18px;
            display: flex; align-items: center; justify-content: center;
            font-size: 28px;
            flex-shrink: 0;
            transition: transform .2s;
        }
        .test-card:hover .card-icon { transform: scale(1.08); }

        .icon-listening  { background: rgba(58,175,169,.12); }
        .icon-structure  { background: rgba(99,179,237,.12); }
        .icon-reading    { background: rgba(154,230,180,.18); }
        .icon-fulltest   { background: rgba(255,193,7,.12); }

        /* Card content */
        .card-content { display: flex; flex-direction: column; gap: 8px; }
        .card-title {
            font-family: 'Nunito', sans-serif;
            font-weight: 900; font-size: 19px;
            color: var(--text-dark);
        }
        .card-subtitle {
            font-size: 12.5px;
            font-weight: 600;
            color: var(--teal);
            letter-spacing: .4px;
            text-transform: uppercase;
        }
        .card-desc {
            font-size: 13.5px;
            color: var(--text-soft);
            line-height: 1.65;
        }

        /* Card meta chips */
        .card-meta {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-top: 4px;
        }
        .meta-chip {
            display: flex;
            align-items: center;
            gap: 5px;
            background: var(--teal-pale);
            border: 1px solid rgba(58,175,169,.2);
            color: var(--teal-dark);
            padding: 4px 12px;
            border-radius: 50px;
            font-size: 11.5px;
            font-weight: 600;
        }
        .meta-chip.gold {
            background: rgba(255,193,7,.12);
            border-color: rgba(255,193,7,.3);
            color: #B7791F;
        }

        /* ══════════ FULL TEST CARD (spans 2 cols) ══════════ */
        .test-card.full-width {
            grid-column: 1 / -1;
            flex-direction: row;
            align-items: center;
            gap: 28px;
        }
        .test-card.full-width .card-icon { width: 80px; height: 80px; font-size: 34px; }

        /* ══════════ ACTION ZONE ══════════ */
        .action-zone {
            padding: 28px 52px 52px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            flex-wrap: wrap;
        }
        .selection-info {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 14px 22px;
            background: var(--teal-pale);
            border: 1.5px solid rgba(58,175,169,.25);
            border-radius: var(--radius-sm);
            min-width: 280px;
        }
        .selection-icon { font-size: 22px; }
        .selection-text { display: flex; flex-direction: column; gap: 2px; }
        .selection-label { font-size: 11px; color: var(--text-soft); font-weight: 600; text-transform: uppercase; letter-spacing: .4px; }
        .selection-value {
            font-family: 'Nunito', sans-serif;
            font-weight: 800; font-size: 16px;
            color: var(--teal-dark);
        }
        .selection-value.empty { color: #A0AEC0; font-weight: 600; font-size: 14px; }

        .btn-start {
            background: var(--teal);
            color: white;
            border: none;
            padding: 16px 48px;
            border-radius: 50px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            font-family: 'Poppins', sans-serif;
            transition: background .2s, transform .15s, box-shadow .2s, opacity .2s;
            box-shadow: 0 6px 22px rgba(58,175,169,.38);
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .btn-start:hover:not(:disabled) {
            background: var(--teal-dark);
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(58,175,169,.45);
        }
        .btn-start:disabled {
            opacity: .5;
            cursor: not-allowed;
            box-shadow: none;
        }
        .btn-start svg {
            width: 18px; height: 18px;
            fill: white;
            transition: transform .2s;
        }
        .btn-start:hover:not(:disabled) svg { transform: translateX(4px); }

        /* ══════════ FOOTER ══════════ */
        footer {
            background: rgba(255,255,255,0.7);
            border-top: 1.5px solid rgba(58,175,169,.12);
            padding: 22px 52px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            font-size: 12.5px;
            color: var(--text-soft);
        }
        .footer-brand {
            font-family: 'Nunito', sans-serif;
            font-weight: 800; color: var(--teal); font-size: 14px;
        }
        .cam-colors { display: flex; gap: 4px; align-items: center; }
        .cam-dot { width: 10px; height: 10px; border-radius: 50%; }

        /* ══════════ ANIMATIONS ══════════ */
        @keyframes fadeSlideUp {
            from { opacity: 0; transform: translateY(22px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        /* ══════════ RESPONSIVE ══════════ */
        @media (max-width: 860px) {
            .page-wrapper { margin: 12px; border-radius: 20px; }
            nav { padding: 18px 24px; }
            .nav-links { gap: 18px; }
            .page-header, .breadcrumb { padding-left: 24px; padding-right: 24px; }
            .cards-grid { grid-template-columns: 1fr; padding: 0 24px 16px; }
            .test-card.full-width { flex-direction: column; align-items: flex-start; }
            .action-zone { padding: 20px 24px 36px; flex-direction: column; align-items: stretch; }
            .selection-info { min-width: unset; }
            .btn-start { justify-content: center; }
            .error-msg { margin: 0 24px 16px; }
            footer { flex-direction: column; gap: 8px; text-align: center; padding: 18px 24px; }
        }
    </style>
</head>
<body>

<div class="bg-wave" aria-hidden="true">
    <svg viewBox="0 0 1440 900" preserveAspectRatio="xMidYMid slice" xmlns="http://www.w3.org/2000/svg">
        <ellipse cx="200" cy="700" rx="520" ry="360" fill="rgba(58,175,169,.13)" />
        <ellipse cx="1300" cy="200" rx="400" ry="280" fill="rgba(58,175,169,.10)" />
        <path d="M0 650 Q360 520 720 640 T1440 560 V900 H0Z" fill="rgba(58,175,169,.08)" />
    </svg>
</div>

<form id="form1" runat="server">

<div class="page-wrapper">

    <!-- ══════════ NAVBAR ══════════ -->
    <nav>
        <a href="Default.aspx" class="nav-logo">
            <div class="logo-icon">T</div>
            <span class="logo-text">TLC <span>Yemba</span></span>
        </a>
        <ul class="nav-links">
            <li><a href="Default.aspx">Accueil</a></li>
            <li><a href="ChoixTest.aspx" class="active">Test</a></li>
            <li><a href="Historique.aspx">Résultats</a></li>
        </ul>
        <a href="Inscription.aspx" class="btn-signup">S'inscrire</a>
    </nav>

    <!-- ══════════ BREADCRUMB ══════════ -->
    <div class="breadcrumb">
        <a href="Default.aspx">🏠 Accueil</a>
        <span class="breadcrumb-sep">›</span>
        <span>Choisir un Test</span>
    </div>

    <!-- ══════════ PAGE HEADER ══════════ -->
    <div class="page-header">
        <div class="page-header-badge">🎯 Étape 1 sur 2 — Sélection du test</div>
        <h1>Quel test voulez-vous <span>passer ?</span></h1>
        <p>Choisissez le type de test adapté à vos objectifs. Chaque section évalue des compétences spécifiques en langue Yemba.</p>
    </div>

    <!-- ══════════ SERVER-SIDE ERROR ══════════ -->
    <asp:Label ID="lblErreur" runat="server" CssClass="server-error" Visible="false" />

    <!-- ══════════ CLIENT-SIDE ERROR ══════════ -->
    <div class="error-msg" id="clientError">
        ⚠️ Veuillez sélectionner un type de test avant de continuer.
    </div>

    <!-- ══════════ CARDS GRID ══════════ -->
    <div class="cards-grid">

        <!-- LISTENING -->
        <label class="test-card" id="cardListening" for="rdListening" onclick="selectCard('Listening','cardListening','🎧','Listening — Compréhension Orale')">
            <input type="radio" id="rdListening" name="typeTest" value="Listening"
                   runat="server" onchange="selectCard('Listening','cardListening','🎧','Listening — Compréhension Orale')" />
            <div class="card-check">
                <svg viewBox="0 0 24 24"><polyline points="20 6 9 17 4 12"/></svg>
            </div>
            <div class="card-icon icon-listening">🎧</div>
            <div class="card-content">
                <div class="card-subtitle">Section 1</div>
                <div class="card-title">Listening</div>
                <div class="card-desc">Testez votre compréhension de la langue Yemba à l'oral grâce à des questions basées sur des dialogues et des discours.</div>
                <div class="card-meta">
                    <span class="meta-chip">⏱ 30 min</span>
                    <span class="meta-chip">📝 50 questions</span>
                    <span class="meta-chip">Score : 31–68</span>
                </div>
            </div>
        </label>

        <!-- STRUCTURE -->
        <label class="test-card" id="cardStructure" for="rdStructure" onclick="selectCard('Structure','cardStructure','📝','Structure — Grammaire')">
            <input type="radio" id="rdStructure" name="typeTest" value="Structure"
                   runat="server" onchange="selectCard('Structure','cardStructure','📝','Structure — Grammaire')" />
            <div class="card-check">
                <svg viewBox="0 0 24 24"><polyline points="20 6 9 17 4 12"/></svg>
            </div>
            <div class="card-icon icon-structure">📝</div>
            <div class="card-content">
                <div class="card-subtitle">Section 2</div>
                <div class="card-title">Structure</div>
                <div class="card-desc">Évaluez votre maîtrise des règles grammaticales et syntaxiques de la langue Yemba.</div>
                <div class="card-meta">
                    <span class="meta-chip">⏱ 25 min</span>
                    <span class="meta-chip">📝 40 questions</span>
                    <span class="meta-chip">Score : 31–68</span>
                </div>
            </div>
        </label>

        <!-- READING -->
        <label class="test-card" id="cardReading" for="rdReading" onclick="selectCard('Reading','cardReading','📖','Reading — Compréhension Écrite')">
            <input type="radio" id="rdReading" name="typeTest" value="Reading"
                   runat="server" onchange="selectCard('Reading','cardReading','📖','Reading — Compréhension Écrite')" />
            <div class="card-check">
                <svg viewBox="0 0 24 24"><polyline points="20 6 9 17 4 12"/></svg>
            </div>
            <div class="card-icon icon-reading">📖</div>
            <div class="card-content">
                <div class="card-subtitle">Section 3</div>
                <div class="card-title">Reading</div>
                <div class="card-desc">Mesurez votre capacité à lire et comprendre des textes écrits en langue Yemba, de différents niveaux de complexité.</div>
                <div class="card-meta">
                    <span class="meta-chip">⏱ 55 min</span>
                    <span class="meta-chip">📝 50 questions</span>
                    <span class="meta-chip">Score : 31–67</span>
                </div>
            </div>
        </label>

        <!-- FULL TEST (pleine largeur) -->
        <label class="test-card full-width" id="cardFullTest" for="rdFullTest" onclick="selectCard('FullTest','cardFullTest','🏆','Test Complet TLC')">
            <input type="radio" id="rdFullTest" name="typeTest" value="FullTest"
                   runat="server" onchange="selectCard('FullTest','cardFullTest','🏆','Test Complet TLC')" />
            <div class="card-check">
                <svg viewBox="0 0 24 24"><polyline points="20 6 9 17 4 12"/></svg>
            </div>
            <div class="card-icon icon-fulltest">🏆</div>
            <div class="card-content">
                <div class="card-subtitle">Test Certifiant</div>
                <div class="card-title">Test Complet TLC</div>
                <div class="card-desc">
                    Passez les trois sections en une seule session pour obtenir votre score TLC global et votre certificat de compétence en langue Yemba. Recommandé pour la certification officielle.
                </div>
                <div class="card-meta">
                    <span class="meta-chip">⏱ 1h 50 min</span>
                    <span class="meta-chip">📝 140 questions</span>
                    <span class="meta-chip gold">⭐ Score : 310–677</span>
                    <span class="meta-chip gold">🎓 Certificat inclus</span>
                </div>
            </div>
        </label>

    </div>

    <!-- ══════════ ACTION ZONE ══════════ -->
    <div class="action-zone">

        <!-- Sélection courante -->
        <div class="selection-info">
            <span class="selection-icon" id="selIcon">📋</span>
            <div class="selection-text">
                <span class="selection-label">Test sélectionné</span>
                <span class="selection-value empty" id="selValue">Aucune sélection</span>
            </div>
        </div>

        <!-- Bouton Commencer -->
        <asp:Button ID="btnCommencer" runat="server"
            Text="Commencer le Test →"
            CssClass="btn-start"
            OnClick="btnCommencer_Click"
            OnClientClick="return validerSelection();"
            Enabled="false" />

    </div>

    <!-- ══════════ FOOTER ══════════ -->
    <footer>
        <span class="footer-brand">TLC Yemba Online Test</span>
        <span>Projet DPW — ASP.NET Web Forms &amp; ADO.NET</span>
        <div class="cam-colors">
            <div class="cam-dot" style="background:#007A5E;"></div>
            <div class="cam-dot" style="background:#CE1126;"></div>
            <div class="cam-dot" style="background:#FCD116;"></div>
            <span style="margin-left:6px; font-size:11px;">Cameroun 🇨🇲</span>
        </div>
    </footer>

</div>

</form>

<script>
    // ── State ──
    var currentCard   = null;
    var currentValue  = null;

    // ── Restore selection if page reloads (postback) ──
    window.addEventListener('DOMContentLoaded', function () {
        var radios = document.querySelectorAll('input[type="radio"]');
        radios.forEach(function (r) {
            if (r.checked) {
                var card = r.closest('.test-card');
                if (card) card.classList.add('selected');
            }
        });
        updateUI();
    });

    // ── Select card ──
    function selectCard(value, cardId, icon, label) {
        // Deselect all cards
        document.querySelectorAll('.test-card').forEach(function (c) {
            c.classList.remove('selected');
        });

        // Select current
        var card = document.getElementById(cardId);
        if (card) {
            card.classList.add('selected');
            var radio = card.querySelector('input[type="radio"]');
            if (radio) radio.checked = true;
        }

        currentCard  = cardId;
        currentValue = value;

        // Update info strip
        document.getElementById('selIcon').textContent  = icon;
        var selVal = document.getElementById('selValue');
        selVal.textContent  = label;
        selVal.className    = 'selection-value';

        // Enable button
        var btn = document.getElementById('<%= btnCommencer.ClientID %>');
        if (btn) btn.disabled = false;

        // Hide error
        hideError();
    }

    function updateUI() {
        var anyChecked = false;
        document.querySelectorAll('input[type="radio"]').forEach(function(r){
            if (r.checked) anyChecked = true;
        });
        var btn = document.getElementById('<%= btnCommencer.ClientID %>');
        if (btn) btn.disabled = !anyChecked;
    }

    // ── Client-side validation before postback ──
    function validerSelection() {
        var radios = document.querySelectorAll('input[type="radio"]');
        for (var i = 0; i < radios.length; i++) {
            if (radios[i].checked) return true;
        }
        showError();
        return false;
    }

    function showError() {
        document.getElementById('clientError').classList.add('visible');
    }

    function hideError() {
        document.getElementById('clientError').classList.remove('visible');
    }
</script>

</body>
</html>
