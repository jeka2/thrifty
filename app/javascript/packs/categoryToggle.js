const availableCategories = document.getElementById('category-select');
const categoriesToPopulate = document.getElementById('item_category_ids');
const toggler = document.querySelector('.select-transfer');
const submitButton = document.getElementById('submit');

// When the user clicks on arrow, the category will be transmitted
// To the select box 
toggler.addEventListener('click', (e) => {
    let selectedOption = availableCategories.options[availableCategories.options.selectedIndex]
    let canPopulate = true;

    for (let i = 0; i < categoriesToPopulate.options.length; i++) {
        if (selectedOption.value === categoriesToPopulate.options[i].value) {
            canPopulate = false;
        }
    }
    if (canPopulate) { categoriesToPopulate.add(selectedOption); }
})
// All of the options in the selected box will be selected when
// the user hovers over the submit button
submitButton.addEventListener('mouseup', (e) => {
    for (let i = 0; i < categoriesToPopulate.options.length; i++) {
        categoriesToPopulate.options[i].selected = true;
    }
});