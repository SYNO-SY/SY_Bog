window.addEventListener("message", function (event) {
  var countdownElement = document.getElementById("countdown");
  if (event.data.action === "show") {
    countdownElement.style.display = "flex";
    countdownElement.innerText = event.data.time;
  } else if (event.data.action === "update") {
    countdownElement.innerText = event.data.time;
  } else if (event.data.action === "hide") {
    countdownElement.style.display = "none";
  }
});
