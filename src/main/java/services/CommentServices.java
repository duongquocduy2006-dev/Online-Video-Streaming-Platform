package services;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import entities.Comment;
import utils.Utils;

public class CommentServices {

    // 1. Thêm mới
    public static void create(Comment comment) throws Exception {
        EntityManager em = Utils.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(comment);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    // 2. Cập nhật
    public static void update(int cmtId, String newContent) throws Exception {
        EntityManager em = Utils.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Comment comment = em.find(Comment.class, cmtId);
            if (comment != null) {
                comment.setContent(newContent);
                em.merge(comment);
            }
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

 // --- SỬA LẠI HÀM DELETE ---
    public static void delete(int commentId) throws Exception {
        EntityManager em = Utils.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Comment comment = em.find(Comment.class, commentId);
            
            if (comment != null) {
                // TRƯỜNG HỢP 1: Xóa Comment CON (Reply)
                if (comment.getParentComment() != null) {
                    Comment parent = comment.getParentComment();
                    
                    // Bước 1: Xóa comment con khỏi list replies của cha
                    // Dùng removeIf để đảm bảo xóa đúng ID (tránh lỗi nếu chưa override equals)
                    if (parent.getReplies() != null) {
                        parent.getReplies().removeIf(reply -> reply.getId() == comment.getId());
                    }
                    
                    // Bước 2: Merge cha. 
                    // Nhờ orphanRemoval=true trong Entity, Hibernate sẽ tự động xóa con khỏi DB
                    em.merge(parent);
                    
                } 
                // TRƯỜNG HỢP 2: Xóa Comment CHA (Cấp 1)
                else {
                    // Khi xóa cha, CascadeType.ALL sẽ tự động xóa hết các comment con
                    em.remove(comment);
                }
            }
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            e.printStackTrace(); // In lỗi ra console để debug nếu có
            throw e;
        } finally {
            em.close();
        }
    }
    // 4. Lấy danh sách (Chỉ lấy cha)
    public static List<Comment> findByVideoId(int videoId) {
        EntityManager em = Utils.getEntityManager();
        try {
            String jpql = "SELECT c FROM Comment c WHERE c.video.id = :vid AND c.parentComment IS NULL ORDER BY c.createAt DESC";
            TypedQuery<Comment> query = em.createQuery(jpql, Comment.class);
            query.setParameter("vid", videoId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    // 5. Đếm số lượng
    public static long count() {
        EntityManager em = Utils.getEntityManager();
        try {
            return em.createQuery("SELECT count(c) FROM Comment c", Long.class).getSingleResult();
        } finally {
            em.close();
        }
    }
    
    // 6. Lấy tất cả (Dành cho trang Admin)
    public static List<Comment> findAll() {
        EntityManager em = Utils.getEntityManager();
        try {
            return em.createQuery("SELECT c FROM Comment c ORDER BY c.createAt DESC", Comment.class).getResultList();
        } finally {
            em.close();
        }
    }
    
    // (Bổ sung thêm findById để tránh lỗi nếu controller gọi)
    public static Comment findById(int id) {
        EntityManager em = Utils.getEntityManager();
        try {
            return em.find(Comment.class, id);
        } finally {
            em.close();
        }
    }
    
    
 // Trong class CommentServices
    public static List<Comment> searchByContent(String keyword) {
        EntityManager em = Utils.getEntityManager();
        try {
            // Tìm kiếm gần đúng (LIKE) theo cột content
            String jpql = "SELECT c FROM Comment c WHERE c.content LIKE :key ORDER BY c.createAt DESC";
            TypedQuery<Comment> query = em.createQuery(jpql, Comment.class);
            query.setParameter("key", "%" + keyword + "%");
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}