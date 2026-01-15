package controllers;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.apache.commons.beanutils.BeanUtils;
import beans.ChangePasswordBean;
import beans.UpdateProfileBean; // BẮT BUỘC IMPORT BEAN UPDATE PROFILE
import entities.*;
import services.*;

@WebServlet({"/user/profile", "/user/update-profile", "/user/change-password", "/user/favorites"})
public class UserController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        User currentUser = (User) req.getSession().getAttribute("currentUser");

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
            
        }

        try {
            if (path.contains("favorites")) {
                List<Video> favs = FavServices.findVideosByUser(currentUser.getId());
                req.setAttribute("videos", favs);
                req.getRequestDispatcher("/user/favorites.jsp").forward(req, resp);
            } else {
                req.getRequestDispatcher("/user/profile.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi tải dữ liệu: " + e.getMessage());
            req.getRequestDispatcher("/user/profile.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("currentUser");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        
        try {
            
            // --- CẬP NHẬT THÔNG TIN (UPDATE PROFILE) ---
            if (path.contains("update-profile")) {
                
                UpdateProfileBean bean = new UpdateProfileBean(); // 1. KHỞI TẠO BEAN MỚI
                BeanUtils.populate(bean, req.getParameterMap());

                Map<String, String> errors = bean.validate(user); // 2. VALIDATE (Check trùng email)
                
                if (!errors.isEmpty()) {
                    req.setAttribute("profileErrors", errors); // Gán lỗi profile riêng
                    req.setAttribute("error", "Cập nhật thông tin thất bại!");
                } else {
                    // 3. THÀNH CÔNG: Controller set dữ liệu từ Bean
                    user.setName(bean.getName());
                    user.setEmail(bean.getEmail());
                    
                    UserServices.update(user);
                    session.setAttribute("currentUser", user); 
                    
                    req.setAttribute("message", "Cập nhật thông tin thành công!");
                }
            
            // --- ĐỔI MẬT KHẨU (CHANGE PASSWORD) ---
            } else if (path.contains("change-password")) {
                
                ChangePasswordBean bean = new ChangePasswordBean();
                BeanUtils.populate(bean, req.getParameterMap());

                Map<String, String> errors = bean.validate(user);
                
                if (!errors.isEmpty()) {
                    req.setAttribute("changePasswordErrors", errors); 
                    req.setAttribute("error", "Thay đổi mật khẩu thất bại!");
                } else {
                    user.setPassword(bean.getNewPassword());
                    UserServices.update(user);
                    
                    req.setAttribute("message", "Đổi mật khẩu thành công!");
                }
            }
            
            // Forward về trang profile để hiện thông báo
            req.getRequestDispatcher("/user/profile.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Thao tác thất bại: " + e.getMessage());
            req.getRequestDispatcher("/user/profile.jsp").forward(req, resp);
        }
    }
}