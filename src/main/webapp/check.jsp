<%@ page contentType="text/html;charset=UTF-8" %>
<%
    Integer customerID = (Integer) session.getAttribute("customerID");
    if (customerID != null && customerID > 0) {
%>
<html>
<head>
    <title>Outfitter</title>

    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.7/css/all.css" />
    <link rel="stylesheet" href="check.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.4.2/css/fontawesome.min.css">

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
        <div class="homePageContent">
            <h1>Discover Your Style</h1>
            <p>A specialist label creating luxury essentials.</p>
            <p1>Ethically crafted with an unwavering commitment to exceptional quality.</p1>
            <div>
                <button  type="button" class="shopNowButton" ><span></span><a href="Product" style="text-decoration: none; color: black">SHOP NOW</a></button>
            </div>
        </div>
    </div>

<!-- Featured Products -->

    <div class="small-container">
        <h2 class="featuredTitle">Featured Products</h2>
        <div class="row">
            <div class="col-4">
                <img src="productImages/1.jpg" alt="">
                <h4>Red T-shirt</h4>
                <p> $50.0</p>
            </div>
            <div class="col-4">
                <img src="productImages/3.jpg" alt="">
                <h4>Blue T-shirt</h4>
                <p> $45.0</p>
            </div>
            <div class="col-4">
                <img src="productImages/2.jpg" alt="">
                <h4>Black T-shirt</h4>
                <p> $30.0</p>
            </div>
        </div>
    </div>

<!-- Exclusive -->
    <div class="exclusive">
        <div class="small-container">
            <div class="row">
                <div class="col-2">
                    <img src="productImages/exclusive1.png" alt="" class="exclusive-img">
                </div>
                <div class="col-2">
                    <p>Exclusively Available</p>
                    <h1>Mi-Band 5</h1>
                    <h5>The Mi-Band 5 features a 30% larger AMOLED color full-touch display
                    compared to its predecessors, with adjustable brightness so everything is
                    clear as can be.</h5>
                </div>
            </div>
        </div>
    </div>

<!-- Testimonial -->
    <div class="testimonial">
        <div class="small-container">
            <div class="row">
                <div class="col-3">
                    <p>"This clothing website exceeded my expectations! The styles are effortlessly chic, and the quality of the fabrics is top-notch.
                        Each piece I ordered felt both fashionable and durable."</p>
                    <img src="images/user-1.png" alt="">
                    <img src="productImages/download-removebg-preview.png" alt="">
                    <h3>Sarah Colt</h3>
                </div>
                <div class="col-3">
                    <p>"Shopping on this website was a breeze – intuitive design and quick navigation.
                        I was pleasantly surprised by the speedy delivery, showcasing their commitment to a seamless customer experience."</p>
                    <img src="images/user-2.png" alt="">
                    <img src="productImages/download-removebg-preview.png" alt="">
                    <h3>Jason Smith</h3>
                </div>
                <div class="col-3">
                    <p>"Impressed with the swift delivery and exceptional service.
                        The personalized attention to customer queries reflects a brand that not only delivers trendy clothing but also values its customers' satisfaction."</p>
                    <img src="images/user-3.png" alt="">
                    <img src="productImages/download-removebg-preview.png" alt="">
                    <h3>Julia Parker</h3>
                </div>
            </div>
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