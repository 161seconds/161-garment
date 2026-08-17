package utils;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PasswordUtils {

    public static String hashPassword(String password) {
        if (password == null) return null;
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes(StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder();
            
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA-256 algorithm not found", e);
        }
    }

    /**
     * Validates password complexity:
     * - Minimum 6 characters
     * - At least 1 uppercase letter (A-Z)
     * - At least 1 number/digit (0-9)
     * - At least 1 special character (!@#$%^&*...)
     */
    public static boolean isValidComplexity(String password) {
        if (password == null || password.length() < 6) {
            return false;
        }
        boolean hasUpper = false;
        boolean hasDigit = false;
        boolean hasSpecial = false;

        for (char c : password.toCharArray()) {
            if (Character.isUpperCase(c)) {
                hasUpper = true;
            } else if (Character.isDigit(c)) {
                hasDigit = true;
            } else if (!Character.isWhitespace(c) && !Character.isLetterOrDigit(c)) {
                hasSpecial = true;
            }
        }
        return hasUpper && hasDigit && hasSpecial;
    }

    public static String getPasswordRequirementsMessage() {
        return "Mật khẩu phải từ 6 ký tự trở lên, bao gồm ít nhất 1 chữ in hoa (A-Z), 1 chữ số (0-9) và 1 ký tự đặc biệt (ví dụ: @, #, $, %, !...)!";
    }
}
