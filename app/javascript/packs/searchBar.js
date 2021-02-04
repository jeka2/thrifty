const searchBar = document.getElementById('form-control');
let timeOut;
let listItems;
searchBar.addEventListener('keyup', (e) => {
    if (!listItems) { createList(); }
    if (timeOut) { clearTimeout(timeOut); }
    timeOut = setTimeout(() => { getRecords(searchBar.value); }, 500);

    if (e.key == "Backspace" && searchBar.value == "") {
        if (listItems) { listItems.remove(); }
        if (timeOut) { clearTimeout(timeOut); }
    }
});

window.addEventListener('click', (e) => {
    if (listItems.firstChild && e.target.id != searchBar.id) {
        listItems.remove();
    }
});

function createList() {
    listItems = document.createElement('ul');
}

async function getRecords(query) {
    let result;
    try {
        result = await $.ajax({
            url: '/search',
            type: 'GET',
            data: {
                'query': query,
                'type:': 'item'
            },
            success: function (data, status, xhr) {
                appendRecords(data);
            },
            dataType: "json"
        });
    } catch (e) {

    }
}

function appendRecords(records) {
    console.log(records);
}

// function appendNames(bookInfo, ul) {
//     ul.innerHTML = "";
//     for (let i = 0; i < bookInfo.length; i++) {
//         const listItem = document.createElement("LI");
//         listItem.classList.add('list-item');
//         listItem.classList.add(`item-${i + 1}`);

//         const bookLink = document.createElement("A");
//         bookLink.classList.add('book-link');
//         bookLink.classList.add(`link-${i + 1}`);
//         bookLink.href = `/books/${bookInfo[i].id}`;

//         const bookName = document.createElement("P");
//         bookName.classList.add('book-name');
//         bookName.classList.add(`name-${i + 1}`);
//         let truncatedTitle = bookInfo[i].title.length > 60 ? bookInfo[i].title.substring(0, 60) + "..." : bookInfo[i].title;
//         bookName.innerHTML = truncatedTitle;

//         const bookImg = document.createElement("IMG");
//         bookImg.classList.add('book-image');
//         bookImg.classList.add(`image-${i + 1}`);
//         bookImg.src = bookInfo[i].image;

//         bookLink.appendChild(bookName);
//         bookLink.appendChild(bookImg);
//         listItem.appendChild(bookLink);
//         ul.appendChild(listItem);
//     }
// }