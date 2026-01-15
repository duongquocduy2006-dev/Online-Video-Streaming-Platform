package beans;

import java.util.HashMap;
import java.util.Map;
import lombok.Data;
import services.CategoryServices; // Import Service để check Category (dù không dùng, nhưng nên có)

@Data
public class CommentBean {
    private String videoId; // ID video đang comment (dạng String từ form)
    private String content;

    public Map<String, String> validate() {
        Map<String, String> errors = new HashMap<>();

        // 1. Kiểm tra videoId (Phải là số nguyên)
        if (videoId == null || videoId.trim().isEmpty()) {
             errors.put("videoId", "Không tìm thấy ID video.");
        } else {
             try {
                 Integer.parseInt(videoId);
             } catch (NumberFormatException e) {
                 errors.put("videoId", "ID video không hợp lệ.");
             }
        }
        
        // 2. Kiểm tra nội dung
        if (content == null || content.trim().isEmpty()) {
            errors.put("content", "Nội dung bình luận không được để trống.");
        } else if (content.length() > 500) {
            errors.put("content", "Bình luận quá dài (tối đa 500 ký tự).");
        }

        return errors;
    }
}