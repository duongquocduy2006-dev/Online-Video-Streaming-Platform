package beans;

import java.util.HashMap;
import java.util.Map;
import lombok.Data;
import entities.User;
import services.UserServices;

@Data
public class LoginBean {
    private String username;
    private String password;
    private boolean remember;
    private User currentUser; 

    public Map<String, String> validate() {
        Map<String, String> errors = new HashMap<>();

        // 1. CHECK RỖNG
        if (username == null || username.trim().isEmpty()) {
            errors.put("username", "Vui lòng nhập tên đăng nhập");
        }
        
        // 2. CHECK PASSWORD FORMAT <--- ĐÃ THÊM CHECK NÀY
        if (password == null || password.trim().isEmpty()) {
            errors.put("password", "Vui lòng nhập mật khẩu");
        } else if (!password.matches("^[a-zA-Z0-9]+$")) { // <--- THÊM CHECK NÀY
            errors.put("password", "Mật khẩu không được chứa ký tự đặc biệt!");
        }

        if (!errors.isEmpty()) return errors;

        // 3. CHECK LOGIC (Database & Authentication)
        try {
            User user = UserServices.login(username, password);
            
            if (user == null) {
                errors.put("message", "Sai tên đăng nhập hoặc mật khẩu!");
            } else if (!user.isStatus()) {
                errors.put("message", "Tài khoản của bạn đã bị khóa!");
            } else {
                this.currentUser = user;
            }
        } catch (Exception e) {
            e.printStackTrace();
            errors.put("message", "Lỗi kết nối cơ sở dữ liệu!");
        }

        return errors;
    }
}