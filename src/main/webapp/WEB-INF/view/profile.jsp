<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <style>
        :root {
            --primary: #FF9149;
            --primary-light: #FFF5EF;
            --primary-dark: #E07F3A;
            --text: #2D3748;
            --text-light: #718096;
            --bg: #F8F9FA;
            --white: #FFFFFF;
            --border: #E2E8F0;
            --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.08);
            --shadow-md: 0 4px 12px rgba(0, 0, 0, 0.1);
            --radius-lg: 16px;
            --radius-md: 12px;
            --radius-sm: 8px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
        }

        body {
            background-color: var(--bg);
            color: var(--text);
            line-height: 1.6;
            padding: 32px;
            min-height: 100vh;
            font-size: 18px;
        }

        .profile-container {
            max-width: 760px;
            margin: 0 auto;
            background: var(--white);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-md);
            overflow: hidden;
        }

        .profile-header {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            padding: 48px 40px;
            text-align: center;
            color: var(--white);
            position: relative;
        }

        .profile-title {
            font-size: 36px;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .profile-subtitle {
            font-size: 18px;
            opacity: 0.9;
            font-weight: 500;
        }

        .profile-image-container {
            position: relative;
            width: fit-content;
            margin: -88px auto 32px;
            z-index: 2;
        }

        .profile-image {
            width: 180px;
            height: 180px;
            border-radius: 50%;
            border: 5px solid var(--white);
            object-fit: cover;
            box-shadow: var(--shadow-md);
            display: block;
            background-color: var(--primary-light);
        }

        .profile-placeholder {
            width: 180px;
            height: 180px;
            border-radius: 50%;
            border: 5px solid var(--white);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 72px;
            font-weight: 700;
            color: var(--white);
            background-color: var(--primary);
            box-shadow: var(--shadow-md);
        }

        .profile-content {
            padding: 0 48px 48px;
        }

        .profile-info {
            margin-bottom: 40px;
        }

        .info-item {
            display: flex;
            padding: 24px 0;
            border-bottom: 1px solid var(--border);
        }

        .info-item:last-child {
            border-bottom: none;
        }

        .info-label {
            width: 160px;
            font-weight: 600;
            color: var(--primary);
            font-size: 18px;
        }

        .info-value {
            flex: 1;
            color: var(--text);
            font-size: 18px;
        }

        .profile-actions {
            display: flex;
            justify-content: center;
            gap: 15px;
        }

        .btn-edit {
            padding: 16px 36px;
            background-color: var(--primary);
            color: var(--white);
            border: none;
            border-radius: var(--radius-md);
            font-weight: 600;
            font-size: 18px;
            cursor: pointer;
            transition: all 0.2s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            box-shadow: 0 4px 8px rgba(255, 145, 73, 0.25);
        }

        .btn-edit:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(255, 145, 73, 0.3);
        }

        .btn-back {
            padding: 10px 20px;
            background-color: var(--primary-light);
            color: var(--text);
            border: none;
            border-radius: var(--radius-md);
            font-weight: 600;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
        }

        .btn-back:hover {
            background-color: var(--primary-dark);
            color: var(--white);
            transform: translateY(-2px);
        }

        @media (max-width: 640px) {
            body {
                padding: 20px;
                font-size: 16px;
            }

            .profile-header {
                padding: 36px 28px;
            }

            .profile-image,
            .profile-placeholder {
                width: 130px;
                height: 130px;
                font-size: 52px;
            }

            .info-item {
                flex-direction: column;
                gap: 8px;
                padding: 18px 0;
            }

            .info-label {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<div class="profile-container">
    <div class="profile-header">
        <c:if test="${not empty user}">
            <h1 class="profile-title">Welcome, ${user.fullName}</h1>
        </c:if>
    </div>

    <c:if test="${not empty user}">
        <div class="profile-image-container">
            <c:choose>
                <c:when test="${not empty user.profileImage}">
                    <img src="data:image/jpeg;base64,${user.profileImage}" alt="Profile Picture" class="profile-image"/>
                </c:when>
                <c:otherwise>
                    <div class="profile-placeholder">
                            ${fn:toUpperCase(fn:substring(user.fullName, 0, 1))}
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

    <c:if test="${not empty user}">
        <div class="info-item">
            <div class="info-label">Full Name</div>
            <div class="info-value">${user.fullName != null ? user.fullName : 'N/A'}</div>
        </div>
        <div class="info-item">
            <div class="info-label">Email</div>
            <div class="info-value">${user.email != null ? user.email : 'N/A'}</div>
        </div>
        <div class="info-item">
            <div class="info-label">Phone</div>
            <div class="info-value">${user.phone != null ? user.phone : 'N/A'}</div>
        </div>
        <div class="info-item">
            <div class="info-label">Address</div>
            <div class="info-value">${user.address != null ? user.address : 'N/A'}</div>
        </div>
    </c:if>


    <div class="profile-actions">
                <a href="${pageContext.request.contextPath}/editProfile" class="btn-edit">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path>
                        <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
                    </svg>
                    Edit Profile
                </a>

                <!-- Back Button -->
                <a href="${pageContext.request.contextPath}/packages" class="btn-back">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M14 3l-9 9 9 9"></path>
                    </svg>
                    Back
                </a>
            </div>
        </div>
    </c:if>
</div>

</body>
</html>