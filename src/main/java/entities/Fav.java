package entities;

import jakarta.persistence.*;

@Entity
@Table(name = "Fav", uniqueConstraints = { @UniqueConstraint(columnNames = { "userId", "videoId" }) })
public class Fav {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@ManyToOne
	@JoinColumn(name = "userId")
	private User user;

	@ManyToOne
	@JoinColumn(name = "videoId")
	private Video video;

	// Getter & Setter
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Video getVideo() {
		return video;
	}

	public void setVideo(Video video) {
		this.video = video;
	}
}