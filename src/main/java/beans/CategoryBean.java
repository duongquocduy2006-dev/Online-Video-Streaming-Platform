package beans;

import java.util.HashMap;
import java.util.Map;
import lombok.Data;
import entities.Category;
import services.CategoryServices;

//TESTTTTTTT
@Data
public class CategoryBean {
    private Integer id; // Dùng cho việc update
    private String name;

    public Map<String, String> validate() {
        Map<String, String> errors = new HashMap<>();

        // 1. Kiểm tra Rỗng
        if (name == null || name.trim().isEmpty()) {
            errors.put("name", "Tên danh mục không được để trống.");
        }
        
        // 2. Kiểm tra Trùng lặp (Business Logic)
        if (!errors.containsKey("name")) {
            try {
                // Giả sử có một hàm findByName trong CategoryServices
                Category existingCategory = CategoryServices.findByName(name);
                
                // Logic: Nếu tìm thấy một Category có tên trùng KHÁC với ID của Bean đang xét
                // Nếu ID là null (thêm mới), thì existingCategory phải là null
                if (existingCategory != null) {
                    // SỬA: Dùng equals() để so sánh an toàn ID, hoặc check ID không phải null
                    if (id == null || existingCategory.getId() != id.intValue()) {
                        errors.put("name", "Danh mục này đã tồn tại.");
                    }
                }
            } catch (Exception e) {
                // Lỗi DB, không nên chặn validation, chỉ log
                e.printStackTrace(); 
            }
        }
        
        return errors;
    }
}