<html>
<head>
    <title>Navigation</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Navbar.css">
</head>
<body>
<!-- Header -->
<header>
    <img src="${pageContext.request.contextPath}/assets/BanYatraLogo.png" alt="Logo" />
    <nav class="nav-wrapper">
        <div class="nav-center">
            <a href="${pageContext.request.contextPath}/Home" class="nav-link">Home</a>
            <a href="${pageContext.request.contextPath}/packages" class="nav-link">Packages</a>
            <a href="${pageContext.request.contextPath}/About-us" class="nav-link">About Us</a>
            <a href="${pageContext.request.contextPath}/Reservation" class="nav-link">Reserve Now</a>
        </div>
        <div class="nav-right">
            <a href="${pageContext.request.contextPath}/logout" style="background-color:#ff5858; color:white;">Logout</a>
            <a href="${pageContext.request.contextPath}/profile" class="profile-link">
                <i class="fas fa-user"></i>
                <span>Profile</span>
            </a>
        </div>
    </nav>
</header>

<!-- JavaScript for Active Link -->
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const currentPath = window.location.pathname;
        const links = document.querySelectorAll(".nav-link");

        links.forEach(link => {
            if (currentPath.includes(link.getAttribute("href"))) {
                link.classList.add("active");
            }
        });
    });
</script>
</body>
</html>
