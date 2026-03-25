<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="TLCYemba.Test" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="fr">
<head runat="server">
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Test en cours &#8212; TLC Yemba</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800;900&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <style>
        :root{--teal:#3AAFA9;--teal-dark:#2B8F8A;--teal-pale:#EAF8F7;
            --txt-dark:#2D3748;--txt-mid:#4A5568;--txt-soft:#718096;
            --white:#FFFFFF;--radius:18px;--danger:#E53E3E;}
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
        html{scroll-behavior:smooth}
        body{font-family:'Poppins',sans-serif;
            background:linear-gradient(145deg,#C8EDEA 0%,#EAF8F7 40%,#DEF5F3 70%,#B8E8E4 100%);
            min-height:100vh;color:var(--txt-dark);}
        .page-wrapper{max-width:900px;margin:32px auto;
            background:rgba(255,255,255,.92);backdrop-filter:blur(20px);
            border-radius:28px;box-shadow:0 8px 48px rgba(58,175,169,.16);
            overflow:hidden;}
        /* TOP BAR */
        .top-bar{display:flex;align-items:center;justify-content:space-between;
            padding:18px 36px;background:rgba(255,255,255,.98);
            border-bottom:1.5px solid rgba(58,175,169,.12);}
        .top-bar-left{display:flex;align-items:center;gap:14px}
        .top-logo{display:flex;align-items:center;gap:10px;text-decoration:none}
        .logo-icon{width:38px;height:38px;background:var(--teal);border-radius:50%;
            display:flex;align-items:center;justify-content:center;
            font-family:'Nunito',sans-serif;font-weight:900;font-size:16px;color:#fff;}
        .logo-text{font-family:'Nunito',sans-serif;font-weight:900;font-size:17px;color:var(--txt-dark)}
        .logo-text span{color:var(--teal)}
        .section-badge{display:inline-flex;align-items:center;gap:6px;
            background:var(--teal-pale);border:1.5px solid rgba(58,175,169,.25);
            color:var(--teal-dark);padding:5px 14px;border-radius:50px;
            font-size:12px;font-weight:700;}
        .section-badge i{font-size:11px;color:var(--teal)}
        /* TIMER */
        .timer-wrap{display:flex;align-items:center;gap:10px}
        .timer-box{display:flex;align-items:center;gap:8px;
            padding:8px 18px;border-radius:50px;
            background:var(--teal-pale);border:1.5px solid rgba(58,175,169,.25);
            font-family:'Nunito',sans-serif;font-weight:900;font-size:20px;color:var(--teal-dark);}
        .timer-box i{font-size:15px;color:var(--teal)}
        .timer-box.danger{background:#FFF5F5;border-color:#FEB2B2;color:var(--danger);
            animation:pulse 1s ease-in-out infinite}
        .timer-box.danger i{color:var(--danger)}
        @keyframes pulse{0%,100%{transform:scale(1)}50%{transform:scale(1.04)}}
        /* PROGRESS */
        .progress-section{padding:20px 36px 0}
        .progress-header{display:flex;justify-content:space-between;align-items:center;
            margin-bottom:10px}
        .progress-label{font-size:13px;color:var(--txt-soft);font-weight:500}
        .progress-count{font-family:'Nunito',sans-serif;font-weight:800;font-size:14px;color:var(--teal)}
        .progress-bar-wrap{height:8px;background:#E2E8F0;border-radius:50px;overflow:hidden}
        .progress-bar-fill{height:100%;background:linear-gradient(90deg,#3AAFA9,#44C4BE);
            border-radius:50px;transition:width .4s ease;}
        /* NAV DOTS */
        .nav-dots{display:flex;gap:6px;padding:14px 36px;flex-wrap:wrap}
        .dot{width:28px;height:28px;border-radius:50%;border:2px solid #CBD5E0;
            background:white;display:flex;align-items:center;justify-content:center;
            font-size:10px;font-weight:700;color:#A0AEC0;cursor:pointer;transition:all .2s;}
        .dot.answered{background:var(--teal);border-color:var(--teal);color:white}
        .dot.current{border-color:var(--teal);color:var(--teal);font-weight:900}
        .dot.current.answered{background:var(--teal-dark);border-color:var(--teal-dark);color:white}
        /* QUESTION AREA */
        .question-area{padding:28px 36px}
        .question-header{display:flex;align-items:center;gap:12px;margin-bottom:20px}
        .q-num{width:44px;height:44px;border-radius:14px;background:var(--teal);
            display:flex;align-items:center;justify-content:center;
            font-family:'Nunito',sans-serif;font-weight:900;font-size:18px;color:white;flex-shrink:0}
        .q-section-tag{font-size:11px;font-weight:700;color:var(--teal);text-transform:uppercase;
            letter-spacing:.5px}
        /* AUDIO PLAYER */
        .audio-panel{background:var(--teal-pale);border:1.5px solid rgba(58,175,169,.25);
            border-radius:var(--radius);padding:20px 24px;margin-bottom:20px;
            display:flex;align-items:center;gap:16px;}
        .audio-panel.hidden{display:none}
        .audio-icon{width:48px;height:48px;background:var(--teal);border-radius:14px;
            display:flex;align-items:center;justify-content:center;flex-shrink:0}
        .audio-icon i{font-size:22px;color:white}
        .audio-info{display:flex;flex-direction:column;gap:4px;flex:1}
        .audio-label{font-size:12px;font-weight:700;color:var(--teal-dark);text-transform:uppercase;letter-spacing:.4px}
        .audio-desc{font-size:13px;color:var(--txt-soft)}
        audio{width:100%;height:36px;outline:none}
        audio::-webkit-media-controls-panel{background:white}
        .btn-replay{display:inline-flex;align-items:center;gap:6px;
            background:var(--teal);color:white;border:none;padding:8px 16px;
            border-radius:50px;font-size:12.5px;font-weight:600;cursor:pointer;
            font-family:'Poppins',sans-serif;transition:background .2s;}
        .btn-replay:hover{background:var(--teal-dark)}
        /* QUESTION TEXT */
        .question-text{font-size:17px;font-weight:600;color:var(--txt-dark);
            line-height:1.65;margin-bottom:24px;}
        /* ANSWER CHOICES */
        .choices-list{display:flex;flex-direction:column;gap:12px}
        .choice-item{display:flex;align-items:center;gap:14px;
            padding:14px 20px;border-radius:14px;border:2px solid #E2E8F0;
            background:white;cursor:pointer;transition:all .2s;}
        .choice-item:hover{border-color:var(--teal);background:var(--teal-pale)}
        .choice-item.selected{border-color:var(--teal);background:var(--teal-pale)}
        .choice-item input[type="radio"]{display:none}
        .choice-letter{width:36px;height:36px;border-radius:10px;
            background:#F7FAFC;border:2px solid #CBD5E0;
            display:flex;align-items:center;justify-content:center;
            font-family:'Nunito',sans-serif;font-weight:800;font-size:15px;color:var(--txt-mid);
            flex-shrink:0;transition:all .2s;}
        .choice-item.selected .choice-letter{background:var(--teal);border-color:var(--teal);color:white}
        .choice-item:hover .choice-letter{border-color:var(--teal);color:var(--teal)}
        .choice-item.selected:hover .choice-letter{color:white}
        .choice-text{font-size:14.5px;color:var(--txt-dark);line-height:1.5}
        /* NAVIGATION BUTTONS */
        .nav-buttons{display:flex;align-items:center;justify-content:space-between;
            padding:20px 36px 28px;border-top:1.5px solid rgba(58,175,169,.10);gap:12px;}
        .btn-nav{display:inline-flex;align-items:center;gap:8px;
            padding:12px 26px;border-radius:50px;font-size:14px;font-weight:600;
            cursor:pointer;font-family:'Poppins',sans-serif;transition:all .2s;border:none;}
        .btn-prev{background:#F7FAFC;color:var(--txt-mid);border:1.5px solid #E2E8F0}
        .btn-prev:hover{background:#EDF2F7;color:var(--txt-dark)}
        .btn-prev:disabled{opacity:.4;cursor:not-allowed}
        .btn-next{background:var(--teal);color:white;
            box-shadow:0 4px 14px rgba(58,175,169,.35)}
        .btn-next:hover{background:var(--teal-dark);transform:translateY(-2px)}
        .btn-finish{background:#48BB78;color:white;
            box-shadow:0 4px 14px rgba(72,187,120,.35)}
        .btn-finish:hover{background:#38A169;transform:translateY(-2px)}
        /* MODAL CONFIRMATION */
        .modal-overlay{display:none;position:fixed;inset:0;background:rgba(0,0,0,.45);
            z-index:1000;align-items:center;justify-content:center;}
        .modal-overlay.show{display:flex}
        .modal{background:white;border-radius:24px;padding:40px;max-width:440px;width:90%;
            box-shadow:0 20px 60px rgba(0,0,0,.20);text-align:center;
            animation:modalIn .3s ease both;}
        @keyframes modalIn{from{transform:scale(.9);opacity:0}to{transform:scale(1);opacity:1}}
        .modal-icon{width:72px;height:72px;background:#EBF8F5;border-radius:50%;
            display:flex;align-items:center;justify-content:center;margin:0 auto 20px;}
        .modal-icon i{font-size:32px;color:var(--teal)}
        .modal h2{font-family:'Nunito',sans-serif;font-weight:900;font-size:22px;
            color:var(--txt-dark);margin-bottom:10px;}
        .modal p{font-size:14px;color:var(--txt-soft);line-height:1.7;margin-bottom:8px}
        .modal-stats{display:flex;justify-content:center;gap:24px;
            margin:16px 0;padding:16px;background:var(--teal-pale);
            border-radius:14px;border:1px solid rgba(58,175,169,.2);}
        .modal-stat{display:flex;flex-direction:column;gap:2px;text-align:center}
        .modal-stat-num{font-family:'Nunito',sans-serif;font-weight:900;font-size:22px;color:var(--teal)}
        .modal-stat-label{font-size:11px;color:var(--txt-soft);font-weight:500}
        .modal-buttons{display:flex;gap:12px;justify-content:center;margin-top:24px}
        .btn-modal-cancel{padding:11px 24px;border-radius:50px;border:2px solid #E2E8F0;
            background:white;color:var(--txt-mid);font-size:14px;font-weight:600;
            cursor:pointer;font-family:'Poppins',sans-serif;transition:all .2s;}
        .btn-modal-cancel:hover{background:#F7FAFC}
        .btn-modal-confirm{display:inline-flex;align-items:center;gap:8px;
            padding:11px 28px;border-radius:50px;background:#48BB78;
            color:white;border:none;font-size:14px;font-weight:600;cursor:pointer;
            font-family:'Poppins',sans-serif;transition:all .2s;
            box-shadow:0 4px 14px rgba(72,187,120,.35);}
        .btn-modal-confirm:hover{background:#38A169}
    </style>
</head>
<body>
<form id="form1" runat="server">

<div class="page-wrapper">

  <!-- TOP BAR -->
  <div class="top-bar">
    <div class="top-bar-left">
      <a href="Default.aspx" class="top-logo">
        <div class="logo-icon">T</div>
        <span class="logo-text">TLC <span>Yemba</span></span>
      </a>
      <asp:Label ID="lblSectionBadge" runat="server" CssClass="section-badge">
        <i class="fa-solid fa-layer-group"></i>
        <asp:Literal ID="litSection" runat="server"/>
      </asp:Label>
    </div>
    <div class="timer-wrap">
      <div class="timer-box" id="timerBox">
        <i class="fa-solid fa-clock"></i>
        <span id="timerDisplay">--:--</span>
      </div>
    </div>
  </div>

  <!-- PROGRESS BAR -->
  <div class="progress-section">
    <div class="progress-header">
      <span class="progress-label">
        <i class="fa-solid fa-chart-line" style="color:var(--teal);margin-right:5px"></i>
        Progression
      </span>
      <span class="progress-count">
        <asp:Literal ID="litQNum" runat="server"/>
        <asp:Literal ID="litQTotal" runat="server"/>
      </span>
    </div>
    <div class="progress-bar-wrap">
      <div class="progress-bar-fill" id="progressFill" style="width:0%"></div>
    </div>
  </div>

  <!-- NAV DOTS -->
  <div class="nav-dots" id="navDots"></div>

  <!-- QUESTION AREA -->
  <div class="question-area">

    <!-- Question header -->
    <div class="question-header">
      <div class="q-num">
        <asp:Literal ID="litNumero" runat="server"/>
      </div>
      <div>
        <div class="q-section-tag">
          <i class="fa-solid fa-tag" style="margin-right:4px"></i>
          <asp:Literal ID="litSectionTag" runat="server"/>
        </div>
      </div>
    </div>

    <!-- AUDIO PANEL (Listening only) -->
    <asp:Panel ID="pnlAudio" runat="server" CssClass="audio-panel hidden">
      <div class="audio-icon"><i class="fa-solid fa-volume-high"></i></div>
      <div class="audio-info">
        <div class="audio-label"><i class="fa-solid fa-headphones" style="margin-right:4px"></i>Ecoutez l'enregistrement</div>
        <div class="audio-desc">Ecoutez attentivement avant de repondre</div>
        <audio id="audioPlayer" controls controlsList="nodownload noplaybackrate">
          <source id="audioSrc" src="" type="audio/mpeg"/>
          Votre navigateur ne supporte pas l'audio HTML5.
        </audio>
      </div>
      <button type="button" class="btn-replay" onclick="rejouerAudio()">
        <i class="fa-solid fa-rotate-left"></i> Reecouter
      </button>
    </asp:Panel>

    <!-- QUESTION TEXT -->
    <asp:Panel ID="pnlEnonce" runat="server">
      <p class="question-text">
        <asp:Literal ID="litEnonce" runat="server"/>
      </p>
    </asp:Panel>

    <!-- ANSWER CHOICES -->
    <div class="choices-list" id="choicesList">
      <label class="choice-item" id="choiceA">
        <input type="radio" name="reponse" value="A" id="rdA" runat="server" onchange="onChoiceChange('A')"/>
        <div class="choice-letter">A</div>
        <div class="choice-text"><asp:Literal ID="litChoixA" runat="server"/></div>
      </label>
      <label class="choice-item" id="choiceB">
        <input type="radio" name="reponse" value="B" id="rdB" runat="server" onchange="onChoiceChange('B')"/>
        <div class="choice-letter">B</div>
        <div class="choice-text"><asp:Literal ID="litChoixB" runat="server"/></div>
      </label>
      <label class="choice-item" id="choiceC">
        <input type="radio" name="reponse" value="C" id="rdC" runat="server" onchange="onChoiceChange('C')"/>
        <div class="choice-letter">C</div>
        <div class="choice-text"><asp:Literal ID="litChoixC" runat="server"/></div>
      </label>
      <label class="choice-item" id="choiceD">
        <input type="radio" name="reponse" value="D" id="rdD" runat="server" onchange="onChoiceChange('D')"/>
        <div class="choice-letter">D</div>
        <div class="choice-text"><asp:Literal ID="litChoixD" runat="server"/></div>
      </label>
    </div>

  </div><!-- end question-area -->

  <!-- NAVIGATION BUTTONS -->
  <div class="nav-buttons">
    <asp:Button ID="btnPrecedent" runat="server" Text="Precedent"
      CssClass="btn-nav btn-prev"
      OnClick="btnPrecedent_Click"
      OnClientClick="sauvegarderReponse()"/>

    <asp:Label ID="lblQInfo" runat="server"
      style="font-size:13px;color:var(--txt-soft);font-weight:500;text-align:center"/>

    <asp:Button ID="btnSuivant" runat="server" Text="Suivant"
      CssClass="btn-nav btn-next"
      OnClick="btnSuivant_Click"
      OnClientClick="sauvegarderReponse()"/>

    <asp:Button ID="btnTerminer" runat="server" Text="Terminer le test"
      CssClass="btn-nav btn-finish"
      OnClientClick="return ouvrirModal();"
      OnClick="btnTerminer_Click"
      Visible="false"/>
  </div>

</div><!-- end page-wrapper -->

<!-- HIDDEN FIELD pour la reponse courante -->
<asp:HiddenField ID="hfReponse" runat="server" />

<!-- MODAL CONFIRMATION -->
<div class="modal-overlay" id="modalOverlay">
  <div class="modal">
    <div class="modal-icon"><i class="fa-solid fa-flag-checkered"></i></div>
    <h2>Terminer le test ?</h2>
    <p>Vous etes sur le point de soumettre vos reponses. Cette action est irreversible.</p>
    <div class="modal-stats">
      <div class="modal-stat">
        <span class="modal-stat-num" id="mAnswered">0</span>
        <span class="modal-stat-label">Repondu</span>
      </div>
      <div class="modal-stat">
        <span class="modal-stat-num" id="mSkipped" style="color:#ED8936">0</span>
        <span class="modal-stat-label">Non repondu</span>
      </div>
      <div class="modal-stat">
        <span class="modal-stat-num">
          <asp:Literal ID="litTotalModal" runat="server"/>
        </span>
        <span class="modal-stat-label">Total</span>
      </div>
    </div>
    <div class="modal-buttons">
      <button type="button" class="btn-modal-cancel" onclick="fermerModal()">
        <i class="fa-solid fa-arrow-left"></i> Continuer
      </button>
      <button type="button" class="btn-modal-confirm" onclick="confirmerTerminer()">
        <i class="fa-solid fa-flag-checkered"></i> Soumettre
      </button>
    </div>
  </div>
</div>

<!-- Hidden submit button for modal confirm -->
<asp:Button ID="btnSubmitFinal" runat="server" Text="Submit"
  style="display:none" OnClick="btnTerminer_Click"/>

</form>

<script src="timer.js"></script>
<script>
// ── Donnees injectees par le serveur ──
var totalQuestions = parseInt('<%= NbQuestions %>') || 0;
var currentIndex   = parseInt('<%= IndexCourant %>') || 0;
var answered       = JSON.parse('<%= AnsweredJSON ?? "[]" %>');   // ex: [0,2,4]
var dureeMin       = parseInt('<%= DureeMinutes %>') || 30;

// ── Progress bar ──
function updateProgress(){
    var pct = totalQuestions > 0 ? ((currentIndex+1)/totalQuestions*100) : 0;
    document.getElementById('progressFill').style.width = pct + '%';
}

// ── Nav dots ──
function buildDots(){
    var wrap = document.getElementById('navDots');
    wrap.innerHTML = '';
    for(var i=0;i<Math.min(totalQuestions,50);i++){
        var d = document.createElement('div');
        d.className = 'dot';
        d.textContent = i+1;
        if(answered.indexOf(i) !== -1) d.classList.add('answered');
        if(i === currentIndex) d.classList.add('current');
        wrap.appendChild(d);
    }
}

// ── Highlight selected choice ──
function updateChoiceHighlight(){
    ['A','B','C','D'].forEach(function(l){
        var rd = document.getElementById('rd'+l);
        var ci = document.getElementById('choice'+l);
        if(rd && ci){
            if(rd.checked){ ci.classList.add('selected'); }
            else { ci.classList.remove('selected'); }
        }
    });
}
function onChoiceChange(letter){
    document.getElementById('hfReponse').value = letter;
    updateChoiceHighlight();
}

// ── Audio ──
function rejouerAudio(){
    var p = document.getElementById('audioPlayer');
    if(p){ p.currentTime=0; p.play().catch(function(){}); }
}

// ── Modal ──
function ouvrirModal(){
    var ans = 0;
    ['A','B','C','D'].forEach(function(l){
        var r = document.getElementById('rd'+l); if(r && r.checked) ans++;
    });
    // Compte les reponses totales (depuis answered array + reponse courante)
    var tot = answered.length;
    var skipped = totalQuestions - tot;
    document.getElementById('mAnswered').textContent = tot;
    document.getElementById('mSkipped').textContent = Math.max(0,skipped);
    document.getElementById('modalOverlay').classList.add('show');
    return false;
}
function fermerModal(){
    document.getElementById('modalOverlay').classList.remove('show');
}
function confirmerTerminer(){
    document.getElementById('<%= btnSubmitFinal.ClientID %>').click();
}

// ── Init ──
window.addEventListener('DOMContentLoaded', function(){
    updateProgress();
    buildDots();
    updateChoiceHighlight();
    // Demarrer timer (timer.js)
    if(typeof startTimer === 'function'){
        startTimer(dureeMin * 60, 'timerDisplay', 'timerBox', function(){
            document.getElementById('<%= btnSubmitFinal.ClientID %>').click();
        });
    }
    // Auto-play audio si present
    var audioPanel = document.querySelector('.audio-panel');
    if(audioPanel && !audioPanel.classList.contains('hidden')){
        var p = document.getElementById('audioPlayer');
        if(p) p.play().catch(function(){});
    }
});
function sauvegarderReponse(){
    var sel = '';
    ['A','B','C','D'].forEach(function(l){
        var r=document.getElementById('rd'+l); if(r&&r.checked) sel=l;
    });
    document.getElementById('<%= hfReponse.ClientID %>').value = sel;
    return true;
}
</script>
</body>
</html>
