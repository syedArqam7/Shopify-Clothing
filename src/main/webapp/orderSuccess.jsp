<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    int customerID = (Integer) session.getAttribute("customerID");

    if (customerID > 0) {
%>
<html lang="en">
<head>
    <title>Outfitters</title>
    <link rel="stylesheet" href="styleSingleProd.css">
</head>
<body>

<!-- Home Page -->
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

<!-- Cart Items -->
<div class="small-container cartpage">
    <h2>Order Receipt</h2>
    <table>
        <tr>
            <th>Product</th>
            <th>Quantity</th>
            <th>Product Total</th>
            <th>Status</th>
        </tr>
        <%
            HttpSession sessions = request.getSession(true);
            List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("orderDetails");
            double total = 0;
            Map<String, Object> cartItem = null;
            if (cart != null) {
                for (int i = 0; i < cart.size(); i++) {
                    cartItem = cart.get(i);
                    total += (double) cartItem.get("subtotal");
        %>
        <tr>
            <td>
                <div class="cartInfo">
                    <img src="productImages/<%=cartItem.get("image")%>" alt="">
                    <div>
                        <p><%=cartItem.get("productName")%></p>
                        <small>Price: $<%=cartItem.get("price")%></small>
                        <br>
                        <br>
                        <a href="<%=request.getContextPath()%>/RemoveFromCart?index=<%=i%>">Remove</a>
                    </div>
                </div>
            </td>
            <td><input type="number" value="<%=cartItem.get("quantity")%>"></td>
            <td>$<%=cartItem.get("subtotal")%></td>
            <td><button class="status-button" style="background-color: green; color: white;">Ordered</button></td>
        </tr>
        <%
                }
            }
            request.setAttribute("customerID", customerID);
            request.setAttribute("cartItems", cart);
            request.setAttribute("total", total);
            assert cartItem != null;%>
    </table>

    <div class="totalPrice">
        <table>
            <tr>
                <td>Total</td>
                <td>$<%=total%></td>
            </tr>
        </table>
    </div>
    <a href="check.jsp" class="btn place-order-btn">Back To Home</a>
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

</body>
</html>
<%
    } else {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
%>