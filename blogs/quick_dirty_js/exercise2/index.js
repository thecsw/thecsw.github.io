document.addEventListener("DOMContentLoaded",() => {
    let next = document.querySelector('#next');
    let prev = document.querySelector('#prev');
    let show = document.querySelector('#show');

    let image = 1;
    let num_of_images = 5;
    
    next.addEventListener('click', (e) => {
	image = (image + 1) % num_of_images;
	show.src = "image-" + image + ".jpg";
	return
    });
    
    prev.addEventListener('click', (e) => {
	image -= 1
	if (image === -1) image = num_of_images - 1;
	show.src = "image-" + image + ".jpg";
	return
    });
});
