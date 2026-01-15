package entities;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "Users")
public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private int id;

	@Column(name = "username", unique = true, nullable = false)
	private String username;

	@Column(name = "password", nullable = false)
	private String password;

	@Column(name = "name", columnDefinition = "nvarchar(100)")
	private String name;

	@Column(name = "email", unique = true, nullable = false)
	private String email;

	// --- ĐÃ XÓA PHONE Ở ĐÂY ---

	@Column(name = "role")
	private String role = "user";

	@Column(name = "status")
	private boolean status = true;

	// --- CÁC MỐI QUAN HỆ ---
	@OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
	private List<Video> videos;

	@OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
	private List<Fav> favorites;

	@OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
	private List<Comment> comments;

	// --- CONSTRUCTOR ---
	public User() {
	}

	// --- GETTER & SETTER ---
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	// --- ĐÃ XÓA GETTER/SETTER PHONE ---

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public boolean isStatus() {
		return status;
	}

	public void setStatus(boolean status) {
		this.status = status;
	}

	public List<Video> getVideos() {
		return videos;
	}

	public void setVideos(List<Video> videos) {
		this.videos = videos;
	}

	public List<Fav> getFavorites() {
		return favorites;
	}

	public void setFavorites(List<Fav> favorites) {
		this.favorites = favorites;
	}

	public List<Comment> getComments() {
		return comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}
}