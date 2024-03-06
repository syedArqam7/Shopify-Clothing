<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Outfitters</title>

    <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">
    <link rel="stylesheet" href="styleSgnUpReg.css">
</head>
<body>

<div class="main">
    <section class="signup">
        <div class="container">
            <div class="signup-content">
                <div class="signup-form">
                    <h2 class="form-title">Sign up</h2>

                    <form method="post" action="signUp" class="register-form"
                          id="register-form" onsubmit="return validateForm()">
                        <div class="form-group">
                            <label for="name"><i
                                    class="zmdi zmdi-account material-icons-name"></i></label> <input
                                type="text" name="name" id="name" placeholder="Your Name" />
                        </div>
                        <div class="form-group">
                            <label for="email"><i class="zmdi zmdi-email"></i></label> <input
                                type="email" name="email" id="email" placeholder="Your Email" />
                        </div>
                        <div class="form-group">
                            <label for="pass"><i class="zmdi zmdi-lock"></i></label> <input
                                type="password" name="pass" id="pass" placeholder="Password" />
                        </div>
                        <div class="form-group">
                            <label for="re_pass"><i class="zmdi zmdi-lock-outline"></i></label>
                            <input type="password" name="re_pass" id="re_pass"
                                   placeholder="Repeat your password" />
                        </div>
                        <div class="form-group">
                            <label for="contact"><i class="zmdi zmdi-account material-icons-name"></i></label>
                            <input type="text" name="contact" id="contact"
                                   placeholder="Contact no" />
                        </div>
                        <div class="form-group">
                            <label for="address"><i class="zmdi zmdi-pin"></i></label>
                            <input type="text" name="address" id="address" placeholder="Your Address" />
                        </div>
                        <div class="form-group">
                            <input type="checkbox" name="agree-term" id="agree-term"
                                   class="agree-term" /> <label for="agree-term" class="label-agree-term"><span><span></span></span>I
                            agree to all statements in <a href="#" class="term-service">Terms
                                of service</a></label>
                        </div>
                        <div class="form-group form-button">
                            <input type="submit" name="signup" id="signup"
                                   class="form-submit" value="Register"/>
                        </div>
                    </form>
                </div>
                <div class="signup-image">
                    <figure>
                        <img src="5-removebg-preview.png" alt="sing up image">
                    </figure>
                    <a href="loginPage" class="signup-image-link">Already a
                        member</a>
                </div>
            </div>
        </div>
    </section>


</div>`a
<!-- JS -->

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script src="js/main.js"></script>

<script>
    function validateForm(message) {
        var name = document.getElementById("name").value;
        var email = document.getElementById("email").value;
        var password = document.getElementById("pass").value;
        var rePass = document.getElementById("re_pass").value;
        var contact = document.getElementById("contact").value;
        var address = document.getElementById("address").value;

        var validations = [
            { isValid: name.trim() !== '' || email.trim() !== '' || password.trim() !== '' || rePass.trim() !== '' || contact.trim() !== '' || address.trim() !== '', message: 'Please fill in all fields.' },
            { isValid: email.includes('@') && email.includes('.com'), message: 'Please enter a valid email address. [_____@_____.com]' },
            { isValid: password.length >= 6 && /[A-Z]/.test(password), message: 'Password must be at least 6 characters long and contain at least one capital letter.' },
            { isValid: rePass === password, message: "Passwords don't match. Please make sure your passwords match." },
            { isValid: /^\d{10,14}$/.test(contact), message: 'Contact number should only include numbers and have a length of at least 10 digits.' },
            { isValid: email.includes('@') && email.includes('.com') || password.length >= 6 && /[A-Z]/.test(password) || /^\d{10,}$/.test(contact) , message: 'Please check your credentials'}
        ];

        var validationFailed = false;

        for (var i = 0; i < validations.length; i++) {
            if (!validations[i].isValid) {
                Swal.fire({
                    icon: 'error',
                    title: 'Validation Error',
                    text: validations[i].message,
                });
                validationFailed = true;
                break;
            }
        }

        if (validationFailed) {
            return false;
        }

        document.getElementById("signup").removeAttribute("disabled");
        Swal.fire({
            icon: 'success',
            title: 'Success!',
            text: message,
            showConfirmButton: false,
            timer: 3000
        });
        return true;
    }



    function isValidEmail(email) {
        return email.includes('@') && email.includes('.com');
    }

    function isValidPassword(password) {
        return password.length >= 6 && /[A-Z]/.test(password);
    }

    function isValidContact(contact) {
        return /^\d{10,}$/.test(contact);
    }
</script>


</body>
</html>