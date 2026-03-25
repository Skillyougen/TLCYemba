<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChoixTest.aspx.cs" Inherits="TLCYemba.ChoixTest" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="fr">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Choisir un Test &#8212; TLC Yemba</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800;900&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <style>
        :root{--teal:#3AAFA9;--teal-dark:#2B8F8A;--teal-pale:#EAF8F7;--teal-mid:#DEF2F1;
            --txt-dark:#2D3748;--txt-mid:#4A5568;--txt-soft:#718096;--white:#FFFFFF;--radius:20px;}
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
        html{scroll-behavior:smooth}
        body{font-family:'Poppins',sans-serif;
            background:linear-gradient(145deg,#C8EDEA 0%,#EAF8F7 40%,#DEF5F3 70%,#B8E8E4 100%);
            min-height:100vh;color:var(--txt-dark);}
        .bg-wave{position:fixed;inset:0;z-index:0;pointer-events:none}
        .bg-wave svg{width:100%;height:100%}
        .page-wrapper{position:relative;z-index:1;max-width:1280px;margin:32px auto;
            background:rgba(255,255,255,.84);backdrop-filter:blur(18px);border-radius:32px;
            box-shadow:0 8px 64px rgba(58,175,169,.18);overflow:hidden;}
        /* NAVBAR */
        nav{display:flex;align-items:center;justify-content:space-between;padding:22px 52px;
            background:rgba(255,255,255,.97);border-bottom:1.5px solid rgba(58,175,169,.10);}
        .nav-logo{display:flex;align-items:center;gap:13px;text-decoration:none}
        .logo-icon{width:44px;height:44px;background:var(--teal);border-radius:50%;
            display:flex;align-items:center;justify-content:center;
            font-family:'Nunito',sans-serif;font-weight:900;font-size:19px;color:#fff;
            box-shadow:0 4px 14px rgba(58,175,169,.4);}
        .logo-text{font-family:'Nunito',sans-serif;font-weight:900;font-size:19px;color:var(--txt-dark)}
        .logo-text span{color:var(--teal)}
        .nav-links{display:flex;gap:4px;list-style:none}
        .nav-links a{display:flex;align-items:center;gap:7px;text-decoration:none;
            color:var(--txt-mid);font-size:14px;font-weight:500;
            padding:8px 16px;border-radius:50px;transition:all .2s;}
        .nav-links a i{font-size:13px;color:var(--txt-soft);transition:color .2s}
        .nav-links a:hover,.nav-links a.active{color:var(--teal);background:var(--teal-pale)}
        .nav-links a:hover i,.nav-links a.active i{color:var(--teal)}
        .btn-signup{display:inline-flex;align-items:center;gap:8px;background:var(--teal);
            color:#fff;border:none;padding:11px 26px;border-radius:50px;font-size:14.5px;
            font-weight:600;cursor:pointer;font-family:'Poppins',sans-serif;
            transition:background .2s,transform .15s,box-shadow .2s;
            box-shadow:0 4px 16px rgba(58,175,169,.38);text-decoration:none;}
        .btn-signup:hover{background:var(--teal-dark);transform:translateY(-2px)}
        /* BREADCRUMB */
        .breadcrumb{padding:18px 52px 0;font-size:12.5px;color:var(--txt-soft);
            display:flex;align-items:center;gap:8px;}
        .breadcrumb a{color:var(--teal);text-decoration:none;font-weight:500;}
        .breadcrumb a:hover{text-decoration:underline}
        /* PAGE HEADER */
        .page-header{padding:36px 52px 24px;text-align:center;animation:fadeUp .45s ease both;}
        .page-header-badge{display:inline-flex;align-items:center;gap:8px;
            background:var(--teal-pale);border:1.5px solid rgba(58,175,169,.25);
            color:var(--teal-dark);padding:7px 18px;border-radius:50px;
            font-size:12.5px;font-weight:600;margin-bottom:16px;}
        .page-header-badge i{font-size:12px;color:var(--teal)}
        .page-header h1{font-family:'Nunito',sans-serif;font-size:clamp(1.7rem,3vw,2.4rem);
            font-weight:900;color:var(--txt-dark);margin-bottom:10px;}
        .page-header h1 span{color:var(--teal)}
        .page-header p{font-size:14.5px;color:var(--txt-soft);max-width:520px;
            margin:0 auto;line-height:1.7;}
        /* ERROR */
        .error-msg{display:none;background:#FFF5F5;border:1.5px solid #FEB2B2;color:#C53030;
            padding:12px 24px;border-radius:12px;font-size:13.5px;font-weight:500;
            margin:0 52px 16px;text-align:center;animation:shake .35s ease;}
        .error-msg.visible{display:block}
        @keyframes shake{0%,100%{transform:translateX(0)}25%{transform:translateX(-6px)}75%{transform:translateX(6px)}}
        .server-error{color:#C53030;font-size:13px;font-weight:500;text-align:center;
            margin:0 52px 12px;display:block;}
        /* CARDS GRID */
        .cards-grid{display:grid;grid-template-columns:repeat(2,1fr);gap:22px;padding:0 52px 20px;}
        .test-card{position:relative;background:var(--white);border-radius:var(--radius);
            padding:34px 28px;box-shadow:0 2px 20px rgba(0,0,0,.06);cursor:pointer;
            border:2.5px solid transparent;transition:border-color .22s,transform .22s,box-shadow .22s;
            display:flex;flex-direction:column;gap:16px;
            animation:fadeUp .5s ease both;user-select:none;}
        .test-card:nth-child(1){animation-delay:.08s}
        .test-card:nth-child(2){animation-delay:.16s}
        .test-card:nth-child(3){animation-delay:.24s}
        .test-card:nth-child(4){animation-delay:.32s}
        .test-card:hover{border-color:var(--teal);transform:translateY(-5px);
            box-shadow:0 12px 36px rgba(58,175,169,.18);}
        .test-card.selected{border-color:var(--teal);
            background:linear-gradient(135deg,rgba(58,175,169,.05) 0%,#fff 100%);
            box-shadow:0 8px 32px rgba(58,175,169,.20);}
        .test-card input[type="radio"]{position:absolute;opacity:0;width:0;height:0}
        /* Check circle */
        .card-check{position:absolute;top:18px;right:18px;width:28px;height:28px;
            border-radius:50%;border:2px solid #CBD5E0;background:white;
            display:flex;align-items:center;justify-content:center;transition:all .2s;}
        .test-card.selected .card-check{background:var(--teal);border-color:var(--teal)}
        .card-check i{font-size:13px;color:white;opacity:0;transition:opacity .2s}
        .test-card.selected .card-check i{opacity:1}
        /* Card icon */
        .card-icon{width:70px;height:70px;border-radius:18px;
            display:flex;align-items:center;justify-content:center;
            flex-shrink:0;transition:transform .2s;}
        .test-card:hover .card-icon{transform:scale(1.08)}
        .card-icon i{font-size:30px}
        .icon-listening{background:rgba(58,175,169,.12)} .icon-listening i{color:#3AAFA9}
        .icon-structure{background:rgba(99,179,237,.12)} .icon-structure i{color:#4299E1}
        .icon-reading{background:rgba(72,187,120,.12)}   .icon-reading i{color:#38A169}
        .icon-fulltest{background:rgba(237,137,54,.12)}  .icon-fulltest i{color:#DD6B20}
        /* Card content */
        .card-content{display:flex;flex-direction:column;gap:7px}
        .card-subtitle{font-size:11.5px;font-weight:700;color:var(--teal);
            letter-spacing:.5px;text-transform:uppercase}
        .card-title{font-family:'Nunito',sans-serif;font-weight:900;font-size:20px;color:var(--txt-dark)}
        .card-desc{font-size:13.5px;color:var(--txt-soft);line-height:1.65}
        /* Meta chips */
        .card-meta{display:flex;gap:8px;flex-wrap:wrap;margin-top:4px}
        .meta-chip{display:flex;align-items:center;gap:5px;background:var(--teal-pale);
            border:1px solid rgba(58,175,169,.2);color:var(--teal-dark);
            padding:4px 12px;border-radius:50px;font-size:11.5px;font-weight:600}
        .meta-chip i{font-size:10px;color:var(--teal)}
        .meta-chip.gold{background:rgba(237,137,54,.10);border-color:rgba(237,137,54,.28);color:#C05621}
        .meta-chip.gold i{color:#DD6B20}
        /* Full width card */
        .test-card.full-width{grid-column:1 / -1;flex-direction:row;align-items:center;gap:26px}
        .test-card.full-width .card-icon{width:80px;height:80px;font-size:34px}
        /* ACTION ZONE */
        .action-zone{padding:26px 52px 52px;display:flex;align-items:center;
            justify-content:space-between;gap:20px;flex-wrap:wrap;}
        .selection-info{display:flex;align-items:center;gap:14px;padding:14px 22px;
            background:var(--teal-pale);border:1.5px solid rgba(58,175,169,.25);
            border-radius:14px;min-width:280px;}
        .sel-icon-wrap{width:42px;height:42px;background:white;border-radius:12px;
            display:flex;align-items:center;justify-content:center;
            box-shadow:0 2px 8px rgba(58,175,169,.15);}
        .sel-icon-wrap i{font-size:18px;color:var(--teal)}
        .selection-text{display:flex;flex-direction:column;gap:2px}
        .sel-label{font-size:10.5px;color:var(--txt-soft);font-weight:700;
            text-transform:uppercase;letter-spacing:.4px}
        .sel-value{font-family:'Nunito',sans-serif;font-weight:800;font-size:16px;color:var(--teal-dark)}
        .sel-value.empty{color:#A0AEC0;font-weight:600;font-size:14px}
        /* Start button */
        .btn-start{display:inline-flex;align-items:center;gap:10px;background:var(--teal);
            color:white;border:none;padding:16px 44px;border-radius:50px;font-size:15.5px;
            font-weight:700;cursor:pointer;font-family:'Poppins',sans-serif;
            transition:background .2s,transform .15s,box-shadow .2s,opacity .2s;
            box-shadow:0 6px 22px rgba(58,175,169,.38);}
        .btn-start i{font-size:15px;transition:transform .2s}
        .btn-start:hover:not(:disabled){background:var(--teal-dark);transform:translateY(-3px);
            box-shadow:0 10px 30px rgba(58,175,169,.45);}
        .btn-start:hover:not(:disabled) i{transform:translateX(4px)}
        .btn-start:disabled{opacity:.45;cursor:not-allowed;box-shadow:none}
        /* FOOTER */
        footer{background:rgba(255,255,255,.7);border-top:1.5px solid rgba(58,175,169,.12);
            padding:22px 52px;display:flex;align-items:center;justify-content:space-between;
            font-size:12.5px;color:var(--txt-soft);}
        .footer-brand{font-family:'Nunito',sans-serif;font-weight:800;color:var(--teal);font-size:14px}
        .cam-colors{display:flex;gap:5px;align-items:center}
        .cam-dot{width:11px;height:11px;border-radius:50%}
        @keyframes fadeUp{from{opacity:0;transform:translateY(22px)}to{opacity:1;transform:translateY(0)}}
        @media(max-width:860px){
            .page-wrapper{margin:12px;border-radius:20px}
            nav{padding:18px 24px}
            .page-header,.breadcrumb,.error-msg{padding-left:24px;padding-right:24px}
            .cards-grid{grid-template-columns:1fr;padding:0 24px 16px}
            .test-card.full-width{flex-direction:column;align-items:flex-start}
            .action-zone{padding:20px 24px 36px;flex-direction:column;align-items:stretch}
            .selection-info{min-width:unset}
            .btn-start{justify-content:center}
            footer{flex-direction:column;gap:8px;text-align:center;padding:18px 24px}
        }
    </style>
</head>
<body>
<div class="bg-wave" aria-hidden="true">
    <svg viewBox="0 0 1440 900" preserveAspectRatio="xMidYMid slice" xmlns="http://www.w3.org/2000/svg">
        <ellipse cx="200" cy="700" rx="520" ry="360" fill="rgba(58,175,169,.13)"/>
        <ellipse cx="1300" cy="200" rx="400" ry="280" fill="rgba(58,175,169,.10)"/>
        <path d="M0 650 Q360 520 720 640 T1440 560 V900 H0Z" fill="rgba(58,175,169,.08)"/>
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
    <li><a href="ChoixTest.aspx" class="active"><i class="fa-solid fa-list-check"></i><span>Test</span></a></li>
    <li><a href="Historique.aspx"><i class="fa-solid fa-chart-bar"></i><span>Resultats</span></a></li>
  </ul>
  <a href="Inscription.aspx" class="btn-signup">
    <i class="fa-solid fa-user-plus"></i> S'inscrire
  </a>
</nav>

<!-- BREADCRUMB -->
<div class="breadcrumb">
  <a href="Default.aspx"><i class="fa-solid fa-house" style="font-size:11px;margin-right:4px"></i>Accueil</a>
  <span style="color:#A0AEC0">&#8250;</span>
  <span>Choisir un Test</span>
</div>

<!-- PAGE HEADER -->
<div class="page-header">
  <div class="page-header-badge">
    <i class="fa-solid fa-bullseye"></i> Etape 1 sur 2 &#8212; Selection du test
  </div>
  <h1>Quel test voulez-vous <span>passer ?</span></h1>
  <p>Choisissez le type de test adapte a vos objectifs. Chaque section evalue des competences specifiques en langue Yemba.</p>
</div>

<!-- SERVER-SIDE ERROR -->
<asp:Label ID="lblErreur" runat="server" CssClass="server-error" Visible="false" />

<!-- CLIENT-SIDE ERROR -->
<div class="error-msg" id="clientError">
  <i class="fa-solid fa-triangle-exclamation"></i>
  Veuillez selectionner un type de test avant de continuer.
</div>

<!-- CARDS GRID -->
<div class="cards-grid">

  <!-- LISTENING -->
  <label class="test-card" id="cardListening" for="rdListening">
    <input type="radio" id="rdListening" name="typeTest" value="Listening" runat="server"/>
    <div class="card-check"><i class="fa-solid fa-check"></i></div>
    <div class="card-icon icon-listening"><i class="fa-solid fa-headphones"></i></div>
    <div class="card-content">
      <div class="card-subtitle">Section 1</div>
      <div class="card-title">Listening</div>
      <div class="card-desc">Testez votre comprehension de la langue Yemba a l'oral grace a des questions basees sur des dialogues et discours.</div>
      <div class="card-meta">
        <span class="meta-chip"><i class="fa-solid fa-clock"></i> 30 min</span>
        <span class="meta-chip"><i class="fa-solid fa-list"></i> 50 questions</span>
        <span class="meta-chip"><i class="fa-solid fa-star-half-stroke"></i> 31&#8211;68</span>
      </div>
    </div>
  </label>

  <!-- STRUCTURE -->
  <label class="test-card" id="cardStructure" for="rdStructure">
    <input type="radio" id="rdStructure" name="typeTest" value="Structure" runat="server"/>
    <div class="card-check"><i class="fa-solid fa-check"></i></div>
    <div class="card-icon icon-structure"><i class="fa-solid fa-pen-nib"></i></div>
    <div class="card-content">
      <div class="card-subtitle">Section 2</div>
      <div class="card-title">Structure</div>
      <div class="card-desc">Evaluez votre maitrise des regles grammaticales et syntaxiques de la langue Yemba.</div>
      <div class="card-meta">
        <span class="meta-chip"><i class="fa-solid fa-clock"></i> 25 min</span>
        <span class="meta-chip"><i class="fa-solid fa-list"></i> 40 questions</span>
        <span class="meta-chip"><i class="fa-solid fa-star-half-stroke"></i> 31&#8211;68</span>
      </div>
    </div>
  </label>

  <!-- READING -->
  <label class="test-card" id="cardReading" for="rdReading">
    <input type="radio" id="rdReading" name="typeTest" value="Reading" runat="server"/>
    <div class="card-check"><i class="fa-solid fa-check"></i></div>
    <div class="card-icon icon-reading"><i class="fa-solid fa-book-open"></i></div>
    <div class="card-content">
      <div class="card-subtitle">Section 3</div>
      <div class="card-title">Reading</div>
      <div class="card-desc">Mesurez votre capacite a lire et comprendre des textes ecrits en langue Yemba de differents niveaux.</div>
      <div class="card-meta">
        <span class="meta-chip"><i class="fa-solid fa-clock"></i> 55 min</span>
        <span class="meta-chip"><i class="fa-solid fa-list"></i> 50 questions</span>
        <span class="meta-chip"><i class="fa-solid fa-star-half-stroke"></i> 31&#8211;67</span>
      </div>
    </div>
  </label>

  <!-- FULL TEST (pleine largeur) -->
  <label class="test-card full-width" id="cardFullTest" for="rdFullTest">
    <input type="radio" id="rdFullTest" name="typeTest" value="FullTest" runat="server"/>
    <div class="card-check"><i class="fa-solid fa-check"></i></div>
    <div class="card-icon icon-fulltest"><i class="fa-solid fa-trophy"></i></div>
    <div class="card-content">
      <div class="card-subtitle">Test Certifiant</div>
      <div class="card-title">Test Complet TLC</div>
      <div class="card-desc">Passez les trois sections en une seule session pour obtenir votre score TLC global et votre certificat de competence en langue Yemba. Recommande pour la certification officielle.</div>
      <div class="card-meta">
        <span class="meta-chip"><i class="fa-solid fa-clock"></i> 1h 50 min</span>
        <span class="meta-chip"><i class="fa-solid fa-list"></i> 140 questions</span>
        <span class="meta-chip gold"><i class="fa-solid fa-star"></i> Score 310&#8211;677</span>
        <span class="meta-chip gold"><i class="fa-solid fa-certificate"></i> Certificat inclus</span>
      </div>
    </div>
  </label>

</div>

<!-- ACTION ZONE -->
<div class="action-zone">
  <div class="selection-info">
    <div class="sel-icon-wrap">
      <i class="fa-solid fa-clipboard-list" id="selIconEl"></i>
    </div>
    <div class="selection-text">
      <span class="sel-label">Test selectionne</span>
      <span class="sel-value empty" id="selValue">Aucune selection</span>
    </div>
  </div>
  <asp:Button ID="btnCommencer" runat="server"
    Text="Commencer le Test"
    CssClass="btn-start"
    OnClick="btnCommencer_Click"
    OnClientClick="return validerSelection();"
    Enabled="false" />
</div>

<!-- FOOTER -->
<footer>
  <span class="footer-brand">TLC Yemba Online Test</span>
  <span>Projet DPW &#8212; ASP.NET Web Forms &amp; ADO.NET</span>
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
var iconMap = {
  Listening: 'fa-headphones',
  Structure: 'fa-pen-nib',
  Reading: 'fa-book-open',
  FullTest: 'fa-trophy'
};
var labelMap = {
  Listening: 'Listening &#8212; Comprehension Orale',
  Structure: 'Structure &#8212; Grammaire',
  Reading:   'Reading &#8212; Comprehension Ecrite',
  FullTest:  'Test Complet TLC'
};
var cardIds = {
  Listening:'cardListening', Structure:'cardStructure',
  Reading:'cardReading', FullTest:'cardFullTest'
};

function selectCard(val){
  document.querySelectorAll('.test-card').forEach(function(c){c.classList.remove('selected')});
  var card = document.getElementById(cardIds[val]);
  if(card){
    card.classList.add('selected');
    var r = card.querySelector('input[type="radio"]');
    if(r) r.checked = true;
  }
  var iconEl = document.getElementById('selIconEl');
  iconEl.className = 'fa-solid ' + iconMap[val];
  var selVal = document.getElementById('selValue');
  selVal.innerHTML = labelMap[val];
  selVal.className = 'sel-value';
  var btn = document.getElementById('<%= btnCommencer.ClientID %>');
  if(btn) btn.disabled = false;
  hideError();
}

// Attach click handlers to each card label
window.addEventListener('DOMContentLoaded', function(){
  ['Listening','Structure','Reading','FullTest'].forEach(function(val){
    var card = document.getElementById(cardIds[val]);
    if(card) card.addEventListener('click', function(){ selectCard(val); });
  });
  // Restore selection on postback
  document.querySelectorAll('.test-card input[type="radio"]').forEach(function(r){
    if(r.checked) selectCard(r.value);
  });
});

function validerSelection(){
  var radios = document.querySelectorAll('input[type="radio"]');
  for(var i=0;i<radios.length;i++){ if(radios[i].checked) return true; }
  showError(); return false;
}
function showError(){ document.getElementById('clientError').classList.add('visible'); }
function hideError(){ document.getElementById('clientError').classList.remove('visible'); }
</script>
</body>
</html>
