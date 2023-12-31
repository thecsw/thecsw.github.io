window.addEventListener('load', function() {
    const mobileWidth = 550;
    const collapsedHeader = "Film";
    const originalHeader = "Title";
    const columnJoin = "<br>";
    let table = document.querySelector("table");
    let is_collapsed = false;

    reformatTableForSize = () => {
        if (window.innerWidth <= mobileWidth && !is_collapsed) {
            table.rows[0].cells[1].innerText = collapsedHeader;
            table.rows[0].cells[2].innerText = "";
            for (var i = 1, row; row = table.rows[i]; i++) {
                let collapsed_text =
                    '<span id="title">' + row.cells[2].innerHTML + '</span>'+ columnJoin +
                    '<span id="director">' + row.cells[3].innerHTML + '</span>'+ columnJoin + 
                    '<span id="country">' + row.cells[4].innerHTML + ", " + row.cells[5].innerHTML + '</span>';
                row.cells[2].innerHTML = row.cells[1].innerHTML;
                row.cells[1].innerHTML = collapsed_text;
            }
            is_collapsed = true;
        }
        if (window.innerWidth > mobileWidth && is_collapsed) {
            table.rows[0].cells[1].innerText = "";
            table.rows[0].cells[2].innerText = originalHeader;
            for (var i = 1, row; row = table.rows[i]; i++) {
                let picture = row.cells[2].innerHTML;
                row.cells[2].innerHTML = row.cells[1].innerHTML.split(columnJoin)[0]
                row.cells[1].innerHTML = picture;
            }
            is_collapsed = false;
        }
    }

    reformatTableForSize()
    window.onresize = reformatTableForSize;
}, false);
