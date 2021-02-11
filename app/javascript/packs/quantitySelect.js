const maxQuantity = parseInt(document.getElementById('quantity').innerText);
const cartForm = document.getElementById('cart-form');
const cartButton = document.getElementById('cart-button');
let mainQuantityDiv;

document.addEventListener('click', (e) => {
    console.log(e)
    if (mainQuantityDiv != 'undefined' && !e.path.includes(cartForm)) {
        removeQuantitySelect();
    }
});

cartButton.addEventListener('mouseenter', (e) => {
    if (!document.querySelector('#quantity-input')) { appendQuantitySelect(); }
});

function appendQuantitySelect() {
    mainQuantityDiv = document.createElement('div');
    mainQuantityDiv.id = 'quantity-input';

    quantityFields = document.createElement('div');
    quantityFields.classList.add('quantity-fields');

    let quantityPrompt = document.createElement('p');
    quantityPrompt.innerText = "Quantity: ";

    let numberInput = document.createElement('input');
    numberInput.classList.add('quantity-input-field');
    numberInput.innerText = 1;
    numberInput.type = 'number';
    numberInput.name = 'quantity';
    numberInput.min = 1;
    numberInput.max = maxQuantity;

    quantityFields.appendChild(quantityPrompt);
    quantityFields.appendChild(numberInput);

    mainQuantityDiv.appendChild(quantityFields);

    cartForm.appendChild(mainQuantityDiv);
}

function removeQuantitySelect() {
    mainQuantityDiv.remove();
}