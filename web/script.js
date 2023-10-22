window.addEventListener("message", function (event) {
  var countdownElement = document.getElementById("countdown");
  if (event.data.action === "show") {
    countdownElement.style.display = "flex";
    countdownElement.innerText = event.data.time;
  } else if (event.data.action === "update") {
    countdownElement.innerText = event.data.time;
  } else if (event.data.action === "hide") {
    countdownElement.innerText = "FIGHT";
    countdownElement.style.color = "red";
    setTimeout(() => {
      countdownElement.style.display = "none";
    }, 5000);
  } else if (event.data.action === "killfeed") {
    var killer = event.data.killer;
    var victim = event.data.victim;
    var weapon = event.data.weapon;
    killfeed(killer, victim, weapon.toLowerCase());
  }
});

function killfeed(killer, victim, weapon) {
  var number = Math.floor(Math.random() * 1000 + 1);
  var killfeed = `
  <div class="killfeed-container-${number} py-1 px-3 animate__animated animate__fadeInRightBig" id = "killfeed">
  <span class="killer mx-1">${killer}</span>
  <img src="./weapons/${weapon}.png" onerror="this.src='./weapons/pistol.png';" alt="" />
  <span class="victim mx-1">${victim}</span>
  </div>`;
  $("#kill-feed").append(killfeed);
  setTimeout(function () {
    $(`.killfeed-container-${number}`)
      .removeClass("animate__fadeInRightBig")
      .addClass("animate__fadeOutRightBig");
    $(`.killfeed-container-${number}`).fadeOut("slow");
  }, 5000);
}
