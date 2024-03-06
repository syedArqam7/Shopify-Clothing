<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Outfitters</title>

  <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">
  <link rel="stylesheet" href="styleSignup.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">

  <style>
    .popup {
      display: none;
      position: fixed;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      padding: 20px;
      background-color: #fff;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      border-radius: 15px;
      z-index: 1000;
    }
  </style>

</head>
<body>

<div class="main">
  <section class="sign-in">
    <div class="container">
      <div class="signin-content">
        <div class="signin-image">
          <figure>
            <img src="5-removebg-preview.png" alt="sing up image">
          </figure>
          <a href="signUpAccount" class="signup-image-link">Create an
            account</a>
        </div>

        <div class="signin-form">
          <h2 class="form-title">Sign In</h2>
          <form method="post" action="loginHome" class="register-form"
                id="login-form">
            <div class="form-group">
              <label for="username"><i
                      class="zmdi zmdi-account material-icons-name"></i></label> <input
                    type="text" name="username" id="username"
                    placeholder="Your Name" />
            </div>
            <div class="form-group">
              <label for="password"><i class="zmdi zmdi-lock"></i></label> <input
                    type="password" name="password" id="password"
                    placeholder="Password" />
            </div>
            <div class="form-group form-button">
              <input type="submit" name="signin" id="signin"
                     class="form-submit" value="Log in" />
            </div>
          </form>

        </div>
      </div>
    </div>
  </section>


  <div id="loginSuccessPopup" class="popup">
    <p style="color: green; text-align: center;">Login successful. Welcome!</p>
  </div>

  <div id="loginFailedPopup" class="popup">
    <p style="color: red; text-align: center;">Invalid credentials. Please try again.</p>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

  <script src="js/main.js"></script>
  <script>
    const loginSuccess = '<%= request.getAttribute("loginSuccess") %>';
    if (loginSuccess === 'true') {
      document.getElementById('loginSuccessPopup').style.display = 'block';
      setTimeout(function () {
        document.getElementById('loginSuccessPopup').style.display = 'none';
        window.location.href = 'login.jsp';
      }, 3000);
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

</div>
</body>
</html>