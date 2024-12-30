<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OTP Verification</title>
    <link rel="stylesheet" href="./OTPVerification.css">
</head>
<body>

    <div class="container">
        <div class="logo">
            <img src="<%= request.getContextPath()%>/Public/images/PlateraLogo-red.png" alt="Logo" width="50" height="50">
        </div>
        <h2>Check your email</h2>
        <p>An OTP has been sent to your email address: <strong>${email} </strong></p>
         <!-- Message Section -->
    <p style="color: #F12630; font-size: 0.95rem; margin-bottom: 20px;">
        Enter the OTP within <strong>2 minutes</strong>.
    </p>
        <form action="http://localhost:8080/Platera-Main/TwoFASignIn" method="POST">
            <input type="text" name="otp" placeholder="Enter OTP" required>
            <input type="hidden" name="email" value="${email}" /> 
            <input type="submit" value="Verify OTP">
        </form>
    </div>

</body>
</html>
