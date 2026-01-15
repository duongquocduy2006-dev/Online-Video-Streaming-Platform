<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<title>${video.title}-PolyOETheater</title>
<jsp:include page="/common/head.jsp" />

<link
	href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;700;800&family=Plus+Jakarta+Sans:wght@400;500;600&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css"
	rel="stylesheet">

<style>
:root {
	--neon-cyan: #00d2ff;
	--neon-pink: #ff416c;
	--text-main: #e0e0e0;
	--bg-glass: rgba(255, 255, 255, 0.05);
	--border-glass: 1px solid rgba(255, 255, 255, 0.1);
	--radius-xl: 24px;
}

body {
	font-family: 'Plus Jakarta Sans', sans-serif;
	/* Thêm màu nền dự phòng màu tối nếu gradient lỗi */
	background-color: #0f0c29;
	background: linear-gradient(135deg, #0f0c29 0%, #302b63 50%, #24243e 100%)
		fixed;
	color: var(--text-main);
	min-height: 100vh;
	overflow-x: hidden;
	/* --- SỬA LỖI ĐÈ HEADER --- */
	/* Đẩy nội dung xuống 100px để tránh bị Header (nếu là fixed) che mất */
	padding-top: 100px;
}

/* Container chính */
.main-content-container {
	position: relative;
	z-index: 5; /* Đảm bảo nội dung nổi lên trên các lớp nền */
}

.video-stage-wrapper {
	position: relative;
	margin-bottom: 2rem;
	z-index: 10;
}

.video-glow-effect {
	position: absolute;
	top: 10%;
	left: 5%;
	width: 90%;
	height: 80%;
	background: linear-gradient(135deg, var(--neon-cyan), var(--neon-pink));
	filter: blur(60px);
	opacity: 0.3;
	z-index: -1;
}

.video-frame {
	border-radius: var(--radius-xl);
	overflow: hidden;
	box-shadow: 0 0 50px rgba(0, 0, 0, 0.5);
	background: #000;
	border: 1px solid rgba(255, 255, 255, 0.15);
}

.video-title-main {
	font-family: 'Outfit', sans-serif;
	font-weight: 800;
	font-size: 2.2rem;
	color: #fff;
	text-shadow: 0 0 20px rgba(0, 210, 255, 0.3);
	margin-bottom: 1.5rem;
}

/* Button Styles */
.btn-magic {
	padding: 10px 24px;
	border-radius: 50px;
	font-weight: 700;
	display: inline-flex;
	align-items: center;
	gap: 8px;
	border: none;
	transition: 0.3s;
	cursor: pointer;
	text-decoration: none;
}

.btn-love {
	background: linear-gradient(135deg, #ff416c, #ff4b2b);
	color: #fff;
	box-shadow: 0 5px 15px rgba(255, 65, 108, 0.3);
}

.btn-liked {
	background: rgba(255, 65, 108, 0.1);
	border: 1px solid var(--neon-pink);
	color: var(--neon-pink);
	box-shadow: 0 0 15px rgba(255, 65, 108, 0.2);
}

.btn-glass {
	background: rgba(255, 255, 255, 0.1);
	border: 1px solid rgba(255, 255, 255, 0.2);
	color: #fff;
	backdrop-filter: blur(5px);
}

.glass-card {
	background: var(--bg-glass);
	backdrop-filter: blur(20px);
	border: var(--border-glass);
	border-radius: var(--radius-xl);
	padding: 30px;
}

/* Comment Styles */
.comment-bubble {
	padding: 16px;
	border-radius: 20px;
	display: flex;
	gap: 16px;
	border-bottom: 1px solid rgba(255, 255, 255, 0.05);
}

.avatar {
	width: 48px;
	height: 48px;
	border-radius: 14px;
	object-fit: cover;
}

.btn-action {
	text-decoration: none;
	font-size: 1rem;
	opacity: 0.7;
	transition: 0.3s;
	padding: 0 5px;
	cursor: pointer;
	border: none;
	background: none;
	color: inherit;
}

.btn-action:hover {
	opacity: 1;
	transform: scale(1.1);
}

.reply-container {
	margin-left: 60px;
	border-left: 2px solid rgba(255, 255, 255, 0.1);
	padding-left: 15px;
	margin-top: 10px;
}

.reply-form {
	display: none;
	margin-left: 64px;
	margin-top: 10px;
}

/* --- SỬA LỖI TRẮNG TRANG: TẮT ẨN NỘI DUNG --- */
.fade-up {
	/* opacity: 0;  <-- Đã comment dòng này lại để nội dung luôn hiện */
	animation: fadeUp 0.8s ease-out forwards;
}

@keyframes fadeUp {from { opacity:0; /* Chỉ ẩn lúc bắt đầu animation */
	transform: translateY(30px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}

/* Modal & Toast */
.modal-overlay {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.8);
	z-index: 9999;
	display: none;
	justify-content: center;
	align-items: center;
	backdrop-filter: blur(5px);
}

.modal-glass {
	background: #1a1a2e;
	border: 1px solid rgba(255, 255, 255, 0.1);
	box-shadow: 0 0 30px rgba(0, 210, 255, 0.3);
	padding: 30px;
	border-radius: 20px;
	width: 90%;
	max-width: 500px;
}

#toast {
	visibility: hidden;
	min-width: 250px;
	background-color: rgba(0, 210, 255, 0.1);
	color: #fff;
	text-align: center;
	border-radius: 50px;
	padding: 16px;
	position: fixed;
	z-index: 9999;
	left: 50%;
	bottom: 30px;
	transform: translateX(-50%);
	border: 1px solid var(--neon-cyan);
	backdrop-filter: blur(10px);
}

#toast.show {
	visibility: visible;
	opacity: 1;
	bottom: 50px;
}
</style>
</head>
<body>
	<jsp:include page="/common/header.jsp" />

	<div class="container main-content-container"
		style="max-width: 1320px;">
		<div class="row g-5">
			<div class="col-lg-8 fade-up">

				<div class="video-stage-wrapper">
					<div class="video-glow-effect"></div>
					<div class="video-frame ratio ratio-16x9">
						<iframe
							src="https://www.youtube.com/embed/${video.url}?rel=0&modestbranding=1"
							allowfullscreen style="border: 0;"></iframe>
					</div>
				</div>

				<div class="fade-up d-1">
					<h1 class="video-title-main">${video.title}</h1>

					<div class="d-flex justify-content-between align-items-center mb-4">
						<div class="d-flex gap-2">
							<span
								class="badge bg-transparent border border-secondary rounded-pill px-3 py-2">
								<i class="ri-eye-line text-info"></i> ${video.viewcount} views
							</span> <span
								class="badge bg-transparent border border-secondary rounded-pill px-3 py-2">
								<i class="ri-calendar-line text-warning"></i> ${video.createAt}
							</span>
						</div>

						<div class="d-flex gap-3">
							<c:if test="${not empty sessionScope.currentUser}">
								<button id="likeBtn"
									class="btn-magic ${isLiked ? 'btn-liked' : 'btn-love'}"
									onclick="toggleLike('${video.id}')">
									<i class="${isLiked ? 'ri-heart-3-fill' : 'ri-heart-3-line'}"
										id="likeIcon"></i> <span id="likeText">${isLiked ? 'Đã thích' : 'Thích'}</span>
								</button>
							</c:if>
							<button id="btnShare" class="btn-magic btn-glass">
								<i class="ri-share-forward-fill"></i> <span>Chia sẻ</span>
							</button>
						</div>
					</div>

					<div class="glass-card mb-5">
						<p class="mb-0 text-description"
							style="color: rgba(255, 255, 255, 0.8);">${not empty video.description ? video.description : 'Chưa có mô tả cho video này.'}
						</p>
					</div>
				</div>

				<div class="fade-up d-2">
					<h3 class="fw-bold mb-4 text-white">
						Bình luận <span class="badge rounded-pill bg-white text-dark fs-6">${comments.size()}</span>
					</h3>

					<c:if test="${not empty sessionScope.currentUser}">
						<form action="${pageContext.request.contextPath}/video/comment"
							method="POST" class="mb-5 d-flex gap-3 align-items-center">
							<input type="hidden" name="videoId" value="${video.id}">
							<img
								src="https://ui-avatars.com/api/?name=${sessionScope.currentUser.name}&background=random&size=128"
								class="avatar"> <input type="text" name="content"
								class="form-control bg-transparent text-white rounded-pill"
								placeholder="Viết bình luận..." required
								style="border: 1px solid rgba(255, 255, 255, 0.2); color: white;">
							<button class="btn btn-primary rounded-circle"
								style="width: 40px; height: 40px;">
								<i class="ri-send-plane-fill"></i>
							</button>
						</form>
					</c:if>

					<div class="d-flex flex-column gap-3">
						<c:forEach var="cmt" items="${comments}">
							<div>
								<div class="comment-bubble">
									<img
										src="https://ui-avatars.com/api/?name=${cmt.user.name}&background=random"
										class="avatar">
									<div class="flex-grow-1">
										<div class="d-flex align-items-center gap-2 mb-1">
											<span class="fw-bold text-white">${cmt.user.name}</span> <span
												class="text-muted small">${cmt.createAt}</span>
										</div>
										<p class="mb-1 text-white-50" id="content-${cmt.id}">${cmt.content}</p>

										<div class="d-flex gap-3 align-items-center mt-1">
											<c:if test="${not empty sessionScope.currentUser}">
												<button class="btn-action text-warning small"
													onclick="toggleReply(${cmt.id})">Trả lời</button>
											</c:if>

											<c:if
												test="${not empty sessionScope.currentUser and sessionScope.currentUser.id == cmt.user.id}">
												<div class="d-flex gap-2 align-self-center ms-2">
													<a href="#" onclick="openEditModal(${cmt.id}, ${video.id})"
														class="btn-action text-info" title="Sửa"> <i
														class="ri-pencil-line"></i>
													</a> <a
														href="${pageContext.request.contextPath}/video/comment/delete?cmtId=${cmt.id}&id=${video.id}"
														class="btn-action text-danger"
														onclick="return confirm('Bạn chắc chắn muốn xóa bình luận này?')"
														title="Xóa"> <i class="ri-delete-bin-line"></i>
													</a>
												</div>
											</c:if>
										</div>
									</div>
								</div>

								<div id="reply-form-${cmt.id}" class="reply-form">
									<form action="${pageContext.request.contextPath}/video/comment"
										method="POST" class="d-flex gap-2">
										<input type="hidden" name="videoId" value="${video.id}">
										<input type="hidden" name="parentId" value="${cmt.id}">
										<input type="text" name="content"
											class="form-control form-control-sm bg-transparent text-white rounded-pill border-secondary"
											placeholder="Trả lời ${cmt.user.name}...">
										<button class="btn btn-sm btn-warning rounded-circle">
											<i class="ri-reply-fill"></i>
										</button>
									</form>
								</div>

								<c:if test="${not empty cmt.replies}">
									<div class="reply-container d-flex flex-column gap-2">
										<c:forEach var="reply" items="${cmt.replies}">
											<div class="comment-bubble"
												style="background: rgba(255, 255, 255, 0.03); border: none; padding: 10px;">
												<img
													src="https://ui-avatars.com/api/?name=${reply.user.name}&background=random"
													class="avatar" style="width: 32px; height: 32px;">
												<div class="flex-grow-1">
													<div class="d-flex align-items-center gap-2">
														<span class="fw-bold text-white small">${reply.user.name}</span>
														<span class="text-muted" style="font-size: 0.7rem;">${reply.createAt}</span>
													</div>
													<p class="mb-0 text-white-50 small"
														id="content-${reply.id}">${reply.content}</p>

													<c:if
														test="${not empty sessionScope.currentUser and sessionScope.currentUser.id == reply.user.id}">
														<div class="d-flex gap-2 mt-1">
															<button class="btn-action text-info small"
																onclick="openEditModal(${reply.id}, ${video.id})">Sửa</button>
															<a
																href="${pageContext.request.contextPath}/video/comment/delete?cmtId=${reply.id}&id=${video.id}"
																class="btn-action text-danger small"
																onclick="return confirm('Xóa?')">Xóa</a>
														</div>
													</c:if>
												</div>
											</div>
										</c:forEach>
									</div>
								</c:if>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>

			<div class="col-lg-4 fade-up d-1">
				<div class="glass-card p-4">
					<h5 class="fw-bold mb-4 text-white">Đề xuất cho bạn</h5>
					<div class="d-flex flex-column gap-3">
						<c:forEach var="rel" items="${relatedVideos}">
							<a
								href="${pageContext.request.contextPath}/video/detail?id=${rel.id}"
								class="d-flex gap-3 text-decoration-none text-white"> <img
								src="${rel.poster}"
								style="width: 120px; height: 70px; object-fit: cover; border-radius: 10px;">
								<div>
									<h6 class="fw-bold mb-1" style="font-size: 0.9rem;">${rel.title}</h6>
									<small class="text-muted">${rel.viewcount} views</small>
								</div>
							</a>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div id="editModal" class="modal-overlay">
		<div class="modal-glass">
			<h4 class="text-white mb-4">Chỉnh sửa bình luận</h4>
			<form
				action="${pageContext.request.contextPath}/video/comment/update"
				method="POST">
				<input type="hidden" name="cmtId" id="modalCmtId"> <input
					type="hidden" name="videoId" id="modalVideoId">
				<div class="mb-4">
					<textarea name="content" id="modalContent"
						class="form-control bg-transparent text-white" rows="3"
						style="border: 1px solid rgba(255, 255, 255, 0.2); color: white !important;"></textarea>
				</div>
				<div class="d-flex justify-content-end gap-2">
					<button type="button" class="btn btn-secondary rounded-pill"
						onclick="closeEditModal()">Hủy</button>
					<button type="submit" class="btn btn-primary rounded-pill fw-bold"
						style="background: var(--neon-cyan); border: none; color: #000;">Lưu
						thay đổi</button>
				</div>
			</form>
		</div>
	</div>

	<div id="toast"></div>
	<jsp:include page="/common/footer.jsp" />

	<script>
        // JS: Ẩn hiện form Reply
        function toggleReply(id) {
            var form = document.getElementById('reply-form-' + id);
            form.style.display = (form.style.display === 'block') ? 'none' : 'block';
        }

        // JS: Mở Modal Sửa
        function openEditModal(cmtId, vidId) {
            document.getElementById('modalCmtId').value = cmtId;
            document.getElementById('modalVideoId').value = vidId;
            document.getElementById('modalContent').value = document.getElementById('content-' + cmtId).innerText;
            document.getElementById('editModal').style.display = 'flex';
        }

        function closeEditModal() {
            document.getElementById("editModal").style.display = "none";
        }

        window.onclick = function(event) {
            var modal = document.getElementById("editModal");
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }

        // JS: Like/Unlike (AJAX)
        let isLikedState = ${isLiked}; 
        function toggleLike(videoId) {
            const btn = document.getElementById('likeBtn');
            const icon = document.getElementById('likeIcon');
            const text = document.getElementById('likeText');
            const action = isLikedState ? 'unlike' : 'like';
            const url = '${pageContext.request.contextPath}/video/' + action + '?id=' + videoId;

            fetch(url).then(response => {
                if (response.ok) {
                    isLikedState = !isLikedState;
                    if (isLikedState) {
                        btn.classList.remove('btn-love'); btn.classList.add('btn-liked');
                        icon.classList.remove('ri-heart-3-line'); icon.classList.add('ri-heart-3-fill');
                        text.innerText = "Đã thích";
                    } else {
                        btn.classList.remove('btn-liked'); btn.classList.add('btn-love');
                        icon.classList.remove('ri-heart-3-fill'); icon.classList.add('ri-heart-3-line');
                        text.innerText = "Thích";
                    }
                }
            });
        }
        
        // JS: Share
        document.getElementById("btnShare").addEventListener("click", function() {
            navigator.clipboard.writeText(window.location.href).then(() => {
                var t = document.getElementById("toast");
                t.innerHTML = '<i class="ri-check-line"></i> Đã sao chép link!'; t.className = "show";
                setTimeout(() => { t.className = t.className.replace("show", ""); }, 3000);
            });
        });
    </script>
</body>
</html>