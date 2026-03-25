/**
 * timer.js — Chronomètre dégressif TLC Yemba
 * Couche UI uniquement — aucun accès serveur.
 */
function startTimer(totalSeconds, displayId, boxId, onExpire) {
    var remaining = totalSeconds;
    var display   = document.getElementById(displayId);
    var box       = document.getElementById(boxId);

    function tick() {
        if (remaining < 0) {
            if (typeof onExpire === "function") onExpire();
            return;
        }
        var m = Math.floor(remaining / 60);
        var s = remaining % 60;
        display.textContent =
            (m < 10 ? "0" : "") + m + ":" + (s < 10 ? "0" : "") + s;

        // Couleur danger sous 5 minutes
        if (remaining <= 300) {
            box.classList.add("danger");
        } else {
            box.classList.remove("danger");
        }
        remaining--;
        setTimeout(tick, 1000);
    }
    tick();
}
