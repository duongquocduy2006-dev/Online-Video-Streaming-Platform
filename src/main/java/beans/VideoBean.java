package beans;

import java.util.HashMap;
import java.util.Map;
import lombok.Data;
import services.CategoryServices;

@Data
public class VideoBean {
    private String id; 
    private String title;
    private String url; 
    private String poster; 
    private String description;
    private String catId; 
    private boolean status;

    public Map<String, String> validate() {
        Map<String, String> errors = new HashMap<>();
        
        // 1. Validate ID (Chỉ cần khi UPDATE/DELETE)
        if (id != null && !id.trim().isEmpty()) {
             try {
                Integer.parseInt(id);
             } catch (NumberFormatException e) {
                 errors.put("id", "ID video không hợp lệ.");
             }
        }

        // 2. Validate Title (Bắt buộc)
        if (title == null || title.trim().isEmpty()) {
            errors.put("title", "Tiêu đề không được để trống.");
        }

        // 3. Validate URL (ID Youtube Format - Bắt buộc)
        String youtubeIdRegex = "^[a-zA-Z0-9_-]+$";
        if (url == null || url.trim().isEmpty()) {
            errors.put("url", "ID Youtube không được để trống.");
        } else if (!url.matches(youtubeIdRegex)) {
             errors.put("url", "ID Youtube chứa ký tự không hợp lệ.");
        }
        
        // 4. Validate Category ID (Phải là số nguyên hợp lệ và phải tồn tại trong DB)
        if (catId == null || catId.trim().isEmpty()) {
            errors.put("catId", "Vui lòng chọn một danh mục.");
        } else {
            try {
                int categoryId = Integer.parseInt(catId);
                if (CategoryServices.findById(categoryId) == null) {
                    errors.put("catId", "Danh mục không tồn tại.");
                }
            } catch (NumberFormatException e) {
                 errors.put("catId", "Giá trị danh mục không hợp lệ.");
            } catch (Exception e) {
                 errors.put("catId", "Lỗi kiểm tra CSDL.");
            }
        }
        
        // Poster và Description đã trở thành tùy chọn, không cần check rỗng ở đây.

        return errors;
    }
}