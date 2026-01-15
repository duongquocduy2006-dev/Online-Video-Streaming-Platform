package services;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import entities.Category;
import utils.Utils;

public class CategoryServices {

    public static List<Category> findAll() {
        EntityManager em = Utils.getEntityManager();
        try {
            return em.createQuery("SELECT c FROM Category c", Category.class).getResultList();
        } finally {
            em.close();
        }
    }

    public static Category findById(int id) {
        EntityManager em = Utils.getEntityManager();
        try {
            return em.find(Category.class, id);
        } finally {
            em.close();
        }
    }
    
    // =======================================================
    // HÀM BỔ SUNG CHO BEAN VALIDATION (CHECK TRÙNG LẶP)
    // =======================================================
    /**
     * Tìm kiếm danh mục theo Tên. Dùng để kiểm tra trùng lặp trong CategoryBean.
     */
    public static Category findByName(String name) {
        EntityManager em = Utils.getEntityManager();
        try {
            // JPQL: So sánh không phân biệt hoa thường và lấy 1 kết quả duy nhất
            String jpql = "SELECT c FROM Category c WHERE LOWER(c.name) = :name";
            TypedQuery<Category> query = em.createQuery(jpql, Category.class);
            query.setParameter("name", name.toLowerCase());
            return query.getSingleResult(); 
        } catch (Exception e) {
            return null; // Trả về null nếu không tìm thấy
        } finally {
            em.close();
        }
    }

    // =======================================================
    // HÀM CRUD (Giữ nguyên)
    // =======================================================
    
    public static void create(Category category) throws Exception {
        EntityManager em = Utils.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(category);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public static void update(Category category) throws Exception {
        EntityManager em = Utils.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(category);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public static void delete(int id) throws Exception {
        EntityManager em = Utils.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Category category = em.find(Category.class, id);
            if (category != null) {
                em.remove(category);
            }
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e; 
        } finally {
            em.close();
        }
    }
}