<%@ page contentType="text/html;charset=UTF-8" %>
<%
    int customerID = (Integer) session.getAttribute("customerID");

    if ( customerID > 0) {
%>
<html lang="en">
<head>
    <title>Outfitters</title>
    <link rel="stylesheet" href="style.css">
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

<!-- Products -->

<div class="small-container">

    <div class="row row-2">
        <h2>All Products</h2>
        <form action="default" method="get">
            <select name="" id="">
                <option value="default">Default</option>
                <option value="">Sort By Date</option>
                <option value="">Sort By Price</option>
                <option value="">Sort By Popularity</option>
            </select>
            <input type="submit" value="Sort">
        </form>
    </div>


    <div class="row">
        <%
            int productIndex = 1;
            while (true) {
                String productNameAttribute = "product_name_" + productIndex;
                String priceAttribute = "price_" + productIndex;
                String imageAttribute = "image_" + productIndex;

                String productName = (String) request.getAttribute(productNameAttribute);
                Double price = (Double) request.getAttribute(priceAttribute);
                String imageFileName = (String) request.getAttribute(imageAttribute);

                if (productName == null || price == null || imageFileName == null ) {
                    break;
                }
        %>
        <div class="col-4">
            <img src="<%= imageFileName%>" alt="">
            <h4><a href="singleProductServlet?product_name=<%= productName%>" style="color: #555; font-weight: bold; text-decoration: none"><%= productName %></a></h4>
            <p>$<%= price %></p>
        </div>
        <%
            productIndex++;
            if (productIndex % 4 == 1) {
        %>
    </div>
    <div class="row">
        <%
                }
                if (productIndex > 25) {
                    break;
                }
            }
        %>
    </div>
</div>

<!-- Footer -->
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