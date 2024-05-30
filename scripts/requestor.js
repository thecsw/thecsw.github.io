async function get() {
    const response = await fetch("https://sandyuraz.com/writings/ideal_love/");
    let text = document.querySelector("#text");
    text.innerHTML = "I reached out to the article, here are some response stats: " + response.status + " " + response.statusText + "<br>";
    text.innerHTML += "The response headers are: " + JSON.stringify(response.headers) + "<br>";
    text.innerHTML += "The response body is: " + JSON.stringify(await response.text()).length + " characters long<br>";
    text.innerHTML += "The response URL is: " + response.url + "<br>";
    text.innerHTML += "The response type is: " + response.type + "<br>";
    console.log(response);
}

get();
