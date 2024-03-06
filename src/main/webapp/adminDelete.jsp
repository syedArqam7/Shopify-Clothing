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
          <h2 class="form-title">Delete</h2>

          <form method="post" action="Admin" class="register-form"
                id="register-form">
            <input type="hidden" name="action" value="deleteProduct">
            <div class="form-group">
              <label for="productID"></label>
              <input type="text" name="productID" id="productID" placeholder="Product ID" />
            </div>
            <div class="form-group form-button">
              <input type="submit" name="deleteProduct" id="deleteProduct" class="form-submit" value="Delete Product" />
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
    var productId = document.getElementById("productID").value;
    var validProductIds = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "23", "28", "29"];

    var validations = [
      { isValid: productId.trim() !== '', message: 'Please fill in all fields.' },
      { isValid: validProductIds.includes(productId), message: 'Please enter a valid Product ID.' },
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