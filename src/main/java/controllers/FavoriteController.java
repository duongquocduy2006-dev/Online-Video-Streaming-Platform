package controllers;

import java.io.IOException;
import java.util.List;

// --- SỬA CÁC DÒNG NÀY ---
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
// -------------------------

import entities.User;
import entities.Video;
import services.FavServices;

@WebServlet("/video/favorite")
public class FavoriteController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("currentUser");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            // Lấy dữ liệu từ DB
            List<Video> videos = FavServices.findVideosByUser(user.getId());
            req.setAttribute("videos", videos);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi tải dữ liệu!");
        }

        // Forward về trang JSP
        req.getRequestDispatcher("/views/favorite-video.jsp").forward(req, resp);
    }
}