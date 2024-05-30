window.addEventListener("load", function () {
  let wait_time = 2_000;
  let refresh_time = 1_000;
  let text = document.querySelector("#text");
  text.innerHTML = "You should get redirected in " + (wait_time / 1_000) +
    " seconds.";
  let counter = 1;
  setInterval(() => {
    let left = (wait_time - counter * refresh_time) / 1_000;
    text.innerHTML = "You should get redirected " +
      ((left > 0)
        ? ("in " + left + " second" + (left == 1 ? "" : "s") + ".")
        : "now.");
    counter++;
  }, refresh_time);
  setInterval(() => {
    window.location =
      "https://www.nybooks.com/articles/2021/07/01/dostoevsky-and-his-demons/";
  }, wait_time);
}, false);
