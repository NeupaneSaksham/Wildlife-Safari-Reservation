<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.wildlifesafarireservation.models.UserModel" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    UserModel user = (UserModel) session.getAttribute("user");
    boolean isLoggedIn = (user != null);
    String userName = isLoggedIn ? user.getFullName() : "";
%>

<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Safari Packages</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/packages.css" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
</head>
<body>

<c:if test="${not empty sessionScope.registrationSuccess}">
    <div class="registration-success" role="alert">
        <p>Welcome <strong><%= userName %></strong>! Your registration was successful.</p>
    </div>
    <%
        session.removeAttribute("registrationSuccess");
    %>
</c:if>

<jsp:include page="Navbar.jsp" />

<div class="page-title" role="banner">
    <h2>Our Safari Packages</h2>
    <h3>Discover the Wild with Our Exclusive Tours</h3>
</div>

<div class="packages-container">

    <%-- Package Card Template --%>
    <div class="package-card" role="region" aria-labelledby="chitwan-title">
        <div class="package-image">
            <img src="https://i.pinimg.com/736x/ef/4a/43/ef4a4340254431bcec6bd9ea3ff33a03.jpg" alt="Chitwan Jungle Safari" />
        </div>
        <div class="card-content">
            <h4 id="chitwan-title">Chitwan Jungle Safari</h4>
            <p class="desc">Experience the thrill of spotting rhinos and tigers in their natural habitat.</p>
            <div class="button-group">
                <button class="btn btn-view" onclick="openModal('chitwan')" aria-controls="chitwan" aria-expanded="false">View Details</button>
                <c:choose>
                    <c:when test="${isLoggedIn}">
                        <a href="${pageContext.request.contextPath}/Reservation?packageId=1" class="btn btn-book">Book Now</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/RegisterServlet"
                           class="btn btn-book"
                           onclick="alert('Please login or register to book a package'); return true;">
                            Book Now
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <div class="package-card" role="region" aria-labelledby="bardia-title">
        <div class="package-image">
            <img src="https://www.nepaltrekkingagency.com/wp-content/uploads/2024/05/bardia-jungle-safari-tour1.jpg" alt="Bardia Wildlife Safari" />
        </div>
        <div class="card-content">
            <h4 id="bardia-title">Bardia Wildlife Safari</h4>
            <p class="desc">Explore the untamed wilderness of Bardia National Park and spot elusive wildlife.</p>
            <div class="button-group">
                <button class="btn btn-view" onclick="openModal('bardia')" aria-controls="bardia" aria-expanded="false">View Details</button>
                <c:choose>
                    <c:when test="${isLoggedIn}">
                        <a href="${pageContext.request.contextPath}/Reservation?packageId=2" class="btn btn-book">Book Now</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/RegisterServlet"
                           class="btn btn-book"
                           onclick="alert('Please login or register to book a package'); return true;">
                            Book Now
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <div class="package-card" role="region" aria-labelledby="koshi-title">
        <div class="package-image">
            <img src="https://upload.wikimedia.org/wikipedia/commons/d/d1/Koshi_Tappu_Wildlife_Reserve_board.jpg" alt="Koshi Tappu Bird Watching" />
        </div>
        <div class="card-content">
            <h4 id="koshi-title">Koshi Tappu Safari</h4>
            <p class="desc">Witness thousands of migratory birds and enjoy tranquil river scenery.</p>
            <div class="button-group">
                <button class="btn btn-view" onclick="openModal('koshi')" aria-controls="koshi" aria-expanded="false">View Details</button>
                <c:choose>
                    <c:when test="${isLoggedIn}">
                        <a href="${pageContext.request.contextPath}/Reservation?packageId=3" class="btn btn-book">Book Now</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/RegisterServlet"
                           class="btn btn-book"
                           onclick="alert('Please login or register to book a package'); return true;">
                            Book Now
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

</div>

<!-- Modals -->

<div id="chitwan" class="modal" role="dialog" aria-modal="true" aria-labelledby="chitwan-header" tabindex="-1" aria-hidden="true">
    <div class="modal-content">
        <button class="close" aria-label="Close" onclick="closeModal('chitwan')">&times;</button>
        <img src="https://i.pinimg.com/736x/ef/4a/43/ef4a4340254431bcec6bd9ea3ff33a03.jpg" alt="Chitwan National Park" />
        <h3 id="chitwan-header">Chitwan Jungle Safari</h3>
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

<div id="bardia" class="modal" role="dialog" aria-modal="true" aria-labelledby="bardia-header" tabindex="-1" aria-hidden="true">
    <div class="modal-content">
        <button class="close" aria-label="Close" onclick="closeModal('bardia')">&times;</button>
        <img src="https://images.unsplash.com/photo-1466721591366-2d5fba72006d" alt="Bardia National Park" />
        <h3 id="bardia-header">Bardia Wildlife Expedition</h3>
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

<div id="koshi" class="modal" role="dialog" aria-modal="true" aria-labelledby="koshi-header" tabindex="-1" aria-hidden="true">
    <div class="modal-content">
        <button class="close" aria-label="Close" onclick="closeModal('koshi')">&times;</button>
        <img src="https://i.pinimg.com/736x/48/d8/c7/48d8c7a9b5c1f742f03f55538a39f5ca.jpg" alt="Koshi Tappu Wildlife Reserve" />
        <h3 id="koshi-header">Koshi Tappu Birdwatching</h3>
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


<script>
    function openModal(id) {
        const modal = document.getElementById(id);
        modal.style.display = "block";
        modal.setAttribute('aria-hidden', 'false');
        document.body.style.overflow = "hidden";
    }

    function closeModal(id) {
        const modal = document.getElementById(id);
        modal.style.display = "none";
        modal.setAttribute('aria-hidden', 'true');
        document.body.style.overflow = "auto";
    }

    window.onclick = function(event) {
        if (event.target.classList.contains('modal')) {
            event.target.style.display = "none";
            event.target.setAttribute('aria-hidden', 'true');
            document.body.style.overflow = "auto";
        }
    };

    // Auto hide registration success message after 5 seconds
    setTimeout(function () {
        var successMsg = document.querySelector('.registration-success');
        if (successMsg) {
            successMsg.style.display = 'none';
        }
    }, 5000);
</script>

</body>
</html>
