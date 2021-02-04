const categories = document.getElementById('category-select');
const optionsToPopulate = document.getElementById('selected-options-list');
const submitButton = document.getElementById('submit-button');
categories.selectedIndex = -1;

categories.addEventListener('change', (e) => {
    let selectedOption = categories.options[categories.selectedIndex];

    let listItemToAppend = document.createElement('li');
    let checkbox = document.createElement('input');
    let categoryName = document.createElement('p');

    categoryName.innerHTML = selectedOption.innerText;
    categoryName.classList.add('category-name');

    checkbox.type = 'checkbox';
    checkbox.name = 'category_ids[]';
    checkbox.value = selectedOption.value;
    checkbox.classList.add('category-checkbox');
    checkbox.checked = true;

    listItemToAppend.appendChild(categoryName);
    listItemToAppend.appendChild(checkbox);
    listItemToAppend.id = selectedOption.value;
    listItemToAppend.classList.add('category');

    removeOnUncheck(checkbox, listItemToAppend);

    let itemsInOptions = optionsToPopulate.getElementsByTagName('li');
    let duplicate = false;
    // Flipping though already created ones to make sure 
    // There's no duplicates
    for (let i = 0; i < itemsInOptions.length; i++) {
        if (listItemToAppend.id == itemsInOptions[i].id) { duplicate = true; }
    }

    let capacityReached = itemsInOptions.length > 2 ? true : false;

    if (!duplicate && !capacityReached) { optionsToPopulate.appendChild(listItemToAppend); }
});

function removeOnUncheck(checkbox, surroundingLi) {
    checkbox.addEventListener('change', (e) => {
        if (checkbox.checked == false) {
            surroundingLi.remove();
        }
    });
}

