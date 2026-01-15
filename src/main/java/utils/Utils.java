package utils;

import java.security.MessageDigest;



// PHẦN WEB: Vẫn dùng Javax (Tomcat 9)
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
public class Utils {

	    private static EntityManagerFactory factory;

	    public static synchronized EntityManager getEntityManager() {
	        if (factory == null || !factory.isOpen()) {
	            factory = Persistence.createEntityManagerFactory("PolyOE"); 
	        }
	        return factory.createEntityManager();
	    }

	    public static void close() {
	        if (factory != null && factory.isOpen()) {
	            factory.close();
	        }
	    }

    public static void addCookie(HttpServletResponse resp, String name, String value, int hours) {
        Cookie cookie = new Cookie(name, value);
        cookie.setMaxAge(hours * 60 * 60);
        cookie.setPath("/");
        resp.addCookie(cookie);
    }

    public static String getCookie(HttpServletRequest req, String name) {
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equalsIgnoreCase(name)) {
                    return cookie.getValue();
                }
            }
        }
        return "";
    }
    
    public static String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(password.getBytes());
            byte[] byteData = md.digest();
            StringBuilder sb = new StringBuilder();
            for (byte b : byteData) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }
}