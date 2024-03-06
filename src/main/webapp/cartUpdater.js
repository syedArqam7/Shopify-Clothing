function updateCartIcon() {
    var cartIcon = document.getElementById("cart-icon");
    cartIcon.innerHTML = '<img src="images/cart.png" width="200" height="200" alt="">';

    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            var productCount = parseInt(xhr.responseText, 10);

            if (productCount > 0) {
                var badge = document.createElement("span");
                badge.className = "badge";
                badge.textContent = productCount;
                cartIcon.appendChild(badge);
            }
        }
    };
    xhr.open("GET", "productCountServlet", true);
    xhr.send();
}