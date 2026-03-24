<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TLCYemba.Default" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="fr">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>TLC Yemba — Test de Langue du Cameroun</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800;900&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet" />
    <style>
        /* ── CSS Variables ── */
        :root {
            --teal:       #3AAFA9;
            --teal-dark:  #2B8F8A;
            --teal-light: #DEF2F1;
            --teal-pale:  #EAF8F7;
            --green-cam:  #007A5E;
            --red-cam:    #CE1126;
            --yellow-cam: #FCD116;
            --text-dark:  #2D3748;
            --text-mid:   #4A5568;
            --text-soft:  #718096;
            --white:      #FFFFFF;
            --card-bg:    #FFFFFF;
            --shadow:     0 4px 24px rgba(58,175,169,.13);
            --radius:     18px;
            --radius-sm:  12px;
        }

        /* ── Reset & Base ── */
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        html { scroll-behavior: smooth; }
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(145deg, #C8EDEA 0%, #EAF8F7 40%, #DEF5F3 70%, #B8E8E4 100%);
            min-height: 100vh;
            color: var(--text-dark);
        }

        /* ── Decorative Background Waves ── */
        .bg-wave {
            position: fixed;
            inset: 0;
            z-index: 0;
            pointer-events: none;
        }
        .bg-wave svg { width: 100%; height: 100%; }

        /* ── Main wrapper card ── */
        .page-wrapper {
            position: relative;
            z-index: 1;
            max-width: 1280px;
            margin: 32px auto;
            background: rgba(255,255,255,0.82);
            backdrop-filter: blur(18px);
            border-radius: 32px;
            box-shadow: 0 8px 64px rgba(58,175,169,.18);
            overflow: hidden;
        }

        /* ══════════════ NAVBAR ══════════════ */
        nav {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 22px 52px;
            background: rgba(255,255,255,0.95);
            border-bottom: 1.5px solid rgba(58,175,169,.10);
        }
        .nav-logo {
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
        }
        .logo-icon {
            width: 42px; height: 42px;
            background: var(--teal);
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-family: 'Nunito', sans-serif;
            font-weight: 900; font-size: 18px;
            color: white;
            box-shadow: 0 3px 12px rgba(58,175,169,.4);
        }
        .logo-text {
            font-family: 'Nunito', sans-serif;
            font-weight: 800; font-size: 18px;
            color: var(--text-dark);
        }
        .logo-text span { color: var(--teal); }

        .nav-links {
            display: flex;
            gap: 36px;
            list-style: none;
        }
        .nav-links a {
            text-decoration: none;
            color: var(--text-mid);
            font-size: 14.5px;
            font-weight: 500;
            transition: color .2s;
        }
        .nav-links a:hover { color: var(--teal); }

        .btn-signup {
            background: var(--teal);
            color: white;
            border: none;
            padding: 11px 28px;
            border-radius: 50px;
            font-size: 14.5px;
            font-weight: 600;
            cursor: pointer;
            font-family: 'Poppins', sans-serif;
            transition: background .2s, transform .15s, box-shadow .2s;
            box-shadow: 0 4px 16px rgba(58,175,169,.35);
            text-decoration: none;
        }
        .btn-signup:hover {
            background: var(--teal-dark);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(58,175,169,.45);
        }

        /* ══════════════ HERO ══════════════ */
        .hero {
            display: grid;
            grid-template-columns: 1fr 1fr;
            align-items: center;
            padding: 70px 52px 50px;
            gap: 32px;
            position: relative;
        }

        /* Left side */
        .hero-left { display: flex; flex-direction: column; gap: 22px; }

        .hero-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: var(--teal-pale);
            border: 1.5px solid rgba(58,175,169,.25);
            color: var(--teal-dark);
            padding: 6px 16px;
            border-radius: 50px;
            font-size: 12.5px;
            font-weight: 600;
            width: fit-content;
            animation: fadeSlideUp .5s ease both;
        }
        .hero-badge .dot {
            width: 7px; height: 7px;
            background: var(--teal);
            border-radius: 50%;
        }

        .hero-title {
            font-family: 'Nunito', sans-serif;
            font-size: clamp(2rem, 3.5vw, 2.9rem);
            font-weight: 900;
            line-height: 1.18;
            color: var(--text-dark);
            animation: fadeSlideUp .55s .1s ease both;
        }
        .hero-title span { color: var(--teal); }

        .hero-desc {
            font-size: 14.5px;
            color: var(--text-soft);
            line-height: 1.75;
            max-width: 420px;
            animation: fadeSlideUp .55s .2s ease both;
        }

        .hero-buttons {
            display: flex;
            gap: 14px;
            flex-wrap: wrap;
            animation: fadeSlideUp .55s .3s ease both;
        }
        .btn-primary {
            background: var(--teal);
            color: white;
            border: none;
            padding: 15px 36px;
            border-radius: 50px;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
            font-family: 'Poppins', sans-serif;
            transition: background .2s, transform .15s, box-shadow .2s;
            box-shadow: 0 6px 20px rgba(58,175,169,.38);
            text-decoration: none;
            display: inline-block;
        }
        .btn-primary:hover {
            background: var(--teal-dark);
            transform: translateY(-3px);
            box-shadow: 0 10px 28px rgba(58,175,169,.45);
        }
        .btn-secondary {
            background: transparent;
            color: var(--teal);
            border: 2px solid var(--teal);
            padding: 13px 30px;
            border-radius: 50px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            font-family: 'Poppins', sans-serif;
            transition: all .2s;
            text-decoration: none;
            display: inline-block;
        }
        .btn-secondary:hover {
            background: var(--teal);
            color: white;
            transform: translateY(-3px);
        }

        /* Stats strip */
        .hero-stats {
            display: flex;
            gap: 28px;
            margin-top: 6px;
            animation: fadeSlideUp .55s .4s ease both;
        }
        .stat-item { display: flex; flex-direction: column; }
        .stat-num {
            font-family: 'Nunito', sans-serif;
            font-weight: 900; font-size: 22px;
            color: var(--teal);
        }
        .stat-label { font-size: 11.5px; color: var(--text-soft); font-weight: 500; }

        /* Right side — illustration */
        .hero-right {
            position: relative;
            display: flex;
            align-items: flex-end;
            justify-content: center;
            min-height: 340px;
        }

        /* Blob background */
        .hero-blob {
            position: absolute;
            width: 420px; height: 390px;
            background: linear-gradient(135deg, var(--teal-light) 0%, rgba(58,175,169,.08) 100%);
            border-radius: 60% 40% 55% 45% / 45% 55% 40% 60%;
            top: 50%; left: 50%;
            transform: translate(-50%, -50%);
            z-index: 0;
        }

        /* Cameroon Flag */
        .cam-flag {
            position: absolute;
            top: 16px; left: 32px;
            width: 62px; height: 62px;
            border-radius: 50%;
            overflow: hidden;
            display: flex;
            box-shadow: 0 4px 18px rgba(0,0,0,.14);
            z-index: 4;
            border: 3px solid white;
            animation: floatA 3.5s ease-in-out infinite;
        }
        .cam-flag .stripe { flex: 1; }
        .cam-flag .stripe-green  { background: #007A5E; }
        .cam-flag .stripe-red    { background: #CE1126; position: relative; display: flex; align-items: center; justify-content: center; }
        .cam-flag .stripe-yellow { background: #FCD116; }
        .cam-flag .star {
            position: absolute;
            font-size: 13px;
            color: #FCD116;
            line-height: 1;
            text-shadow: 0 1px 3px rgba(0,0,0,.2);
        }

        /* Floating bubbles */
        .bubble {
            position: absolute;
            background: var(--teal);
            border-radius: var(--radius-sm);
            display: flex; align-items: center; justify-content: center;
            box-shadow: 0 4px 16px rgba(58,175,169,.3);
            z-index: 4;
        }
        .bubble-chat {
            width: 52px; height: 46px;
            top: 38%; right: 8px;
            animation: floatB 4s ease-in-out infinite;
        }
        .bubble-chat2 {
            width: 64px; height: 46px;
            top: 54%; right: -8px;
            animation: floatB 4s .8s ease-in-out infinite;
        }
        .bubble svg { fill: white; }

        /* Check badge */
        .check-badge {
            position: absolute;
            top: 12px; right: 22px;
            width: 40px; height: 40px;
            background: white;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            box-shadow: 0 3px 14px rgba(0,0,0,.1);
            z-index: 4;
            animation: floatA 3s .5s ease-in-out infinite;
        }
        .check-badge svg { width: 20px; height: 20px; }

        /* Lady illustration (CSS art) */
        .lady-wrap {
            position: relative;
            z-index: 3;
            width: 300px;
            height: 290px;
        }
        .lady-desk {
            position: absolute;
            bottom: 0; left: 50%;
            transform: translateX(-50%);
            width: 310px;
            height: 12px;
            background: rgba(58,175,169,.18);
            border-radius: 50%;
        }
        /* Laptop */
        .laptop {
            position: absolute;
            bottom: 18px; left: 50%;
            transform: translateX(-50%);
        }
        .laptop-base {
            width: 170px; height: 8px;
            background: #B0D8D6;
            border-radius: 4px;
        }
        .laptop-screen {
            width: 150px; height: 100px;
            background: linear-gradient(135deg, #DEF2F1, #B2DDD9);
            border-radius: 8px 8px 0 0;
            margin: 0 auto;
            border: 3px solid #AACFCC;
            display: flex; align-items: center; justify-content: center;
            position: relative;
            overflow: hidden;
        }
        .laptop-screen::after {
            content: '';
            position: absolute;
            inset: 0;
            background: repeating-linear-gradient(90deg, transparent, transparent 18px, rgba(255,255,255,.3) 18px, rgba(255,255,255,.3) 19px);
        }
        .laptop-logo {
            font-family: 'Nunito', sans-serif;
            font-weight: 900; font-size: 12px;
            color: var(--teal-dark);
            z-index: 1;
        }
        /* Cup */
        .cup {
            position: absolute;
            bottom: 18px;
            left: calc(50% + 88px);
            width: 24px; height: 26px;
            background: #B8D8D8;
            border-radius: 0 0 6px 6px;
        }
        .cup::before {
            content: '';
            position: absolute;
            right: -8px; top: 5px;
            width: 9px; height: 12px;
            border: 2.5px solid #B8D8D8;
            border-radius: 0 6px 6px 0;
        }
        /* Plant */
        .plant {
            position: absolute;
            bottom: 18px; right: 0;
        }
        .plant-pot {
            width: 28px; height: 22px;
            background: #A0C4BF;
            border-radius: 3px 3px 7px 7px;
            margin: 0 auto;
        }
        .plant-stems { display: flex; justify-content: center; gap: 3px; margin-bottom: 2px; }
        .plant-stem {
            width: 3px;
            background: #7BBBB5;
            border-radius: 2px;
        }
        .plant-stem:nth-child(1) { height: 32px; transform: rotate(-12deg) translateX(2px); }
        .plant-stem:nth-child(2) { height: 44px; }
        .plant-stem:nth-child(3) { height: 28px; transform: rotate(10deg) translateX(-2px); }

        /* Figure */
        .figure {
            position: absolute;
            bottom: 26px;
            left: 50%;
            transform: translateX(-75%);
        }
        /* Head */
        .fig-head {
            width: 54px; height: 58px;
            background: #F5C9A0;
            border-radius: 50% 50% 42% 42%;
            margin: 0 auto;
            position: relative;
            z-index: 2;
        }
        .fig-hair {
            position: absolute;
            top: -10px; left: -8px;
            width: 70px; height: 44px;
            background: #2D3A2E;
            border-radius: 50% 50% 40% 40%;
            z-index: 1;
        }
        .fig-hair::after {
            content: '';
            position: absolute;
            bottom: -28px; left: -2px;
            width: 22px; height: 50px;
            background: #2D3A2E;
            border-radius: 0 0 40% 50%;
        }
        .fig-headphone {
            position: absolute;
            top: -8px; left: -12px;
            width: 78px; height: 38px;
            border: 5px solid #E8A48A;
            border-bottom: none;
            border-radius: 60px 60px 0 0;
            z-index: 3;
        }
        .fig-headphone::before,
        .fig-headphone::after {
            content: '';
            position: absolute;
            bottom: -10px;
            width: 14px; height: 16px;
            background: #E8A48A;
            border-radius: 50%;
        }
        .fig-headphone::before { left: -8px; }
        .fig-headphone::after  { right: -8px; }
        /* Face features */
        .fig-eye-l, .fig-eye-r {
            position: absolute;
            top: 22px;
            width: 5px; height: 5px;
            background: #2D3748;
            border-radius: 50%;
            z-index: 3;
        }
        .fig-eye-l { left: 12px; }
        .fig-eye-r { right: 14px; }
        .fig-smile {
            position: absolute;
            bottom: 12px; left: 50%;
            transform: translateX(-50%);
            width: 18px; height: 8px;
            border: 2.5px solid #D98A70;
            border-top: none;
            border-radius: 0 0 20px 20px;
            z-index: 3;
        }
        /* Body */
        .fig-body {
            width: 80px; height: 80px;
            background: var(--teal);
            border-radius: 16px 16px 0 0;
            margin: -4px auto 0;
            position: relative;
            z-index: 1;
        }
        .fig-shirt {
            position: absolute;
            top: 10px; left: 50%;
            transform: translateX(-50%);
            width: 36px; height: 20px;
            background: white;
            border-radius: 4px;
        }
        /* Arms */
        .fig-arm-l, .fig-arm-r {
            position: absolute;
            top: 12px;
            width: 16px; height: 55px;
            background: var(--teal);
            border-radius: 8px;
        }
        .fig-arm-l { left: -14px; transform: rotate(8deg); }
        .fig-arm-r { right: -14px; transform: rotate(-15deg); }
        .fig-hand-l, .fig-hand-r {
            position: absolute;
            bottom: -8px;
            width: 14px; height: 12px;
            background: #F5C9A0;
            border-radius: 50%;
        }
        .fig-hand-l { left: 1px; }
        .fig-hand-r { right: 1px; }

        /* ══════════════ SECTIONS EXPLAINER ══════════════ */
        .sections-strip {
            display: flex;
            justify-content: center;
            gap: 10px;
            padding: 0 52px 40px;
            flex-wrap: wrap;
            animation: fadeSlideUp .6s .5s ease both;
        }
        .section-pill {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 9px 20px;
            border-radius: 50px;
            border: 1.5px solid rgba(58,175,169,.25);
            background: var(--teal-pale);
            font-size: 13px;
            font-weight: 600;
            color: var(--teal-dark);
            cursor: pointer;
            transition: all .2s;
            text-decoration: none;
        }
        .section-pill:hover {
            background: var(--teal);
            color: white;
            border-color: var(--teal);
            transform: translateY(-2px);
            box-shadow: 0 4px 14px rgba(58,175,169,.3);
        }
        .section-pill .pill-icon { font-size: 15px; }

        /* ══════════════ FEATURE CARDS ══════════════ */
        .cards-section {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            padding: 0 52px 52px;
        }
        .card {
            background: var(--card-bg);
            border-radius: var(--radius);
            padding: 28px 24px;
            box-shadow: var(--shadow);
            display: flex;
            flex-direction: row;
            align-items: flex-start;
            gap: 18px;
            transition: transform .2s, box-shadow .2s;
            animation: fadeSlideUp .6s .6s ease both;
        }
        .card:hover {
            transform: translateY(-6px);
            box-shadow: 0 12px 36px rgba(58,175,169,.18);
        }
        .card-icon-wrap {
            flex-shrink: 0;
            width: 56px; height: 56px;
            background: var(--teal);
            border-radius: var(--radius-sm);
            display: flex; align-items: center; justify-content: center;
            box-shadow: 0 4px 14px rgba(58,175,169,.3);
        }
        .card-icon-wrap svg { width: 28px; height: 28px; fill: white; }
        .card-body { display: flex; flex-direction: column; gap: 6px; }
        .card-title {
            font-family: 'Nunito', sans-serif;
            font-weight: 800; font-size: 16px;
            color: var(--text-dark);
        }
        .card-desc {
            font-size: 12.5px;
            color: var(--text-soft);
            line-height: 1.6;
        }
        .card-link {
            font-size: 12px;
            font-weight: 600;
            color: var(--teal);
            text-decoration: none;
            margin-top: 4px;
            display: inline-flex;
            align-items: center;
            gap: 4px;
            transition: gap .2s;
        }
        .card-link:hover { gap: 8px; }

        /* ══════════════ FOOTER ══════════════ */
        footer {
            background: rgba(255,255,255,0.7);
            border-top: 1.5px solid rgba(58,175,169,.12);
            padding: 24px 52px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            font-size: 12.5px;
            color: var(--text-soft);
        }
        .footer-brand {
            font-family: 'Nunito', sans-serif;
            font-weight: 800;
            color: var(--teal);
            font-size: 14px;
        }
        .cam-colors {
            display: flex;
            gap: 4px;
            align-items: center;
        }
        .cam-dot {
            width: 10px; height: 10px;
            border-radius: 50%;
        }

        /* ══════════════ ANIMATIONS ══════════════ */
        @keyframes fadeSlideUp {
            from { opacity: 0; transform: translateY(22px); }
            to   { opacity: 1; transform: translateY(0); }
        }
        @keyframes floatA {
            0%, 100% { transform: translateY(0); }
            50%       { transform: translateY(-10px); }
        }
        @keyframes floatB {
            0%, 100% { transform: translateY(0) rotate(-2deg); }
            50%       { transform: translateY(-8px) rotate(2deg); }
        }

        /* ══════════════ RESPONSIVE ══════════════ */
        @media (max-width: 900px) {
            .page-wrapper { margin: 12px; border-radius: 20px; }
            nav { padding: 18px 24px; }
            .nav-links { gap: 18px; }
            .hero { grid-template-columns: 1fr; padding: 40px 24px 24px; }
            .hero-right { display: none; }
            .cards-section { grid-template-columns: 1fr; padding: 0 24px 36px; }
            .sections-strip { padding: 0 24px 28px; }
            footer { flex-direction: column; gap: 8px; text-align: center; padding: 20px 24px; }
        }
    </style>
</head>
<body>

<!-- ── Background Waves ── -->
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
            <li><a href="#sections">Sections</a></li>
            <li><a href="#fonctionnement">À propos</a></li>
            <li><a href="Historique.aspx">Résultats</a></li>
        </ul>
        <a href="Inscription.aspx" class="btn-signup">S'inscrire</a>
    </nav>

    <!-- ══════════ HERO ══════════ -->
    <section class="hero">

        <!-- Left -->
        <div class="hero-left">
            <div class="hero-badge">
                <span class="dot"></span>
                Plateforme officielle TLC — Yemba
            </div>

            <h1 class="hero-title">
                Apprenez &amp; Maîtrisez<br/>
                <span>Le Yemba</span> en Ligne
            </h1>

            <p class="hero-desc">
                Testez et certifiez votre niveau en langue Yemba grâce à notre 
                plateforme de tests certifiants inspirée du TOEFL/TOEIC, 
                conçue pour valoriser les langues maternelles du Cameroun.
            </p>

            <div class="hero-buttons">
                <a href="ChoixTest.aspx" class="btn-primary">Commencer un Test</a>
                <a href="Historique.aspx" class="btn-secondary">Voir mes Résultats</a>
            </div>

            <div class="hero-stats">
                <div class="stat-item">
                    <span class="stat-num">4</span>
                    <span class="stat-label">Sections TLC</span>
                </div>
                <div class="stat-item">
                    <span class="stat-num">5</span>
                    <span class="stat-label">Niveaux</span>
                </div>
                <div class="stat-item">
                    <span class="stat-num">100%</span>
                    <span class="stat-label">Gratuit</span>
                </div>
            </div>
        </div>

        <!-- Right — Illustration -->
        <div class="hero-right">
            <div class="hero-blob"></div>

            <!-- Cameroon Flag -->
            <div class="cam-flag" title="Drapeau du Cameroun">
                <div class="stripe stripe-green"></div>
                <div class="stripe stripe-red">
                    <span class="star">★</span>
                </div>
                <div class="stripe stripe-yellow"></div>
            </div>

            <!-- Floating chat bubbles -->
            <div class="bubble bubble-chat">
                <svg viewBox="0 0 24 24" width="26" height="26"><path d="M20 2H4a2 2 0 00-2 2v18l4-4h14a2 2 0 002-2V4a2 2 0 00-2-2zm-2 10H6V10h12v2zm0-4H6V6h12v2z"/></svg>
            </div>
            <div class="bubble bubble-chat2">
                <svg viewBox="0 0 24 24" width="30" height="30"><path d="M20 2H4a2 2 0 00-2 2v18l4-4h14a2 2 0 002-2V4a2 2 0 00-2-2zM7 11a1 1 0 110-2 1 1 0 010 2zm5 0a1 1 0 110-2 1 1 0 010 2zm5 0a1 1 0 110-2 1 1 0 010 2z"/></svg>
            </div>

            <!-- Check badge -->
            <div class="check-badge">
                <svg viewBox="0 0 24 24" fill="none" stroke="var(--teal)" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                    <circle cx="12" cy="12" r="10"/><polyline points="9 12 11 14 15 10"/>
                </svg>
            </div>

            <!-- Lady figure -->
            <div class="lady-wrap">

                <!-- Figure -->
                <div class="figure">
                    <!-- Head -->
                    <div style="position:relative; margin-bottom:-4px;">
                        <div class="fig-hair"></div>
                        <div class="fig-head">
                            <div class="fig-headphone"></div>
                            <div class="fig-eye-l"></div>
                            <div class="fig-eye-r"></div>
                            <div class="fig-smile"></div>
                        </div>
                    </div>
                    <!-- Body -->
                    <div class="fig-body">
                        <div class="fig-shirt"></div>
                        <div class="fig-arm-l"><div class="fig-hand-l"></div></div>
                        <div class="fig-arm-r"><div class="fig-hand-r"></div></div>
                    </div>
                </div>

                <!-- Laptop -->
                <div class="laptop">
                    <div class="laptop-screen">
                        <span class="laptop-logo">TLC Yemba</span>
                    </div>
                    <div class="laptop-base"></div>
                </div>

                <!-- Cup -->
                <div class="cup"></div>

                <!-- Plant -->
                <div class="plant">
                    <div class="plant-stems">
                        <div class="plant-stem"></div>
                        <div class="plant-stem"></div>
                        <div class="plant-stem"></div>
                    </div>
                    <div class="plant-pot"></div>
                </div>

                <!-- Desk shadow -->
                <div class="lady-desk"></div>
            </div>
        </div>
    </section>

    <!-- ══════════ SECTIONS PILLS ══════════ -->
    <div class="sections-strip" id="sections">
        <a href="ChoixTest.aspx?section=Listening"  class="section-pill"><span class="pill-icon">🎧</span> Listening</a>
        <a href="ChoixTest.aspx?section=Structure"  class="section-pill"><span class="pill-icon">📝</span> Structure</a>
        <a href="ChoixTest.aspx?section=Reading"    class="section-pill"><span class="pill-icon">📖</span> Reading</a>
        <a href="ChoixTest.aspx?section=FullTest"   class="section-pill"><span class="pill-icon">🏆</span> Test Complet</a>
    </div>

    <!-- ══════════ FEATURE CARDS ══════════ -->
    <div class="cards-section">

        <!-- Card 1 -->
        <div class="card">
            <div class="card-icon-wrap">
                <svg viewBox="0 0 24 24"><path d="M20 2H4a2 2 0 00-2 2v18l4-4h14a2 2 0 002-2V4a2 2 0 00-2-2zM7 11a1 1 0 110-2 1 1 0 010 2zm5 0a1 1 0 110-2 1 1 0 010 2zm5 0a1 1 0 110-2 1 1 0 010 2z"/></svg>
            </div>
            <div class="card-body">
                <div class="card-title">Compréhension Orale</div>
                <p class="card-desc">Entraînez-vous à comprendre le Yemba parlé à travers des exercices audio ciblés.</p>
                <a href="ChoixTest.aspx?section=Listening" class="card-link">Commencer →</a>
            </div>
        </div>

        <!-- Card 2 -->
        <div class="card">
            <div class="card-icon-wrap">
                <svg viewBox="0 0 24 24"><path d="M12 2a10 10 0 100 20A10 10 0 0012 2zm1 14.93V15a1 1 0 00-2 0v1.93A8.001 8.001 0 014.07 11H6a1 1 0 000-2H4.07A8.001 8.001 0 0111 4.07V6a1 1 0 002 0V4.07A8.001 8.001 0 0119.93 11H18a1 1 0 000 2h1.93A8.001 8.001 0 0113 16.93z"/></svg>
            </div>
            <div class="card-body">
                <div class="card-title">Grammaire & Structure</div>
                <p class="card-desc">Maîtrisez la syntaxe et les règles grammaticales de la langue Yemba en profondeur.</p>
                <a href="ChoixTest.aspx?section=Structure" class="card-link">Commencer →</a>
            </div>
        </div>

        <!-- Card 3 -->
        <div class="card">
            <div class="card-icon-wrap">
                <svg viewBox="0 0 24 24"><path d="M19 2H6a2 2 0 00-2 2v16a2 2 0 002 2h13a1 1 0 001-1V3a1 1 0 00-1-1zm-7 15H8v-2h4v2zm4-4H8v-2h8v2zm0-4H8V7h8v2z"/></svg>
            </div>
            <div class="card-body">
                <div class="card-title">Lecture & Vocabulaire</div>
                <p class="card-desc">Développez votre compréhension écrite et enrichissez votre vocabulaire Yemba.</p>
                <a href="ChoixTest.aspx?section=Reading" class="card-link">Commencer →</a>
            </div>
        </div>

    </div>

    <!-- ══════════ FOOTER ══════════ -->
    <footer>
        <span class="footer-brand">TLC Yemba Online Test</span>
        <span>Projet DPW — ASP.NET Web Forms &amp; ADO.NET</span>
        <div class="cam-colors" title="Couleurs du Cameroun">
            <div class="cam-dot" style="background:#007A5E;"></div>
            <div class="cam-dot" style="background:#CE1126;"></div>
            <div class="cam-dot" style="background:#FCD116;"></div>
            <span style="margin-left:6px; font-size:11px;">Cameroun 🇨🇲</span>
        </div>
    </footer>

</div><!-- end .page-wrapper -->

</form>

<script>
    // Smooth active state for nav links
    document.querySelectorAll('.nav-links a').forEach(link => {
        if (link.href === window.location.href) {
            link.style.color = 'var(--teal)';
            link.style.fontWeight = '700';
        }
    });

    // Card entrance animation on scroll (lightweight IntersectionObserver)
    const cards = document.querySelectorAll('.card');
    const observer = new IntersectionObserver((entries) => {
        entries.forEach((e, i) => {
            if (e.isIntersecting) {
                e.target.style.animationDelay = (i * 0.12) + 's';
                e.target.classList.add('visible');
                observer.unobserve(e.target);
            }
        });
    }, { threshold: 0.1 });
    cards.forEach(c => observer.observe(c));
</script>

</body>
</html>
