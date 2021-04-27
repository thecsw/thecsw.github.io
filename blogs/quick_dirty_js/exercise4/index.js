document.addEventListener("DOMContentLoaded",() => {
    let border = document.querySelector('#border');
    let back = document.querySelector('#back');
    let text = document.querySelector('#text');
    let button = document.querySelector('#button');
    let re = /([a-z]+) (\d)/;
    
    let handler = (e) => {
	text.style.backgroundColor = back.value;

	let vals = re.exec(border.value)
	if (vals !== null) {
	    text.style.borderColor = vals[1];
	    text.style.borderWidth = parseInt(vals[2]);
	}
    }
    
    button.addEventListener('click', handler);
});
