package beans;

import java.util.HashMap;
import java.util.Map;
import entities.User; // Cần import User để xác minh mật khẩu cũ
import lombok.Data;

@Data
public class ChangePasswordBean {
    // 3 trường dữ liệu từ form
    private String currentPassword;
    private String newPassword;
    private String confirmPassword;

    /**
     * Validate toàn bộ logic đổi mật khẩu.
     * @param user Đối tượng User hiện tại (từ HttpSession) để xác minh mật khẩu cũ.
     * @return Map<String, String> chứa các lỗi chi tiết.
     */
    public Map<String, String> validate(User user) {
        Map<String, String> errors = new HashMap<>();

        // 1. Validate Mật khẩu cũ
        if (currentPassword == null || currentPassword.trim().isEmpty()) {
            errors.put("currentPassword", "Vui lòng nhập mật khẩu hiện tại.");
        } 
        // Logic nghiệp vụ: Kiểm tra mật khẩu cũ có khớp với DB không
        else if (user != null && !currentPassword.equals(user.getPassword())) {
            errors.put("currentPassword", "Mật khẩu hiện tại không đúng.");
        }

        // 2. Validate Mật khẩu mới (Format và độ dài)
        if (newPassword == null || newPassword.trim().isEmpty()) {
             errors.put("newPassword", "Vui lòng nhập mật khẩu mới.");
        } else if (newPassword.length() < 6) {
            errors.put("newPassword", "Mật khẩu mới phải có ít nhất 6 ký tự.");
        } else if (!newPassword.matches("^[a-zA-Z0-9]+$")) { // Quy tắc không ký tự đặc biệt
            errors.put("newPassword", "Mật khẩu không được chứa ký tự đặc biệt.");
        }

        // 3. Validate Khớp mật khẩu
        if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
            errors.put("confirmPassword", "Vui lòng xác nhận lại mật khẩu.");
        } else if (!newPassword.equals(confirmPassword)) {
            errors.put("confirmPassword", "Mật khẩu xác nhận không khớp.");
        }
        
        return errors;
    }
}