<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<title>Creator Studio - Command Center</title>
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
	--neon-green: #00ff9d;
	--neon-red: #ff416c;
	--bg-dark: #0f0c29;
	--card-glass: rgba(255, 255, 255, 0.03);
	--border-glass: 1px solid rgba(255, 255, 255, 0.08);
	--text-main: #e0e0e0;
	--text-muted: rgba(255, 255, 255, 0.5);
}

body {
	font-family: 'Plus Jakarta Sans', sans-serif;
	background: linear-gradient(135deg, #0f0c29 0%, #302b63 50%, #24243e 100%)
		fixed;
	color: var(--text-main);
	min-height: 100vh;
}

/* --- 1. HEADER (Command Bar) --- */
.studio-header {
	margin-top: 3rem;
	margin-bottom: 2.5rem;
	display: flex;
	justify-content: space-between;
	align-items: flex-end;
	border-bottom: 1px solid rgba(255, 255, 255, 0.1);
	padding-bottom: 20px;
}

.title-group h2 {
	font-family: 'Outfit', sans-serif;
	font-weight: 800;
	font-size: 2.5rem;
	color: #fff;
	letter-spacing: 1px;
	margin-bottom: 0.5rem;
	text-transform: uppercase;
	text-shadow: 0 0 20px rgba(0, 210, 255, 0.3); /* Glow nhẹ */
}

.btn-create {
	background: linear-gradient(90deg, #00d2ff 0%, #3a7bd5 100%);
	color: #fff;
	padding: 12px 28px;
	border-radius: 50px;
	font-weight: 700;
	border: none;
	box-shadow: 0 0 15px rgba(0, 210, 255, 0.3);
	display: flex;
	align-items: center;
	gap: 8px;
	text-decoration: none;
	transition: 0.3s;
}

.btn-create:hover {
	transform: translateY(-3px);
	box-shadow: 0 0 30px rgba(0, 210, 255, 0.6);
	color: #fff;
}

/* --- 2. TABLE STYLING (Floating Panels) --- */
.table-responsive {
	overflow-x: auto;
}

.content-table {
	width: 100%;
	border-collapse: separate;
	border-spacing: 0 12px;
}

.content-table thead th {
	font-size: 0.8rem;
	text-transform: uppercase;
	letter-spacing: 1.5px;
	font-weight: 700;
	color: var(--text-muted);
	padding: 0 24px 10px 24px;
	border: none;
}

.row-card {
	background: var(--card-glass);
	backdrop-filter: blur(10px);
	transition: 0.3s;
}

/* Hiệu ứng Hover Row: Sáng viền Neon */
.row-card:hover td {
	background: rgba(255, 255, 255, 0.08);
	border-top: 1px solid rgba(0, 210, 255, 0.3);
	border-bottom: 1px solid rgba(0, 210, 255, 0.3);
}

.row-card:hover td:first-child {
	border-left: 1px solid rgba(0, 210, 255, 0.3);
}

.row-card:hover td:last-child {
	border-right: 1px solid rgba(0, 210, 255, 0.3);
}

.content-table td {
	padding: 20px 24px;
	vertical-align: middle;
	border-top: var(--border-glass);
	border-bottom: var(--border-glass);
	color: var(--text-main);
}

/* Bo góc cho hàng */
.content-table td:first-child {
	border-top-left-radius: 16px;
	border-bottom-left-radius: 16px;
	border-left: var(--border-glass);
}

.content-table td:last-child {
	border-top-right-radius: 16px;
	border-bottom-right-radius: 16px;
	border-right: var(--border-glass);
}

/* --- 3. CONTENT ELEMENTS --- */
.thumb-box {
	width: 140px;
	height: 80px;
	border-radius: 10px;
	overflow: hidden;
	border: 1px solid rgba(255, 255, 255, 0.1);
	position: relative;
}

.thumb-img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	transition: 0.5s;
	opacity: 0.8;
}

.row-card:hover .thumb-img {
	transform: scale(1.1);
	opacity: 1;
}

.video-title {
	font-family: 'Outfit', sans-serif;
	font-weight: 600;
	font-size: 1.05rem;
	color: #fff;
	margin-bottom: 4px;
}

.video-desc {
	font-size: 0.85rem;
	color: var(--text-muted);
}

/* Stats Badge */
.stat-badge {
	display: inline-flex;
	align-items: center;
	gap: 6px;
	padding: 6px 12px;
	background: rgba(0, 0, 0, 0.3);
	border-radius: 6px;
	font-size: 0.85rem;
	color: #fff;
	border: 1px solid rgba(255, 255, 255, 0.05);
}

/* Status Dot with Glow */
.status-wrapper {
	display: inline-flex;
	align-items: center;
	gap: 10px;
	font-weight: 600;
	font-size: 0.85rem;
}

.dot {
	width: 8px;
	height: 8px;
	border-radius: 50%;
	box-shadow: 0 0 10px currentColor;
}

.status-active {
	color: var(--neon-green);
}

.status-inactive {
	color: var(--text-muted);
	box-shadow: none;
}

/* Actions Buttons */
.action-btn {
	width: 36px;
	height: 36px;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	background: rgba(255, 255, 255, 0.05);
	color: var(--text-muted);
	transition: 0.2s;
	text-decoration: none;
	border: 1px solid transparent;
}

.btn-edit:hover {
	background: rgba(0, 210, 255, 0.1);
	color: var(--neon-cyan);
	border-color: var(--neon-cyan);
	box-shadow: 0 0 10px rgba(0, 210, 255, 0.2);
}

.btn-delete:hover {
	background: rgba(255, 65, 108, 0.1);
	color: var(--neon-red);
	border-color: var(--neon-red);
	box-shadow: 0 0 10px rgba(255, 65, 108, 0.2);
}

/* Empty State */
.empty-icon {
	font-size: 3rem;
	color: var(--text-muted);
	opacity: 0.3;
	animation: float 4s infinite ease-in-out;
}

@
keyframes float { 0%, 100% {
	transform: translateY(0);
}
50
%
{
transform
:
translateY(
-10px
);
}
}
</style>
</head>
<body>
	<jsp:include page="/common/header.jsp" />

	<div class="container mb-5">

		<div class="studio-header">
			<div class="title-group">
				<h2>
					<i class="ri-dashboard-3-line me-2"></i>Studio
				</h2>
				<p class="text-muted mb-0" style="font-weight: 300;">Trung tâm
					quản lý nội dung sáng tạo</p>
			</div>
			<a href="${pageContext.request.contextPath}/creator/video/create"
				class="btn-create"> <i class="ri-upload-cloud-2-fill"
				style="font-size: 1.1rem;"></i> <span>Tải lên</span>
			</a>
		</div>

		<div class="table-responsive">
			<table class="content-table">
				<thead>
					<tr>
						<th class="ps-4">Video</th>
						<th>Hiệu suất</th>
						<th>Trạng thái</th>
						<th>Ngày đăng</th>
						<th class="text-end pe-4">Hành động</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="v" items="${myVideos}">
						<tr class="row-card">
							<td class="ps-4">
								<div class="d-flex align-items-center gap-3">
									<div class="thumb-box">
										<img src="${v.poster}" class="thumb-img">
									</div>
									<div style="max-width: 300px;">
										<div class="video-title text-truncate" title="${v.title}">${v.title}</div>
										<div class="video-desc text-truncate">${v.description}</div>
									</div>
								</div>
							</td>

							<td>
								<div class="stat-badge">
									<i class="ri-eye-fill text-info"></i> ${v.viewcount}
								</div>
							</td>

							<td><c:choose>
									<c:when test="${v.status}">
										<div class="status-wrapper status-active">
											<div class="dot"></div>
											<span>Đã duyệt</span>
										</div>
									</c:when>
									<c:otherwise>
										<div class="status-wrapper" style="color: #ff9f43;">
											<div class="dot"
												style="background-color: #ff9f43; box-shadow: 0 0 10px #ff9f43;"></div>
											<span>Chờ duyệt</span>
										</div>
									</c:otherwise>
								</c:choose></td>


							<td class="text-muted"
								style="font-family: 'Outfit', sans-serif; font-size: 0.9rem;">
								${v.createAt}</td>

							<td class="text-end pe-4">
								<div class="d-flex justify-content-end gap-2">
									<a
										href="${pageContext.request.contextPath}/creator/video/edit?id=${v.id}"
										class="action-btn btn-edit" data-bs-toggle="tooltip"
										title="Chỉnh sửa"> <i class="ri-settings-4-line"></i>
									</a> <a
										href="${pageContext.request.contextPath}/creator/video/delete?id=${v.id}"
										class="action-btn btn-delete"
										onclick="return confirm('Bạn chắc chắn muốn xóa video này khỏi hệ thống?');"
										data-bs-toggle="tooltip" title="Xóa vĩnh viễn"> <i
										class="ri-delete-bin-2-line"></i>
									</a>
								</div>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<c:if test="${empty myVideos}">
				<div class="text-center py-5 mt-4"
					style="border: 1px dashed rgba(255, 255, 255, 0.1); border-radius: 20px;">
					<i class="ri-film-line empty-icon mb-3 d-block"></i>
					<h5 class="fw-bold text-white">Kho nội dung trống</h5>
					<p class="text-muted small mb-4">Bạn chưa tải lên video nào.</p>
					<a href="${pageContext.request.contextPath}/creator/video/create"
						class="btn btn-outline-light rounded-pill px-4 py-2"
						style="font-size: 0.9rem;"> Tạo video đầu tiên </a>
				</div>
			</c:if>
		</div>
	</div>

	<jsp:include page="/common/footer.jsp" />

	<script>
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
          return new bootstrap.Tooltip(tooltipTriggerEl)
        })
    </script>
</body>
</html>