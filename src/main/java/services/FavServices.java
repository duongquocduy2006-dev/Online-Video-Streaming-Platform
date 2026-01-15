package services;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import entities.Fav;
import entities.User;
import entities.Video;
import utils.Utils;

public class FavServices {

    public static void like(int userId, int videoId) throws Exception {
        EntityManager em = Utils.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            if (!isLiked(userId, videoId)) {
                Fav fav = new Fav();
                User u = em.find(User.class, userId);
                Video v = em.find(Video.class, videoId);
                fav.setUser(u);
                fav.setVideo(v);
                em.persist(fav);
            }
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public static void unlike(int userId, int videoId) throws Exception {
        EntityManager em = Utils.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            String jpql = "SELECT f FROM Fav f WHERE f.user.id = :uid AND f.video.id = :vid";
            Fav fav = em.createQuery(jpql, Fav.class)
                        .setParameter("uid", userId)
                        .setParameter("vid", videoId)
                        .getSingleResult();
            if (fav != null) {
                em.remove(fav);
            }
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }
    
    public static boolean isLiked(int userId, int videoId) {
        EntityManager em = Utils.getEntityManager();
        try {
            String jpql = "SELECT count(f) FROM Fav f WHERE f.user.id = :uid AND f.video.id = :vid";
            long count = em.createQuery(jpql, Long.class)
                        .setParameter("uid", userId)
                        .setParameter("vid", videoId)
                        .getSingleResult();
            return count > 0;
        } finally {
            em.close();
        }
    }

    public static List<Video> findVideosByUser(int userId) {
        EntityManager em = Utils.getEntityManager();
        try {
            String jpql = "SELECT f.video FROM Fav f WHERE f.user.id = :uid AND f.video.status = true";
            
            TypedQuery<Video> query = em.createQuery(jpql, Video.class);
            query.setParameter("uid", userId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}