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
    <title>footer</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        footer {
            background-color: #111;
            color: #ccc;
            padding: 60px 40px;
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 40px;
        }

        .footer-column {
            flex: 1 1 250px;
        }

        .footer-column a {
            color: #aaa;
            font-size: 0.95rem;
            margin-bottom: 12px;
            text-decoration: none;
            transition: color 0.3s ease;
            display: block;
        }

        .footer-column h4 {
            color: #FF9149;
            font-size: 1.3rem;
            margin-bottom: 20px;
        }

        .footer-column p,
        .footer-column a {
            color: #aaa;
            font-size: 0.95rem;
            margin-bottom: 12px;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer-column a:hover {
            color: #FF9149;
        }

        .footer-bottom {
            width: 100%;
            text-align: center;
            margin-top: 40px;
            font-size: 0.85rem;
            color: #666;
            border-top: 1px solid #333;
            padding-top: 20px;
        }

        .footer-socials {
            display: flex;
            gap: 15px;
            margin-top: 15px;
        }

        .footer-socials a {
            color: #aaa;
            font-size: 1.3rem;
            transition: color 0.3s ease;
        }

        .footer-socials a:hover {
            color: #FF9149;
        }

        /* Responsive */
        @media (max-width: 768px) {
            footer {
                flex-direction: column;
                align-items: flex-start;
            }

            .footer-bottom {
                text-align: left;
            }
        }
    </style>
</head>
<body>

<div class="footer-column">
    <h4>Ban Yatra</h4>
    <p>Discover the unseen. Embrace the wild. Join us for unforgettable adventures.</p>
</div>

<div class="footer-column">
    <h4>Quick Links</h4>
    <a href="../../index.jsp">Home</a>
    <a href="../pages/packages.jsp">Packages</a>
    <a href="../pages/reservation.jsp">Reserve Now</a>
    <a href="../pages/aboutUs.jsp">About Us</a>
</div>

<div class="footer-column">
    <h4>Contact & Socials</h4>
    <p>Email: contact@wildlifetours.com</p>
    <p>Phone: +977-9800000000</p>
    <div class="footer-socials">
        <a><i class="fab fa-facebook-f"></i></a>
        <a><i class="fab fa-instagram"></i></a>
        <a><i class="fab fa-twitter"></i></a>
        <a><i class="fab fa-youtube"></i></a>
    </div>
</div>

<div class="footer-bottom">
    &copy; 2025 Ban Yatra. All rights reserved.
</div>
</body>
</html>
