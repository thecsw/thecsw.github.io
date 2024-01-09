document.addEventListener(
        "DOMContentLoaded",
        function () {
                let title = document.querySelector(".section-1");
                title.innerHTML = title.innerHTML.replace(
                        /Love/,
                        '<ss style="color:#ff001f">Love</ss>'
                );
        },
        false
);
