package entities;

import jakarta.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "Comment")
public class Comment {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(columnDefinition = "nvarchar(MAX)")
	private String content;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createAt = new Date();

	private boolean status = true;

	@ManyToOne
	@JoinColumn(name = "userId")
	private User user;

	@ManyToOne
	@JoinColumn(name = "videoId")
	private Video video;

	// --- QUAN HỆ CHA CON ---
	@ManyToOne
	@JoinColumn(name = "parentId")
	private Comment parentComment;

	// SỬA DÒNG NÀY: Thêm cascade = CascadeType.ALL, orphanRemoval = true
	// Ý nghĩa: Khi xóa cha, JPA sẽ tự động xóa tất cả con cháu liên quan
	@OneToMany(mappedBy = "parentComment", fetch = FetchType.EAGER, cascade = CascadeType.ALL, orphanRemoval = true)
	private List<Comment> replies;

	// --- GETTER & SETTER ---
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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

	public Video getVideo() {
		return video;
	}

	public void setVideo(Video video) {
		this.video = video;
	}

	public Comment getParentComment() {
		return parentComment;
	}

	public void setParentComment(Comment parentComment) {
		this.parentComment = parentComment;
	}

	public List<Comment> getReplies() {
		return replies;
	}

	public void setReplies(List<Comment> replies) {
		this.replies = replies;
	}
}