const ratingsContainer = document.getElementById('ratings-container');
const individualStars = ratingsContainer.children;
for (let i = 0; i < individualStars.length; i++) {
    let individualStar = individualStars[i];
    individualStar.addEventListener('mouseover', (e) => {
        modifyHighlights(e.path[0], 'add');
    });
    individualStar.addEventListener('mouseleave', (e) => {
        modifyHighlights(e.path[0], 'remove');
    });
}

function modifyHighlights(star, action) {
    if (action === 'remove') { star = ratingsContainer.children[4]; }
    while (star) {
        action === 'add' ? star.classList.add('filled') : star.classList.remove('filled');
        star = star.previousElementSibling;
    }
}

