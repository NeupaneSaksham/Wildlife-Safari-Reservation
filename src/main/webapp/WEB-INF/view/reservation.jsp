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

<%@ include file="Navbar.jsp" %>

<div class="wrapper">
    <div class="image-container" style="flex: 1; background: url('${pageContext.request.contextPath}/assets/reservation.PNG') no-repeat center center; background-size: cover; min-height: 100%;"></div>
    <div class="form-container">
        <h2>Safari Reservation</h2>
        <form action="${pageContext.request.contextPath}/Reservation" method="post">
            <label for="fullName">Full Name</label>
            <input type="text" id="fullName" name="fullName" required>

            <label for="email">Email</label>
            <input type="email" id="email" name="email" required>

            <label for="phone">Phone Number</label>
            <input type="tel" id="phone" name="phone" required>

            <label for="safariDate">Safari Date</label>
            <input type="date" id="safariDate" name="safariDate" required>

            <label for="packageName">Wildlife Reserve</label>
            <select id="packageName" name="packageName" required onchange="updatePrice()">
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

            <label for="price">Reservation Fee (NPR)</label>
            <input type="text" id="price" name="price" value="0" readonly>

            <button type="submit">Book Now</button>
        </form>

    </div>
</div>

<%@ include file="Footer.jsp" %>

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
        const selectedPackage = document.getElementById('packageName').value;  // Corrected to match the select element ID
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
