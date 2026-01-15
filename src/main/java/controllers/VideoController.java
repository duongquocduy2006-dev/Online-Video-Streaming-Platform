package controllers;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.apache.commons.beanutils.BeanUtils;
import beans.CommentBean; 
import entities.*;
import services.*;

@WebServlet(urlPatterns = {"/video/detail", "/video/like", "/video/unlike", "/video/comment", "/video/comment/delete", "/video/comment/update"})
public class VideoController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath(); 
        String idStr = req.getParameter("id");
        int id = 0; 
        
        if (idStr != null && !idStr.isEmpty()) {
            try { id = Integer.parseInt(idStr); } catch (Exception e) {}
        }

        // XỬ LÝ XÓA COMMENT (Đơn giản)
        if (path.contains("/comment/delete")) {
            try {
                int cmtId = Integer.parseInt(req.getParameter("cmtId"));
                // Gọi thẳng hàm xóa, không cần check quyền phức tạp
                CommentServices.delete(cmtId);
                resp.sendRedirect(req.getContextPath() + "/video/detail?id=" + id);
            } catch (Exception e) { e.printStackTrace(); }
            return; 
        }

        // Like / Unlike
        if (path.contains("unlike")) { doLike(req, resp, id, false); return; }
        if (path.contains("like")) { doLike(req, resp, id, true); return; }

        // Detail Video
     // Trong hàm doGet của VideoController
        try {
            Video video = VideoServices.findById(id);
            
            // Nếu không tìm thấy video, quay về home
            if (video == null) { 
                resp.sendRedirect(req.getContextPath() + "/index"); 
                return; 
            }

            // Tăng view
            try {
                video.setViewcount(video.getViewcount() + 1);
                VideoServices.update(video);
            } catch (Exception e) {
                System.out.println("Lỗi tăng view: " + e.getMessage());
            }

            // Lấy dữ liệu liên quan
            List<Comment> comments = CommentServices.findByVideoId(id);
            List<Video> related = VideoServices.findByCategory(video.getCategory().getId());
            
            // Kiểm tra Like
            User currentUser = (User) req.getSession().getAttribute("currentUser");
            boolean isLiked = (currentUser != null) ? FavServices.isLiked(currentUser.getId(), id) : false;

            // Đẩy dữ liệu ra JSP
            req.setAttribute("video", video);
            req.setAttribute("comments", comments);
            req.setAttribute("relatedVideos", related);
            req.setAttribute("isLiked", isLiked);
            
            // Đường dẫn này phải CHÍNH XÁC theo ảnh bạn gửi lúc trước: webapp/user/detail.jsp
            req.getRequestDispatcher("/user/detail.jsp").forward(req, resp);

        } catch (Exception e) { 
            e.printStackTrace(); // In lỗi vào Console server
            
            // --- THÊM ĐOẠN NÀY ĐỂ KHÔNG BỊ TRANG TRẮNG ---
            req.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            // Forward về trang chủ hoặc trang thông báo lỗi
            req.getRequestDispatcher("/user/index.jsp").forward(req, resp); 
        }
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("currentUser");
        
        if (user == null) { resp.sendRedirect(req.getContextPath() + "/login"); return; }

        // Update Comment
        if (path.contains("/comment/update")) {
            try {
                int cmtId = Integer.parseInt(req.getParameter("cmtId"));
                int videoId = Integer.parseInt(req.getParameter("videoId"));
                CommentServices.update(cmtId, req.getParameter("content"));
                resp.sendRedirect(req.getContextPath() + "/video/detail?id=" + videoId);
            } catch (Exception e) { e.printStackTrace(); }
            return;
        }
        
        // Add Comment
        CommentBean bean = new CommentBean();
        try {
            BeanUtils.populate(bean, req.getParameterMap());
            int videoId = Integer.parseInt(bean.getVideoId());
            
            Comment c = new Comment();
            c.setUser(user);
            c.setVideo(VideoServices.findById(videoId));
            c.setContent(bean.getContent());
            c.setStatus(true);

            String parentIdStr = req.getParameter("parentId");
            if (parentIdStr != null && !parentIdStr.isEmpty()) {
                Comment parent = new Comment();
                parent.setId(Integer.parseInt(parentIdStr));
                c.setParentComment(parent);
            }

            CommentServices.create(c);
            resp.sendRedirect(req.getContextPath() + "/video/detail?id=" + videoId);
        } catch (Exception e) { e.printStackTrace(); }
    }
    
    private void doLike(HttpServletRequest req, HttpServletResponse resp, int vidId, boolean isLike) throws IOException {
        User user = (User) req.getSession().getAttribute("currentUser");
        if (user != null) {
            try {
                if (isLike) FavServices.like(user.getId(), vidId);
                else FavServices.unlike(user.getId(), vidId);
            } catch (Exception e) {}
        }
        String referer = req.getHeader("Referer");
        resp.sendRedirect(referer != null ? referer : req.getContextPath() + "/home");
    }
}