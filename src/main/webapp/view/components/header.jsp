<%--
  Created by IntelliJ IDEA.
  User: shaks
  Date: 4/19/2025
  Time: 10:51 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>header</title>
   <style>

       header {
           background-color: #fff;
           padding: 20px 50px;
           display: flex;
           justify-content: space-between;
           align-items: center;
           box-shadow: 0 2px 10px rgba(0,0,0,0.1);
       }

       header img {
           height: 60px;
       }
       /* Wrapper to handle center and right alignment */
       .nav-wrapper {
           display: flex;
           justify-content: center;
           align-items: center;
           flex: 1;
           gap: 40px;
           position: relative;
       }

       /* Centered navigation links */
       .nav-center {
           display: flex;
           align-items: center;
           gap: 25px;
       }

       /* Right-side login/signup */
       .nav-right {
           position: absolute;
           right: 0;
           display: flex;
           align-items: center;
           gap: 15px;
       }

       /* Common nav link styles */
       .nav-center a,
       .nav-right a {
           color: #000;
           text-decoration: none;
           font-size: 1.1rem;
           padding-bottom: 5px;
           border-bottom: 2px solid transparent;
           transition: border-color 0.3s ease, color 0.3s ease;
       }

       .nav-center a:hover,
       .nav-right a:hover {
           color: #FF9149;
           border-bottom: 2px solid #FF9149;
       }

       .nav-center a.active {
           color: #FF9149;
           border-bottom: 2px solid #FF9149;
       }

       /* Styling login/signup as buttons */
       .nav-right a {
           background-color: #FF9149;
           color: white;
           padding: 8px 16px;
           border-radius: 6px;
           border: 2px solid transparent;
       }

       .nav-right a:hover {
           background-color: #e77e32;
           color: white;
           border-color: white;
       }
   </style>
</head>
<body>
<img src="../../assets/BanYatraLogo.png" alt="Logo" />
<nav class="nav-wrapper">
    <div class="nav-center">
        <a href="../../index.jsp" class="active">Home</a>
        <a href="../pages/packages.jsp">Packages</a>
        <a href="../pages/reservation.jsp">Reserve Now</a>
        <a href="../pages/aboutUs.jsp">About Us</a>
    </div>
    <div class="nav-right">
        <a href="login.jsp" style="background-color: #D2D2D2; color: black ">Login</a>
        <a href="signup.jsp">Signup</a>
    </div>
</nav>
</body>
</html>
