document.addEventListener("DOMContentLoaded",() => {
    let pass1  = document.querySelector('#input1');
    let pass2  = document.querySelector('#input2');
    let button  = document.querySelector('#button');

    let handler = (e) => {
        let val1 = input1.value;
        let val2 = input2.value;
	if (val1.length < 8 || val2.length < 8) {
	    alert("Should be at least 8 chars long");
	    return
	}
	if (val1 !== val2) {
	    alert("Passwords don't match!");
	    return
	}
	button.innerText = "VALIDATED";
    }

    button.addEventListener('click', handler);
});
