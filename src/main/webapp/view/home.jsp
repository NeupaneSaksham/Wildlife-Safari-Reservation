<%--
  Created by IntelliJ IDEA.
  User: shaks
  Date: 4/13/2025
  Time: 9:55 PM
  To change this template use File | Settings | File Templates.
--%><%-- Created by IntelliJ IDEA. User: shaks Date: 4/13/2025 --%>
<%-- Created by IntelliJ IDEA. User: shaks Date: 4/13/2025 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Wildlife Safari Adventure</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #fff;
            color: #000;
        }

        header {
            background-color: #fff;
            padding: 20px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        header img {
            height: 50px; /* Adjust logo size */
        }

        header h1 {
            color: #FF9149;
            font-size: 1.8rem;
            margin: 0;
        }

        nav a {
            color: #000;
            text-decoration: none;
            margin-left: 25px;
            font-size: 1rem;
            transition: color 0.3s ease;
        }

        nav a:hover {
            color: #FF9149;
        }

        .hero {
            display: flex;
            flex-direction: row;
            justify-content: space-between;
            align-items: center;
            padding: 50px;
            background-color: #fff;
            flex-wrap: wrap;
        }

        .hero-text {
            flex: 1;
            min-width: 300px;
            padding-right: 30px;
        }

        .hero-text h1 {
            font-size: 3rem;
            margin-bottom: 20px;
            color: #FF9149;
        }

        .hero-text p {
            font-size: 1.2rem;
            margin-bottom: 30px;
            line-height: 1.6;
        }

        .hero-text a {
            background-color: #FF9149;
            color: white;
            padding: 12px 24px;
            font-size: 1.1rem;
            text-decoration: none;
            border-radius: 8px;
            transition: background-color 0.3s ease;
        }

        .hero-text a:hover {
            background-color: #e77e32;
        }

        .hero-video {
            flex: 1;
            min-width: 300px;
        }

        .hero-video video {
            width: 100%;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0,0,0,0.6);
        }

        .gallery {
            background-color: #f4f4f4;
            color: #333;
            padding: 60px 20px;
            text-align: center;
        }

        .gallery h2 {
            font-size: 2.5rem;
            margin-bottom: 40px;
            color: #FF9149;
        }

        .gallery-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            max-width: 1000px;
            margin: 0 auto;
        }

        .gallery-grid img {
            width: 100%;
            height: 250px;
            object-fit: cover;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.2);
            transition: transform 0.3s ease;
        }

        .gallery-grid img:hover {
            transform: scale(1.05);
        }

        .testimonials {
            background-color: #fff;
            color: #000;
            padding: 60px 20px;
            text-align: center;
        }

        .testimonials h2 {
            font-size: 2.5rem;
            margin-bottom: 40px;
            color: #FF9149;
        }

        .testimonial-cards {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 30px;
            max-width: 1100px;
            margin: 0 auto;
        }

        .testimonial-card {
            background-color: #f4f4f4;
            border-radius: 12px;
            padding: 30px;
            max-width: 300px;
            box-shadow: 0 0 10px rgba(0,0,0,0.3);
        }

        .testimonial-card p {
            font-style: italic;
        }

        .testimonial-card .author {
            margin-top: 15px;
            font-weight: bold;
            color: #FF9149;
        }

        footer {
            background-color: #222;
            color: #aaa;
            text-align: center;
            padding: 20px;
        }

        @media (max-width: 768px) {
            .hero {
                flex-direction: column;
                padding: 30px 20px;
            }

            .hero-text {
                padding-right: 0;
                margin-bottom: 30px;
            }

            header {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }

            nav a {
                margin: 10px;
            }
        }
    </style>
</head>
<body>

<!-- Header -->
<header>
    <img src="assets/BanYatraLogo.png" alt="Ban Yatra Logo"> <!-- Logo -->
    <nav>
        <a href="home.jsp">Home</a>
        <a href="aboutUs.jsp">About Us</a>
        <a href="packages.jsp">Packages</a>
        <a href="contact.jsp">Contact</a>
        <a href="login.jsp">Login</a>
        <a href="signup.jsp">Signup</a>
    </nav>
</header>

<!-- Hero Section with Video -->
<div class="hero">
    <div class="hero-text">
        <h1>Wildlife Safari Awaits</h1>
        <p>Step into the heart of the jungle. Witness the raw beauty of nature and its wild inhabitants on our immersive safari experiences. Perfect for nature lovers, photographers, and adventurers.</p>
        <a href="reservation.jsp">Book Now</a>
    </div>
    <div class="hero-video">
        <video autoplay muted loop controls>
            <source src="safari-intro.mp4" type="video/mp4" />
            Your browser does not support the video tag.
        </video>
    </div>
</div>

<!-- Photo Gallery -->
<div class="gallery">
    <h2>Gallery Highlights</h2>
    <div class="gallery-grid">
        <img src="assets/elephant.jpg" alt="Elephant">
        <img src="assets/leopard.jpg" alt="Leopard on a Tree">
        <img src="assets/rhino.jpg" alt="Rhino">
        <img src="assets/deer.webp" alt="deer">
        <img src="assets/bird.jpg" alt="Bird">
        <img src="assets/safari.jpg" alt="Safari Adventure">
    </div>
</div>

<!-- Testimonials Section -->
<div class="testimonials">
    <h2>What Our Visitors Say</h2>
    <div class="testimonial-cards">
        <div class="testimonial-card">
            <p>"An unforgettable adventure! We saw lions, elephants, and even a leopard up close. Highly recommended!"</p>
            <p class="author">– Aayush Sharma</p>
        </div>
        <div class="testimonial-card">
            <p>"The guides were super knowledgeable and friendly. The safari felt safe and exciting from start to finish!"</p>
            <p class="author">– Sneha Thapa</p>
        </div>
        <div class="testimonial-card">
            <p>"Loved every minute of it. The photo opportunities were insane. I’ll definitely come back next year!"</p>
            <p class="author">– Ramesh Karki</p>
        </div>
    </div>
</div>

<!-- Footer -->
<footer>
    &copy; 2025 Ban Yatra Safari Adventures. All rights reserved.
</footer>

</body>
</html>

