package beans;

import java.util.HashMap;
import java.util.Map;
import lombok.Data;
import services.UserServices;

@Data
public class RegisterBean {
    private String username;
    private String password;
    private String confirmPassword;
    private String name;
    private String email;
    // Đã loại bỏ trường phone

    public Map<String, String> validate() {
        Map<String, String> errors = new HashMap<>();

        // 1. VALIDATE USERNAME (Phần này đã chuẩn)
        if (username == null || username.trim().isEmpty()) {
            errors.put("username", "Thiếu tên đăng nhập");
        } else if (username.length() < 4) {
            errors.put("username", "Tên đăng nhập quá ngắn (tối thiểu 4 ký tự)");
        } else if (!username.matches("^[a-zA-Z0-9_]+$")) {
            errors.put("username", "Tên đăng nhập không được chứa ký tự đặc biệt");
        } else {
            try {
                if (UserServices.findByUsername(username) != null) {
                    errors.put("username", "Tên đăng nhập đã tồn tại");
                }
            } catch (Exception e) { e.printStackTrace(); }
        }

        // 2. VALIDATE PASSWORD <--- ĐÃ THÊM: KHÔNG CHO KÝ TỰ ĐẶC BIỆT
        if (password == null || password.trim().isEmpty()) {
            errors.put("password", "Mật khẩu không được để trống");
        } else if (!password.matches("^[a-zA-Z0-9]+$")) { // <--- THÊM CHECK NÀY
            errors.put("password", "Mật khẩu không được chứa ký tự đặc biệt!");
        } else if (password.length() < 6) {
            errors.put("password", "Mật khẩu phải từ 6 ký tự");
        }

        // 3. CONFIRM PASSWORD
        if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
            errors.put("confirmPassword", "Vui lòng xác nhận lại mật khẩu");
        } else if (!confirmPassword.equals(password)) {
            errors.put("confirmPassword", "Mật khẩu xác nhận không khớp");
        }

        // 4. VALIDATE NAME
        if (name == null || name.trim().isEmpty()) {
            errors.put("name", "Nhập họ tên");
        }

        // 5. VALIDATE EMAIL (Phần này giữ nguyên)
        String emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$";
        if (email == null || email.trim().isEmpty()) {
            errors.put("email", "Email không được để trống");
        } else if (!email.matches(emailRegex)) {
            errors.put("email", "Email không đúng định dạng");
        } else {
            try {
                if (UserServices.findByEmail(email) != null) {
                    errors.put("email", "Email đã được sử dụng");
                }
            } catch (Exception e) { e.printStackTrace(); }
        }

        return errors;
    }
}