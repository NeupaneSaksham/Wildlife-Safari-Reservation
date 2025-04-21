<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Wildlife Safari Adventure</title>
  <link rel="stylesheet" href="css/home.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

<!-- Header -->
<header>
  <img src="assets/BanYatraLogo.png" alt="Logo" />
  <nav class="nav-wrapper">
    <div class="nav-center">
      <a href="./index.jsp" class="active">Home</a>
      <a href="view/pages/packages.jsp">Packages</a>
      <a href="view/pages/reservation.jsp">Reserve Now</a>
      <a href="view/pages/aboutUs.jsp">About Us</a>
    </div>
    <div class="nav-right">
      <a href="login.jsp" style="background-color: #D2D2D2; color: black ">Login</a>
      <a href="signup.jsp">Signup</a>
    </div>
  </nav>
</header>


<!-- Hero Section with Background Image -->
<div class="hero">
  <div class="hero-text">
    <h1>Wildlife Safari Awaits</h1>
    <p>Step into the heart of the jungle. Witness the raw beauty of nature and its wild inhabitants on our immersive safari experiences.</p>
    <a href="view/pages/reservation.jsp">Book Now</a>
  </div>
</div>

<!-- Gallery -->
<div class="gallery">
  <h2>Gallery Highlights</h2>
  <div class="gallery-grid">
    <img src="assets/elephant.jpg" alt="Elephant">
    <img src="assets/leopard.jpg" alt="Leopard on a Tree">
    <img src="assets/rhino.jpg" alt="Rhino">
    <img src="assets/deer.webp" alt="Deer">
    <img src="assets/bird.jpg" alt="Bird">
    <img src="assets/safari.jpg" alt="Safari Adventure">
  </div>
</div>

<!-- Testimonials -->
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

<!-- FAQ Section -->
<section class="faq">
  <h2>Frequently Asked Questions</h2>
  <div class="faq-container">

    <div class="faq-item">
      <div class="faq-question">
        <h3>What should I bring on a wildlife safari?</h3>
        <i class="fas fa-chevron-down arrow-icon"></i>
      </div>
      <div class="faq-answer">
        <p>We recommend bringing binoculars, a camera, light clothing, sunscreen, insect repellent, and sturdy shoes.</p>
      </div>
    </div>

    <div class="faq-item">
      <div class="faq-question">
        <h3>Are safaris safe for children and elders?</h3>
        <i class="fas fa-chevron-down arrow-icon"></i>
      </div>
      <div class="faq-answer">
        <p>Yes, our safaris are family-friendly and designed to ensure safety and comfort for all age groups.</p>
      </div>
    </div>

    <div class="faq-item">
      <div class="faq-question">
        <h3>When is the best time to go on a safari?</h3>
        <i class="fas fa-chevron-down arrow-icon"></i>
      </div>
      <div class="faq-answer">
        <p>The best time is during the dry seasons (October to March), when animals are easier to spot near water sources.</p>
      </div>
    </div>

    <div class="faq-item">
      <div class="faq-question">
        <h3>How do I make a reservation?</h3>
        <i class="fas fa-chevron-down arrow-icon"></i>
      </div>
      <div class="faq-answer">
        <p>Simply visit our <a href="view/reservation.jsp">reservation page</a>, fill out the form, and you’ll get a confirmation via email.</p>
      </div>
    </div>

  </div>
</section>

<!-- Footer -->
<footer>
  <div class="footer-column">
    <h4>Ban Yatra</h4>
    <p>Discover the unseen. Embrace the wild. Join us for unforgettable adventures.</p>
  </div>

  <div class="footer-column">
    <h4>Quick Links</h4>
    <a href="./index.jsp">Home</a>
    <a href="view/pages/packages.jsp">Packages</a>
    <a href="view/pages/reservation.jsp">Reserve Now</a>
    <a href="view/pages/aboutUs.jsp">About Us</a>
  </div>

  <div class="footer-column">
    <h4>Contact & Socials</h4>
    <p>Email: contact@wildlifetours.com</p>
    <p>Phone: +977-9800000000</p>
    <div class="footer-socials">
      <a href="#"><i class="fab fa-facebook-f"></i></a>
      <a href="#"><i class="fab fa-instagram"></i></a>
      <a href="#"><i class="fab fa-twitter"></i></a>
      <a href="#"><i class="fab fa-youtube"></i></a>
    </div>
  </div>

  <div class="footer-bottom">
    &copy; 2025 WildLife Tours. All rights reserved.
  </div>
</footer>

<script>
  const faqItems = document.querySelectorAll('.faq-item');

  faqItems.forEach(item => {
    const question = item.querySelector('.faq-question');

    question.addEventListener('click', () => {
      item.classList.toggle('active');
    });
  });
</script>
</body>
</html>
