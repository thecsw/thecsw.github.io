function run() {
    let text = document.querySelector("#text");
    
    let xhr = new XMLHttpRequest();
    let url = 'https://sandyuraz.com/writings/ideal_love/';
    xhr.open("GET", url, true);
    
    // function execute after request is successful 
    xhr.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            text.innerHTML = "I reached out to the server and got a response!";
            text.innerHTML += "<br>";
            text.innerHTML += "Status: " + this.status;
            text.innerHTML += "<br>";
            text.innerHTML += "URL: " + this.responseURL;
            text.innerHTML += "<br>";
            text.innerHTML += "Headers: " + this.getAllResponseHeaders();
            text.innerHTML += "<br>";
            text.innerHTML += "Response length: " + this.responseText.length;
            text.innerHTML += "<br>";
            text.innerHTML += "Response type: " + this.responseType
            
        }
    }
    // Sending our request 
    xhr.send();
}
run();
