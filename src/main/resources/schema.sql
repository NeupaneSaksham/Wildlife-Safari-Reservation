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