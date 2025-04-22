package com.example.wildlifesafarireservation.utils;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordHashUtil {

    // Method to hash the password using BCrypt
    public static String hashPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt());
    }

    // Method to check if the given password matches the hashed password
    public static boolean checkPassword(String password, String hashedPassword) {
        return BCrypt.checkpw(password, hashedPassword);
    }
}
