CREATE SCHEMA IF NOT EXISTS safaridb;
USE safaridb;

-- Create the users table
CREATE TABLE IF NOT EXISTS users (
                                     id INT AUTO_INCREMENT PRIMARY KEY,  -- Auto increment the user ID
                                     full_name VARCHAR(100) NOT NULL,    -- Store the user's full name
    email VARCHAR(100) NOT NULL UNIQUE, -- Store the user's email and ensure it's unique
    password VARCHAR(255) NOT NULL,     -- Store the user's password (hashed, not plain text)
    role INT DEFAULT 1 NOT NULL,        -- User role: 1=regular user (default), 0=admin, 2=super admin
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,   -- Track when the user was created
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP -- Track when user details were last updated
    );


-- Create the activity_logs table to track user activities
CREATE TABLE IF NOT EXISTS activity_logs (
                                             id INT AUTO_INCREMENT PRIMARY KEY,   -- Auto increment the activity log ID
                                             activity VARCHAR(255) NOT NULL,       -- Description of the activity
    activity_type VARCHAR(50),            -- Type of activity (upload, delete, login, etc.)
    user_id INT,                          -- Foreign key to link the activity to a user
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,   -- Track when the activity occurred
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE -- Ensure logs are deleted if the user is deleted
    );
-- Create the user_packages table to associate users with packages
CREATE TABLE IF NOT EXISTS user_packages (
                                             package_id NUMBER(10) PRIMARY KEY,       -- Unique identifier for the package (also FK)
                                             user_id NUMBER(10),                      -- Foreign key referencing user
                                             FOREIGN KEY (user_id) REFERENCES email(user_id) ON DELETE CASCADE
);

-- Create the packages table to store package details
CREATE TABLE IF NOT EXISTS packages (
                                        package_id NUMBER(10) PRIMARY KEY,       -- Unique identifier for the package
                                        title VARCHAR2(50) NOT NULL,             -- Title of the package
                                        description VARCHAR2(100) NOT NULL,      -- Description of the package
                                        price NUMBER(30) NOT NULL,               -- Price of the package
                                        duration NUMBER(30) NOT NULL,            -- Duration of the package
                                        user_id NUMBER(10),                      -- Foreign key (part of composite key concept)
                                        FOREIGN KEY (user_id) REFERENCES email(user_id) ON DELETE SET NULL
);

-- Create the reservation table to store booking details
CREATE TABLE IF NOT EXISTS reservation (
                                           reservation_id NUMBER(10) PRIMARY KEY,   -- Unique identifier for each reservation
                                           number_of_guests NUMBER(20) NOT NULL,    -- Number of guests
                                           total_cost NUMBER(30) NOT NULL,          -- Total cost of reservation
                                           reservation_date DATE NOT NULL,          -- Date of reservation
                                           safari_date DATE NOT NULL,               -- Scheduled safari date
                                           status VARCHAR2(60) NOT NULL,            -- Status of the reservation
                                           package_id NUMBER(10),                   -- Foreign key to the packages table
                                           FOREIGN KEY (package_id) REFERENCES packages(package_id) ON DELETE CASCADE
);

-- Create the email table to store user information
CREATE TABLE IF NOT EXISTS email (
                                     email_id NUMBER(10) PRIMARY KEY,         -- Unique identifier for each email/user
                                     full_name VARCHAR2(50) NOT NULL,         -- Full name of the user
                                     email VARCHAR2(50) UNIQUE,               -- Unique email address
                                     password VARCHAR2(50) NOT NULL,          -- User's password
                                     role VARCHAR2(50) NOT NULL,              -- Role (admin, user, etc.)
                                     created_at DATE NOT NULL,                -- Account creation date
                                     updated_at DATE NOT NULL,                -- Last updated timestamp
                                     user_id NUMBER(10),                      -- Foreign key reference
                                     FOREIGN KEY (user_id) REFERENCES email(email_id) ON DELETE CASCADE
);
