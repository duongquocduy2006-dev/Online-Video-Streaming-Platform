package entities;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "Category")
public class Category {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(columnDefinition = "nvarchar(100)")
	private String name;

	private boolean status = true;

	@OneToMany(mappedBy = "category")
	private List<Video> videos;

	// Getter & Setter
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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
}