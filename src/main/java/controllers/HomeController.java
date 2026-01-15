package controllers;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import entities.Video;
import services.CategoryServices;
import services.VideoServices;

@WebServlet("/home")
public class HomeController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Luôn lấy danh sách Categories để hiển thị trên Menu Header
        req.setAttribute("categories", CategoryServices.findAll());

        String action = req.getParameter("action");
        List<Video> listVideos;

        try {
            if (action != null && action.equals("search")) {
                // --- LOGIC TÌM KIẾM ---
                String keyword = req.getParameter("keyword");
                if (keyword != null && !keyword.trim().isEmpty()) {
                    listVideos = VideoServices.searchByTitle(keyword);
                    req.setAttribute("message", "Kết quả tìm kiếm cho: '" + keyword + "'");
                } else {
                    listVideos = VideoServices.findAllActive();
                }

            } else if (action != null && action.equals("filter")) {
                // --- LOGIC LỌC THEO DANH MỤC ---
                String catIdStr = req.getParameter("catId");
                if (catIdStr != null) {
                    int catId = Integer.parseInt(catIdStr);
                    listVideos = VideoServices.findByCategory(catId);
                } else {
                    listVideos = VideoServices.findAllActive();
                }

            } else {
                // --- MẶC ĐỊNH: LẤY TẤT CẢ ---
                listVideos = VideoServices.findAllActive();
            }

            req.setAttribute("videos", listVideos);
            req.getRequestDispatcher("/user/index.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi tải dữ liệu: " + e.getMessage());
            // Dù lỗi vẫn cố gắng hiển thị trang chủ (có thể là danh sách rỗng)
            req.getRequestDispatcher("/user/index.jsp").forward(req, resp);
        }
    }
}