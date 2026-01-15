package controllers;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.apache.commons.beanutils.BeanUtils;
import beans.VideoBean; // Sử dụng Bean để hứng dữ liệu và Validation
import entities.*;
import services.*;

@WebServlet({"/creator/video", "/creator/video/create", "/creator/video/edit", "/creator/video/save", "/creator/video/delete"})
public class CreatorController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        User user = (User) req.getSession().getAttribute("currentUser");

        // 1. Bảo vệ: Nếu User không có (session hết hạn) -> Chuyển về login
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            // --- FORM THÊM MỚI HOẶC SỬA ---
            if (path.contains("create") || path.contains("edit")) {
                req.setAttribute("categories", CategoryServices.findAll());
                
                if (path.contains("edit")) {
                    String idStr = req.getParameter("id");
                    
                    if (idStr != null) {
                        try {
                            int id = Integer.parseInt(idStr);
                            Video v = VideoServices.findById(id);
                            
                            // Logic bảo mật: Kiểm tra quyền sở hữu
                            if (v != null && v.getUser().getId() == user.getId()) {
                                req.setAttribute("video", v);
                            } else {
                                resp.sendRedirect(req.getContextPath() + "/creator/video?error=unauthorized");
                                return;
                            }
                        } catch (NumberFormatException nfe) {
                             resp.sendRedirect(req.getContextPath() + "/creator/video?error=invalid_id");
                             return;
                        }
                    }
                }
                req.getRequestDispatcher("/creator/form.jsp").forward(req, resp);
                
            // --- XÓA VIDEO ---
            } else if (path.contains("delete")) {
                String idStr = req.getParameter("id");
                if (idStr == null) {
                    resp.sendRedirect(req.getContextPath() + "/creator/video?error=invalid_id");
                    return;
                }
                
                int id = Integer.parseInt(idStr); 
                Video v = VideoServices.findById(id);
                
                if (v != null && v.getUser().getId() == user.getId()) {
                    VideoServices.delete(id);
                    req.setAttribute("message", "Xóa video thành công!");
                } else {
                    req.setAttribute("error", "Bạn không có quyền xóa video này!");
                }
                
                // Load lại danh sách sau khi xóa
                List<Video> list = VideoServices.findByUserId(user.getId());
                req.setAttribute("myVideos", list);
                req.getRequestDispatcher("/creator/index.jsp").forward(req, resp);
                
            // --- XEM DANH SÁCH VIDEO (DEFAULT: /creator/video) ---
            } else {
                List<Video> list = VideoServices.findByUserId(user.getId());
                req.setAttribute("myVideos", list);
                req.getRequestDispatcher("/creator/index.jsp").forward(req, resp);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi tải dữ liệu: " + e.getMessage());
            req.getRequestDispatcher("/creator/index.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        User user = (User) req.getSession().getAttribute("currentUser");
        VideoBean bean = new VideoBean();
        
        try {
            BeanUtils.populate(bean, req.getParameterMap());
            Map<String, String> errors = bean.validate();
            String idStr = bean.getId();
            
            if (!errors.isEmpty()) {
                // ... (Logic FORWARD khi có lỗi) ...
                req.setAttribute("errors", errors);
                req.setAttribute("bean", bean); 
                req.setAttribute("categories", CategoryServices.findAll()); 
                req.getRequestDispatcher("/creator/form.jsp").forward(req, resp);
                return;
            }

            // --- KHÔNG CÓ LỖI: Tiến hành lưu DB ---
            Video v = new Video();
            
            // Lấy ID video đã được validate và tạo link Poster TỰ ĐỘNG
            String thumbnailId = bean.getUrl();
            String generatedPosterUrl = "https://img.youtube.com/vi/" + thumbnailId + "/maxresdefault.jpg";
            
            // 4. Update
            if (idStr != null && !idStr.isEmpty()) {
                int id = Integer.parseInt(idStr);
                v = VideoServices.findById(id);
                
                if (v.getUser().getId() != user.getId()) {
                    resp.sendRedirect(req.getContextPath() + "/creator/video?error=unauthorized");
                    return;
                }
                
                v.setStatus(false);
            } 
            // 5. Insert
            else {
                v.setUser(user);
                v.setViewcount(0); 
                v.setStatus(false);
            }

            // Gán giá trị từ Bean vào Entity
            v.setTitle(bean.getTitle());
            v.setUrl(thumbnailId); 
            v.setPoster(generatedPosterUrl); // <-- GÁN POSTER TỰ ĐỘNG
            v.setDescription(bean.getDescription()); // <-- CỘT NÀY SẼ LÀ NULL HOẶC GIÁ TRỊ TỪ FORM
//            v.setStatus(bean.isStatus());

            // CatId đã được validate là hợp lệ và tồn tại trong Bean
            int catId = Integer.parseInt(bean.getCatId());
            v.setCategory(CategoryServices.findById(catId));

            // Gọi Service lưu xuống DB
            if (v.getId() > 0) {
                VideoServices.update(v);
            } else {
                VideoServices.create(v);
            }

            resp.sendRedirect(req.getContextPath() + "/creator/video?message=saved");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lưu thất bại: " + e.getMessage());
            req.setAttribute("bean", bean); 
            req.setAttribute("categories", CategoryServices.findAll()); 
            req.getRequestDispatcher("/creator/form.jsp").forward(req, resp);
        }
    }
}