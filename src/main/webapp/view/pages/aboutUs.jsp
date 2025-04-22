<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Ban Yatra</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/aboutUs.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>

<!-- Header Navigation -->

<header>
    <img src="${pageContext.request.contextPath}/assets/BanYatraLogo.png" alt="Logo" />
    <nav class="nav-wrapper">
        <div class="nav-center">
            <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
            <a href="${pageContext.request.contextPath}/view/pages/packages.jsp">Packages</a>
            <a href="${pageContext.request.contextPath}/view/pages/reservation.jsp" >Reserve Now</a>
            <a href="${pageContext.request.contextPath}/view/pages/aboutUs.jsp" class="active">About Us</a>
        </div>
        <div class="nav-right">
            <a href="${pageContext.request.contextPath}/view/pages/logout.jsp" style="background-color:#ff5858; color:white;">Logout</a>

            <a href="${pageContext.request.contextPath}/view/pages/profile.jsp" class="profile-link">
                <i class="fas fa-user"></i>
                <span>Profile</span>
            </a>
        </div>
    </nav>
</header>

<!-- Hero Banner Section -->
<div class="hero-banner" style="background-image: url('${pageContext.request.contextPath}/assets/safari-banner.jpg');">
    <h1>Ban Yatra</h1>
    <p>Your gateway to the nature,</p>
    <p>Where the jungle tells the story</p>
</div>

<!-- Our Focus Section -->
<section>
    <h2>Our Focus</h2>
    <p>At <strong>Ban Yatra</strong>, we believe in offering more than just a safari.
        It's a chance to step into the wild and experience nature up close.
        Our safaris are designed for everyone, whether you're a first-time adventurer or a seasoned traveler.
        With us, you can enjoy the beauty of untamed landscapes, witness incredible animals in their natural habitats, and feel the peace of the forest.
        We make sure every journey is safe, exciting, and unforgettable. Our goal is to create moments that stay with you, long after the journey ends.
        So come, join us on a safari adventure that connects you with nature like never before.</p>
</section>

<!-- Meet Our Wildlife Section -->
<section class="animals">
    <h2>Meet Our Wildlife</h2>
    <div class="animal-cards">
        <div class="animal-card">
            <img src="../../assets/tigers.png" alt="Tiger">
            <div class="info">
                <h3>Tiger</h3>
                <p>Tigers, found in Chitwan National Park and Bardia National Park, are apex predators in the wild. Their solitary nature and powerful hunting skills make them one of the most iconic animals of Nepal's protected areas.</p>
            </div>
        </div>

        <div class="animal-card">
            <img src="../../assets/elephant.jpg" alt="Elephant">
            <div class="info">
                <h3>Elephant</h3>
                <p>Elephants roam freely in the jungles of Chitwan and Bardia National Parks. Known for their intelligence and strong family bonds, these gentle giants are key figures in maintaining the ecological balance of their habitat.</p>
            </div>
        </div>

        <div class="animal-card">
            <img src="../../assets/gharial.png" alt="Gharial">
            <div class="info">
                <h3>Gharial</h3>
                <p>Found in the rivers of Bardiya National Park and Koshi Tappu Wildlife Reserve, gharials are unique fish-eating crocodiles. Their long, thin snouts make them adept hunters of fish, contributing to the natural control of aquatic ecosystems.</p>
            </div>
        </div>

        <div class="animal-card">
            <img src="../../assets/rhino.jpg" alt="Rhinoceros">
            <div class="info">
                <h3>Rhinoceros</h3>
                <p>Rhinos, especially the endangered one-horned variety, thrive in Chitwan National Park and Bardia National Park. These large herbivores play an important role in maintaining the ecosystem by grazing on grasses, helping shape the landscape.</p>
            </div>
        </div>

        <div class="animal-card">
            <img src="../../assets/black-stork.png" alt="Gharial">
            <div class="info">
                <h3>Black Stork</h3>
                <p>The Black Stork can be spotted in the Koshi Tappu Wildlife Reserve, where it migrates seasonally. This rare bird contributes to the rich biodiversity of the reserve, alongside other unique species such as the Indian wild buffalo and various waterfowl.</p>
            </div>
        </div>

        <div class="animal-card">
            <img src="../../assets/swamp-deer.png" alt="Swamp Deer">
            <div class="info">
                <h3>Swamp Deer</h3>
                <p>Swamp deer, or barasingha, are commonly found in Shuklaphanta Wildlife Reserve. These unique creatures, with their large antlers, thrive in wetland habitats, playing a crucial role in the balance of this fragile ecosystem.</p>
            </div>
        </div>

        <div class="animal-card">
            <img src="../../assets/himalayan-tahr.png" alt="Himalayan Tahr">
            <div class="info">
                <h3>Himalayan Tahr</h3>
                <p>Himalayan tahrs can be found in high-altitude areas like the Annapurna Conservation Area. Their remarkable climbing skills allow them to navigate rocky hills and alpine meadows, grazing on grasses and shrubs in these rugged regions.</p>
            </div>
        </div>

        <div class="animal-card">
            <img src="../../assets/red-panda.png" alt="Red Panda">
            <div class="info">
                <h3>Red Panda</h3>
                <p>Red pandas inhabit the forests of the Annapurna Conservation Area. These small, elusive creatures are often seen in the treetops, feeding on bamboo and playing an important role in maintaining forest health and biodiversity.</p>
            </div>
        </div>
    </div>
</section>

<!-- Explore Our Packages Section -->
<section class="animals">
    <h2>Explore Our Reservation Areas</h2>
    <div class="animal-cards">
        <div class="animal-card">
            <img src="../../assets/img.png" alt="Chitwan National Park">
            <div class="info">
                <h3>Chitwan National Park</h3>
                <p>Chitwan National Park, a UNESCO World Heritage site, is home to tigers, rhinos, and elephants. Visitors can enjoy jungle safaris, canoe rides, and birdwatching, making it one of Nepal's most popular wildlife destinations.</p>
            </div>
        </div>

        <div class="animal-card">
            <img src="../../assets/bardia.png" alt="Bardia National Park">
            <div class="info">
                <h3>Bardia National Park</h3>
                <p>Located in western Nepal, Bardia is a hidden gem for wildlife enthusiasts. It's home to tigers, elephants, and rare species like the gharial crocodile, offering a unique experience with jungle safaris and nature walks.</p>
            </div>
        </div>

        <div class="animal-card">
            <img src="../../assets/koshitappu.png" alt="Koshi Tappu Wildlife Reserve">
            <div class="info">
                <h3>Koshi Tappu Wildlife Reserve</h3>
                <p>Famous for birdwatching, Koshi Tappu hosts over 400 bird species, including the endangered Black Stork. The reserve is also home to aquatic wildlife, making it perfect for boat rides and tranquil wildlife observation.</p>
            </div>
        </div>

        <div class="animal-card">
            <img src="../../assets/suklapanta.png" alt="Shuklaphanta Wildlife Reserve">
            <div class="info">
                <h3>Shuklaphanta Wildlife Reserve</h3>
                <p>Shuklaphanta is renowned for its large population of swamp deer. It offers a unique experience in Nepal's western plains, with a diverse range of wildlife, including tigers and wild boars, in its pristine grasslands and wetlands.</p>
            </div>
        </div>

        <div class="animal-card">
            <img src="../../assets/image.png" alt="Dhorpatan Hunting Reserve">
            <div class="info">
                <h3>Dhorpatan Hunting Reserve</h3>
                <p>Dhorpatan is Nepal's only hunting reserve, located in the west. It offers a regulated environment for hunting select species and allows visitors to enjoy treks through alpine forests and meadows, observing wildlife such as Himalayan tahrs.</p>
            </div>
        </div>

        <div class="animal-card">
            <img src="../../assets/annapurna.jpg" alt="Annapurna Conservation Area">
            <div class="info">
                <h3>Annapurna Conservation Area</h3>
                <p>Annapurna Conservation Area offers a unique combination of trekking and wildlife viewing. Home to Himalayan tahrs, langurs, and pheasants, it's a haven for nature lovers with stunning views of snow-capped peaks.</p>
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
        <a href="../../index.jsp">Home</a>
        <a href="./packages.jsp">Packages</a>
        <a href="./reservation.jsp">Reserve Now</a>
        <a href="./aboutUs.jsp">About Us</a>
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

</body>
</html>