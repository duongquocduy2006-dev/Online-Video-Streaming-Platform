package controllers;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.apache.commons.beanutils.BeanUtils;
import beans.CategoryBean;
import entities.*;
import services.*;

@WebServlet({"/admin/dashboard", "/admin/users", "/admin/user/toggle", 
    "/admin/categories", "/admin/category/save", "/admin/category/edit", "/admin/category/delete", 
    "/admin/user/setrole", 
    "/admin/comments", "/admin/comment/delete",
    "/admin/videos", "/admin/video/delete", "/admin/video/status", "/admin/export"
})
public class AdminController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        


        try {
            // --- DASHBOARD (THỐNG KÊ) ---
            if (path.contains("dashboard")) {
                long totalUsers = UserServices.count();
                long totalVideos = VideoServices.count();
                long totalComments = CommentServices.count();
                
                long activeUsers = UserServices.countActive();
                long inactiveUsers = UserServices.countInactive();

                req.setAttribute("totalUsers", totalUsers);
                req.setAttribute("totalVideos", totalVideos);
                req.setAttribute("totalComments", totalComments);
                
                req.setAttribute("activeUsers", activeUsers);
                req.setAttribute("inactiveUsers", inactiveUsers);
                
                
                List<Object[]> stats = VideoServices.countVideoByLast6Months();
                
                String chartLabels = "";
                String chartData = "";
                
                for (Object[] row: stats) {
                	chartLabels += "'Tháng" + row[0] + "',";
                	chartData += row[1] + ",";
                }
                
                if (chartLabels.length() > 0) {
                	chartLabels = chartLabels.substring(0, chartLabels.length() - 1);
                	chartData = chartData.substring(0, chartData.length() -1);
                	
                } else {
                	chartLabels = "'Tháng hiện tại'";
                	chartData = "0";
                	
                }
                
                req.setAttribute("chartLabels", chartLabels);
                req.setAttribute("chartData", chartData);
                
                req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, resp);
                return;
            }

            // --- QUẢN LÝ USER (READ & TOGGLE) ---
            if (path.contains("users")) {
            	String keyword = req.getParameter("keyword");
            	List<User> list;
            	
            	if (keyword != null && !keyword.trim().isEmpty()) {
            		list = UserServices.searchByName(keyword);
            	} else {
            		list = UserServices.findAll();
            	}
            	
                req.setAttribute("users", list);
                req.getRequestDispatcher("/admin/users.jsp").forward(req, resp);
                return;
            } 
            
            if (path.contains("user/toggle")) {
                int id = Integer.parseInt(req.getParameter("id"));
                User u = UserServices.findById(id);
                if (u != null) {
                    u.setStatus(!u.isStatus());
                    UserServices.update(u);
                }
                resp.sendRedirect(req.getContextPath() + "/admin/users");
                return;
            }

            // --- QUẢN LÝ DANH MỤC (LISTING & LOAD EDIT FORM) ---
            if (path.contains("categories")) {
                req.setAttribute("categories", CategoryServices.findAll());
                req.getRequestDispatcher("/admin/categories.jsp").forward(req, resp);
                return;
            }

            if (path.contains("category/edit")) {
                String idStr = req.getParameter("id");
                if (idStr != null) {
                    int id = Integer.parseInt(idStr);
                    Category c = CategoryServices.findById(id);
                    
                    // Copy Entity data to Bean for form pre-filling
                    CategoryBean bean = new CategoryBean();
                    BeanUtils.copyProperties(bean, c); 
                    req.setAttribute("bean", bean); 
                    req.setAttribute("category", c); // Để logic JSP biết là đang edit
                }
                
                req.setAttribute("categories", CategoryServices.findAll()); 
                req.getRequestDispatcher("/admin/categories.jsp").forward(req, resp);
                return;
            }

            // --- XÓA DANH MỤC ---
            if (path.contains("category/delete")) {
                int id = Integer.parseInt(req.getParameter("id"));
                CategoryServices.delete(id); 
                
                resp.sendRedirect(req.getContextPath() + "/admin/categories?message=deleted");
                return;
            }
            
            // --- SET ROLE ---
            if (path.contains("user/setrole")) {
                int id = Integer.parseInt(req.getParameter("id"));
                String newRole = req.getParameter("role");
                
                User u = UserServices.findById(id);
                if (u != null && !u.getRole().equalsIgnoreCase("admin")) {
                    u.setRole(newRole);
                    UserServices.update(u);
                }
                resp.sendRedirect(req.getContextPath() + "/admin/users");
                return;
            }
            
            // Trong doGet của AdminController
            if (path.contains("comments")) {
            	String keyword = req.getParameter("keyword");
            	List<Comment> list;
            	
            	if (keyword != null && !keyword.trim().isEmpty()) {
            		list = CommentServices.searchByContent(keyword);
            		req.setAttribute("keyword", keyword); //lưu từ khóa để nó hiện thị trên ô input
            	} else {
            		list = CommentServices.findAll();
            	}
                req.setAttribute("comments", list);
                req.getRequestDispatcher("/admin/comments.jsp").forward(req, resp);
                return;
            }
            
            if (path.contains("comment/delete")) {
                int id = Integer.parseInt(req.getParameter("id"));
                CommentServices.delete(id);
                resp.sendRedirect(req.getContextPath() + "/admin/comments"); // Quay lại trang list comment
                return;
            }
            
            if (path.contains("videos")) {
            	// lấy tất cả video kể cả ẩn hiện
            	req.setAttribute("videos", VideoServices.findAll());
            	req.getRequestDispatcher("/admin/videos.jsp").forward(req, resp);
            	return;
            }
            
            if (path.contains("video/delete")) {
            	int id = Integer.parseInt(req.getParameter("id"));
            	VideoServices.delete(id);
            	resp.sendRedirect(req.getContextPath() + "/admin/videos?message=deleted");
            	return;
            }
            
            if (path.contains("video/status")) {
            	int id = Integer.parseInt(req.getParameter("id"));
            	Video v = VideoServices.findById(id);
            	if (v != null) {
            		v.setStatus(!v.isStatus());
            		VideoServices.update(v);
            		
            	}
            	resp.sendRedirect(req.getContextPath() + "/admin/videos");
            }
            
            if (path.contains("export")) {
            	long totalUsers = UserServices.count();
            	long activeUsers = UserServices.countActive();
            	long inactiveUsers = UserServices.countInactive();
            	long totalVideos = VideoServices.count();
            	long totalComments = CommentServices.count();
            	
            	resp.setContentType("application/msword");    //text/csv; charset=UTF-8
            	resp.setCharacterEncoding("UTF-8");
            	resp.setHeader("Content-Disposition", "attachment; filename=PolyOE_Report.doc");
            	
            	try (java.io.PrintWriter out = resp.getWriter()) {
                    out.println("<html>");
                    out.println("<head>");
                    out.println("<meta charset='utf-8'>"); // Quan trọng để hiện tiếng Việt
                    out.println("<style>");
                    out.println("body { font-family: 'Times New Roman', serif; padding: 20px; }");
                    out.println(".header { text-align: center; margin-bottom: 30px; }");
                    out.println("h1 { color: #2980b9; text-transform: uppercase; }");
                    out.println("table { width: 100%; border-collapse: collapse; margin-top: 20px; }");
                    out.println("th, td { border: 1px solid #000; padding: 12px; text-align: left; font-size: 14pt; }");
                    out.println("th { background-color: #f2f2f2; font-weight: bold; }");
                    out.println(".footer { margin-top: 50px; text-align: right; font-style: italic; }");
                    out.println("</style>");
                    out.println("</head>");
                    out.println("<body>");
                    
                    // --- PHẦN TIÊU ĐỀ ---
                    out.println("<div class='header'>");
                    out.println("<h3>CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM</h3>");
                    out.println("<h4>Độc lập - Tự do - Hạnh phúc</h4>");
                    out.println("<hr style='width: 200px; margin: 20px auto;'>");
                    out.println("<h1>BÁO CÁO TỔNG HỢP HỆ THỐNG POLYOE</h1>");
                    out.println("<p>Ngày xuất báo cáo: " + new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(new java.util.Date()) + "</p>");
                    out.println("</div>");
                    
                    // --- PHẦN BẢNG DỮ LIỆU ---
                    out.println("<h3>I. Số liệu chi tiết:</h3>");
                    out.println("<table>");
                    out.println("  <tr>");
                    out.println("    <th style='width: 10%'>STT</th>");
                    out.println("    <th style='width: 50%'>Danh mục thống kê</th>");
                    out.println("    <th style='width: 40%'>Số lượng ghi nhận</th>");
                    out.println("  </tr>");
                    
                    out.println("  <tr><td>1</td><td>Tổng số Người dùng</td><td><strong>" + totalUsers + "</strong> tài khoản</td></tr>");
                    out.println("  <tr><td>2</td><td>Users Đang hoạt động</td><td>" + activeUsers + "</td></tr>");
                    out.println("  <tr><td>3</td><td>Users Bị khóa</td><td>" + inactiveUsers + "</td></tr>");
                    out.println("  <tr><td>4</td><td>Tổng số Video</td><td><strong>" + totalVideos + "</strong> video</td></tr>");
                    out.println("  <tr><td>5</td><td>Tổng lượt Bình luận</td><td>" + totalComments + " lượt</td></tr>");
                    
                    out.println("</table>");
                    
                    // --- PHẦN CHỮ KÝ ---
                    out.println("<div class='footer'>");
                    out.println("<p>Cần Thơ, ngày ... tháng ... năm 2025</p>");
                    out.println("<p><strong>Người lập báo cáo</strong></p>");
                    out.println("<br><br><br>");
                    out.println("<p>Admin System</p>");
                    out.println("</div>");
                    
                    out.println("</body>");
                    out.println("</html>");
                }
                return;
            }
            
            
            
        } catch (Exception e) {
            e.printStackTrace();
            // Nếu lỗi xảy ra ở trang danh mục, cố gắng load lại danh sách để hiện lỗi
            if (path.contains("category")) {
            	
            	String msg = e.getMessage();
            	
            	
            	if (msg != null && (msg.contains("committing") || msg.contains("Constraint"))) {
                    req.setAttribute("error", "KHÔNG THỂ XÓA: DANH MỤC NÀY ĐANG CHỨA VIDEO, VUI LÒNG XÓA VIDEO TRƯỚC!");
            	}else {
            		req.setAttribute("error", "Lỗi hệ thống: " + msg);
            	}
                req.setAttribute("categories", CategoryServices.findAll());
                req.getRequestDispatcher("/admin/categories.jsp").forward(req, resp);
            } else {
                resp.sendRedirect(req.getContextPath() + "/error");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();

        // --- LƯU DANH MỤC (THÊM / SỬA) ---
        if (path.contains("category/save")) {
            Category c = new Category();
            CategoryBean bean = new CategoryBean();
            
            try {
                // 1. Đổ dữ liệu từ Form vào Bean
                BeanUtils.populate(bean, req.getParameterMap());
                
                // Set ID vào Bean để Validate biết đây là Update
                String idStr = req.getParameter("id");
                if (idStr != null && !idStr.isEmpty()) {
                    bean.setId(Integer.parseInt(idStr));
                }
                
                // 2. Validate TOÀN BỘ (Rỗng + Trùng lặp)
                Map<String, String> errors = bean.validate();

                if (!errors.isEmpty()) {
                    // CÓ LỖI: Quay lại form
                    req.setAttribute("errors", errors);
                    req.setAttribute("bean", bean); 
                    // Nếu đang sửa, cần lấy lại entity gốc để JSP hiện nút cập nhật
                    if (bean.getId() != null) {
                        req.setAttribute("category", CategoryServices.findById(bean.getId()));
                    }
                    req.setAttribute("categories", CategoryServices.findAll()); 
                    req.getRequestDispatcher("/admin/categories.jsp").forward(req, resp);
                    return; 
                }

                // 3. KHÔNG CÓ LỖI: Tiến hành lưu DB
                if (bean.getId() != null) {
                    // Update
                    c = CategoryServices.findById(bean.getId());
                    c.setName(bean.getName());
                    CategoryServices.update(c);
                } else {
                    // Create
                    c.setName(bean.getName());
                    c.setStatus(true);
                    CategoryServices.create(c);
                }
                
                resp.sendRedirect(req.getContextPath() + "/admin/categories?message=saved");
                
            } catch (Exception e) {
                e.printStackTrace();
                req.setAttribute("error", "Lưu thất bại: " + e.getMessage());
                
                // Tái tạo trạng thái lỗi
                req.setAttribute("categories", CategoryServices.findAll());
                req.setAttribute("bean", bean); 
                req.getRequestDispatcher("/admin/categories.jsp").forward(req, resp);
            }
        }
    }
}