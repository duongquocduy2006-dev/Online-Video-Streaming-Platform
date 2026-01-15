package beans;

import java.util.HashMap;
import java.util.Map;
import lombok.Data;
import entities.User; // Cần User hiện tại để so sánh email cũ/mới
import services.UserServices; // Cần Service để kiểm tra trùng lặp

@Data
public class UpdateProfileBean {
    private String name;
    private String email;

    // Hàm validate nhận User hiện tại để check trùng lặp (nếu email thay đổi)
    public Map<String, String> validate(User currentUser) {
        Map<String, String> errors = new HashMap<>();
        
        // 1. Validate Name
        if (name == null || name.trim().isEmpty()) {
            errors.put("name", "Họ tên không được để trống.");
        }
        
        // 2. Validate Email (Format)
        String emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$";
        if (email == null || email.trim().isEmpty() || !email.matches(emailRegex)) {
            errors.put("email", "Email không hợp lệ.");
        } 
        
        // 3. Check trùng Email (Nghiệp vụ)
        if (!errors.containsKey("email")) {
            try {
                // Chỉ kiểm tra trùng nếu email MỚI khác email HIỆN TẠI của user (currentUser.getEmail())
                if (currentUser != null && !email.equalsIgnoreCase(currentUser.getEmail())) {
                    if (UserServices.findByEmail(email) != null) {
                        errors.put("email", "Email này đã được sử dụng bởi người khác.");
                    }
                }
            } catch (Exception e) { 
                 errors.put("error", "Lỗi kiểm tra CSDL."); 
            }
        }
        
        return errors;
    }
}