const maxQuantity = parseInt(document.getElementById('quantity').innerText);
const cartForm = document.getElementById('cart-form');
const cartButton = document.getElementById('cart-button');
const purchaseForm = document.getElementById('purchase-form');
const purchaseButton = document.getElementById('purchase-button');
let mainQuantityDiv;

document.addEventListener('mousedown', (e) => {
    if (mainQuantityDiv != 'undefined' && (purchaseButton || cartButton) && !(e.path.includes(cartForm) || e.path.includes(purchaseForm))) {
        if (mainQuantityDiv) { removeQuantitySelect(); }
    }
});

if (purchaseButton) {
    purchaseButton.addEventListener('mouseenter', (e) => {
        if (document.querySelector('.cart-input')) { removeQuantitySelect(); }
        if (!document.querySelector('.purchase-input') && maxQuantity !== 0) { appendQuantitySelect('purchase'); }
    });
}

if (cartButton) {
    cartButton.addEventListener('mouseenter', (e) => {
        if (document.querySelector('.purchase-input')) { removeQuantitySelect(); }
        if (!document.querySelector('.cart-input') && maxQuantity !== 0) { appendQuantitySelect('cart'); }
    });
}

function appendQuantitySelect(designation) {
    mainQuantityDiv = document.createElement('div');
    mainQuantityDiv.id = 'quantity-input';
    mainQuantityDiv.classList.add(`${designation}-input`);

    quantityFields = document.createElement('div');
    quantityFields.classList.add('quantity-fields');

    let quantityPrompt = document.createElement('p');
    quantityPrompt.innerText = "Quantity: ";

    let numberInput = document.createElement('input');
    numberInput.classList.add('quantity-input-field');
    numberInput.value = 1;
    numberInput.type = 'number';
    numberInput.name = 'quantity';
    numberInput.min = 1;
    numberInput.max = maxQuantity;

    quantityFields.appendChild(quantityPrompt);
    quantityFields.appendChild(numberInput);

    mainQuantityDiv.appendChild(quantityFields);

    if (designation === 'cart') {
        cartForm.appendChild(mainQuantityDiv);
    }
    else {
        purchaseForm.appendChild(mainQuantityDiv);
    }
}

function removeQuantitySelect() {
    mainQuantityDiv.remove();
}