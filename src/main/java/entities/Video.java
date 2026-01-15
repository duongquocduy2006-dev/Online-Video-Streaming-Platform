package entities;

import jakarta.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "Video")
public class Video {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(columnDefinition = "nvarchar(255)", nullable = false) // Title: Bắt buộc
	private String title;

	// SỬA LỖI: Cho phép NULL vì form không bắt buộc nhập mô tả
	@Column(columnDefinition = "nvarchar(MAX)", nullable = true) 
	private String description; 

	@Column(columnDefinition = "varchar(MAX)", nullable = false)
	private String url;

	// SỬA LỖI: Cho phép NULL vì Poster được tạo tự động/có thể không có (nếu URL sai)
	@Column(columnDefinition = "varchar(MAX)", nullable = true) 
	private String poster;

	private int viewcount = 0;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "createAt")
	private Date createAt = new Date(); 

	private boolean status = true;

	@ManyToOne
    @JoinColumn(name = "userId", nullable = false) 
    private User user;

    @ManyToOne
    @JoinColumn(name = "catId", nullable = false) 
    private Category category;

    @OneToMany(mappedBy = "video", cascade = CascadeType.REMOVE, orphanRemoval = true) 
    private List<Comment> comments;

    @OneToMany(mappedBy = "video", cascade = CascadeType.REMOVE, orphanRemoval = true) 
    private List<Fav> favorites;


	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getPoster() {
		return poster;
	}

	public void setPoster(String poster) {
		this.poster = poster;
	}

	public int getViewcount() {
		return viewcount;
	}

	public void setViewcount(int viewcount) {
		this.viewcount = viewcount;
	}

	public Date getCreateAt() {
		return createAt;
	}

	public void setCreateAt(Date createAt) {
		this.createAt = createAt;
	}

	public boolean isStatus() {
		return status;
	}

	public void setStatus(boolean status) {
		this.status = status;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public List<Comment> getComments() {
		return comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}

	public List<Fav> getFavorites() {
		return favorites;
	}

	public void setFavorites(List<Fav> favorites) {
		this.favorites = favorites;
	}
}