CREATE SCHEMA IF NOT EXISTS safaridb;
USE safaridb;

CREATE TABLE IF NOT EXISTS users (
                                     id INT AUTO_INCREMENT PRIMARY KEY,
                                     full_name VARCHAR(100) NOT NULL,
                                     email VARCHAR(100) NOT NULL UNIQUE,
                                     password VARCHAR(255) NOT NULL,
                                     phone VARCHAR(20),
                                     address VARCHAR(255),
                                     profile_image VARCHAR(255),
                                     role VARCHAR(50) DEFAULT 'user' NOT NULL,
                                     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                     updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS activity_logs (
                                             id INT AUTO_INCREMENT PRIMARY KEY,
                                             activity VARCHAR(255) NOT NULL,
                                             activity_type VARCHAR(50),
                                             user_id INT,
                                             created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                             FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS packages (
                                        package_id INT PRIMARY KEY,
                                        title VARCHAR(50) NOT NULL,
                                        description VARCHAR(100) NOT NULL,
                                        price DECIMAL(10,2) NOT NULL,
                                        duration INT NOT NULL,
                                        user_id INT,
                                        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS reservation (
                                           reservation_id INT AUTO_INCREMENT PRIMARY KEY,
                                           full_name VARCHAR(100) NOT NULL,
                                           email VARCHAR(100) NOT NULL,
                                           phone VARCHAR(20) NOT NULL,
                                           number_of_guests INT NOT NULL,
                                           total_cost DECIMAL(10,2) NOT NULL,
                                           reservation_date DATE NOT NULL,
                                           safari_date DATE NOT NULL,
                                           status VARCHAR(60) NOT NULL,
                                           package_id INT,
                                           payment_method VARCHAR(50),
                                           notes TEXT,
                                           FOREIGN KEY (package_id) REFERENCES packages(package_id) ON DELETE CASCADE
);

