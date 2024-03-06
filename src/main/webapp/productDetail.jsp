<%@ page contentType="text/html;charset=UTF-8" %>
<%
    int customerID = (Integer) session.getAttribute("customerID");


    if ( customerID > 0) {
%>
<html lang="en">
<head>
    <title>Outfitters</title>
    <link rel="stylesheet" href="styleSingleProd.css">
</head>
<body>

<!-------------------- Home Page -------------------->
<div class="banner">
    <div class="navbar">
        <img src="5-removebg-preview.png" class="logo" alt="">
        <ul>
            <li class="navHover"><a href="Home">Home</a></li>
            <li><a href="Product">Products</a></li>
            <li><a href="logOut">Log Out</a></li>
            <li><a href="cart.jsp"><img src="images/cart.png" width="30px" height="30px" alt=""></a></li>
            <li><a href="allOrders?customerID=<%=customerID%>"><img src="receipt.png" width="30px" height="30px" alt=""></a></li>

        </ul>
    </div>
</div>

<!-------------------------- Single Product ------------------------->

<div class="small-container single-prod">
    <div class="row">
        <div class="col-2">
            <img src="productImages/<%= request.getAttribute("image") %>" width="80%" id="productImg" alt="">

            <div class="small-img-row">
                <%
                    String imageName = (String) request.getAttribute("image");
                    if (imageName.endsWith(".jpg")) {
                        imageName = imageName.substring(0, imageName.length() - 4);
                    }
                    String imageFolder = "productImages/" + imageName + "/";
                    if (imageName.endsWith("1")) {
                        imageName = imageName.substring(0, imageName.length() - 1);
                    }
                    if (imageName.endsWith("2")) {
                        imageName = imageName.substring(0, imageName.length() - 1);
                    }
                    if (imageName.endsWith("3")) {
                        imageName = imageName.substring(0, imageName.length() - 1);
                    }
                    if (imageName.endsWith("4")) {
                        imageName = imageName.substring(0, imageName.length() - 1);
                    }
                    if (imageName.endsWith("5")) {
                        imageName = imageName.substring(0, imageName.length() - 1);
                    }
                    if (imageName.endsWith("6")) {
                        imageName = imageName.substring(0, imageName.length() - 1);
                    }
                    if (imageName.endsWith("7")) {
                        imageName = imageName.substring(0, imageName.length() - 1);
                    }
                    if (imageName.endsWith("8")) {
                        imageName = imageName.substring(0, imageName.length() - 1);
                    }
                    if (imageName.endsWith("9")) {
                        imageName = imageName.substring(0, imageName.length() - 1);
                    }
                    if (imageName.endsWith("10")) {
                        imageName = imageName.substring(0, imageName.length() - 1);
                    }
                    if (imageName.endsWith("11")) {
                        imageName = imageName.substring(0, imageName.length() - 1);
                    }
                    if (imageName.endsWith("12")) {
                        imageName = imageName.substring(0, imageName.length() - 1);
                    }
                    if (imageName.endsWith("13")) {
                        imageName = imageName.substring(0, imageName.length() - 1);
                    }
                    if (imageName.endsWith("14")) {
                        imageName = imageName.substring(0, imageName.length() - 1);
                    }
                    if (imageName.endsWith("15")) {
                        imageName = imageName.substring(0, imageName.length() - 1);
                    }

                    String smallImage1 = imageFolder + imageName + "1.jpg";
                    String smallImage2 = imageFolder + imageName + "2.jpg";
                    String smallImage3 = imageFolder + imageName + "3.jpg";
                %>

                <div class="small-img-col">
                    <img class="small-img" src="<%= smallImage1 %>" alt="">
                </div>
                <div class="small-img-col">
                    <img class="small-img" src="<%= smallImage2 %>" alt="">
                </div>
                <div class="small-img-col">
                    <img class="small-img" src="<%= smallImage3 %>" alt="">
                </div>
            </div>

        </div>
        <div class="col-2">
            <p>Home / Clothing</p>
            <h1><%= request.getAttribute("product_name") %></h1>
            <h4>$<%= request.getAttribute("price") %></h4>
            <input type= "number" id="quantity" value="1">
            <a href="#" class="btn" onclick="addToCart()">Add to Cart</a>
            <h3>Product Details <i class="fa-fa-indent"></i></h3>
            <br>
            <p2><%= request.getAttribute("product_description") %></p2>
        </div>
    </div>
</div>

<!---------------------------- Title ----------------------------->

<div class="small-container">
    <div class="row row-2">
        <h2>Related Products</h2>
        <p><a href="Product" style="color: #555555; text-decoration: none;">View More</a></p>
    </div>
</div>


<!-------------------- Recent Products Page -------------------->

<div class="small-container">

    <div class="row">
        <%
            String[] recentProductNames = (String[]) request.getAttribute("recentProductNames");
            double[] recentProductPrices = (double[]) request.getAttribute("recentProductPrices");
            String[] recentProductImages = (String[]) request.getAttribute("recentProductImages");

            for (int i = 0; i < 4; i++) {
        %>
        <div class="col-4">
            <img src="productImages/<%= recentProductImages[i] %>" alt="">
            <h4><a href="singleProductServlet?product_name=<%= recentProductNames[i] %>" style="color: #555; font-weight: bold; text-decoration: none"><%= recentProductNames[i] %></a></h4>
            <p>$<%= recentProductPrices[i] %></p>
        </div>
        <%
            }
        %>
    </div>
</div>

<!--------------------  Footer -------------------->
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

<!-- jscript -->
<script>

    const productImg = document.getElementById("productImg");
    const smallImg = document.getElementsByClassName("small-img");

    smallImg[0].onclick = function () {
        productImg.src = smallImg[0].src;
    }
    smallImg[1].onclick = function () {
        productImg.src = smallImg[1].src;
    }
    smallImg[2].onclick = function () {
        productImg.src = smallImg[2].src;
    }
    smallImg[3].onclick = function () {
        productImg.src = smallImg[3].src;
    }

</script>

<script>
    function addToCart() {
        var quantity = document.getElementById("quantity").value;


        var url = "sendInfoCart?product_name=<%= request.getAttribute("product_name") %>&price=<%= request.getAttribute("price") %>&image=<%= request.getAttribute("image") %>&quantity=" + quantity;

        var xhr = new XMLHttpRequest();
        xhr.open("GET", url, true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                console.log(xhr.responseText);
            }
        };
        xhr.send();
    }
</script>

<script>
    updateCartIcon();
</script>

</body>
</html>
<%
    } else {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
%>