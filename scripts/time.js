window.onload = () => {
  let time = document.querySelector("#hetime");
  const day = 24 * 60 * 60 * 1000;

  setTime = () => {
    let now = new Date();
    let start = new Date(now.getFullYear(), 0, 0);
    var diff =
      now -
      start +
      (start.getTimezoneOffset() - now.getTimezoneOffset()) * 60 * 1000;

    time.innerText =
      (now.getHours() > 0 && now.getHours() < 12 ? "🌑" : "🌕") +
      " " +
      Math.floor(diff / day) +
      "; " +
      (now.getFullYear() + 10000) +
      " H.E. " +
      (now.getHours() * 100 + now.getMinutes()).toString().padStart(4, "0") +
      "." +
      now.getSeconds().toString().padStart(2, "0");
  };

  setTime();
  setInterval(setTime, 1000);
};
