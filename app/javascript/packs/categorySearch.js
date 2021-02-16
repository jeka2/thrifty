const categories = document.getElementById('category-select');
const optionsToPopulate = document.getElementById('selected-options-list');
categories.selectedIndex = -1;

// When updating, categories that are aleady attributed
// To the item
let existingCategories = document.querySelectorAll('.category');
for (let i = 0; i < existingCategories.length; i++) {
    let li = existingCategories[i];
    let checkbox = li.childNodes[3];
    removeOnUncheck(checkbox, li);
}

categories.addEventListener('change', (e) => {
    let selectedOption = categories.options[categories.selectedIndex];

    let listItemToAppend = document.createElement('li');
    let checkbox = document.createElement('input');
    let categoryName = document.createElement('p');

    categoryName.innerHTML = selectedOption.innerText;
    categoryName.classList.add('category-name');

    checkbox.type = 'checkbox';
    checkbox.name = 'item[category_ids][]';
    checkbox.value = selectedOption.value;
    checkbox.classList.add('category-checkbox');
    checkbox.checked = true;

    console.log(checkbox)

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

