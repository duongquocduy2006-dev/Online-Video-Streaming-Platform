package services;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import entities.User;
import utils.Utils;

public class UserServices {

    public static User login(String username, String password) {
        EntityManager em = Utils.getEntityManager();
        try {
            String jpql = "SELECT u FROM User u WHERE (u.username = :uid OR u.email = :uid) AND u.password = :pwd";
            TypedQuery<User> query = em.createQuery(jpql, User.class);
            query.setParameter("uid", username);
            query.setParameter("pwd", password);
            return query.getSingleResult();
        } catch (Exception e) {
            return null;
        } finally {
            em.close();
        }
    }


	
	
    public static User findById(int id) {
        EntityManager em = Utils.getEntityManager();
        try {
            return em.find(User.class, id);
        } finally {
        	em.close();
        }
    }

    // Hàm hỗ trợ Controller check trùng Username
    public static User findByUsername(String username) {
        EntityManager em = Utils.getEntityManager();
        try {
            String jpql = "SELECT u FROM User u WHERE u.username = :uid";
            TypedQuery<User> query = em.createQuery(jpql, User.class);
            query.setParameter("uid", username);
            return query.getSingleResult();
        } catch (Exception e) {
            return null;
        } finally {
            em.close();
        }
    }

    // Hàm hỗ trợ Controller check trùng Email
    public static User findByEmail(String email) {
        EntityManager em = Utils.getEntityManager();
        try {
            String jpql = "SELECT u FROM User u WHERE u.email = :mail";
            TypedQuery<User> query = em.createQuery(jpql, User.class);
            query.setParameter("mail", email);
            return query.getSingleResult();
        } catch (Exception e) {
            return null;
        } finally {
            em.close();
        }
    }

    public static List<User> findAll() {
        EntityManager em = Utils.getEntityManager();
        try {
            return em.createQuery("SELECT u FROM User u", User.class).getResultList();
        } finally {
            em.close();
        }
    }

    public static void create(User user) throws Exception {
        EntityManager em = Utils.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(user);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public static void update(User user) throws Exception {
        EntityManager em = Utils.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(user);
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
            return em.createQuery("SELECT count(u) FROM User u", Long.class).getSingleResult();
        } finally {
            em.close();
        }
    }
    
    public static List<User> searchByName(String keyword) {
        EntityManager em = Utils.getEntityManager();
        try {
            // Tìm kiếm trong cả Username và Name
            String jpql = "SELECT u FROM User u WHERE u.username LIKE :key OR u.name LIKE :key";
            TypedQuery<User> query = em.createQuery(jpql, User.class);
            query.setParameter("key", "%" + keyword + "%");
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
 // Đếm User đang hoạt động (Status = 1)
    public static long countActive() {
        EntityManager em = Utils.getEntityManager();
        try {
            return em.createQuery("SELECT count(u) FROM User u WHERE u.status = true", Long.class).getSingleResult();
        } finally {
            em.close();
        }
    }

    // Đếm User bị khóa (Status = 0)
    public static long countInactive() {
        EntityManager em = Utils.getEntityManager();
        try {
            return em.createQuery("SELECT count(u) FROM User u WHERE u.status = false", Long.class).getSingleResult();
        } finally {
            em.close();
        }
    }
}