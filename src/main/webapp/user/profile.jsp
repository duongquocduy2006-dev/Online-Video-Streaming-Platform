<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>Hồ sơ cá nhân</title>
<jsp:include page="/common/head.jsp" />

<style>
    /* 1. Thiết lập nền và phông chữ tổng thể */
    @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600;700&display=swap');

    body {
        /* Tạo nền tối màu gradient sâu thăm thẳm */
        background: radial-gradient(circle at top right, #2b32b2, #1488cc) fixed; /* Fallback */
        background: linear-gradient(135deg, #0f0c29 0%, #302b63 50%, #24243e 100%) fixed;
        font-family: 'Montserrat', sans-serif;
        color: #e0e0e0;
        min-height: 100vh;
    }

    /* 2. Hiệu ứng thẻ Card chính (Glassmorphism) */
    .card {
        background: rgba(255, 255, 255, 0.05) !important; /* Trong suốt */
        backdrop-filter: blur(20px); /* Làm mờ hậu cảnh */
        -webkit-backdrop-filter: blur(20px);
        border: 1px solid rgba(255, 255, 255, 0.1) !important; /* Viền kính mỏng */
        box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.7); /* Đổ bóng sâu */
        border-radius: 24px !important;
        overflow: hidden;
        animation: fadeIn Up 0.8s ease-out; /* Hiệu ứng xuất hiện */
    }

    /* Override cột bên trái (Avatar) */
    .bg-dark {
        background: rgba(0, 0, 0, 0.3) !important; /* Làm tối hơn card chính */
        border-right: 1px solid rgba(255, 255, 255, 0.05);
    }

    /* 3. Avatar "Điện ảnh" */
    img.rounded-circle {
        border: 3px solid rgba(255, 255, 255, 0.2) !important;
        box-shadow: 0 0 30px rgba(0, 200, 255, 0.3); /* Phát sáng nhẹ */
        transition: transform 0.4s ease, box-shadow 0.4s ease;
    }

    img.rounded-circle:hover {
        transform: scale(1.05);
        box-shadow: 0 0 50px rgba(0, 200, 255, 0.6); /* Phát sáng mạnh khi hover */
        cursor: pointer;
    }

    /* Text & Badge */
    h4.fw-bold {
        letter-spacing: 1px;
        background: linear-gradient(to right, #fff, #a5a5a5);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        text-shadow: 0 2px 10px rgba(0,0,0,0.5);
    }

    .badge {
        background: linear-gradient(45deg, #ff00cc, #333399) !important; /* Màu Neon */
        color: white !important;
        border: none;
        padding: 0.6em 1em;
        letter-spacing: 1px;
        box-shadow: 0 0 15px rgba(255, 0, 204, 0.4);
    }

    /* 4. Tabs Navigation */
    .nav-tabs {
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }

    .nav-tabs .nav-link {
        color: rgba(255, 255, 255, 0.6);
        border: none;
        font-weight: 600;
        transition: all 0.3s;
        background: transparent;
    }

    .nav-tabs .nav-link:hover {
        color: #fff;
        text-shadow: 0 0 10px rgba(255,255,255,0.5);
        border: none;
    }

    .nav-tabs .nav-link.active {
        background: transparent !important;
        color: #fff !important;
        border: none;
        border-bottom: 3px solid #00d2ff; /* Gạch chân phát sáng */
        text-shadow: 0 0 20px rgba(0, 210, 255, 0.6);
    }

    /* 5. Inputs (Form Floating) */
    .form-floating label {
        color: rgba(255, 255, 255, 0.5);
    }

    .form-floating > .form-control:focus ~ label,
    .form-floating > .form-control:not(:placeholder-shown) ~ label {
        color: #00d2ff;
        transform: scale(.85) translateY(-0.5rem) translateX(0.15rem);
    }

    .form-control {
        background: rgba(0, 0, 0, 0.2) !important;
        border: 1px solid rgba(255, 255, 255, 0.1);
        color: #fff !important;
        border-radius: 12px;
        backdrop-filter: blur(5px);
        transition: all 0.3s ease;
    }

    .form-control:focus {
        background: rgba(0, 0, 0, 0.4) !important;
        border-color: #00d2ff;
        box-shadow: 0 0 20px rgba(0, 210, 255, 0.2); /* Glow input khi gõ */
    }

    /* 6. Buttons */
    .btn-primary {
        background: linear-gradient(90deg, #00d2ff 0%, #3a7bd5 100%);
        border: none;
        padding: 12px;
        font-weight: bold;
        letter-spacing: 1px;
        text-transform: uppercase;
        border-radius: 12px;
        box-shadow: 0 10px 20px rgba(0, 210, 255, 0.3);
        transition: transform 0.2s, box-shadow 0.2s;
    }

    .btn-danger {
        background: linear-gradient(90deg, #ff416c 0%, #ff4b2b 100%);
        border: none;
        padding: 12px;
        font-weight: bold;
        letter-spacing: 1px;
        text-transform: uppercase;
        border-radius: 12px;
        box-shadow: 0 10px 20px rgba(255, 65, 108, 0.3);
    }

    .btn:hover {
        transform: translateY(-3px); /* Nổi lên khi hover */
        box-shadow: 0 15px 30px rgba(0,0,0,0.4);
    }

    /* 7. Animation Keyframes */
    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(40px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    /* Tùy chỉnh thanh cuộn cho hợp tông màu */
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
        background: #00d2ff; 
    }
</style>
</head>
<body>
	<jsp:include page="/common/header.jsp" />

	<div class="container mt-5">
		<div class="row justify-content-center">
			<div class="col-lg-9">
                <div class="card shadow-lg border-0"> 
					<div class="row g-0">
						<div
							class="col-md-4 bg-dark text-white text-center p-4 d-flex flex-column align-items-center justify-content-center">
							<img
								src="https://ui-avatars.com/api/?name=${sessionScope.currentUser.name}&size=128&background=random"
								class="rounded-circle mb-3">
							<h4 class="fw-bold mt-2">${sessionScope.currentUser.name}</h4>
							<p class="mb-0 text-white-50" style="font-style: italic;">@${sessionScope.currentUser.username}</p>
							<span class="badge bg-light text-dark mt-3">${sessionScope.currentUser.role}</span>
						</div>

						<div class="col-md-8">
							<div class="card-body p-5"> <ul class="nav nav-tabs mb-4" id="profileTabs" role="tablist">
									<li class="nav-item">
										<button class="nav-link active" data-bs-toggle="tab"
											data-bs-target="#info" type="button">Thông tin chung</button>
									</li>
									<li class="nav-item">
										<button class="nav-link" data-bs-toggle="tab"
											data-bs-target="#password" type="button">Đổi mật
											khẩu</button>
									</li>
								</ul>

								<div class="tab-content">

									<div class="tab-pane fade show active" id="info">
										<form
											action="${pageContext.request.contextPath}/user/update-profile"
											method="POST" novalidate>
											<c:if test="${not empty message}">
												<div class="alert alert-success bg-transparent border-success text-success">${message}</div>
											</c:if>
											<c:if test="${not empty error}">
												<div class="alert alert-danger bg-transparent border-danger text-danger">${error}</div>
											</c:if>

											<div class="form-floating mb-4">
												<input type="text"
													class="form-control ${not empty profileErrors.name ? 'is-invalid' : ''}"
													id="fullname" name="name"
													value="${sessionScope.currentUser.name}" placeholder="Họ và tên"> 
                                                <label for="fullname">Họ và tên</label>
												<div class="invalid-feedback">${profileErrors.name}</div>
											</div>

											<div class="form-floating mb-4">
												<input type="text"
													class="form-control ${not empty profileErrors.email ? 'is-invalid' : ''}"
													id="email" name="email"
													value="${sessionScope.currentUser.email}" placeholder="Email"> 
                                                <label for="email">Email</label>
												<div class="invalid-feedback">${profileErrors.email}</div>
											</div>

											<div class="d-grid mt-5">
												<button class="btn btn-primary btn-lg" type="submit">Lưu
													thay đổi</button>
											</div>
										</form>
									</div>

									<div class="tab-pane fade" id="password">
										<form
											action="${pageContext.request.contextPath}/user/change-password"
											method="POST" novalidate>

											<c:if test="${not empty error}">
												<div class="alert alert-danger bg-transparent border-danger text-danger">${error}</div>
											</c:if>
											<c:if test="${not empty message}">
												<div class="alert alert-success bg-transparent border-success text-success">${message}</div>
											</c:if>

											<div class="form-floating mb-3">
												<input type="password"
													class="form-control ${not empty changePasswordErrors.currentPassword ? 'is-invalid' : ''}"
													id="currentPass" name="currentPassword" placeholder="MK cũ">
												<label for="currentPass">Mật khẩu hiện tại</label>
												<div class="invalid-feedback">${changePasswordErrors.currentPassword}</div>
											</div>

											<div class="form-floating mb-3">
												<input type="password"
													class="form-control ${not empty changePasswordErrors.newPassword ? 'is-invalid' : ''}"
													id="newPass" name="newPassword" placeholder="MK mới">
												<label for="newPass">Mật khẩu mới</label>
												<div class="invalid-feedback">${changePasswordErrors.newPassword}</div>
											</div>

											<div class="form-floating mb-4">
												<input type="password"
													class="form-control ${not empty changePasswordErrors.confirmPass ? 'is-invalid' : ''}"
													id="confirmPass" name="confirmPassword"
													placeholder="Xác nhận"> <label for="confirmPass">Xác
													nhận mật khẩu mới</label>
												<div class="invalid-feedback">${changePasswordErrors.confirmPassword}</div>
											</div>

											<div class="d-grid mt-4">
												<button class="btn btn-danger btn-lg" type="submit">Đổi
													mật khẩu</button>
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/common/footer.jsp" />
</body>
</html>