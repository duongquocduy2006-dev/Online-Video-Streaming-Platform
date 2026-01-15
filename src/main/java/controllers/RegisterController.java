package controllers;

import java.io.IOException;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.apache.commons.beanutils.BeanUtils;
import beans.RegisterBean;
import entities.User;
import services.UserServices;

@WebServlet("/register")
public class RegisterController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        
        try {
            // 1. Đổ dữ liệu
            RegisterBean bean = new RegisterBean();
            BeanUtils.populate(bean, req.getParameterMap());
            
            // 2. Validate TOÀN BỘ bằng Bean
            Map<String, String> errors = bean.validate();

            if (!errors.isEmpty()) {
                req.setAttribute("errors", errors);
                req.setAttribute("bean", bean); 
                req.getRequestDispatcher("/register.jsp").forward(req, resp);
                return;
            }

            // 3. Tiến hành đăng ký
            User u = new User();
            u.setUsername(bean.getUsername());
            u.setPassword(bean.getPassword());
            u.setName(bean.getName());
            u.setEmail(bean.getEmail());
            // Cột phone sẽ là NULL (do Bean không có field phone, và Entity cho phép NULL)
            u.setRole("user");
            u.setStatus(true);

            UserServices.create(u);
            
            req.setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
        }
    }
}