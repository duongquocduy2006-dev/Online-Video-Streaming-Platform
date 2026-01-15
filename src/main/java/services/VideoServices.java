package services;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import entities.Video;
import utils.Utils;

public class VideoServices {

	// Trong VideoServices.java
	public static Video findById(int id) {
	    EntityManager em = Utils.getEntityManager();
	    try {
	        Video v = em.find(Video.class, id);
	        if (v != null) {
	            // Mẹo: Gọi getter để Hibernate nạp dữ liệu trước khi đóng session
	            v.getCategory().getName(); 
	            v.getUser().getName();
	        }
	        return v;
	    } finally {
	        em.close();
	    }
	}

    public static List<Video> findAll() {
        EntityManager em = Utils.getEntityManager();
        try {
            return em.createQuery("SELECT v FROM Video v", Video.class).getResultList();
        } finally {
            em.close();
        }
    }

    public static List<Video> findAllActive() {
        EntityManager em = Utils.getEntityManager();
        try {
            String jpql = "SELECT v FROM Video v WHERE v.status = true ORDER BY v.createAt DESC";
            return em.createQuery(jpql, Video.class).getResultList();
        } finally {
            em.close();
        }
    }

    public static List<Video> findByUserId(int userId) {
        EntityManager em = Utils.getEntityManager();
        try {
            String jpql = "SELECT v FROM Video v WHERE v.user.id = :uid";
            TypedQuery<Video> query = em.createQuery(jpql, Video.class);
            query.setParameter("uid", userId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public static List<Video> findByCategory(int catId) {
        EntityManager em = Utils.getEntityManager();
        try {
            String jpql = "SELECT v FROM Video v WHERE v.category.id = :cid AND v.status = true";
            TypedQuery<Video> query = em.createQuery(jpql, Video.class);
            query.setParameter("cid", catId);
            return query.setMaxResults(6).getResultList();
        } finally {
            em.close();
        }
    }

    public static void create(Video video) throws Exception {
        EntityManager em = Utils.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(video);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public static void update(Video video) throws Exception {
        EntityManager em = Utils.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(video);
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
            Video video = em.find(Video.class, id);
            if (video != null) {
                em.remove(video);
            }
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }
    
    public static long count() {
        jakarta.persistence.EntityManager em = utils.Utils.getEntityManager();
        try {
            return em.createQuery("SELECT count(v) FROM Video v", Long.class).getSingleResult();
        } finally {
            em.close();
        }
    }
    
    public static List<Video> searchByTitle(String keyword) {
        EntityManager em = Utils.getEntityManager();
        try {
            String jpql = "SELECT v FROM Video v WHERE v.title LIKE :key AND v.status = true";
            TypedQuery<Video> query = em.createQuery(jpql, Video.class);
            query.setParameter("key", "%" + keyword + "%");
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    

 // Thống kê số lượng video đăng trong 6 tháng gần nhất
 public static List<Object[]> countVideoByLast6Months() {
     EntityManager em = Utils.getEntityManager();
     try {
         // Query SQL Native (Dành cho SQL Server)
         // Lấy tháng và đếm số video, group by tháng
         String sql = "SELECT MONTH(createAt) as Thang, COUNT(id) as SoLuong " +
                      "FROM Video " +
                      "WHERE createAt >= DATEADD(MONTH, -6, GETDATE()) " +
                      "GROUP BY MONTH(createAt) " +
                      "ORDER BY MONTH(createAt)";
         
         return em.createNativeQuery(sql).getResultList();
     } catch (Exception e) {
         return new java.util.ArrayList<>(); // Trả về list rỗng nếu lỗi
     } finally {
         em.close();
     }
 }
}