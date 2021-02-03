const categories = document.getElementById('category-select');
const optionsToPopulate = document.getElementById('selected-options-list');
categories.selectedIndex = -1;

categories.addEventListener('change', (e) => {
    let selectedOption = categories.options[categories.selectedIndex];

    let listItemToAppend = document.createElement('li');
    listItemToAppend.id = selectedOption.value;
    listItemToAppend.innerText = selectedOption.innerText;


    let itemsInOptions = optionsToPopulate.getElementsByTagName('li');
    let duplicate = false;
    // Flipping though already created ones to make sure 
    // There's no duplicates
    for (let i = 0; i < itemsInOptions.length; i++) {
        console.log(listItemToAppend.id)

        if (listItemToAppend.id == itemsInOptions[i].id) { duplicate = true; }
    }

    let capacityReached = itemsInOptions.length > 2 ? true : false;

    if (!duplicate && !capacityReached) { optionsToPopulate.appendChild(listItemToAppend); }
});