<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<title>${not empty video ? 'Hiệu chỉnh tín hiệu' : 'Khởi tạo nguồn phát'}</title>
<jsp:include page="/common/head.jsp" />

<link
	href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;600;800&family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css"
	rel="stylesheet">

<style>
:root {
	--neon-cyan: #00d2ff;
	--neon-purple: #bd34fe;
	--bg-dark: #0f0c29;
	--card-glass: rgba(255, 255, 255, 0.03);
	--border-glass: 1px solid rgba(255, 255, 255, 0.1);
	--text-main: #e0e0e0;
	--input-bg: rgba(0, 0, 0, 0.3);
}

body {
	font-family: 'Plus Jakarta Sans', sans-serif;
	background: linear-gradient(135deg, #0f0c29 0%, #302b63 50%, #24243e 100%)
		fixed;
	color: var(--text-main);
	min-height: 100vh;
}

/* 1. Main Card (Control Unit) */
.control-card {
	background: var(--card-glass);
	backdrop-filter: blur(20px);
	border: var(--border-glass);
	border-radius: 24px;
	box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.6);
	overflow: hidden;
	animation: slideUp 0.6s ease-out;
}

.card-header-custom {
	padding-bottom: 20px;
	margin-bottom: 30px;
	border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.page-title {
	font-family: 'Outfit', sans-serif;
	font-weight: 800;
	text-transform: uppercase;
	letter-spacing: 1px;
	background: linear-gradient(to right, #fff, var(--neon-cyan));
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
	margin-bottom: 5px;
}

/* 2. Inputs & Floating Labels */
.form-floating>.form-control, .form-floating>.form-select {
	background: var(--input-bg) !important;
	border: 1px solid rgba(255, 255, 255, 0.1);
	color: #fff !important;
	border-radius: 12px;
	height: 60px;
}

.form-floating>textarea.form-control {
	height: 120px;
}

.form-control:focus, .form-select:focus {
	background: rgba(0, 0, 0, 0.5) !important;
	border-color: var(--neon-cyan);
	box-shadow: 0 0 15px rgba(0, 210, 255, 0.2);
}

/* Label styling */
.form-floating>label {
	color: rgba(255, 255, 255, 0.5);
}

.form-floating>.form-control:focus ~ label, .form-floating>.form-control:not(:placeholder-shown) 
	~ label, .form-floating>.form-select ~ label {
	color: var(--neon-cyan);
	font-weight: 600;
	text-shadow: 0 0 5px rgba(0, 210, 255, 0.5);
}

/* Fix option background on Select */
.form-select option {
	background: #1e1e2d;
	color: #fff;
}

/* 3. Preview Monitor (Màn hình xem trước) */
.monitor-frame {
	background: #000;
	border: 1px solid rgba(255, 255, 255, 0.2);
	border-radius: 12px;
	padding: 5px;
	position: relative;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
}

.monitor-frame::before {
	content: 'PREVIEW MONITOR';
	position: absolute;
	top: -25px;
	left: 0;
	font-size: 0.7rem;
	letter-spacing: 2px;
	color: rgba(255, 255, 255, 0.4);
	font-weight: 700;
}

#previewImage {
	border-radius: 8px;
	opacity: 0.9;
	transition: 0.3s;
}

/* 4. Buttons */
.btn-primary {
	background: linear-gradient(90deg, #00d2ff 0%, #3a7bd5 100%);
	border: none;
	padding: 14px;
	font-weight: bold;
	letter-spacing: 1px;
	border-radius: 12px;
	text-transform: uppercase;
	box-shadow: 0 10px 20px rgba(0, 210, 255, 0.3);
	transition: 0.3s;
}

.btn-primary:hover {
	transform: translateY(-3px);
	box-shadow: 0 15px 30px rgba(0, 210, 255, 0.5);
}

.btn-glass-secondary {
	background: rgba(255, 255, 255, 0.05);
	border: 1px solid rgba(255, 255, 255, 0.2);
	color: #fff;
	padding: 14px;
	font-weight: 600;
	border-radius: 12px;
	transition: 0.3s;
}

.btn-glass-secondary:hover {
	background: rgba(255, 255, 255, 0.1);
	border-color: #fff;
	color: #fff;
}

/* 5. Switch Toggle */
.form-check-input {
	background-color: rgba(255, 255, 255, 0.1);
	border-color: rgba(255, 255, 255, 0.3);
	width: 3em;
	height: 1.5em;
	margin-top: 0.2em;
}

.form-check-input:checked {
	background-color: var(--neon-cyan);
	border-color: var(--neon-cyan);
	box-shadow: 0 0 10px var(--neon-cyan);
}

.form-check-label {
	color: rgba(255, 255, 255, 0.8);
	padding-left: 10px;
	padding-top: 4px;
}

/* Alerts */
.alert-danger {
	background: rgba(255, 65, 108, 0.1);
	border: 1px solid rgba(255, 65, 108, 0.3);
	color: #ff8fa3;
	backdrop-filter: blur(5px);
}

@
keyframes slideUp {
	from {opacity: 0;
	transform: translateY(30px);
}

to {
	opacity: 1;
	transform: translateY(0);
}
}
</style>
</head>
<body>
	<jsp:include page="/common/header.jsp" />

	<div class="container mt-5 mb-5">
		<div class="row justify-content-center">
			<div class="col-lg-8">

				<div class="mb-3">
					<a href="${pageContext.request.contextPath}/creator/video"
						class="text-decoration-none small text-muted hover-white"> <i
						class="ri-arrow-left-line me-1"></i> Quay lại Studio
					</a>
				</div>

				<div class="card control-card border-0">
					<div class="card-body p-5">

						<div class="card-header-custom">
							<h3 class="page-title">
								<i class="ri-equalizer-line me-2"></i> ${not empty video ? 'Hiệu chỉnh Video' : 'Tải lên Video'}
							</h3>
							<p class="text-muted small mb-0">${not empty video ? 'Cập nhật thông tin siêu dữ liệu.' : 'Chia sẻ kiệt tác mới của bạn với thế giới.'}
							</p>
						</div>

						<c:if test="${not empty error}">
							<div class="alert alert-danger d-flex align-items-center">
								<i class="ri-error-warning-fill me-2 fs-5"></i> ${error}
							</div>
						</c:if>

						<form
							action="${pageContext.request.contextPath}/creator/video/save"
							method="POST" novalidate>
							<c:if test="${not empty video}">
								<input type="hidden" name="id" value="${video.id}">
							</c:if>

							<div class="row g-4 mb-4">
								<div class="col-md-6">
									<div class="form-floating">
										<input type="text"
											class="form-control ${not empty errors.url ? 'is-invalid' : ''}"
											id="url" name="url"
											value="${not empty bean ? bean.url : video.url}"
											placeholder="ID Youtube"> <label for="url"><i
											class="ri-youtube-fill me-1"></i>Youtube ID (Ví dụ:
											dQw4w9WgXcQ)</label>
										<div class="invalid-feedback">${errors.url}</div>
									</div>
								</div>

								<div class="col-md-6">
									<div class="form-floating">
										<select
											class="form-select ${not empty errors.catId ? 'is-invalid' : ''}"
											id="cat" name="catId">
											<option value=""
												${empty bean.catId && empty video.category.id ? 'selected' : ''}>---
												Chọn danh mục ---</option>
											<c:forEach var="c" items="${categories}">
												<option value="${c.id}"
													${bean.catId == c.id || (not empty video && video.category.id == c.id) ? 'selected' : ''}>${c.name}</option>
											</c:forEach>
										</select> <label for="cat"><i class="ri-folder-open-fill me-1"></i>Danh
											mục</label>
										<div class="invalid-feedback">${errors.catId}</div>
									</div>
								</div>
							</div>

							<div class="mb-4">
								<div class="monitor-frame">
									<img id="previewImage"
										src="${not empty video.poster ? video.poster : 'https://via.placeholder.com/800x450/000000/FFFFFF?text=NO+SIGNAL'}"
										alt="Video Poster Preview"
										style="width: 100%; height: auto; aspect-ratio: 16/9; object-fit: cover; display: block;">
								</div>
								<div class="text-end mt-1">
									<small class="text-muted"
										style="font-size: 0.7rem; font-family: monospace;">STATUS:
										<span class="text-success">ONLINE</span>
									</small>
								</div>
							</div>

							<div class="form-floating mb-4">
								<input type="text"
									class="form-control ${not empty errors.title ? 'is-invalid' : ''}"
									id="title" name="title"
									value="${not empty bean ? bean.title : video.title}"
									placeholder="Tên video"> <label for="title"><i
									class="ri-text me-1"></i>Tiêu đề Video</label>
								<div class="invalid-feedback">${errors.title}</div>
							</div>

							<div class="form-floating mb-4">
								<textarea class="form-control" placeholder="Mô tả" id="desc"
									name="description" style="height: 120px">${not empty bean ? bean.description : video.description}</textarea>
								<label for="desc"><i class="ri-file-text-line me-1"></i>Mô
									tả nội dung</label>
							</div>

							<div class="mb-5 p-3 rounded-3"
								style="background: rgba(255, 159, 67, 0.1); border: 1px solid rgba(255, 159, 67, 0.3);">
								<div class="d-flex align-items-center gap-3">
									<i class="ri-hourglass-2-fill text-warning fs-2"></i>
									<div>
										<h6 class="fw-bold text-white mb-1">Quy trình kiểm duyệt</h6>
										<p class="text-muted small mb-0">
											Video sau khi tải lên sẽ ở trạng thái <span
												class="text-warning fw-bold">Chờ duyệt</span>. Admin sẽ kiểm
											tra nội dung trước khi công khai lên hệ thống.
										</p>
									</div>
								</div>
							</div>

							<div class="d-grid gap-3">
								<button class="btn btn-primary btn-lg" type="submit">
									<i class="ri-save-3-line me-2"></i> Lưu Cấu Hình
								</button>
								<a href="${pageContext.request.contextPath}/creator/video"
									class="btn btn-glass-secondary text-center text-decoration-none">
									Hủy bỏ </a>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
        document.addEventListener('DOMContentLoaded', function() {
            const urlInput = document.getElementById('url');
            const previewImg = document.getElementById('previewImage');
            
            // Hàm trích xuất ID từ URL đầy đủ (Hỗ trợ người dùng paste cả link)
            function extractVideoID(url) {
                var regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
                var match = url.match(regExp);
                if (match && match[2].length == 11) {
                    return match[2];
                } else {
                    return url; // Trả về nguyên bản nếu không match (giả sử người dùng nhập ID trực tiếp)
                }
            }

            function updatePreview(inputVal) {
                const videoId = extractVideoID(inputVal);
                
                if (videoId && videoId.length > 5) {
                    const imageUrl = 'https://img.youtube.com/vi/' + videoId + '/maxresdefault.jpg';
                    previewImg.src = imageUrl;
                    
                    // Fallback nếu không có ảnh HD
                    previewImg.onerror = function() {
                        previewImg.src = 'https://img.youtube.com/vi/' + videoId + '/hqdefault.jpg';
                    };
                } else {
                    previewImg.src = 'https://via.placeholder.com/800x450/000000/FFFFFF?text=WAITING+FOR+SIGNAL...';
                }
            }

            // Init
            if (urlInput.value) updatePreview(urlInput.value);

            // Listen
            urlInput.addEventListener('input', function() {
                updatePreview(urlInput.value);
            });
        });
    </script>

	<style>
.hover-white:hover {
	color: #fff !important;
	text-decoration: underline !important;
}
</style>

	<jsp:include page="/common/footer.jsp" />
</body>
</html>