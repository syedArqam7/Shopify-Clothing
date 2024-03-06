<%@ page contentType="text/html;charset=UTF-8" %>
<%
    Integer customerID = (Integer) session.getAttribute("customerID");
    if (customerID != null && customerID == 2) {
%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Outfitters</title>

    <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">
    <link rel="stylesheet" href="adminStyle.css">
</head>
<body>

<div class="banner">
    <div class="navbar">
        <img src="5-removebg-preview.png" class="logo" alt="">
        <ul>
            <li class="navHover"><a href="admin.jsp">Add Product</a></li>
            <li><a href="adminEdit.jsp">Edit Product</a></li>
            <li><a href="adminDelete.jsp">Delete Product</a></li>
            <li><a href="adminDelCustomer.jsp">Delete Customer</a></li>
            <li><a href="logOut">Log Out</a></li>
        </ul>
    </div>
</div>


<div class="main">
    <section class="signup">
        <div class="container">
            <div class="signup-content">
                <div class="signup-form">
                    <h2 class="form-title">Add</h2>

                    <form method="post" action="Admin" class="register-form"
                          id="register-form" onsubmit= "return validateAddProductForm()">
                        <input type="hidden" name="action" value="addProduct">
                        <div class="form-group">
                            <label for="productName"></label>
                            <input type="text" name="productName" id="productName" placeholder="Product Name" />
                        </div>
                        <div class="form-group">
                            <label for="productDescription"></label>
                            <textarea name="productDescription" id="productDescription" placeholder="Product Description"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="price"></label>
                            <input type="number" name="price" id="price" step="0.01" placeholder="Price" />
                        </div>
                        <div class="form-group">
                            <label for="categoryId"></label>
                            <input type="number" name="categoryId" id="categoryId" placeholder="Category ID" />
                        </div>
                        <div class="form-group">
                            <label for="brandId"></label>
                            <input type="number" name="brandId" id="brandId" placeholder="Brand ID" />
                        </div>
                        <div class="form-group">
                            <label for="sizeId"></label>
                            <input type="number" name="sizeId" id="sizeId" placeholder="Size ID" />
                        </div>
                        <div class="form-group">
                            <label for="availabilityStatus"></label>
                            <input type="text" name="availabilityStatus" id="availabilityStatus" placeholder="Availability Status" />
                        </div>
                        <div class="form-group">
                            <label for="image"></label>
                            <input type="text" name="image" id="image" placeholder="Image URL" />
                        </div>
                        <div class="form-group form-button">
                            <input type="submit" name="addProduct" id="addProduct" class="form-submit" value="Add Product" />
                        </div>
                    </form>
                </div>
                <div class="signup-image">
                    <figure>
                    </figure>
                </div>
            </div>
        </div>
    </section>
</div>


<div class="footer">
    <div class="container">
        <div class="row">
            <div class="footer-col-1">
                <h3>Download Our App</h3>
                <p>Download App for Android and Ios Mobile Phone</p>
                <div class="app-logo">
                    <img src="images/app-store.png" alt="">
                    <img src="images/play-store.png" alt="">
                </div>
            </div>
            <div class="footer-col-2">
                <img src="5-removebg-preview.png" alt="">
                <p>Providing Elegance and Quality in a Single Package</p>
            </div>
            <div class="footer-col-3">
                <h3>Useful Links</h3>
                <ul>
                    <li>Coupons</li>
                    <li>Blog Posts</li>
                    <li>Return Policy</li>
                    <li>Join Affiliate</li>
                </ul>
            </div>
            <div class="footer-col-4">
                <h3>Follow Us</h3>
                <ul>
                    <li>Facebook</li>
                    <li>Twitter</li>
                    <li>Instagram</li>
                    <li>Youtube</li>
                </ul>
            </div>
        </div>
        <hr>
        <p class="copyright">Copyright 2023 - Outfitters</p>
    </div>
</div>

<div id="loginFailedPopup" class="popup">
    <p style="color: red; text-align: center;">Invalid credentials. Please try again.</p>
</div>

<script src="js/main.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>


<script>
    function validateAddProductForm() {
        var productName = document.getElementById("productName").value;
        var productDescription = document.getElementById("productDescription").value;
        var price = document.getElementById("price").value;
        var categoryId = document.getElementById("categoryId").value;
        var brandId = document.getElementById("brandId").value;
        var sizeId = document.getElementById("sizeId").value;
        var availabilityStatus = document.getElementById("availabilityStatus").value;
        var image = document.getElementById("image").value;

        var validations = [
            { isValid: productName.trim() !== '', message: "Please fill the Product Name"},
            { isValid: price.trim() !== '', message: "Please fill the Price"},
            { isValid: productName.trim() !== '' && productDescription.trim() !== '' && price.trim() !== '' && categoryId.trim() !== '' && brandId.trim() !== '' && sizeId.trim() !== '' && availabilityStatus.trim() !== '' && image.trim() !== '', message: 'Please fill in all fields.' },
            { isValid: !isNaN(price) && parseFloat(price) > 0 && parseFloat(price) < 500, message: 'Please enter only numeric values and a valid price between 0 and 500.'},
            { isValid: !isNaN(categoryId) && parseInt(categoryId) >= 1 && parseInt(categoryId) <= 7, message: 'Please enter only numeric values and a valid categoryID between 1 and 7.'},
            { isValid: !isNaN(brandId) && parseInt(brandId) >= 1 && parseInt(brandId) <= 4, message: 'Please enter only numeric values and a valid brandID between 1 and 4.'},
            { isValid: !isNaN(sizeId) && parseInt(sizeId) >= 1 && parseInt(sizeId) <= 4, message: 'Please enter only numeric values and a valid sizeID between 1 and 4.'},
            { isValid: availabilityStatus.trim().toLowerCase() === 'in stock' || availabilityStatus.trim().toLowerCase() === 'out of stock', message: 'Please enter a valid availability status: "In Stock" or "Out of Stock".' },
            { isValid: image.toLowerCase().includes('.jpg') || image.toLowerCase().includes('.png'), message: 'Please enter a valid image URL with .jpg or .png extension and make sure it exists.'},
        ];

        var validationFailed = false;

        for (var i = 0; i < validations.length; i++) {
            if (!validations[i].isValid) {
                showErrorPopup(validations[i].message);
                validationFailed = true;
                break;
            }
        }

        if(validationFailed) {
            return false;
        }

        document.getElementById("addProduct").removeAttribute("disabled");
        if (availabilityStatus.trim().toLowerCase() !== 'in stock' && availabilityStatus.trim().toLowerCase() !== 'out of stock') {
            showErrorPopup('Please enter a valid availability status: "In Stock" or "Out of Stock".');
            return false;
        }

        return true;
    }

    document.getElementById("register-form").addEventListener("submit", function (event) {
        if (!validateAddProductForm()) {
            event.preventDefault();
        }
    });
</script>

<script>
    function showSuccessPopup(message) {
        Swal.fire({
            icon: 'success',
            title: 'Success!',
            text: message,
            showConfirmButton: false,
            timer: 3000
        });
    }

    const successParam = '<%= request.getParameter("success") %>';
    if (successParam === 'true') {
        showSuccessPopup('Operation completed successfully!');
    }
</script>

<script>
    const loginFailed = '<%= request.getAttribute("loginFailed") %>';
    if (loginFailed === 'true') {
        document.getElementById('loginFailedPopup').style.display = 'block';

        setTimeout(function () {
            document.getElementById('loginFailedPopup').style.display = 'none';
            window.location.href = 'login.jsp';
        }, 3000);
    }
</script>

<script>
    function showErrorPopup(message) {
        Swal.fire({
            icon: 'error',
            title: 'Error!',
            text: message,
            showConfirmButton: false,
            timer: 3000
        });
    }
</script>

</body>
</html>
<%
    } else {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
%>