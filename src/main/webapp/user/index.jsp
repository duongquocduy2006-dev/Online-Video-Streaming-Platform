<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<title>Khám phá - PolyOE Masterpiece</title>
<jsp:include page="/common/head.jsp" />

<link
	href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css"
	rel="stylesheet">

<style>
:root {
	--primary-glow: #00d2ff;
	--secondary-glow: #ff416c;
	--card-bg: rgba(255, 255, 255, 0.05);
	--card-border: rgba(255, 255, 255, 0.1);
	--text-main: #e0e0e0;
	--text-muted: rgba(255, 255, 255, 0.6);
	--transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
	/* Bouncy transition */
}

body {
	font-family: 'Plus Jakarta Sans', sans-serif;
	color: var(--text-main);
	min-height: 100vh;
	/* Nền tối Gradient sâu thăm thẳm */
	background: linear-gradient(135deg, #0f0c29 0%, #302b63 50%, #24243e 100%)
		fixed;
}

/* --- 1. HERO SECTION (Holographic Banner) --- */
.hero-glass {
	margin-top: 30px;
	margin-bottom: 50px;
	background: rgba(255, 255, 255, 0.03);
	backdrop-filter: blur(20px);
	-webkit-backdrop-filter: blur(20px);
	border: 1px solid var(--card-border);
	border-radius: 30px;
	padding: 60px 40px;
	position: relative;
	overflow: hidden;
	box-shadow: 0 0 50px rgba(0, 0, 0, 0.5); /* Bóng đen sâu */
	animation: fadeIn 1s ease-out;
}

/* Decor background lines */
.hero-glass::before {
	content: '';
	position: absolute;
	top: -50%;
	left: -50%;
	width: 200%;
	height: 200%;
	background: radial-gradient(circle, rgba(0, 210, 255, 0.1) 0%,
		transparent 60%);
	z-index: 0;
	pointer-events: none;
}

.hero-title {
	font-size: 3.5rem;
	font-weight: 800;
	letter-spacing: -1px;
	line-height: 1.1;
	/* Gradient Text: Cyan to Purple */
	background: linear-gradient(to right, #00d2ff, #928DAB);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
	margin-bottom: 20px;
	text-shadow: 0 0 30px rgba(0, 210, 255, 0.3);
}

.btn-hero {
	background: linear-gradient(90deg, #00d2ff 0%, #3a7bd5 100%);
	color: #fff;
	padding: 14px 35px;
	border-radius: 50px;
	font-weight: 700;
	text-decoration: none;
	display: inline-flex;
	align-items: center;
	gap: 10px;
	transition: var(--transition);
	box-shadow: 0 0 20px rgba(0, 210, 255, 0.4);
	position: relative;
	z-index: 1;
	text-transform: uppercase;
	letter-spacing: 1px;
}

.btn-hero:hover {
	transform: translateY(-5px) scale(1.05);
	box-shadow: 0 0 40px rgba(0, 210, 255, 0.7);
	color: #fff;
}

/* --- 2. SECTION HEADER --- */
.section-header {
	display: flex;
	align-items: center;
	justify-content: space-between;
	margin-bottom: 30px;
	padding-left: 15px;
	border-left: 4px solid var(--secondary-glow); /* Viền hồng */
}

.section-title {
	font-size: 1.8rem;
	font-weight: 800;
	color: #fff;
	margin: 0;
	text-shadow: 0 0 10px rgba(255, 65, 108, 0.5);
}

.btn-view-all {
	color: var(--text-muted);
	font-weight: 600;
	text-decoration: none;
	transition: 0.3s;
}

.btn-view-all:hover {
	color: var(--secondary-glow);
	text-shadow: 0 0 8px var(--secondary-glow);
}

/* --- 3. VIDEO CARD (Glass Effect) --- */
.video-card {
	background: var(--card-bg);
	border-radius: 20px;
	overflow: hidden;
	border: 1px solid var(--card-border);
	box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3);
	transition: var(--transition);
	height: 100%;
	display: flex;
	flex-direction: column;
	position: relative;
	backdrop-filter: blur(10px);
}

.thumbnail-wrapper {
	position: relative;
	overflow: hidden;
	padding-top: 56.25%; /* 16:9 */
}

.thumbnail-img {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	object-fit: cover;
	transition: transform 0.6s ease;
}

/* Overlay Play Button */
.play-overlay {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.4);
	display: flex;
	align-items: center;
	justify-content: center;
	opacity: 0;
	transition: var(--transition);
	backdrop-filter: blur(3px);
}

.play-icon {
	width: 60px;
	height: 60px;
	background: rgba(255, 255, 255, 0.1);
	border: 1px solid rgba(255, 255, 255, 0.5);
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	color: #fff;
	font-size: 2rem;
	transform: scale(0.5) rotate(-180deg); /* Hiệu ứng xoay khi hiện */
	transition: var(--transition);
	box-shadow: 0 0 20px rgba(255, 255, 255, 0.2);
}

/* View Badge */
.view-badge {
	position: absolute;
	bottom: 10px;
	right: 10px;
	background: rgba(0, 0, 0, 0.7);
	border: 1px solid rgba(255, 255, 255, 0.2);
	backdrop-filter: blur(5px);
	color: #fff;
	padding: 5px 12px;
	border-radius: 12px;
	font-size: 0.75rem;
	font-weight: 700;
	display: flex;
	align-items: center;
	gap: 5px;
}

/* Card Content */
.card-content {
	padding: 20px;
	flex-grow: 1;
	display: flex;
	flex-direction: column;
}

.video-title {
	font-size: 1.1rem;
	font-weight: 700;
	color: #fff;
	margin-bottom: 12px;
	line-height: 1.4;
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
	overflow: hidden;
	text-decoration: none;
	transition: 0.3s;
}

.video-title:hover {
	color: var(--secondary-glow); /* Hover chuyển màu hồng */
	text-shadow: 0 0 10px rgba(255, 65, 108, 0.6);
}

.video-meta {
	margin-top: auto;
	display: flex;
	align-items: center;
	gap: 12px;
	border-top: 1px solid var(--card-border);
	padding-top: 12px;
}

.author-avatar {
	width: 35px;
	height: 35px;
	border-radius: 50%;
	border: 2px solid rgba(255, 255, 255, 0.2);
}

.author-name {
	font-size: 0.9rem;
	font-weight: 500;
	color: var(--text-muted);
}

/* HOVER STATE CARD */
.video-card:hover {
	transform: translateY(-10px) scale(1.02);
	border-color: var(--secondary-glow); /* Viền phát sáng hồng */
	box-shadow: 0 15px 40px rgba(255, 65, 108, 0.2); /* Đổ bóng hồng */
	background: rgba(255, 255, 255, 0.1);
	z-index: 10;
}

.video-card:hover .thumbnail-img {
	transform: scale(1.1);
}

.video-card:hover .play-overlay {
	opacity: 1;
}

.video-card:hover .play-icon {
	transform: scale(1) rotate(0deg);
	background: var(--secondary-glow);
	border-color: transparent;
}

/* Animation */
@
keyframes float { 0% {
	transform: translateY(0px) rotate(0deg);
}

50


%
{
transform


:


translateY
(


-20px


)


rotate
(


2deg


)
;


}
100


%
{
transform


:


translateY
(


0px


)


rotate
(


0deg


)
;


}
}
@
keyframes fadeIn {from { opacity:0;
	transform: translateY(20px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}

/* Scrollbar */
::-webkit-scrollbar {
	width: 8px;
}

::-webkit-scrollbar-track {
	background: #0f0c29;
}

::-webkit-scrollbar-thumb {
	background: #302b63;
	border-radius: 4px;
}

::-webkit-scrollbar-thumb:hover {
	background: var(--primary-glow);
}
</style>
</head>
<body>
	<jsp:include page="/common/header.jsp" />

	<div class="container pb-5">

		<div class="hero-glass">
			<div class="row align-items-center position-relative"
				style="z-index: 2;">
				<div class="col-lg-7">
					<span class="badge mb-3 fw-bold text-uppercase px-3 py-2"
						style="background: rgba(255, 255, 255, 0.1); color: #00d2ff; border: 1px solid #00d2ff; letter-spacing: 2px;">
						<i class="ri-vip-diamond-line me-1"></i> Cinematic Experience
					</span>
					<h1 class="hero-title">
						Khám phá thế giới qua<br> lăng kính điện ảnh.
					</h1>
					<p class="lead mb-4"
						style="color: rgba(255, 255, 255, 0.7); font-weight: 300;">
						Đắm chìm trong kho tàng video chất lượng cao. Nơi cảm xúc thăng
						hoa và trải nghiệm giải trí đỉnh cao bắt đầu.</p>
					<a href="#trending" class="btn-hero"> Bắt đầu xem ngay <i
						class="ri-arrow-right-line"></i>
					</a>
				</div>
				<div class="col-lg-5 d-none d-lg-block text-center">
					<i class="ri-vidicon-2-fill" alt="Cinema"
						style="font-size: 15rem; color: rgba(0, 210, 255, 0.7); filter: drop-shadow(0 0 50px rgba(0, 210, 255, 0.6)); animation: float 6s ease-in-out infinite; display: inline-block; /* Quan trọng để animation float hoạt động */ transform: translateY(-20px);">
					</i>
				</div>
			</div>

			<i class="ri-movie-2-line"
				style="position: absolute; right: -20px; bottom: -40px; font-size: 20rem; color: rgba(255, 255, 255, 0.02); transform: rotate(-15deg); pointer-events: none;">
			</i>
		</div>

		<div id="trending" class="section-header">
			<h4 class="section-title">Xu Hướng Mới Nhất</h4>
			
		</div>

		<div
			class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
			<c:forEach var="v" items="${videos}">
				<div class="col">
					<div class="video-card">
						<div class="position-relative">
							<a
								href="${pageContext.request.contextPath}/video/detail?id=${v.id}"
								class="thumbnail-wrapper d-block"> <img src="${v.poster}"
								class="thumbnail-img" alt="${v.title}"
								onerror="this.src='https://source.unsplash.com/random/800x450/?cinema'">
							</a> <a
								href="${pageContext.request.contextPath}/video/detail?id=${v.id}"
								class="play-overlay">
								<div class="play-icon">
									<i class="ri-play-fill"></i>
								</div>
							</a>

							<div class="view-badge">
								<i class="ri-eye-fill"></i> ${v.viewcount}
							</div>
						</div>

						<div class="card-content">
							<a
								href="${pageContext.request.contextPath}/video/detail?id=${v.id}"
								class="video-title" title="${v.title}"> ${v.title} </a>

							<div class="video-meta">
								<img
									src="https://ui-avatars.com/api/?name=${v.user.name}&background=random&size=64&color=fff"
									class="author-avatar"> <span
									class="author-name text-truncate">${v.user.name}</span>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>

	<jsp:include page="/common/footer.jsp" />
</body>
</html>