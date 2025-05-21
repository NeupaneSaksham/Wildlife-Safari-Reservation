<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile | Wildlife Reserve</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #FF9149;
            --primary-dark: #e07f3a;
            --accent: #FFA96B;
            --text: #333333;
            --light-bg: #FFF5EF;
            --light-accent: #FFE8D6;
            --border-radius: 12px;
            --shadow: 0 8px 20px rgba(255, 145, 73, 0.15);
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--light-bg);
            color: var(--text);
            line-height: 1.6;
        }

        .container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .profile-container {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            overflow: hidden;
            animation: fadeIn 0.8s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .profile-header {
            background: linear-gradient(to right, var(--primary-dark), var(--accent));
            color: white;
            padding: 40px 30px;
            text-align: center;
            position: relative;
        }

        .profile-header h1 {
            margin: 20px 0 0;
            font-size: 2rem;
            font-weight: 600;
        }

        .profile-picture-container {
            position: relative;
            width: fit-content;
            margin: 0 auto;
        }

        .profile-picture {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            border: 4px solid white;
            object-fit: cover;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
            display: block;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .profile-picture:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.2);
        }

        .profile-placeholder {
            width: 150px;
            height: 150px;
            line-height: 150px;
            border-radius: 50%;
            background-color: var(--accent);
            color: white;
            font-size: 3rem;
            font-weight: bold;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .profile-placeholder:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.2);
        }

        .profile-form {
            padding: 35px;
        }

        .form-row {
            display: flex;
            gap: 20px;
            margin-bottom: 24px;
        }

        .form-group {
            flex: 1;
            min-width: 0;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--primary);
            font-size: 0.9rem;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #e0e0e0;
            border-radius: var(--border-radius);
            font-size: 1rem;
            font-family: inherit;
            background-color: #FAFAFA;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(255, 169, 107, 0.2);
            background-color: #FFFFFF;
        }

        .file-input-wrapper {
            position: relative;
            overflow: hidden;
            display: inline-block;
            width: 100%;
        }

        .file-input-button {
            width: 100%;
            padding: 12px 15px;
            background-color: var(--light-accent);
            color: var(--primary);
            border: 1px dashed var(--accent);
            border-radius: var(--border-radius);
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
        }

        .file-input-button:hover {
            background-color: #ffe0c8;
        }

        .file-input {
            position: absolute;
            left: 0;
            top: 0;
            opacity: 0;
            width: 100%;
            height: 100%;
            cursor: pointer;
        }

        .btn {
            background-color: var(--primary);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: var(--border-radius);
            cursor: pointer;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s;
            width: 100%;
            margin-top: 10px;
        }

        .btn:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(255, 145, 73, 0.3);
        }

        .message {
            text-align: center;
            margin-bottom: 20px;
            padding: 12px;
            border-radius: var(--border-radius);
            font-weight: 500;
        }

        .message.success {
            background-color: #e8f5e9;
            color: #2e7d32;
            border: 1px solid #c8e6c9;
        }

        .message.error {
            background-color: #ffebee;
            color: #c62828;
            border: 1px solid #ffcdd2;
        }

        .action-links {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }

        .action-link {
            text-decoration: none;
            color: var(--primary);
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 5px;
            transition: color 0.3s;
        }

        .action-link:hover {
            color: var(--primary-dark);
            text-decoration: underline;
        }

        .hidden {
            display: none;
        }

        @media (max-width: 768px) {
            .form-row {
                flex-direction: column;
                gap: 15px;
            }

            .profile-header {
                padding: 30px 20px;
            }

            .profile-form {
                padding: 25px;
            }

            .profile-picture,
            .profile-placeholder {
                width: 120px;
                height: 120px;
                line-height: 120px;
                font-size: 2.5rem;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="profile-container">
        <div class="profile-header">
            <div class="profile-picture-container">
                <!-- Profile Image with Click-to-Change Functionality -->
                <label for="profileImage" style="cursor: pointer;">
                    <c:choose>
                        <c:when test="${not empty userDTO.profileImage}">
                            <img id="profileImagePreview" src="${pageContext.request.contextPath}/images/${userDTO.profileImage}" alt="Profile Picture" class="profile-picture" />
                        </c:when>
                        <c:otherwise>
                            <div id="profilePlaceholder" class="profile-placeholder">
                                    ${fn:toUpperCase(fn:substring(userDTO.fullName, 0, 1))}
                            </div>
                            <img id="profileImagePreview" class="profile-picture hidden" alt="Profile Picture Preview" />
                        </c:otherwise>
                    </c:choose>
                </label>
            </div>
            <h1>Update Your Profile</h1>
        </div>

        <div class="profile-form">
            <!-- Success and Error messages -->
            <c:if test="${not empty success}">
                <p class="message success">${success}</p>
            </c:if>
            <c:if test="${not empty error}">
                <p class="message error">${error}</p>
            </c:if>

            <!-- Profile Update Form -->
            <form action="${pageContext.request.contextPath}/editProfile" method="POST" enctype="multipart/form-data">
                <input type="file" id="profileImage" name="profileImage" class="hidden" accept="image/*" />

                <div class="form-row">
                    <div class="form-group">
                        <label for="fullName">Full Name</label>
                        <input type="text" id="fullName" name="fullName" class="form-control" value="${userDTO.fullName}" required />
                    </div>

                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" class="form-control" value="${userDTO.email}" required />
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="phone">Phone</label>
                        <input type="text" id="phone" name="phone" class="form-control" value="${userDTO.phone}" />
                    </div>

                    <div class="form-group">
                        <label for="address">Address</label>
                        <input type="text" id="address" name="address" class="form-control" value="${userDTO.address}" />
                    </div>
                </div>

                <div class="form-group">
                    <label for="profileImage">Change Profile Picture</label>
                    <div class="file-input-wrapper">
                        <div class="file-input-button" onclick="document.getElementById('profileImage').click()">
                            Choose New Image
                        </div>
                    </div>
                </div>

                <button type="submit" class="btn">Update Profile</button>
            </form>

            <div class="action-links">
                <a href="${pageContext.request.contextPath}/profile" class="action-link">
                    ← Back to Profile
                </a>
            </div>
        </div>
    </div>
</div>

<script>
    // Image Preview Functionality
    document.getElementById('profileImage').addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(event) {
                const preview = document.getElementById('profileImagePreview');
                const placeholder = document.getElementById('profilePlaceholder');

                preview.src = event.target.result;
                preview.classList.remove('hidden');

                if (placeholder) {
                    placeholder.classList.add('hidden');
                }
            };
            reader.readAsDataURL(file);
        }
    });

    // Click on profile image to trigger file input
    document.getElementById('profileImagePreview')?.addEventListener('click', function() {
        document.getElementById('profileImage').click();
    });
</script>

</body>
</html>