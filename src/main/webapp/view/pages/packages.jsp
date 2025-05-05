<%--
  Created by IntelliJ IDEA.
  User: shaks
  Date: 4/18/2025
  Time: 8:23 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Packages</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/packages.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>


<header>
    <img src="${pageContext.request.contextPath}/assets/BanYatraLogo.png" alt="Logo" />
    <nav class="nav-wrapper">
        <div class="nav-center">
            <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
            <a href="${pageContext.request.contextPath}/view/pages/packages.jsp" class="active">Packages</a>
            <a href="${pageContext.request.contextPath}/view/pages/reservation.jsp">Reserve Now</a>
            <a href="${pageContext.request.contextPath}/view/pages/aboutUs.jsp">About Us</a>
        </div>
        <div class="nav-right">
            <a href="${pageContext.request.contextPath}/logout" style="background-color:#ff5858; color:white;">Logout</a>

            <a href="${pageContext.request.contextPath}/view/pages/profile.jsp" class="profile-link">
                <i class="fas fa-user"></i>
                <span>Profile</span>
            </a>
        </div>
    </nav>
</header>

<div class="page-title">
    <h2>Our Safari Packages</h2>
    <h3>Discover the Wild with Our Exclusive Tours</h3>
</div>

<div class="packages-container">
    <!-- Package 1: Chitwan -->
    <div class="package-card">
        <div class="package-image">
            <img src="https://i.pinimg.com/736x/ef/4a/43/ef4a4340254431bcec6bd9ea3ff33a03.jpg" alt="Chitwan Safari">
        </div>
        <div class="card-content">
            <h4>Chitwan Jungle Safari</h4>
            <p class="desc">Experience the thrill of spotting rhinos and tigers in their natural habitat at Chitwan National Park.</p>
            <div class="button-group">
                <button class="btn btn-view" onclick="openModal('chitwan')">View Details</button>
                <button class="btn btn-book" onclick="openModal('booking')">Book Now</button>
            </div>
        </div>
    </div>

    <!-- Package 2: Bardia -->
    <div class="package-card">
        <div class="package-image">
            <img src="https://images.unsplash.com/photo-1466721591366-2d5fba72006d" alt="Bardia Wildlife">
        </div>
        <div class="card-content">
            <h4>Bardia Wildlife Expedition</h4>
            <p class="desc">Explore the untouched wilderness of Bardia National Park and its diverse wildlife.</p>
            <div class="button-group">
                <button class="btn btn-view" onclick="openModal('bardia')">View Details</button>
                <button class="btn btn-book" onclick="openModal('booking')">Book Now</button>
            </div>
        </div>
    </div>

    <!-- Package 3: Koshi Tappu -->
    <div class="package-card">
        <div class="package-image">
            <img src="https://i.pinimg.com/736x/48/d8/c7/48d8c7a9b5c1f742f03f55538a39f5ca.jpg" alt="Koshi Tappu">
        </div>
        <div class="card-content">
            <h4>Koshi Tappu Birdwatching</h4>
            <p class="desc">A paradise for bird enthusiasts with over 500 species of birds in their natural habitat.</p>
            <div class="button-group">
                <button class="btn btn-view" onclick="openModal('koshi')">View Details</button>
                <button class="btn btn-book" onclick="openModal('booking')">Book Now</button>
            </div>
        </div>
    </div>

    <!-- Package 4: Shuklaphanta -->
    <div class="package-card">
        <div class="package-image">
            <img src="https://images.unsplash.com/photo-1485833077593-4278bba3f11f" alt="Shuklaphanta Wildlife">
        </div>
        <div class="card-content">
            <h4>Shuklaphanta Grassland Safari</h4>
            <p class="desc">Discover the beauty of Nepal's largest grassland ecosystem and its unique wildlife.</p>
            <div class="button-group">
                <button class="btn btn-view" onclick="openModal('shuklaphanta')">View Details</button>
                <button class="btn btn-book" onclick="openModal('booking')">Book Now</button>
            </div>
        </div>
    </div>

    <!-- Package 5: Dhorpatan -->
    <div class="package-card">
        <div class="package-image">
            <img src="https://i.pinimg.com/736x/38/1b/fb/381bfb76d368c5b4128e29d279721d3c.jpg" alt="Dhorpatan Reserve">
        </div>
        <div class="card-content">
            <h4>Dhorpatan Hunting Reserve Trek</h4>
            <p class="desc">Trek through Nepal's only hunting reserve and witness the majestic blue sheep.</p>
            <div class="button-group">
                <button class="btn btn-view" onclick="openModal('dhorpatan')">View Details</button>
                <button class="btn btn-book" onclick="openModal('booking')">Book Now</button>
            </div>
        </div>
    </div>

    <!-- Package 6: Annapurna -->
    <div class="package-card">
        <div class="package-image">
            <img src="https://i.pinimg.com/736x/05/cf/2c/05cf2ce67822932d84b219020fbad329.jpg" alt="Annapurna Trek">
        </div>
        <div class="card-content">
            <h4>Annapurna Wildlife Trek</h4>
            <p class="desc">Experience the diverse wildlife of the Annapurna region while trekking through stunning landscapes.</p>
            <div class="button-group">
                <button class="btn btn-view" onclick="openModal('annapurna')">View Details</button>
                <button class="btn btn-book" onclick="openModal('booking')">Book Now</button>
            </div>
        </div>
    </div>
</div>

<!-- View Details Modals -->
<div id="chitwan" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal('chitwan')">&times;</span>
        <img src="https://i.pinimg.com/736x/ef/4a/43/ef4a4340254431bcec6bd9ea3ff33a03.jpg" alt="Chitwan National Park">
        <h3>Chitwan Jungle Safari</h3>
        <p>Embark on a 3-day adventure into the heart of Chitwan National Park. Experience:</p>
        <ul>
            <li>Elephant-back safaris through dense jungle</li>
            <li>Canoe rides on the Rapti River</li>
            <li>Cultural performances by the Tharu community</li>
            <li>Guided nature walks and bird watching</li>
            <li>Chance to spot one-horned rhinos and Bengal tigers</li>
        </ul>

    </div>
</div>

<!-- Similar modal structure for other packages -->
<div id="bardia" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal('bardia')">&times;</span>
        <img src="https://images.unsplash.com/photo-1466721591366-2d5fba72006d" alt="Bardia National Park">
        <h3>Bardia Wildlife Expedition</h3>
        <p>Discover the untouched wilderness of Bardia National Park. Highlights include:</p>
        <ul>
            <li>Jeep safaris to spot tigers and rhinos</li>
            <li>Guided jungle walks with expert naturalists</li>
            <li>Bird watching tours to see diverse avian species</li>
            <li>Cultural experiences with local Tharu communities</li>
            <li>Tranquil boat rides on the Karnali River</li>
        </ul>
    </div>
</div>

<div id="koshi" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal('koshi')">&times;</span>
        <img src="https://i.pinimg.com/736x/48/d8/c7/48d8c7a9b5c1f742f03f55538a39f5ca.jpg" alt="Koshi Tappu Wildlife Reserve">
        <h3>Koshi Tappu Birdwatching</h3>
        <p>Explore the avian paradise of Koshi Tappu Wildlife Reserve. Key activities:</p>
        <ul>
            <li>Guided birdwatching tours with experienced ornithologists</li>
            <li>Boat trips on the Koshi River to spot migratory birds</li>
            <li>Nature walks through wetlands and grasslands</li>
            <li>Opportunities to see endangered species like the Bengal florican</li>
            <li>Cultural visits to nearby villages</li>
        </ul>

    </div>
</div>

<div id="shuklaphanta" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal('shuklaphanta')">&times;</span>
        <img src="https://images.unsplash.com/photo-1485833077593-4278bba3f11f" alt="Shuklaphanta National Park">
        <h3>Shuklaphanta Grassland Safari</h3>
        <p>Experience the unique grassland ecosystem of Shuklaphanta National Park. Highlights:</p>
        <ul>
            <li>Jeep safaris through vast grasslands</li>
            <li>Opportunities to see swamp deer and tigers</li>
            <li>Birdwatching tours to spot various grassland species</li>
            <li>Guided nature walks with local guides</li>
            <li>Cultural immersion with local communities</li>
        </ul>

    </div>
</div>

<div id="dhorpatan" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal('dhorpatan')">&times;</span>
        <img src="https://i.pinimg.com/736x/38/1b/fb/381bfb76d368c5b4128e29d279721d3c.jpg" alt="Dhorpatan Hunting Reserve">
        <h3>Dhorpatan Hunting Reserve Trek</h3>
        <p>Trek through Nepal's only hunting reserve and witness the majestic blue sheep. Key features:</p>
        <ul>
            <li>Guided treks through remote mountain landscapes</li>
            <li>Opportunities to see blue sheep and other wildlife</li>
            <li>Cultural interactions with local communities</li>
            <li>Stunning views of the Himalayas</li>
            <li>Unique trekking experience in a restricted area</li>
        </ul>

    </div>
</div>

<div id="annapurna" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal('annapurna')">&times;</span>
        <img src="https://i.pinimg.com/736x/05/cf/2c/05cf2ce67822932d84b219020fbad329.jpg" alt="Annapurna Conservation Area">
        <h3>Annapurna Wildlife Trek</h3>
        <p>Experience the diverse wildlife of the Annapurna region while trekking through stunning landscapes. Highlights:</p>
        <ul>
            <li>Trekking through diverse ecosystems</li>
            <li>Opportunities to see various wildlife species</li>
            <li>Stunning views of the Annapurna range</li>
            <li>Cultural experiences with local communities</li>
            <li>Guided treks with experienced guides</li>
        </ul>
    </div>
</div>

<!-- Booking Modal -->
<div id="booking" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal('booking')">&times;</span>
        <h3>Book Your Safari Adventure</h3>
        <form id="bookingForm" onsubmit="handleSubmit(event)">
            <div class="form-group">
                <label for="name">Full Name</label>
                <input type="text" id="name" required placeholder="Enter your full name">
            </div>

            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" required placeholder="Enter your email">
            </div>

            <div class="form-group">
                <label for="package">Select Package</label>
                <select id="package" required>
                    <option value="">Choose a package...</option>
                    <option value="chitwan">Chitwan Jungle Safari</option>
                    <option value="bardia">Bardia Wildlife Expedition</option>
                    <option value="koshi">Koshi Tappu Birdwatching</option>
                    <option value="shuklaphanta">Shuklaphanta Grassland Safari</option>
                    <option value="dhorpatan">Dhorpatan Hunting Reserve Trek</option>
                    <option value="annapurna">Annapurna Wildlife Trek</option>
                </select>
            </div>

            <div class="form-group">
                <label for="date">Preferred Date</label>
                <input type="date" id="date" required min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
            </div>

            <div class="form-group">
                <label for="guests">Number of Guests</label>
                <input type="number" id="guests" required min="1" max="10" placeholder="Number of guests">
            </div>

            <button type="submit" class="btn btn-book">Submit Booking</button>
        </form>
    </div>
</div>

<footer>
    <div class="footer-column">
        <h4>Ban Yatra</h4>
        <p>Discover the unseen. Embrace the wild. Join us for unforgettable adventures.</p>
    </div>

    <div class="footer-column">
        <h4>Quick Links</h4>
        <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
        <a href="${pageContext.request.contextPath}/view/pages/packages.jsp">Packages</a>
        <a href="${pageContext.request.contextPath}/view/pages/reservation.jsp">Reserve Now</a>
        <a href="${pageContext.request.contextPath}/view/pages/aboutUs.jsp">About Us</a>
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
    function openModal(id) {
        document.getElementById(id).style.display = "block";
        document.body.style.overflow = "hidden";
    }

    function closeModal(id) {
        document.getElementById(id).style.display = "none";
        document.body.style.overflow = "auto";
    }

    // Close modal when clicking outside
    window.onclick = function(event) {
        if (event.target.classList.contains('modal')) {
            event.target.style.display = "none";
            document.body.style.overflow = "auto";
        }
    }

    function handleSubmit(event) {
        event.preventDefault();

        // Get form values
        const name = document.getElementById('name').value;
        const email = document.getElementById('email').value;
        const packageType = document.getElementById('package').value;
        const date = document.getElementById('date').value;
        const guests = document.getElementById('guests').value;

        // Here you would typically send this data to your server
        alert(`Thank you for your booking request!\n\nWe will contact you at ${email} to confirm your ${packageType} safari for ${guests} guests on ${date}.`);

        // Close the modal and reset form
        closeModal('booking');
        document.getElementById('bookingForm').reset();
    }

    // Add escape key listener for modals
    document.addEventListener('keydown', function(event) {
        if (event.key === "Escape") {
            const modals = document.getElementsByClassName('modal');
            for (let modal of modals) {
                if (modal.style.display === "block") {
                    modal.style.display = "none";
                    document.body.style.overflow = "auto";
                }
            }
        }
    });
</script>

</body>
</html>
