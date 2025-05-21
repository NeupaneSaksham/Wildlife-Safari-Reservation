<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Experience Nepal's incredible wildlife in the Himalayan foothills and lush national parks">
  <title>BAN YATRA - Reserve Your Wildlife Safari </title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&family=Montserrat:wght@700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

  <style>
    :root {
      --primary: #fac8a7;
      --primary-dark: #388E3C;
      --secondary: #8BC34A;
      --accent: #FFC107;
      --light: #F8F9FA;
      --dark: #212529;
      --himalayan-blue: #1976D2;
      --cta-color: #FF9149; /* Color for Explore Tours button */
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Poppins', sans-serif;
      color: var(--dark);
      line-height: 1.6;
      overflow-x: hidden;
      background-color: #f5f5f5;
    }

    .hero {
      position: relative;
      height: 100vh;
      background: linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.5)),
      url('assets/landing.jpg');
      background-size: cover;
      background-position: center;
      background-attachment: fixed;
      display: flex;
      justify-content: center;
      align-items: center;
      text-align: center;
      color: white;
      padding: 0 20px;
    }

    .hero-content {
      max-width: 900px;
      animation: fadeIn 1.5s ease-in-out;
    }

    .hero-content h1 {
      font-family: 'Montserrat', sans-serif;
      font-size: clamp(2.5rem, 5vw, 4.5rem);
      font-weight: 700;
      margin-bottom: 25px;
      text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.6);
      line-height: 1.2;
    }

    .hero-content p {
      font-size: clamp(1rem, 2vw, 1.5rem);
      margin-bottom: 40px;
      text-shadow: 1px 1px 4px rgba(0, 0, 0, 0.5);
      max-width: 700px;
      margin-left: auto;
      margin-right: auto;
    }

    .cta-button {
      display: inline-block;
      padding: 16px 45px;
      font-size: 1.1rem;
      background-color: var(--cta-color); /* Updated button color */
      color: white;
      text-decoration: none;
      border-radius: 50px;
      transition: all 0.3s ease;
      font-weight: 600;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
      border: 2px solid var(--cta-color);
      text-transform: uppercase;
      letter-spacing: 1px;
    }

    .cta-button:hover {
      background-color: #FF7A29;
      transform: translateY(-3px);
      box-shadow: 0 6px 25px rgba(0, 0, 0, 0.4);
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }
  </style>
</head>
<body>

<!-- Hero Section -->
<div class="hero">
  <div class="hero-content">
    <h1>Discover Nepal's Wildlife</h1>
    <p>Journey through Wildlife Reserves forests to encounter rare wildlife in their natural habitat</p>
    <div class="cta-group">
      <a href="<%= request.getContextPath() + "/LoginServlet" %>" class="cta-button">
        Get Started <i class="fas fa-arrow-right"></i>
      </a>
    </div>
  </div>
</div>

<script>
  // Parallax effect
  window.addEventListener('scroll', function() {
    const scrollPosition = window.pageYOffset;
    const hero = document.querySelector('.hero');
    hero.style.backgroundPositionY = scrollPosition * 0.5 + 'px';
  });
</script>

</body>
</html>
