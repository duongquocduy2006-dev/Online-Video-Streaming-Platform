package controllers;

import java.io.IOException;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.apache.commons.beanutils.BeanUtils;
import beans.LoginBean;
import entities.User;

@WebServlet({"/login", "/logout"})
public class LoginController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        
        if (path.contains("logout")) {
            req.getSession().invalidate();
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        
        try {
            // 1. Đổ dữ liệu
            LoginBean bean = new LoginBean();
            BeanUtils.populate(bean, req.getParameterMap());
            
            // 2. Validate TOÀN BỘ (Bean lo hết)
            Map<String, String> errors = bean.validate();
            
            if (!errors.isEmpty()) {
                req.setAttribute("errors", errors);
                req.setAttribute("message", errors.get("message")); // Lỗi chung (Sai pass/Khóa)
                req.setAttribute("bean", bean);
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
                return;
            }
            
            // 3. Đăng nhập thành công
            User user = bean.getCurrentUser(); 
            
            HttpSession session = req.getSession();
            session.setAttribute("currentUser", user);
            
            if ("admin".equalsIgnoreCase(user.getRole())) {
                resp.sendRedirect(req.getContextPath() + "/admin/users");
            } else {
                resp.sendRedirect(req.getContextPath() + "/home");
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("message", "Lỗi hệ thống nghiêm trọng: " + e.getMessage());
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }
}