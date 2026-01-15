<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<nav class="navbar navbar-expand-lg fixed-top cinematic-navbar">
	<div class="container">
		<a class="navbar-brand d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/home"> 
			<i class="bi bi-play-circle-fill logo-icon"></i> 
			<span class="brand-text">POLYOE</span>
		</a>
		
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain">
			<span class="bi bi-list text-white fs-1"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarMain">
			
			<ul class="navbar-nav me-3 mb-2 mb-lg-0">
				<li class="nav-item">
					<a class="nav-link nav-link-cinema active" href="${pageContext.request.contextPath}/home">Trang chủ</a>
				</li>

				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle nav-link-cinema" href="#" data-bs-toggle="dropdown">
						Danh mục
					</a>
					<ul class="dropdown-menu dropdown-cinema shadow">
						<c:forEach var="c" items="${categories}">
							<li>
								<a class="dropdown-item" href="${pageContext.request.contextPath}/home?action=filter&catId=${c.id}">
									${c.name}
								</a>
							</li>
						</c:forEach>
						<c:if test="${empty categories}">
							<li><span class="dropdown-item text-muted">Đang cập nhật...</span></li>
						</c:if>
					</ul>
				</li>

				<c:if test="${sessionScope.currentUser.role == 'creator' || sessionScope.currentUser.role == 'admin'}">
					<li class="nav-item">
						<a class="nav-link nav-link-cinema text-warning-bright" href="${pageContext.request.contextPath}/creator/video">
							<i class="bi bi-broadcast me-1"></i>Studio
						</a>
					</li>
				</c:if>

				<c:if test="${sessionScope.currentUser.role == 'admin'}">
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle nav-link-cinema text-info-bright" href="#" data-bs-toggle="dropdown">Quản trị</a>
						<ul class="dropdown-menu dropdown-cinema shadow">
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/dashboard"><i class="bi bi-speedometer2 me-2"></i>Thống kê</a></li>
							<li><hr class="dropdown-divider bg-light opacity-50"></li>
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/users">Quản lý User</a></li>
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/videos">Quản lý Video</a></li>
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/comments">Quản lý Bình luận</a></li>

							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/categories">Quản lý Danh mục</a></li>
						</ul>
					</li>
				</c:if>
			</ul>

			<form class="d-flex mx-auto search-form" role="search" action="${pageContext.request.contextPath}/home" method="GET">
				<input type="hidden" name="action" value="search">
				<div class="input-group search-group">
					<span class="input-group-text bg-transparent border-0 text-white ps-3">
						<i class="bi bi-search"></i>
					</span>
					<input class="form-control search-input" type="search" name="keyword" placeholder="Tìm kiếm video..." aria-label="Search">
				</div>
			</form>

			<div class="d-flex align-items-center gap-3 ms-3 user-actions">
				<c:choose>
					<c:when test="${not empty sessionScope.currentUser}">
						<div class="dropdown">
							<button class="btn btn-user-profile dropdown-toggle text-white" data-bs-toggle="dropdown">
								<img src="https://ui-avatars.com/api/?name=${sessionScope.currentUser.name}&background=random&color=fff&bold=true" class="avatar-glow">
								<span class="d-none d-lg-inline-block ms-2 fw-bold text-uppercase" style="letter-spacing: 0.5px;">
									${sessionScope.currentUser.name}
								</span>
							</button>
							<ul class="dropdown-menu dropdown-menu-end dropdown-cinema shadow">
								<li class="px-3 py-2 text-white-50 small border-bottom border-light border-opacity-25">
                                    Xin chào, <strong class="text-white">${sessionScope.currentUser.name}</strong>
                                </li>
								<li><a class="dropdown-item mt-2" href="${pageContext.request.contextPath}/user/profile"><i class="bi bi-person-badge me-2"></i>Hồ sơ</a></li>
								<li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/favorites"><i class="bi bi-heart-fill me-2 text-danger"></i>Đã thích</a></li>
								<li><hr class="dropdown-divider bg-light opacity-25"></li>
								<li><a class="dropdown-item text-danger fw-bold" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-2"></i>Đăng xuất</a></li>
							</ul>
						</div>
					</c:when>
					<c:otherwise>
						<a href="${pageContext.request.contextPath}/login" class="nav-link text-white fw-bold me-2">ĐĂNG NHẬP</a>
						<a href="${pageContext.request.contextPath}/register" class="btn btn-primary fw-bold px-4 rounded-pill">
							ĐĂNG KÝ
						</a>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</nav>

<style>
	/* 1. Navbar Container - Tăng độ tối nền để chữ trắng nổi bật */
	.cinematic-navbar {
		background: #000000; /* Đen tuyệt đối để tương phản tốt nhất */
		border-bottom: 1px solid rgba(255, 255, 255, 0.2);
		padding: 1rem 0;
	}

	/* 2. Logo - Giữ nguyên vẻ đẹp nhưng sáng hơn */
	.logo-icon {
		font-size: 2rem;
		color: #ff416c;
        filter: drop-shadow(0 0 8px rgba(255, 65, 108, 0.8)); /* Glow mạnh hơn */
	}
	.brand-text {
		font-family: 'Outfit', sans-serif;
		font-weight: 900; /* Đậm nhất */
		font-size: 1.6rem;
		color: #ffffff;
        letter-spacing: 1px;
	}

	/* 3. Navigation Links - TRẮNG TUYỆT ĐỐI */
	.nav-link-cinema {
		color: #ffffff !important; /* Chữ trắng 100% */
		font-weight: 600; /* Chữ đậm hơn */
		font-size: 1rem;
        margin: 0 5px;
        opacity: 0.9;
		transition: 0.2s;
	}
	.nav-link-cinema:hover, .nav-link-cinema:focus {
		opacity: 1;
        color: #00d2ff !important; /* Hover ra màu xanh sáng */
        text-shadow: 0 0 15px rgba(0, 210, 255, 0.8);
	}

    /* Màu nổi bật cho Studio/Admin */
    .text-warning-bright { color: #ffd700 !important; }
    .text-info-bright { color: #00ffff !important; }

	/* 4. Search Bar - Tương phản cao */
	.search-form { width: 40%; }
	@media (max-width: 991px) { .search-form { width: 100%; margin: 15px 0; } }

	.search-group {
		background: #222222; /* Nền xám đậm thay vì trong suốt */
		border: 1px solid #555;
		border-radius: 50px;
	}
	.search-group:focus-within {
		border-color: #ffffff;
        background: #333;
		box-shadow: 0 0 0 2px rgba(255,255,255,0.2);
	}
	.search-input {
		background: transparent !important;
		border: none !important;
		color: #ffffff !important; /* Chữ khi gõ màu trắng */
        font-weight: 500;
		box-shadow: none !important;
	}
	.search-input::placeholder { color: #bbbbbb; opacity: 1; } /* Placeholder xám sáng */

	/* 5. Dropdowns - Nền đen đặc, chữ trắng */
	.dropdown-cinema {
		background: #1a1a1a; /* Đen xám */
		border: 1px solid #444;
		border-radius: 8px;
		margin-top: 15px;
	}
	.dropdown-cinema .dropdown-item {
		color: #ffffff; /* Item chữ trắng */
        font-weight: 500;
		padding: 10px 20px;
	}
	.dropdown-cinema .dropdown-item:hover {
		background: #333;
		color: #00d2ff;
	}

	/* 6. Avatar & Buttons */
	.avatar-glow {
		width: 38px; height: 38px; border-radius: 50%;
		border: 2px solid #fff;
	}
    
    .btn-primary {
        background-color: #ff416c;
        border-color: #ff416c;
        color: white;
    }
    .btn-primary:hover {
        background-color: #ff2052;
        box-shadow: 0 0 15px rgba(255, 32, 82, 0.6);
    }
</style>