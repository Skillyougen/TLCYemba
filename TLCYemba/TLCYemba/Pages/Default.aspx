<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TLCYemba.Default" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="fr">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>TLC Yemba — Test de Langue du Cameroun</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800;900&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <style>
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
            --radius:     18px;
        }
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        html { scroll-behavior: smooth; }
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(145deg, #C8EDEA 0%, #EAF8F7 40%, #DEF5F3 70%, #B8E8E4 100%);
            min-height: 100vh;
            color: var(--text-dark);
        }
        .bg-wave { position: fixed; inset: 0; z-index: 0; pointer-events: none; }
        .bg-wave svg { width: 100%; height: 100%; }
        .page-wrapper {
            position: relative; z-index: 1;
            max-width: 1280px; margin: 32px auto;
            background: rgba(255,255,255,0.84);
            backdrop-filter: blur(20px);
            border-radius: 32px;
            box-shadow: 0 8px 64px rgba(58,175,169,.18);
            overflow: hidden;
        }
        /* NAVBAR */
        nav {
            display: flex; align-items: center; justify-content: space-between;
            padding: 22px 52px;
            background: rgba(255,255,255,0.96);
            border-bottom: 1.5px solid rgba(58,175,169,.10);
        }
        .nav-logo { display: flex; align-items: center; gap: 13px; text-decoration: none; }
        .logo-icon {
            width: 44px; height: 44px; background: var(--teal); border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-family: 'Nunito', sans-serif; font-weight: 900; font-size: 19px; color: white;
            box-shadow: 0 4px 14px rgba(58,175,169,.4);
        }
        .logo-text { font-family: 'Nunito', sans-serif; font-weight: 900; font-size: 19px; color: var(--text-dark); }
        .logo-text span { color: var(--teal); }
        .nav-links { display: flex; gap: 4px; list-style: none; }
        .nav-links a {
            display: flex; align-items: center; gap: 7px;
            text-decoration: none; color: var(--text-mid);
            font-size: 14px; font-weight: 500;
            padding: 8px 16px; border-radius: 50px; transition: all .2s;
        }
        .nav-links a i { font-size: 13px; color: var(--text-soft); transition: color .2s; }
        .nav-links a:hover { color: var(--teal); background: var(--teal-pale); }
        .nav-links a:hover i { color: var(--teal); }
        .btn-signup {
            display: inline-flex; align-items: center; gap: 8px;
            background: var(--teal); color: white; border: none;
            padding: 11px 26px; border-radius: 50px;
            font-size: 14.5px; font-weight: 600; cursor: pointer;
            font-family: 'Poppins', sans-serif;
            transition: background .2s, transform .15s, box-shadow .2s;
            box-shadow: 0 4px 16px rgba(58,175,169,.38); text-decoration: none;
        }
        .btn-signup:hover { background: var(--teal-dark); transform: translateY(-2px); }
        /* HERO */
        .hero {
            display: grid; grid-template-columns: 1fr 1fr;
            align-items: center; padding: 60px 52px 44px; gap: 20px;
        }
        .hero-left { display: flex; flex-direction: column; gap: 24px; }
        .hero-badge {
            display: inline-flex; align-items: center; gap: 8px;
            background: var(--teal-pale); border: 1.5px solid rgba(58,175,169,.25);
            color: var(--teal-dark); padding: 7px 18px; border-radius: 50px;
            font-size: 12.5px; font-weight: 600; width: fit-content;
            animation: fadeUp .5s ease both;
        }
        .hero-badge i { font-size: 11px; color: var(--teal); }
        .hero-title {
            font-family: 'Nunito', sans-serif;
            font-size: clamp(2rem, 3.4vw, 2.85rem);
            font-weight: 900; line-height: 1.17; color: var(--text-dark);
            animation: fadeUp .5s .1s ease both;
        }
        .hero-title span { color: var(--teal); }
        .hero-desc {
            font-size: 14.5px; color: var(--text-soft);
            line-height: 1.78; max-width: 420px;
            animation: fadeUp .5s .2s ease both;
        }
        .hero-buttons { display: flex; gap: 14px; flex-wrap: wrap; animation: fadeUp .5s .3s ease both; }
        .btn-primary {
            display: inline-flex; align-items: center; gap: 9px;
            background: var(--teal); color: white; border: none;
            padding: 15px 34px; border-radius: 50px;
            font-size: 15px; font-weight: 700; cursor: pointer;
            font-family: 'Poppins', sans-serif;
            transition: background .2s, transform .15s, box-shadow .2s;
            box-shadow: 0 6px 22px rgba(58,175,169,.38); text-decoration: none;
        }
        .btn-primary:hover { background: var(--teal-dark); transform: translateY(-3px); }
        .btn-secondary {
            display: inline-flex; align-items: center; gap: 9px;
            background: transparent; color: var(--teal); border: 2px solid var(--teal);
            padding: 13px 28px; border-radius: 50px;
            font-size: 15px; font-weight: 600; cursor: pointer;
            font-family: 'Poppins', sans-serif; transition: all .2s; text-decoration: none;
        }
        .btn-secondary:hover { background: var(--teal); color: white; transform: translateY(-3px); }
        .hero-stats { display: flex; gap: 32px; animation: fadeUp .5s .4s ease both; }
        .stat-item { display: flex; flex-direction: column; gap: 2px; }
        .stat-num { font-family: 'Nunito', sans-serif; font-weight: 900; font-size: 24px; color: var(--teal); }
        .stat-label { font-size: 11.5px; color: var(--text-soft); font-weight: 500; }
        /* HERO RIGHT */
        .hero-right {
            position: relative; display: flex;
            align-items: flex-end; justify-content: center;
            min-height: 380px; animation: fadeUp .5s .15s ease both;
        }
        .hero-right svg.illustration {
            width: 100%; max-width: 560px; height: auto;
            filter: drop-shadow(0 12px 32px rgba(58,175,169,.12));
        }
        /* SECTIONS PILLS */
        .sections-strip {
            display: flex; justify-content: center;
            gap: 10px; padding: 0 52px 42px; flex-wrap: wrap;
            animation: fadeUp .5s .5s ease both;
        }
        .section-pill {
            display: flex; align-items: center; gap: 9px;
            padding: 10px 22px; border-radius: 50px;
            border: 1.5px solid rgba(58,175,169,.25);
            background: var(--teal-pale);
            font-size: 13.5px; font-weight: 600; color: var(--teal-dark);
            cursor: pointer; transition: all .2s; text-decoration: none;
        }
        .section-pill i { font-size: 14px; color: var(--teal); transition: color .2s; }
        .section-pill:hover { background: var(--teal); color: white; border-color: var(--teal); transform: translateY(-2px); box-shadow: 0 4px 16px rgba(58,175,169,.3); }
        .section-pill:hover i { color: white; }
        /* CARDS */
        .cards-section {
            display: grid; grid-template-columns: repeat(3, 1fr);
            gap: 20px; padding: 0 52px 52px;
        }
        .card {
            background: var(--white); border-radius: var(--radius);
            padding: 28px 24px;
            box-shadow: 0 2px 20px rgba(0,0,0,.06);
            display: flex; flex-direction: row; align-items: flex-start; gap: 18px;
            transition: transform .22s, box-shadow .22s;
            animation: fadeUp .5s .6s ease both;
        }
        .card:hover { transform: translateY(-7px); box-shadow: 0 14px 40px rgba(58,175,169,.17); }
        .card-icon-wrap {
            flex-shrink: 0; width: 58px; height: 58px;
            background: var(--teal); border-radius: 16px;
            display: flex; align-items: center; justify-content: center;
            box-shadow: 0 4px 16px rgba(58,175,169,.32);
            transition: transform .2s;
        }
        .card:hover .card-icon-wrap { transform: scale(1.1) rotate(-5deg); }
        .card-icon-wrap i { font-size: 24px; color: white; }
        .card-body { display: flex; flex-direction: column; gap: 6px; }
        .card-title { font-family: 'Nunito', sans-serif; font-weight: 800; font-size: 16px; color: var(--text-dark); }
        .card-desc { font-size: 12.5px; color: var(--text-soft); line-height: 1.65; }
        .card-link {
            font-size: 12px; font-weight: 600; color: var(--teal);
            text-decoration: none; margin-top: 4px;
            display: inline-flex; align-items: center; gap: 5px; transition: gap .2s;
        }
        .card-link:hover { gap: 9px; }
        /* FOOTER */
        footer {
            background: rgba(255,255,255,0.7);
            border-top: 1.5px solid rgba(58,175,169,.12);
            padding: 22px 52px;
            display: flex; align-items: center; justify-content: space-between;
            font-size: 12.5px; color: var(--text-soft);
        }
        .footer-brand { font-family: 'Nunito', sans-serif; font-weight: 800; color: var(--teal); font-size: 14px; }
        .footer-links { display: flex; gap: 20px; }
        .footer-links a {
            display: flex; align-items: center; gap: 6px;
            color: var(--text-soft); text-decoration: none; font-size: 12px; transition: color .2s;
        }
        .footer-links a:hover { color: var(--teal); }
        .cam-colors { display: flex; gap: 5px; align-items: center; }
        .cam-dot { width: 11px; height: 11px; border-radius: 50%; }
        /* ANIMATIONS */
        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(24px); }
            to   { opacity: 1; transform: translateY(0); }
        }
        @keyframes floatA { 0%,100%{transform:translateY(0)} 50%{transform:translateY(-10px)} }
        @keyframes floatB { 0%,100%{transform:translateY(0)} 50%{transform:translateY(-7px)} }
        @keyframes floatC { 0%,100%{transform:translateY(0)} 50%{transform:translateY(-12px)} }
        .fa { animation: floatA 3.8s ease-in-out infinite; }
        .fb { animation: floatB 4.5s .6s ease-in-out infinite; }
        .fc { animation: floatC 3.2s 1s ease-in-out infinite; }
        /* RESPONSIVE */
        @media (max-width:920px) {
            .page-wrapper { margin: 12px; border-radius: 22px; }
            nav { padding: 18px 24px; }
            .nav-links a span { display: none; }
            .hero { grid-template-columns: 1fr; padding: 40px 24px 24px; }
            .hero-right { display: none; }
            .cards-section { grid-template-columns: 1fr; padding: 0 24px 36px; }
            .sections-strip { padding: 0 24px 30px; }
            footer { flex-direction: column; gap: 10px; text-align: center; padding: 20px 24px; }
        }
    </style>
</head>
<body>
<div class="bg-wave" aria-hidden="true">
    <svg viewBox="0 0 1440 900" preserveAspectRatio="xMidYMid slice" xmlns="http://www.w3.org/2000/svg">
        <ellipse cx="180" cy="720" rx="540" ry="360" fill="rgba(58,175,169,.12)"/>
        <ellipse cx="1300" cy="180" rx="380" ry="260" fill="rgba(58,175,169,.09)"/>
        <path d="M0 640 Q380 510 740 640 T1440 550 V900 H0Z" fill="rgba(58,175,169,.07)"/>
    </svg>
</div>
<form id="form1" runat="server">
<div class="page-wrapper">

  <!-- NAVBAR -->
  <nav>
    <a href="Default.aspx" class="nav-logo">
      <div class="logo-icon">T</div>
      <span class="logo-text">TLC <span>Yemba</span></span>
    </a>
    <ul class="nav-links">
      <li><a href="Default.aspx"><i class="fa-solid fa-house"></i><span>Accueil</span></a></li>
      <li><a href="#sections"><i class="fa-solid fa-layer-group"></i><span>Sections</span></a></li>
      <li><a href="#fonctionnement"><i class="fa-solid fa-circle-info"></i><span>À propos</span></a></li>
      <li><a href="Historique.aspx"><i class="fa-solid fa-chart-bar"></i><span>Résultats</span></a></li>
    </ul>
    <a href="Inscription.aspx" class="btn-signup">
      <i class="fa-solid fa-user-plus"></i> S'inscrire
    </a>
  </nav>

  <!-- HERO -->
  <section class="hero">
    <div class="hero-left">
      <div class="hero-badge">
        <i class="fa-solid fa-circle-check"></i> Plateforme officielle TLC — Yemba
      </div>
      <h1 class="hero-title">Apprenez &amp; Maîtrisez<br/><span>Le Yemba</span> en Ligne</h1>
      <p class="hero-desc">Testez et certifiez votre niveau en langue Yemba grâce à notre plateforme de tests certifiants inspirée du TOEFL/TOEIC, conçue pour valoriser les langues maternelles du Cameroun.</p>
      <div class="hero-buttons">
        <a href="ChoixTest.aspx" class="btn-primary"><i class="fa-solid fa-play"></i> Commencer un Test</a>
        <a href="Historique.aspx" class="btn-secondary"><i class="fa-solid fa-clock-rotate-left"></i> Mes Résultats</a>
      </div>
      <div class="hero-stats">
        <div class="stat-item"><span class="stat-num">4</span><span class="stat-label">Sections TLC</span></div>
        <div class="stat-item"><span class="stat-num">5</span><span class="stat-label">Niveaux</span></div>
        <div class="stat-item"><span class="stat-num">100%</span><span class="stat-label">Gratuit</span></div>
      </div>
    </div>

    <!-- SVG ILLUSTRATION -->
    <div class="hero-right">
<svg class="illustration" viewBox="0 0 560 460" fill="none" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <filter id="sh1"><feDropShadow dx="0" dy="4" stdDeviation="5" flood-color="rgba(0,0,0,0.11)"/></filter>
    <filter id="sh2"><feDropShadow dx="0" dy="2" stdDeviation="3" flood-color="rgba(0,0,0,0.08)"/></filter>
    <clipPath id="fc"><circle cx="148" cy="103" r="38"/></clipPath>
  </defs>

  <!-- Blob background -->
  <ellipse cx="310" cy="248" rx="200" ry="178" fill="#DEF2F1" opacity="0.85"/>
  <ellipse cx="310" cy="248" rx="176" ry="156" fill="#E8F8F7" opacity="0.55"/>

  <!-- DESK -->
  <rect x="108" y="378" width="400" height="14" rx="6" fill="#B5DCDA"/>
  <ellipse cx="295" cy="382" rx="145" ry="7" fill="rgba(58,175,169,.16)"/>

  <!-- LAPTOP -->
  <rect x="186" y="370" width="218" height="14" rx="6" fill="#C8E8E5"/>
  <rect x="192" y="370" width="206" height="5" rx="3" fill="#D8EEEC"/>
  <rect x="198" y="240" width="196" height="134" rx="11" fill="#D5EDEB" stroke="#AACFCC" stroke-width="2.5"/>
  <rect x="208" y="250" width="176" height="114" rx="7" fill="#E8F8F7"/>
  <rect x="220" y="265" width="90" height="7" rx="3.5" fill="rgba(58,175,169,.45)"/>
  <rect x="220" y="279" width="140" height="5" rx="2.5" fill="rgba(58,175,169,.28)"/>
  <rect x="220" y="290" width="120" height="5" rx="2.5" fill="rgba(58,175,169,.22)"/>
  <rect x="220" y="301" width="80" height="5" rx="2.5" fill="rgba(58,175,169,.16)"/>
  <text x="295" y="343" text-anchor="middle" font-family="Nunito,Arial" font-size="11" font-weight="900" fill="#2B8F8A">TLC Yemba</text>

  <!-- CUP -->
  <g class="fc">
    <path d="M430 352 Q428 382 436 383 L455 383 Q463 382 461 352 Z" fill="#AAD4D0"/>
    <rect x="429" y="347" width="32" height="9" rx="4" fill="#BDE0DD"/>
    <path d="M461 358 Q475 360 474 367 Q474 375 461 377" stroke="#AAD4D0" stroke-width="4" fill="none" stroke-linecap="round"/>
    <path d="M438 345 Q441 338 438 330" stroke="#C8E8E5" stroke-width="2.5" fill="none" stroke-linecap="round" opacity="0.8"/>
    <path d="M446 344 Q449 336 446 328" stroke="#C8E8E5" stroke-width="2.5" fill="none" stroke-linecap="round" opacity="0.8"/>
  </g>

  <!-- PLANT -->
  <path d="M512 393 L505 365 L526 365 Z" fill="#9EC4BF"/>
  <rect x="501" y="389" width="32" height="8" rx="3" fill="#8AB5B0"/>
  <path d="M513 365 Q506 345 496 316" stroke="#6BAF9F" stroke-width="4" fill="none" stroke-linecap="round"/>
  <path d="M513 365 Q513 338 511 302" stroke="#6BAF9F" stroke-width="4" fill="none" stroke-linecap="round"/>
  <path d="M513 365 Q522 344 530 312" stroke="#6BAF9F" stroke-width="4" fill="none" stroke-linecap="round"/>
  <ellipse cx="494" cy="312" rx="16" ry="9" fill="#4CAF9A" transform="rotate(-35 494 312)"/>
  <ellipse cx="511" cy="298" rx="16" ry="9" fill="#5BC4AD"/>
  <ellipse cx="531" cy="309" rx="16" ry="9" fill="#4CAF9A" transform="rotate(30 531 309)"/>

  <!-- ARMS (drawn BEFORE torso so torso covers shoulders) -->
  <path d="M238 300 Q213 332 205 376" stroke="#3AAFA9" stroke-width="32" fill="none" stroke-linecap="round"/>
  <path d="M235 304 Q211 335 208 373" stroke="#44C4BE" stroke-width="10" fill="none" stroke-linecap="round" opacity="0.28"/>
  <ellipse cx="207" cy="375" rx="16" ry="11" fill="#F0B98A"/>

  <path d="M342 300 Q367 334 373 376" stroke="#3AAFA9" stroke-width="32" fill="none" stroke-linecap="round"/>
  <path d="M345 304 Q368 336 370 373" stroke="#44C4BE" stroke-width="10" fill="none" stroke-linecap="round" opacity="0.28"/>
  <ellipse cx="371" cy="375" rx="16" ry="11" fill="#F0B98A"/>

  <!-- TORSO (green blazer) -->
  <path d="M194 394 Q194 293 222 275 Q252 263 290 263 Q328 263 358 275 Q386 293 386 394 Z" fill="#3AAFA9"/>
  <path d="M222 279 Q196 312 196 368 L207 368 Q212 313 232 283 Z" fill="rgba(0,0,0,0.06)"/>
  <path d="M358 279 Q384 312 384 368 L373 368 Q368 313 348 283 Z" fill="rgba(0,0,0,0.06)"/>

  <!-- White shirt -->
  <path d="M258 270 L290 302 L322 270 L318 320 Q290 350 262 320 Z" fill="white"/>
  <path d="M274 285 L290 302 L306 285 L304 318 Q290 333 276 318 Z" fill="rgba(210,236,234,0.55)"/>

  <!-- Lapels -->
  <path d="M222 280 Q244 265 258 270 L252 310 Q234 297 220 308 Z" fill="#2B8F8A"/>
  <path d="M358 280 Q336 265 322 270 L328 310 Q346 297 360 308 Z" fill="#2B8F8A"/>

  <!-- Neck -->
  <rect x="272" y="237" width="36" height="32" rx="16" fill="#F0B98A"/>

  <!-- HAIR BACK -->
  <path d="M224 172 Q222 107 290 100 Q358 100 356 172 Q360 226 362 282 Q340 254 290 250 Q240 254 218 282 Q220 226 224 172 Z" fill="#1B2919"/>
  <path d="M222 170 Q202 184 198 220 Q194 257 206 290 Q216 304 230 300 Q214 263 216 227 Q218 193 224 172 Z" fill="#1B2919"/>
  <path d="M358 170 Q378 184 382 220 Q386 257 374 290 Q364 304 350 300 Q366 263 364 227 Q362 193 356 170 Z" fill="#1B2919"/>
  <!-- Hair wave detail -->
  <path d="M200 232 Q196 253 204 278" stroke="#2D3E2A" stroke-width="4" fill="none" stroke-linecap="round" opacity="0.55"/>
  <path d="M380 232 Q384 253 376 278" stroke="#2D3E2A" stroke-width="4" fill="none" stroke-linecap="round" opacity="0.55"/>

  <!-- FACE -->
  <ellipse cx="290" cy="193" rx="58" ry="62" fill="#F5C4A0"/>
  <!-- Face shadow/depth -->
  <ellipse cx="290" cy="206" rx="50" ry="50" fill="#F0B98A" opacity="0.18"/>

  <!-- Ears -->
  <ellipse cx="231" cy="200" rx="10" ry="13" fill="#F0B98A"/>
  <ellipse cx="349" cy="200" rx="10" ry="13" fill="#F0B98A"/>

  <!-- Eyebrows -->
  <path d="M261 171 Q272 165 283 168" stroke="#5C3322" stroke-width="3" fill="none" stroke-linecap="round"/>
  <path d="M297 168 Q308 165 319 171" stroke="#5C3322" stroke-width="3" fill="none" stroke-linecap="round"/>

  <!-- Eyes whites -->
  <ellipse cx="272" cy="184" rx="9" ry="10" fill="white"/>
  <ellipse cx="308" cy="184" rx="9" ry="10" fill="white"/>
  <!-- Iris -->
  <ellipse cx="272" cy="185" rx="6" ry="7" fill="#2A1A0E"/>
  <ellipse cx="308" cy="185" rx="6" ry="7" fill="#2A1A0E"/>
  <!-- Highlights -->
  <circle cx="274" cy="182" r="2.5" fill="white"/>
  <circle cx="310" cy="182" r="2.5" fill="white"/>
  <!-- Upper eyelid -->
  <path d="M263 179 Q272 176 281 179" stroke="#1A1008" stroke-width="1.5" fill="none" stroke-linecap="round"/>
  <path d="M299 179 Q308 176 317 179" stroke="#1A1008" stroke-width="1.5" fill="none" stroke-linecap="round"/>

  <!-- Nose -->
  <path d="M284 203 Q290 213 296 203" stroke="#D4896A" stroke-width="2.5" fill="none" stroke-linecap="round"/>
  <circle cx="284" cy="204" r="2.5" fill="#E8A882" opacity="0.5"/>
  <circle cx="296" cy="204" r="2.5" fill="#E8A882" opacity="0.5"/>

  <!-- Smile -->
  <path d="M269 222 Q290 242 311 222" stroke="#D4896A" stroke-width="3.5" fill="none" stroke-linecap="round"/>
  <!-- Dimples -->
  <circle cx="267" cy="220" r="3" fill="#E8A882" opacity="0.45"/>
  <circle cx="313" cy="220" r="3" fill="#E8A882" opacity="0.45"/>

  <!-- Blush -->
  <ellipse cx="252" cy="212" rx="14" ry="8" fill="rgba(235,130,100,.17)"/>
  <ellipse cx="328" cy="212" rx="14" ry="8" fill="rgba(235,130,100,.17)"/>

  <!-- HEADPHONES -->
  <path d="M228 194 Q232 116 290 113 Q348 116 352 194" stroke="#F0D0C0" stroke-width="11" fill="none" stroke-linecap="round"/>
  <path d="M230 194 Q234 122 290 119 Q346 122 350 194" stroke="rgba(255,255,255,0.3)" stroke-width="4" fill="none" stroke-linecap="round"/>
  <!-- Left cup -->
  <ellipse cx="227" cy="201" rx="20" ry="24" fill="#F0D0C0"/>
  <ellipse cx="227" cy="201" rx="20" ry="24" fill="none" stroke="#E0B8A4" stroke-width="1.5"/>
  <ellipse cx="227" cy="201" rx="13" ry="16" fill="#E8A890"/>
  <circle cx="227" cy="201" r="5" fill="#D89070"/>
  <!-- Right cup -->
  <ellipse cx="353" cy="201" rx="20" ry="24" fill="#F0D0C0"/>
  <ellipse cx="353" cy="201" rx="20" ry="24" fill="none" stroke="#E0B8A4" stroke-width="1.5"/>
  <ellipse cx="353" cy="201" rx="13" ry="16" fill="#E8A890"/>
  <circle cx="353" cy="201" r="5" fill="#D89070"/>

  <!-- FLOATING ELEMENTS -->

  <!-- Cameroon Flag -->
  <g class="fa" filter="url(#sh1)">
    <circle cx="148" cy="103" r="41" fill="white"/>
    <rect x="108" y="63" width="27" height="80" fill="#007A5E" clip-path="url(#fc)"/>
    <rect x="135" y="63" width="27" height="80" fill="#CE1126" clip-path="url(#fc)"/>
    <rect x="162" y="63" width="27" height="80" fill="#FCD116" clip-path="url(#fc)"/>
    <text x="148" y="109" text-anchor="middle" font-size="20" fill="#FCD116" font-family="Arial">&#9733;</text>
    <circle cx="148" cy="103" r="41" fill="none" stroke="white" stroke-width="5"/>
    <circle cx="148" cy="103" r="41" fill="none" stroke="rgba(58,175,169,.22)" stroke-width="2"/>
  </g>

  <!-- Chat bubble 1 (large, 3 lines) -->
  <g class="fb" filter="url(#sh2)">
    <rect x="380" y="100" width="106" height="68" rx="16" fill="#3AAFA9"/>
    <path d="M390 168 L378 186 L414 168 Z" fill="#3AAFA9"/>
    <rect x="396" y="118" width="74" height="6" rx="3" fill="rgba(255,255,255,0.9)"/>
    <rect x="396" y="131" width="62" height="5" rx="2.5" fill="rgba(255,255,255,0.7)"/>
    <rect x="396" y="143" width="50" height="5" rx="2.5" fill="rgba(255,255,255,0.55)"/>
  </g>

  <!-- Chat bubble 2 (dots) -->
  <g class="fa" style="animation-delay:.9s" filter="url(#sh2)">
    <rect x="375" y="202" width="88" height="52" rx="14" fill="#3AAFA9"/>
    <path d="M386 254 L374 272 L406 254 Z" fill="#3AAFA9"/>
    <circle cx="399" cy="228" r="6.5" fill="rgba(255,255,255,0.9)"/>
    <circle cx="419" cy="228" r="6.5" fill="rgba(255,255,255,0.9)"/>
    <circle cx="439" cy="228" r="6.5" fill="rgba(255,255,255,0.9)"/>
  </g>

  <!-- Check badge -->
  <g class="fc" filter="url(#sh1)">
    <circle cx="488" cy="138" r="27" fill="white"/>
    <circle cx="488" cy="138" r="27" fill="none" stroke="#E2F4F3" stroke-width="2"/>
    <path d="M476 138 L484 147 L500 128" stroke="#3AAFA9" stroke-width="4" fill="none" stroke-linecap="round" stroke-linejoin="round"/>
  </g>

  <!-- Decorative dots -->
  <circle cx="162" cy="60" r="6" fill="rgba(58,175,169,0.32)" class="fb"/>
  <circle cx="468" cy="80" r="5" fill="rgba(58,175,169,0.26)" class="fa"/>
  <circle cx="134" cy="200" r="4" fill="rgba(58,175,169,0.20)" class="fc"/>
  <circle cx="480" cy="300" r="4" fill="rgba(58,175,169,0.18)" class="fb"/>
</svg>
    </div>
  </section>

  <!-- SECTION PILLS -->
  <div class="sections-strip" id="sections">
    <a href="ChoixTest.aspx?section=Listening" class="section-pill"><i class="fa-solid fa-headphones"></i> Listening</a>
    <a href="ChoixTest.aspx?section=Structure" class="section-pill"><i class="fa-solid fa-pen-nib"></i> Structure</a>
    <a href="ChoixTest.aspx?section=Reading"   class="section-pill"><i class="fa-solid fa-book-open"></i> Reading</a>
    <a href="ChoixTest.aspx?section=FullTest"  class="section-pill"><i class="fa-solid fa-trophy"></i> Test Complet</a>
  </div>

  <!-- CARDS -->
  <div class="cards-section">
    <div class="card">
      <div class="card-icon-wrap"><i class="fa-solid fa-headphones-simple"></i></div>
      <div class="card-body">
        <div class="card-title">Compréhension Orale</div>
        <p class="card-desc">Entraînez-vous à comprendre le Yemba parlé à travers des exercices audio ciblés.</p>
        <a href="ChoixTest.aspx?section=Listening" class="card-link">Commencer <i class="fa-solid fa-arrow-right"></i></a>
      </div>
    </div>
    <div class="card">
      <div class="card-icon-wrap"><i class="fa-solid fa-book"></i></div>
      <div class="card-body">
        <div class="card-title">Grammaire &amp; Structure</div>
        <p class="card-desc">Maîtrisez la syntaxe et les règles grammaticales de la langue Yemba en profondeur.</p>
        <a href="ChoixTest.aspx?section=Structure" class="card-link">Commencer <i class="fa-solid fa-arrow-right"></i></a>
      </div>
    </div>
    <div class="card">
      <div class="card-icon-wrap"><i class="fa-solid fa-file-lines"></i></div>
      <div class="card-body">
        <div class="card-title">Lecture &amp; Vocabulaire</div>
        <p class="card-desc">Développez votre compréhension écrite et enrichissez votre vocabulaire Yemba.</p>
        <a href="ChoixTest.aspx?section=Reading" class="card-link">Commencer <i class="fa-solid fa-arrow-right"></i></a>
      </div>
    </div>
  </div>

  <!-- FOOTER -->
  <footer>
    <span class="footer-brand">TLC Yemba Online Test</span>
    <div class="footer-links">
      <a href="#"><i class="fa-solid fa-shield-halved"></i> Confidentialité</a>
      <a href="#"><i class="fa-solid fa-envelope"></i> Contact</a>
      <a href="#"><i class="fa-solid fa-circle-info"></i> À propos</a>
    </div>
    <div class="cam-colors">
      <div class="cam-dot" style="background:#007A5E;"></div>
      <div class="cam-dot" style="background:#CE1126;"></div>
      <div class="cam-dot" style="background:#FCD116;"></div>
      <span style="margin-left:7px;font-size:11.5px;font-weight:600;color:#718096;">Cameroun</span>
    </div>
  </footer>

</div>
</form>
<script>
  document.querySelectorAll('.nav-links a').forEach(function(l){
    if(l.href===window.location.href){l.style.color='var(--teal)';l.style.background='var(--teal-pale)';}
  });
</script>
</body>
</html>
