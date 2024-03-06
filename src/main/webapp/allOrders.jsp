<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    int customerID = (Integer) session.getAttribute("customerID");

    if (customerID > 0) {
        // Retrieve all orders for the customer
        List<Map<String, Object>> allOrders = (List<Map<String, Object>>) session.getAttribute("allOrders");

        if (allOrders != null && !allOrders.isEmpty()) {
%>
<html lang="en">
<head>
    <title>Outfitters - All Orders</title>
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

<!-- All Orders -->
<div class="small-container cartpage">
    <h2>All Orders</h2>

    <table>
        <tr>
            <th>Order ID</th>
            <th>Order Date</th>
            <th>Total</th>
            <th>Order Status</th>
            <th>Products</th>
        </tr>
        <%
            for (Map<String, Object> order : allOrders) {
        %>
        <tr>
            <td><%= order.get("orderID") %></td>
            <td><%= order.get("orderDate") %></td>
            <td>$<%= order.get("total") %></td>
            <td><%= order.get("orderStatus") %></td>
            <td>
                <!-- Display products for each order -->
                <table>
                    <tr>
                        <th>Product</th>
                        <th>Quantity</th>
                        <th>Single-Price</th>
                    </tr>
                    <%
                        // Iterate through products in the order
                        List<Map<String, Object>> orderProducts = (List<Map<String, Object>>) order.get("products");
                        for (Map<String, Object> product : orderProducts) {
                    %>
                    <tr>
                        <td><%= product.get("productName") %></td>
                        <td><%= product.get("quantity") %></td>
                        <td>$<%= product.get("subtotal") %></td>
                    </tr>
                    <%
                        }
                    %>
                </table>
            </td>
        </tr>
        <%
            }
        %>
    </table>

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
            // No orders to display
            System.out.println("<p>No orders available.</p>");
        }
    } else {
        // Redirect if not logged in
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
%>