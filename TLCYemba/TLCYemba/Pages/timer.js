/**
 * TLC YEMBA — timer.js
 * Chronomètre côté client pour la page Test.aspx
 * Dépend de l'objet TLC injecté par Test.aspx.cs (secondesRestantes, totalQuestions…)
 */
(function () {
    'use strict';

    // ── Références DOM ──────────────────────────────────────────────
    var displayEl    = document.getElementById('timerDisplay');
    var hdnRestantes = document.querySelector('[id$="hdnSecondesRestantes"]');
    var hdnEcoulee   = document.querySelector('[id$="hdnDureeEcoulee"]');
    var btnHidden    = document.querySelector('[id$="btnTerminerHidden"]');

    if (!displayEl || !hdnRestantes) return;

    // ── État du timer ───────────────────────────────────────────────
    var secondesRestantes = parseInt(hdnRestantes.value) || TLC.secondesRestantes;
    var dureeInitiale     = secondesRestantes;
    var intervalId        = null;

    // ── Formater MM:SS ──────────────────────────────────────────────
    function formaterTemps(sec) {
        var m = Math.floor(sec / 60);
        var s = sec % 60;
        return (m < 10 ? '0' + m : m) + ':' + (s < 10 ? '0' + s : s);
    }

    // ── Mettre à jour l'affichage ───────────────────────────────────
    function mettreAJourAffichage(sec) {
        displayEl.textContent = '⏱ ' + formaterTemps(sec);
        displayEl.classList.remove('warning', 'critical');

        var ratio = dureeInitiale > 0 ? sec / dureeInitiale : 1;

        if (ratio <= 0.1 || sec <= 60) {
            displayEl.classList.add('critical');
        } else if (ratio <= 0.25 || sec <= 180) {
            displayEl.classList.add('warning');
        }
    }

    // ── Tick principal ──────────────────────────────────────────────
    function tick() {
        if (secondesRestantes <= 0) {
            clearInterval(intervalId);
            displayEl.textContent = '⏱ 00:00';
            displayEl.classList.add('critical');
            soumettreAutomatiquement();
            return;
        }

        secondesRestantes--;

        // Mettre à jour les hidden fields
        hdnRestantes.value = secondesRestantes;
        if (hdnEcoulee) {
            hdnEcoulee.value = (dureeInitiale - secondesRestantes).toString();
        }

        mettreAJourAffichage(secondesRestantes);
    }

    // ── Soumission automatique quand le temps est écoulé ────────────
    function soumettreAutomatiquement() {
        // Petite pause pour que l'utilisateur voie 00:00
        setTimeout(function () {
            if (btnHidden) {
                btnHidden.click();
            } else {
                // Fallback : soumettre le formulaire
                var form = document.querySelector('form');
                if (form) form.submit();
            }
        }, 1200);
    }

    // ── Sauvegarde du chrono avant chaque postback ──────────────────
    (function() {
        var form = document.querySelector('form');
        if (form) {
            form.addEventListener('submit', function () {
                if (hdnRestantes) hdnRestantes.value = secondesRestantes;
                if (hdnEcoulee)   hdnEcoulee.value   = dureeInitiale - secondesRestantes;
            });
        }
    })();

    // ── Restauration du chrono après un postback ─────────────────────
    // (ASP.NET Web Forms recharge la page → récupérer la valeur du hidden field)
    secondesRestantes = parseInt(hdnRestantes.value) || TLC.secondesRestantes;
    dureeInitiale = dureeInitiale || secondesRestantes;

    // ── Démarrage ───────────────────────────────────────────────────
    mettreAJourAffichage(secondesRestantes);
    intervalId = setInterval(tick, 1000);

    // ── Nettoyage à la fermeture de la page ─────────────────────────
    window.addEventListener('beforeunload', function () {
        clearInterval(intervalId);
    });

})();
