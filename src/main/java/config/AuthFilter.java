package config;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import entities.User;

@WebFilter({"/admin/*", "/creator/*", "/user/*"})
public class AuthFilter implements Filter {
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) 
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");

        String uri = request.getRequestURI();

        // 1. Chưa đăng nhập -> Login
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 2. Vào trang Admin mà không phải admin -> Lỗi hoặc về Home
        if (uri.contains("/admin/") && !user.getRole().equalsIgnoreCase("admin")) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        // 3. Vào trang Creator mà là User thường -> Về Home
        if (uri.contains("/creator/") && user.getRole().equalsIgnoreCase("user")) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        chain.doFilter(req, resp);
    }
}