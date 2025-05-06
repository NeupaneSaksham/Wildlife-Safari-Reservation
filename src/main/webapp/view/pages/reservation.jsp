<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Safari Reservation | Ban Yatra</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reservation.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>

<header>
    <img src="${pageContext.request.contextPath}/assets/BanYatraLogo.png" alt="Logo" />
    <nav class="nav-wrapper">
        <div class="nav-center">
            <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
            <a href="${pageContext.request.contextPath}/view/pages/packages.jsp">Packages</a>
            <a href="${pageContext.request.contextPath}/view/pages/reservation.jsp" class="active">Reserve Now</a>
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

<div class="wrapper">
    <div class="image-container" style="flex: 1; background: url('${pageContext.request.contextPath}/assets/reservation.PNG') no-repeat center center; background-size: cover; min-height: 100%;"></div>
    <div class="form-container">
        <h2>Safari Reservation</h2>
        <form action="${pageContext.request.contextPath}/submitReservation.jsp" method="post">
            <label for="fullName">Full Name</label>
            <input type="text" id="fullName" name="fullName" required>

            <label for="email">Email</label>
            <input type="email" id="email" name="email" required>

            <label for="phone">Phone Number</label>
            <input type="tel" id="phone" name="phone" required>

            <label for="date">Safari Date</label>
            <input type="date" id="date" name="date" required>

            <label for="package">Wildlife Reserve</label>
            <select id="package" name="package" required onchange="updatePrice()">
                <option value="">-- Select a Reserve --</option>
                <option value="Chitwan National Park">Chitwan National Park</option>
                <option value="Bardia National Park">Bardia National Park</option>
                <option value="Shuklaphanta Wildlife Reserve">Shuklaphanta Wildlife Reserve</option>
                <option value="Koshi Tappu Wildlife Reserve">Koshi Tappu Wildlife Reserve</option>
                <option value="Parsa National Park">Parsa National Park</option>
                <option value="Banke National Park">Banke National Park</option>
            </select>

            <label for="groupSize">Number of People</label>
            <input type="number" id="groupSize" name="groupSize" min="1" required onchange="updatePrice()">

            <label for="notes">Additional Notes</label>
            <textarea id="notes" name="notes" rows="4"></textarea>

            <!-- Payment Section -->
            <label for="price">Reservation Fee (NPR)</label>
            <input type="text" id="price" name="price" value="0" readonly>

            <label for="paymentMethod">Payment Method</label>
            <select id="paymentMethod" name="paymentMethod" required>
                <option value="">-- Select Payment Method --</option>
                <option value="esewa">eSewa</option>
                <option value="khalti">Khalti</option>
                <option value="cash">Cash on Arrival</option>
            </select>

            <button type="submit">Proceed to Payment</button>
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
    const pricing = {
        "Chitwan National Park": 2500,
        "Bardia National Park": 3000,
        "Shuklaphanta Wildlife Reserve": 2000,
        "Koshi Tappu Wildlife Reserve": 2200,
        "Parsa National Park": 2100,
        "Banke National Park": 2800
    };

    function updatePrice() {
        const selectedPackage = document.getElementById('package').value;
        const groupSize = document.getElementById('groupSize').value;
        let price = 0;

        if (selectedPackage && groupSize) {
            // Calculate price based on package and group size
            price = pricing[selectedPackage] * groupSize;
        }

        // Update the price field
        document.getElementById('price').value = price;
    }
</script>

</body>
</html>
