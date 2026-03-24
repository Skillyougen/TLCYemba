<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TLCYemba.Default" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="fr">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>TLC Yemba &#8212; Test de Langue du Cameroun</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800;900&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <style>
        :root {
            --teal:      #3AAFA9;
            --teal-dark: #2B8F8A;
            --teal-pale: #EAF8F7;
            --teal-mid:  #DEF2F1;
            --txt-dark:  #2D3748;
            --txt-mid:   #4A5568;
            --txt-soft:  #718096;
            --white:     #FFFFFF;
            --radius:    18px;
        }
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
        html{scroll-behavior:smooth}
        body{
            font-family:'Poppins',sans-serif;
            background:linear-gradient(145deg,#C8EDEA 0%,#EAF8F7 40%,#DEF5F3 70%,#B8E8E4 100%);
            min-height:100vh;color:var(--txt-dark);
        }
        .bg-wave{position:fixed;inset:0;z-index:0;pointer-events:none}
        .bg-wave svg{width:100%;height:100%}
        .page-wrapper{
            position:relative;z-index:1;
            max-width:1280px;margin:32px auto;
            background:rgba(255,255,255,.84);
            backdrop-filter:blur(20px);
            border-radius:32px;
            box-shadow:0 8px 64px rgba(58,175,169,.18);
            overflow:hidden;
        }
        /* NAVBAR */
        nav{
            display:flex;align-items:center;justify-content:space-between;
            padding:22px 52px;
            background:rgba(255,255,255,.97);
            border-bottom:1.5px solid rgba(58,175,169,.10);
        }
        .nav-logo{display:flex;align-items:center;gap:13px;text-decoration:none}
        .logo-icon{
            width:44px;height:44px;background:var(--teal);border-radius:50%;
            display:flex;align-items:center;justify-content:center;
            font-family:'Nunito',sans-serif;font-weight:900;font-size:19px;color:#fff;
            box-shadow:0 4px 14px rgba(58,175,169,.4);
        }
        .logo-text{font-family:'Nunito',sans-serif;font-weight:900;font-size:19px;color:var(--txt-dark)}
        .logo-text span{color:var(--teal)}
        .nav-links{display:flex;gap:4px;list-style:none}
        .nav-links a{
            display:flex;align-items:center;gap:7px;
            text-decoration:none;color:var(--txt-mid);
            font-size:14px;font-weight:500;
            padding:8px 16px;border-radius:50px;transition:all .2s;
        }
        .nav-links a i{font-size:13px;color:var(--txt-soft);transition:color .2s}
        .nav-links a:hover{color:var(--teal);background:var(--teal-pale)}
        .nav-links a:hover i{color:var(--teal)}
        .btn-signup{
            display:inline-flex;align-items:center;gap:8px;
            background:var(--teal);color:#fff;border:none;
            padding:11px 26px;border-radius:50px;
            font-size:14.5px;font-weight:600;cursor:pointer;
            font-family:'Poppins',sans-serif;
            transition:background .2s,transform .15s,box-shadow .2s;
            box-shadow:0 4px 16px rgba(58,175,169,.38);text-decoration:none;
        }
        .btn-signup:hover{background:var(--teal-dark);transform:translateY(-2px)}
        /* HERO */
        .hero{
            display:grid;grid-template-columns:1fr 1fr;
            align-items:center;padding:60px 52px 44px;gap:16px;
        }
        .hero-left{display:flex;flex-direction:column;gap:24px}
        .hero-badge{
            display:inline-flex;align-items:center;gap:8px;
            background:var(--teal-pale);border:1.5px solid rgba(58,175,169,.25);
            color:var(--teal-dark);padding:7px 18px;
            border-radius:50px;font-size:12.5px;font-weight:600;width:fit-content;
            animation:fadeUp .5s ease both;
        }
        .hero-badge i{font-size:11px;color:var(--teal)}
        .hero-title{
            font-family:'Nunito',sans-serif;
            font-size:clamp(2rem,3.4vw,2.85rem);
            font-weight:900;line-height:1.17;color:var(--txt-dark);
            animation:fadeUp .5s .1s ease both;
        }
        .hero-title span{color:var(--teal)}
        .hero-desc{
            font-size:14.5px;color:var(--txt-soft);
            line-height:1.78;max-width:420px;
            animation:fadeUp .5s .2s ease both;
        }
        .hero-buttons{display:flex;gap:14px;flex-wrap:wrap;animation:fadeUp .5s .3s ease both}
        .btn-primary{
            display:inline-flex;align-items:center;gap:9px;
            background:var(--teal);color:#fff;border:none;
            padding:15px 34px;border-radius:50px;
            font-size:15px;font-weight:700;cursor:pointer;
            font-family:'Poppins',sans-serif;
            transition:background .2s,transform .15s,box-shadow .2s;
            box-shadow:0 6px 22px rgba(58,175,169,.38);text-decoration:none;
        }
        .btn-primary:hover{background:var(--teal-dark);transform:translateY(-3px)}
        .btn-secondary{
            display:inline-flex;align-items:center;gap:9px;
            background:transparent;color:var(--teal);border:2px solid var(--teal);
            padding:13px 28px;border-radius:50px;
            font-size:15px;font-weight:600;cursor:pointer;
            font-family:'Poppins',sans-serif;transition:all .2s;text-decoration:none;
        }
        .btn-secondary:hover{background:var(--teal);color:#fff;transform:translateY(-3px)}
        .hero-stats{display:flex;gap:32px;animation:fadeUp .5s .4s ease both}
        .stat-item{display:flex;flex-direction:column;gap:2px}
        .stat-num{font-family:'Nunito',sans-serif;font-weight:900;font-size:24px;color:var(--teal)}
        .stat-label{font-size:11.5px;color:var(--txt-soft);font-weight:500}
        /* HERO RIGHT */
        .hero-right{
            position:relative;display:flex;
            align-items:flex-end;justify-content:center;
            min-height:380px;animation:fadeUp .5s .15s ease both;
        }
        .hero-right svg.illo{
            width:100%;max-width:570px;height:auto;
            filter:drop-shadow(0 12px 32px rgba(58,175,169,.10));
        }
        /* SVG float animations - DIFFERENT names to avoid FA conflict */
        .svgfa{animation:svgFloatA 3.8s ease-in-out infinite}
        .svgfb{animation:svgFloatB 4.5s .7s ease-in-out infinite}
        .svgfc{animation:svgFloatC 3.2s 1.1s ease-in-out infinite}
        @keyframes svgFloatA{0%,100%{transform:translateY(0)}50%{transform:translateY(-10px)}}
        @keyframes svgFloatB{0%,100%{transform:translateY(0)}50%{transform:translateY(-8px)}}
        @keyframes svgFloatC{0%,100%{transform:translateY(0)}50%{transform:translateY(-13px)}}
        /* SECTION PILLS */
        .sections-strip{
            display:flex;justify-content:center;
            gap:10px;padding:0 52px 42px;flex-wrap:wrap;
            animation:fadeUp .5s .5s ease both;
        }
        .section-pill{
            display:flex;align-items:center;gap:9px;
            padding:10px 22px;border-radius:50px;
            border:1.5px solid rgba(58,175,169,.25);
            background:var(--teal-pale);
            font-size:13.5px;font-weight:600;color:var(--teal-dark);
            cursor:pointer;transition:all .2s;text-decoration:none;
        }
        .section-pill i{font-size:14px;color:var(--teal);transition:color .2s}
        .section-pill:hover{background:var(--teal);color:#fff;border-color:var(--teal);transform:translateY(-2px);box-shadow:0 4px 16px rgba(58,175,169,.3)}
        .section-pill:hover i{color:#fff}
        /* CARDS */
        .cards-section{
            display:grid;grid-template-columns:repeat(3,1fr);
            gap:20px;padding:0 52px 52px;
        }
        .card{
            background:var(--white);border-radius:var(--radius);
            padding:28px 24px;
            box-shadow:0 2px 20px rgba(0,0,0,.06);
            display:flex;flex-direction:row;align-items:flex-start;gap:18px;
            transition:transform .22s,box-shadow .22s;
            animation:fadeUp .5s .6s ease both;
        }
        .card:hover{transform:translateY(-7px);box-shadow:0 14px 40px rgba(58,175,169,.17)}
        .card-icon-wrap{
            flex-shrink:0;width:58px;height:58px;
            background:var(--teal);border-radius:16px;
            display:flex;align-items:center;justify-content:center;
            box-shadow:0 4px 16px rgba(58,175,169,.32);
            transition:transform .2s;
        }
        .card:hover .card-icon-wrap{transform:scale(1.1) rotate(-5deg)}
        .card-icon-wrap i{font-size:24px;color:#fff}
        .card-body{display:flex;flex-direction:column;gap:6px}
        .card-title{font-family:'Nunito',sans-serif;font-weight:800;font-size:16px;color:var(--txt-dark)}
        .card-desc{font-size:12.5px;color:var(--txt-soft);line-height:1.65}
        .card-link{
            font-size:12px;font-weight:600;color:var(--teal);
            text-decoration:none;margin-top:4px;
            display:inline-flex;align-items:center;gap:5px;transition:gap .2s;
        }
        .card-link:hover{gap:9px}
        /* FOOTER */
        footer{
            background:rgba(255,255,255,.7);
            border-top:1.5px solid rgba(58,175,169,.12);
            padding:22px 52px;
            display:flex;align-items:center;justify-content:space-between;
            font-size:12.5px;color:var(--txt-soft);
        }
        .footer-brand{font-family:'Nunito',sans-serif;font-weight:800;color:var(--teal);font-size:14px}
        .footer-links{display:flex;gap:20px}
        .footer-links a{
            display:flex;align-items:center;gap:6px;
            color:var(--txt-soft);text-decoration:none;font-size:12px;transition:color .2s;
        }
        .footer-links a:hover{color:var(--teal)}
        .cam-colors{display:flex;gap:5px;align-items:center}
        .cam-dot{width:11px;height:11px;border-radius:50%}
        /* PAGE ANIMATIONS */
        @keyframes fadeUp{
            from{opacity:0;transform:translateY(24px)}
            to{opacity:1;transform:translateY(0)}
        }
        @media(max-width:920px){
            .page-wrapper{margin:12px;border-radius:22px}
            nav{padding:18px 24px}
            .nav-links a span{display:none}
            .hero{grid-template-columns:1fr;padding:40px 24px 24px}
            .hero-right{display:none}
            .cards-section{grid-template-columns:1fr;padding:0 24px 36px}
            .sections-strip{padding:0 24px 30px}
            footer{flex-direction:column;gap:10px;text-align:center;padding:20px 24px}
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

<!-- ============ NAVBAR ============ -->
<nav>
  <a href="Default.aspx" class="nav-logo">
    <div class="logo-icon">T</div>
    <span class="logo-text">TLC <span>Yemba</span></span>
  </a>
  <ul class="nav-links">
    <li><a href="Default.aspx"><i class="fa-solid fa-house"></i><span>Accueil</span></a></li>
    <li><a href="#sections"><i class="fa-solid fa-layer-group"></i><span>Sections</span></a></li>
    <li><a href="#apropos"><i class="fa-solid fa-circle-info"></i><span>A propos</span></a></li>
    <li><a href="Historique.aspx"><i class="fa-solid fa-chart-bar"></i><span>Resultats</span></a></li>
  </ul>
  <a href="Inscription.aspx" class="btn-signup">
    <i class="fa-solid fa-user-plus"></i> S'inscrire
  </a>
</nav>

<!-- ============ HERO ============ -->
<section class="hero">
  <div class="hero-left">
    <div class="hero-badge">
      <i class="fa-solid fa-circle-check"></i>
      Plateforme officielle TLC &#8212; Yemba
    </div>
    <h1 class="hero-title">
      Apprenez &amp; Maitrisez<br/>
      <span>Le Yemba</span> en Ligne
    </h1>
    <p class="hero-desc">
      Testez et certifiez votre niveau en langue Yemba grace a notre
      plateforme de tests certifiants inspiree du TOEFL/TOEIC,
      concue pour valoriser les langues maternelles du Cameroun.
    </p>
    <div class="hero-buttons">
      <a href="ChoixTest.aspx" class="btn-primary">
        <i class="fa-solid fa-play"></i> Commencer un Test
      </a>
      <a href="Historique.aspx" class="btn-secondary">
        <i class="fa-solid fa-clock-rotate-left"></i> Mes Resultats
      </a>
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

  <!-- ============ SVG ILLUSTRATION ============ -->
  <div class="hero-right">
<svg class="illo" viewBox="0 0 570 460" fill="none" xmlns="http://www.w3.org/2000/svg">
<defs>
  <filter id="s1" x="-30%" y="-30%" width="160%" height="160%">
    <feDropShadow dx="0" dy="3" stdDeviation="5" flood-color="rgba(0,0,0,0.10)"/>
  </filter>
  <filter id="s2" x="-40%" y="-40%" width="180%" height="180%">
    <feDropShadow dx="0" dy="2" stdDeviation="3" flood-color="rgba(0,0,0,0.08)"/>
  </filter>
  <clipPath id="flagClip"><circle cx="152" cy="106" r="36"/></clipPath>
  <linearGradient id="skinGrad" x1="0" y1="0" x2="0" y2="1">
    <stop offset="0%" stop-color="#FCCFA8"/>
    <stop offset="100%" stop-color="#F0B48A"/>
  </linearGradient>
  <linearGradient id="blazerShade" x1="0" y1="0" x2="1" y2="0">
    <stop offset="0%" stop-color="#2B9990"/>
    <stop offset="40%" stop-color="#3AAFA9"/>
    <stop offset="100%" stop-color="#2E9D97"/>
  </linearGradient>
  <linearGradient id="hairShade" x1="0" y1="0" x2="1" y2="1">
    <stop offset="0%" stop-color="#1E2F1C"/>
    <stop offset="100%" stop-color="#131E11"/>
  </linearGradient>
</defs>

<!-- ===== BACKGROUND BLOB ===== -->
<path d="M158 148 C148 72 228 44 338 52 C448 60 508 102 520 192 C532 282 496 376 410 410 C324 444 214 430 170 374 C126 318 168 224 158 148Z" fill="#D8F0EE" opacity="0.92"/>
<path d="M172 164 C163 97 236 72 336 79 C436 86 492 124 502 202 C512 280 478 362 400 394 C322 426 224 412 182 362 C140 312 181 231 172 164Z" fill="#E6F8F6" opacity="0.65"/>

<!-- ===== DESK ===== -->
<rect x="96" y="393" width="414" height="16" rx="7" fill="#B0D8D5"/>
<rect x="96" y="393" width="414" height="6" rx="3" fill="#C4E6E3"/>

<!-- ===== LAPTOP ===== -->
<!-- Laptop base/keyboard -->
<rect x="188" y="382" width="210" height="13" rx="5" fill="#B8DCDA"/>
<rect x="196" y="382" width="194" height="5" rx="2" fill="#CAE8E6"/>
<!-- Laptop hinge line -->
<rect x="190" y="381" width="206" height="3" rx="1.5" fill="#A4CCCA"/>
<!-- Laptop screen outer -->
<rect x="192" y="254" width="202" height="130" rx="10" fill="#CCE8E4" stroke="#A8CCCA" stroke-width="2"/>
<!-- Laptop screen inner display -->
<rect x="202" y="263" width="182" height="112" rx="6" fill="#E2F4F2"/>
<!-- Screen content lines -->
<rect x="218" y="278" width="88" height="8" rx="4" fill="rgba(58,175,169,.50)"/>
<rect x="218" y="293" width="144" height="5" rx="2.5" fill="rgba(58,175,169,.30)"/>
<rect x="218" y="305" width="122" height="5" rx="2.5" fill="rgba(58,175,169,.22)"/>
<rect x="218" y="317" width="100" height="5" rx="2.5" fill="rgba(58,175,169,.16)"/>
<rect x="218" y="329" width="78" height="5" rx="2.5" fill="rgba(58,175,169,.12)"/>
<!-- Screen label -->
<text x="293" y="356" text-anchor="middle" font-family="Nunito,Arial" font-size="10.5" font-weight="900" fill="#2B9990" opacity="0.85">TLC Yemba</text>
<!-- Laptop camera dot -->
<circle cx="293" cy="267" r="2" fill="#9ABFBC"/>

<!-- ===== COFFEE CUP ===== -->
<g class="svgfc">
  <path d="M432 358 L434 386 L456 386 L458 358 Z" fill="#9CC8C4"/>
  <rect x="430" y="352" width="30" height="9" rx="4.5" fill="#B0D8D4"/>
  <path d="M460 362 C470 362 474 367 474 372 C474 377 470 380 460 380" stroke="#9CC8C4" stroke-width="3.5" fill="none" stroke-linecap="round"/>
  <ellipse cx="444" cy="387" rx="12" ry="3" fill="rgba(0,0,0,.07)"/>
  <!-- Steam -->
  <path d="M439 350 C441 344 438 338 440 332" stroke="#C4E6E4" stroke-width="2" fill="none" stroke-linecap="round" opacity="0.7"/>
  <path d="M447 349 C449 342 446 336 448 330" stroke="#C4E6E4" stroke-width="2" fill="none" stroke-linecap="round" opacity="0.7"/>
</g>

<!-- ===== PLANT ===== -->
<g>
  <!-- Pot -->
  <path d="M515 396 L509 368 L529 368 Z" fill="#8FBAB6"/>
  <rect x="505" y="392" width="34" height="9" rx="4" fill="#7EAAA6"/>
  <rect x="505" y="392" width="34" height="4" rx="2" fill="#8FBAB6"/>
  <!-- Soil -->
  <ellipse cx="517" cy="368" rx="10" ry="3" fill="#7EAAA6"/>
  <!-- Stems -->
  <path d="M517 368 C514 352 506 332 500 308" stroke="#5BA898" stroke-width="3.5" fill="none" stroke-linecap="round"/>
  <path d="M517 368 C517 348 516 322 514 296" stroke="#5BA898" stroke-width="3.5" fill="none" stroke-linecap="round"/>
  <path d="M517 368 C521 350 528 328 534 302" stroke="#5BA898" stroke-width="3.5" fill="none" stroke-linecap="round"/>
  <!-- Leaves -->
  <ellipse cx="498" cy="305" rx="18" ry="10" fill="#47A090" transform="rotate(-40 498 305)"/>
  <ellipse cx="498" cy="305" rx="10" ry="5" fill="#5AB8A8" transform="rotate(-40 498 305)" opacity="0.5"/>
  <ellipse cx="514" cy="292" rx="18" ry="10" fill="#52B09F"/>
  <ellipse cx="514" cy="292" rx="10" ry="5" fill="#66C4B4" opacity="0.5"/>
  <ellipse cx="535" cy="299" rx="18" ry="10" fill="#47A090" transform="rotate(35 535 299)"/>
  <ellipse cx="535" cy="299" rx="10" ry="5" fill="#5AB8A8" transform="rotate(35 535 299)" opacity="0.5"/>
</g>

<!-- ===== LEFT ARM (before body so body covers shoulder) ===== -->
<path d="M248 304 C232 328 218 356 212 384" stroke="#3AAFA9" stroke-width="30" fill="none" stroke-linecap="round"/>
<path d="M246 308 C230 332 217 358 214 382" stroke="#44BCBC" stroke-width="10" fill="none" stroke-linecap="round" opacity="0.22"/>
<!-- Left hand -->
<ellipse cx="213" cy="384" rx="15" ry="10" fill="#FCCFA8"/>
<!-- Finger hints -->
<path d="M204 380 C202 376 206 372 210 376" stroke="#F0B48A" stroke-width="2" fill="none" stroke-linecap="round"/>
<path d="M220 379 C222 375 218 371 214 375" stroke="#F0B48A" stroke-width="2" fill="none" stroke-linecap="round"/>

<!-- ===== RIGHT ARM ===== -->
<path d="M348 304 C362 328 374 356 378 384" stroke="#3AAFA9" stroke-width="30" fill="none" stroke-linecap="round"/>
<path d="M350 308 C364 332 375 358 376 382" stroke="#44BCBC" stroke-width="10" fill="none" stroke-linecap="round" opacity="0.22"/>
<!-- Right hand -->
<ellipse cx="377" cy="384" rx="15" ry="10" fill="#FCCFA8"/>
<path d="M368 380 C366 376 370 372 374 376" stroke="#F0B48A" stroke-width="2" fill="none" stroke-linecap="round"/>
<path d="M384 379 C386 375 382 371 378 375" stroke="#F0B48A" stroke-width="2" fill="none" stroke-linecap="round"/>

<!-- ===== TORSO / BLAZER ===== -->
<path d="M196 398 C196 300 222 278 232 270 C252 256 272 250 298 248 C324 250 344 256 364 270 C374 278 400 300 400 398 Z" fill="url(#blazerShade)"/>
<!-- Blazer side shadow left -->
<path d="M196 370 C196 310 216 282 234 272 L220 280 C210 296 202 330 202 398 Z" fill="rgba(0,0,0,.07)"/>
<!-- Blazer side shadow right -->
<path d="M400 370 C400 310 380 282 362 272 L376 280 C386 296 394 330 394 398 Z" fill="rgba(0,0,0,.07)"/>

<!-- White shirt / inner collar -->
<path d="M260 266 L298 310 L336 266 L330 326 C314 352 282 352 266 326 Z" fill="white"/>
<path d="M272 278 L298 310 L324 278 L320 324 C310 344 286 344 276 324 Z" fill="#F0FAFA" opacity="0.6"/>

<!-- Blazer left lapel -->
<path d="M228 274 C240 260 256 258 262 266 L254 314 C238 302 222 308 218 312 Z" fill="#2B9490"/>
<path d="M230 280 C240 270 254 266 258 272" stroke="rgba(255,255,255,.18)" stroke-width="1.5" fill="none" stroke-linecap="round"/>
<!-- Blazer right lapel -->
<path d="M368 274 C356 260 340 258 334 266 L342 314 C358 302 374 308 378 312 Z" fill="#2B9490"/>
<path d="M366 280 C356 270 342 266 338 272" stroke="rgba(255,255,255,.18)" stroke-width="1.5" fill="none" stroke-linecap="round"/>

<!-- Blazer button -->
<circle cx="298" cy="340" r="3.5" fill="#248A84"/>
<circle cx="298" cy="340" r="2" fill="#1E7A74"/>

<!-- ===== NECK ===== -->
<rect x="277" y="236" width="42" height="36" rx="18" fill="#FCCFA8"/>
<rect x="283" y="236" width="30" height="10" rx="5" fill="#F8C4A0" opacity="0.4"/>

<!-- ===== HAIR BACK LAYER (behind face) ===== -->
<!-- Main hair mass behind and around head -->
<path d="M222 178 C218 112 240 84 298 80 C356 80 378 112 374 178 C378 232 378 286 378 300 C354 268 298 260 242 268 C242 256 222 232 222 178 Z" fill="url(#hairShade)"/>
<!-- Left side hair flow (falls to the left, our right in image) -->
<path d="M222 180 C204 196 198 224 200 262 C202 300 216 326 232 342 C222 312 214 280 216 250 C218 220 222 196 224 180 Z" fill="#131E11"/>
<!-- Right side hair (shorter, stays close to face) -->
<path d="M374 180 C386 196 390 220 386 256 C382 292 368 316 354 328 C368 304 376 276 374 248 C372 218 370 196 372 180 Z" fill="#1A2818"/>
<!-- Hair flowing down to right shoulder (the long flowing part visible in the reference) -->
<path d="M222 180 C196 200 178 240 176 288 C174 330 186 364 200 384 C196 358 192 324 196 292 C200 260 210 228 222 204 Z" fill="#131E11"/>
<path d="M222 182 C200 208 188 244 190 284 C192 320 206 356 218 380 C208 350 202 316 204 284 C206 252 216 218 226 194 Z" fill="#1E2F1C" opacity="0.7"/>
<!-- Extra volume on top -->
<path d="M236 96 C250 82 270 76 298 76 C326 76 346 82 360 96 C372 108 378 126 376 146 C368 124 350 108 298 104 C246 108 228 124 220 146 C218 126 224 108 236 96 Z" fill="#1E2F1C"/>
<!-- Hair highlights (subtle sheen) -->
<path d="M250 90 C270 80 310 80 330 90" stroke="#2A3E28" stroke-width="6" fill="none" stroke-linecap="round" opacity="0.6"/>

<!-- ===== FACE ===== -->
<ellipse cx="298" cy="180" rx="60" ry="65" fill="url(#skinGrad)"/>
<!-- Cheek shading -->
<ellipse cx="298" cy="196" rx="52" ry="56" fill="#F0B48A" opacity="0.15"/>

<!-- Ears -->
<ellipse cx="237" cy="188" rx="10" ry="14" fill="#F0B48A"/>
<ellipse cx="240" cy="188" rx="6" ry="9" fill="#E8A880" opacity="0.6"/>
<ellipse cx="359" cy="188" rx="10" ry="14" fill="#F0B48A"/>
<ellipse cx="356" cy="188" rx="6" ry="9" fill="#E8A880" opacity="0.6"/>

<!-- ===== EYEBROWS ===== -->
<path d="M263 162 C270 156 280 155 291 158" stroke="#3A2010" stroke-width="3.5" fill="none" stroke-linecap="round"/>
<path d="M305 158 C316 155 326 156 333 162" stroke="#3A2010" stroke-width="3.5" fill="none" stroke-linecap="round"/>

<!-- ===== EYES ===== -->
<!-- Left eye white -->
<ellipse cx="278" cy="176" rx="12" ry="11" fill="white"/>
<!-- Left iris -->
<ellipse cx="279" cy="177" rx="8" ry="8.5" fill="#2A1808"/>
<!-- Left iris color ring -->
<ellipse cx="279" cy="177" rx="8" ry="8.5" fill="none" stroke="#3D2010" stroke-width="1.5"/>
<!-- Left pupil -->
<circle cx="280" cy="177" r="5" fill="#1A0C04"/>
<!-- Left eye highlight -->
<circle cx="283" cy="173" r="3" fill="white"/>
<circle cx="276" cy="175" r="1.5" fill="rgba(255,255,255,.7)"/>
<!-- Left upper eyelid -->
<path d="M266 171 C272 167 284 167 290 171" stroke="#2A1808" stroke-width="2" fill="none" stroke-linecap="round"/>
<!-- Left lower eyelid subtle -->
<path d="M268 183 C274 187 284 187 288 183" stroke="#D4956A" stroke-width="1.2" fill="none" stroke-linecap="round" opacity="0.6"/>
<!-- Left eyelashes (top) -->
<line x1="267" y1="171" x2="264" y2="165" stroke="#1A0C04" stroke-width="1.8" stroke-linecap="round"/>
<line x1="272" y1="168" x2="271" y2="162" stroke="#1A0C04" stroke-width="1.8" stroke-linecap="round"/>
<line x1="278" y1="167" x2="278" y2="161" stroke="#1A0C04" stroke-width="1.8" stroke-linecap="round"/>
<line x1="284" y1="168" x2="285" y2="162" stroke="#1A0C04" stroke-width="1.8" stroke-linecap="round"/>
<line x1="289" y1="171" x2="291" y2="166" stroke="#1A0C04" stroke-width="1.8" stroke-linecap="round"/>

<!-- Right eye white -->
<ellipse cx="318" cy="176" rx="12" ry="11" fill="white"/>
<!-- Right iris -->
<ellipse cx="317" cy="177" rx="8" ry="8.5" fill="#2A1808"/>
<ellipse cx="317" cy="177" rx="8" ry="8.5" fill="none" stroke="#3D2010" stroke-width="1.5"/>
<circle cx="316" cy="177" r="5" fill="#1A0C04"/>
<!-- Right highlight -->
<circle cx="321" cy="173" r="3" fill="white"/>
<circle cx="314" cy="175" r="1.5" fill="rgba(255,255,255,.7)"/>
<!-- Right eyelid -->
<path d="M306 171 C312 167 324 167 330 171" stroke="#2A1808" stroke-width="2" fill="none" stroke-linecap="round"/>
<path d="M308 183 C314 187 324 187 328 183" stroke="#D4956A" stroke-width="1.2" fill="none" stroke-linecap="round" opacity="0.6"/>
<!-- Right lashes -->
<line x1="307" y1="171" x2="304" y2="165" stroke="#1A0C04" stroke-width="1.8" stroke-linecap="round"/>
<line x1="312" y1="168" x2="311" y2="162" stroke="#1A0C04" stroke-width="1.8" stroke-linecap="round"/>
<line x1="318" y1="167" x2="318" y2="161" stroke="#1A0C04" stroke-width="1.8" stroke-linecap="round"/>
<line x1="324" y1="168" x2="325" y2="162" stroke="#1A0C04" stroke-width="1.8" stroke-linecap="round"/>
<line x1="329" y1="171" x2="331" y2="166" stroke="#1A0C04" stroke-width="1.8" stroke-linecap="round"/>

<!-- ===== NOSE ===== -->
<path d="M291 197 C288 204 284 208 282 208 C280 208 279 207 281 209" stroke="#D4956A" stroke-width="2.2" fill="none" stroke-linecap="round"/>
<path d="M305 197 C308 204 312 208 314 208 C316 208 317 207 315 209" stroke="#D4956A" stroke-width="2.2" fill="none" stroke-linecap="round"/>
<path d="M284 207 C290 212 306 212 312 207" stroke="#D4956A" stroke-width="1.8" fill="none" stroke-linecap="round" opacity="0.7"/>
<!-- Nose tip highlight -->
<ellipse cx="298" cy="207" rx="5" ry="3" fill="rgba(252,207,168,.4)"/>

<!-- ===== SMILE / MOUTH ===== -->
<!-- Upper lip -->
<path d="M278 222 C284 219 291 218 298 219 C305 218 312 219 318 222 C312 226 304 228 298 227 C292 228 284 226 278 222 Z" fill="#C87855"/>
<!-- Lower lip -->
<path d="M278 222 C284 228 292 232 298 232 C304 232 312 228 318 222 C312 226 304 229 298 228 C292 229 284 226 278 222 Z" fill="#D98868"/>
<!-- Teeth hint -->
<path d="M282 223 C288 226 308 226 314 223" fill="white" opacity="0.6"/>
<!-- Smile arc -->
<path d="M276 221 C284 230 312 230 320 221" stroke="#B86848" stroke-width="1.5" fill="none" stroke-linecap="round" opacity="0.5"/>
<!-- Dimples -->
<circle cx="272" cy="219" r="3.5" fill="rgba(216,136,104,.30)"/>
<circle cx="324" cy="219" r="3.5" fill="rgba(216,136,104,.30)"/>

<!-- ===== BLUSH ===== -->
<ellipse cx="254" cy="204" rx="16" ry="9" fill="rgba(240,130,100,.16)"/>
<ellipse cx="342" cy="204" rx="16" ry="9" fill="rgba(240,130,100,.16)"/>

<!-- ===== HEADPHONES ===== -->
<!-- Headband arc - white, goes over top of hair -->
<path d="M234 186 C236 116 262 100 298 99 C334 100 360 116 362 186" stroke="#F4F4F4" stroke-width="13" fill="none" stroke-linecap="round"/>
<!-- Headband top highlight -->
<path d="M237 183 C239 120 264 105 298 104 C332 105 357 120 359 183" stroke="rgba(255,255,255,.8)" stroke-width="5" fill="none" stroke-linecap="round"/>
<!-- Headband shadow -->
<path d="M235 188 C237 118 263 101 298 100 C333 101 359 118 361 188" stroke="rgba(200,200,200,.3)" stroke-width="4" fill="none" stroke-linecap="round"/>

<!-- Left ear cup outer shell -->
<ellipse cx="232" cy="192" rx="22" ry="26" fill="#F2F2F2"/>
<ellipse cx="232" cy="192" rx="22" ry="26" fill="none" stroke="#E0E0E0" stroke-width="1.5"/>
<!-- Left ear cup cushion ring -->
<ellipse cx="232" cy="192" rx="17" ry="20" fill="#E8E8E8"/>
<!-- Left ear cup inner (salmon/pink cushion) -->
<ellipse cx="232" cy="192" rx="13" ry="15" fill="#EDAA90"/>
<!-- Left ear cup center button -->
<circle cx="232" cy="192" r="5" fill="#E09478"/>
<circle cx="230" cy="190" r="2" fill="rgba(255,255,255,.4)"/>

<!-- Right ear cup outer shell -->
<ellipse cx="364" cy="192" rx="22" ry="26" fill="#F2F2F2"/>
<ellipse cx="364" cy="192" rx="22" ry="26" fill="none" stroke="#E0E0E0" stroke-width="1.5"/>
<!-- Right ear cup cushion ring -->
<ellipse cx="364" cy="192" rx="17" ry="20" fill="#E8E8E8"/>
<!-- Right ear cup inner -->
<ellipse cx="364" cy="192" rx="13" ry="15" fill="#EDAA90"/>
<circle cx="364" cy="192" r="5" fill="#E09478"/>
<circle cx="362" cy="190" r="2" fill="rgba(255,255,255,.4)"/>

<!-- ===== FLOATING ELEMENTS ===== -->

<!-- CAMEROON FLAG (circular) -->
<g class="svgfa" filter="url(#s1)">
  <circle cx="152" cy="106" r="44" fill="white"/>
  <circle cx="152" cy="106" r="44" fill="none" stroke="white" stroke-width="5"/>
  <!-- Flag stripes clipped to circle -->
  <rect x="112" y="68" width="27" height="76" fill="#007A5E" clip-path="url(#flagClip)"/>
  <rect x="139" y="68" width="27" height="76" fill="#CE1126" clip-path="url(#flagClip)"/>
  <rect x="166" y="68" width="27" height="76" fill="#FCD116" clip-path="url(#flagClip)"/>
  <!-- Star -->
  <text x="152" y="112" text-anchor="middle" font-size="18" fill="#FCD116" font-family="Arial">&#9733;</text>
  <!-- Outer ring shadow -->
  <circle cx="152" cy="106" r="44" fill="none" stroke="rgba(58,175,169,.20)" stroke-width="2.5"/>
</g>

<!-- CHAT BUBBLE 1 (large, with text lines) -->
<g class="svgfb" filter="url(#s2)">
  <!-- Bubble body -->
  <rect x="384" y="96" width="112" height="74" rx="18" fill="#3AAFA9"/>
  <!-- Bottom left tail -->
  <path d="M396 170 L380 192 L420 170 Z" fill="#3AAFA9"/>
  <!-- Text lines inside -->
  <rect x="400" y="115" width="80" height="7" rx="3.5" fill="rgba(255,255,255,.92)"/>
  <rect x="400" y="129" width="66" height="6" rx="3" fill="rgba(255,255,255,.72)"/>
  <rect x="400" y="142" width="52" height="6" rx="3" fill="rgba(255,255,255,.55)"/>
</g>

<!-- CHAT BUBBLE 2 (smaller, three dots) -->
<g class="svgfa" style="animation-delay:.95s" filter="url(#s2)">
  <rect x="378" y="208" width="94" height="56" rx="16" fill="#3AAFA9"/>
  <path d="M390 264 L374 284 L414 264 Z" fill="#3AAFA9"/>
  <!-- Three dots -->
  <circle cx="403" cy="236" r="7" fill="rgba(255,255,255,.92)"/>
  <circle cx="425" cy="236" r="7" fill="rgba(255,255,255,.92)"/>
  <circle cx="447" cy="236" r="7" fill="rgba(255,255,255,.92)"/>
</g>

<!-- CHECK BADGE -->
<g class="svgfc" filter="url(#s1)">
  <circle cx="492" cy="136" r="28" fill="white"/>
  <circle cx="492" cy="136" r="28" fill="none" stroke="#E0F4F2" stroke-width="2"/>
  <!-- Check mark tick -->
  <path d="M480 136 L489 146 L505 122" stroke="#3AAFA9" stroke-width="4.5" fill="none" stroke-linecap="round" stroke-linejoin="round"/>
</g>

<!-- Decorative background dots -->
<circle cx="165" cy="60" r="7" fill="rgba(58,175,169,.28)" class="svgfb"/>
<circle cx="472" cy="76" r="5.5" fill="rgba(58,175,169,.22)" class="svgfa"/>
<circle cx="136" cy="208" r="4.5" fill="rgba(58,175,169,.18)" class="svgfc"/>
<circle cx="484" cy="310" r="4" fill="rgba(58,175,169,.16)" class="svgfb"/>
<circle cx="106" cy="148" r="5" fill="rgba(58,175,169,.14)" class="svgfa"/>
</svg>
  </div>
</section>

<!-- ============ SECTIONS PILLS ============ -->
<div class="sections-strip" id="sections">
  <a href="ChoixTest.aspx?section=Listening" class="section-pill">
    <i class="fa-solid fa-headphones"></i> Listening
  </a>
  <a href="ChoixTest.aspx?section=Structure" class="section-pill">
    <i class="fa-solid fa-pen-nib"></i> Structure
  </a>
  <a href="ChoixTest.aspx?section=Reading" class="section-pill">
    <i class="fa-solid fa-book-open"></i> Reading
  </a>
  <a href="ChoixTest.aspx?section=FullTest" class="section-pill">
    <i class="fa-solid fa-trophy"></i> Test Complet
  </a>
</div>

<!-- ============ FEATURE CARDS ============ -->
<div class="cards-section">
  <div class="card">
    <div class="card-icon-wrap"><i class="fa-solid fa-headphones-simple"></i></div>
    <div class="card-body">
      <div class="card-title">Comprehension Orale</div>
      <p class="card-desc">Entrainez-vous a comprendre le Yemba parle a travers des exercices audio cibles et progressifs.</p>
      <a href="ChoixTest.aspx?section=Listening" class="card-link">Commencer <i class="fa-solid fa-arrow-right"></i></a>
    </div>
  </div>
  <div class="card">
    <div class="card-icon-wrap"><i class="fa-solid fa-book"></i></div>
    <div class="card-body">
      <div class="card-title">Grammaire &amp; Structure</div>
      <p class="card-desc">Maitrisez la syntaxe et les regles grammaticales de la langue Yemba en profondeur.</p>
      <a href="ChoixTest.aspx?section=Structure" class="card-link">Commencer <i class="fa-solid fa-arrow-right"></i></a>
    </div>
  </div>
  <div class="card">
    <div class="card-icon-wrap"><i class="fa-solid fa-file-lines"></i></div>
    <div class="card-body">
      <div class="card-title">Lecture &amp; Vocabulaire</div>
      <p class="card-desc">Developpez votre comprehension ecrite et enrichissez votre vocabulaire Yemba.</p>
      <a href="ChoixTest.aspx?section=Reading" class="card-link">Commencer <i class="fa-solid fa-arrow-right"></i></a>
    </div>
  </div>
</div>

<!-- ============ FOOTER ============ -->
<footer>
  <span class="footer-brand">TLC Yemba Online Test</span>
  <div class="footer-links">
    <a href="#"><i class="fa-solid fa-shield-halved"></i> Confidentialite</a>
    <a href="#"><i class="fa-solid fa-envelope"></i> Contact</a>
    <a href="#"><i class="fa-solid fa-circle-info"></i> A propos</a>
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
    document.querySelectorAll('.nav-links a').forEach(function (l) {
        if (l.href === window.location.href) {
            l.style.color = 'var(--teal)'; l.style.background = 'var(--teal-pale)';
        }
    });
</script>
</body>
</html>