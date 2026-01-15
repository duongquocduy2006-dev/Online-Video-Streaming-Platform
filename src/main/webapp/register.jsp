<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng ký tài khoản - PolyOE</title>
    <jsp:include page="/common/head.jsp"/> 
    
    <style>
        /* 1. Global Background & Font */
        @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600;700&display=swap');
        
        body {
            /* Nền tối Gradient sâu */
            background: linear-gradient(135deg, #0f0c29 0%, #302b63 50%, #24243e 100%) fixed;
            font-family: 'Montserrat', sans-serif;
            color: #e0e0e0;
        }

        /* 2. Glassmorphism Card */
        .card {
            background: rgba(255, 255, 255, 0.05) !important;
            backdrop-filter: blur(20px); /* Làm mờ hậu cảnh */
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.1) !important;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
            border-radius: 24px !important;
            overflow: hidden;
            animation: fadeIn 0.8s ease-out;
        }

        /* 3. Typography & Headers */
        h3.text-danger {
            /* Biến màu đỏ thường thành Gradient Neon */
            background: linear-gradient(to right, #ff416c, #ff4b2b);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 5px 15px rgba(255, 65, 108, 0.3);
            font-weight: 800 !important;
            letter-spacing: 1px;
        }

        .text-muted { color: rgba(255, 255, 255, 0.6) !important; }
        .text-secondary { color: rgba(255, 255, 255, 0.5) !important; transition: 0.3s; }
        .text-secondary:hover { color: #fff !important; text-shadow: 0 0 10px #fff; }

        /* 4. Inputs & Floating Labels */
        .form-control {
            background: rgba(0, 0, 0, 0.2) !important;
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: #fff !important;
            border-radius: 12px;
            backdrop-filter: blur(5px);
        }

        .form-control:focus {
            background: rgba(0, 0, 0, 0.4) !important;
            border-color: #ff4b2b; /* Màu viền khi focus */
            box-shadow: 0 0 20px rgba(255, 75, 43, 0.3); /* Glow đỏ cam */
        }
        
        /* Chỉnh màu label khi floating */
        .form-floating label { color: rgba(255, 255, 255, 0.5); }
        .form-floating > .form-control:focus ~ label,
        .form-floating > .form-control:not(:placeholder-shown) ~ label {
            color: #ff4b2b;
            text-shadow: 0 0 8px rgba(255, 75, 43, 0.5);
        }

        /* Chỉnh nút mắt ẩn hiện pass */
        .input-group .btn-outline-secondary {
            border-color: rgba(255, 255, 255, 0.1);
            color: rgba(255, 255, 255, 0.7);
            background: rgba(0, 0, 0, 0.2);
        }
        .input-group .btn-outline-secondary:hover {
            background: rgba(255, 255, 255, 0.1);
            color: #fff;
        }

        /* 5. Main Button (Neon Gradient) */
        .btn-danger {
            background: linear-gradient(90deg, #ff416c 0%, #ff4b2b 100%);
            border: none;
            padding: 14px;
            font-weight: bold;
            letter-spacing: 1px;
            text-transform: uppercase;
            border-radius: 12px;
            box-shadow: 0 10px 20px rgba(255, 65, 108, 0.3);
            transition: all 0.3s;
        }
        .btn-danger:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(255, 65, 108, 0.5); /* Glow mạnh hơn */
        }

        /* 6. Alerts & Validation */
        .alert-danger {
            background: rgba(220, 53, 69, 0.15);
            border: 1px solid rgba(220, 53, 69, 0.5);
            color: #ff8fa3;
            backdrop-filter: blur(5px);
        }
        .invalid-feedback {
            color: #ff6b6b;
            font-weight: 500;
            text-shadow: 0 0 5px rgba(255, 0, 0, 0.2);
        }

        /* 7. Links */
        a.fw-bold {
            color: #ff416c;
            transition: 0.3s;
        }
        a.fw-bold:hover {
            color: #fff;
            text-shadow: 0 0 10px #ff416c;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        /* Custom scrollbar */
        ::-webkit-scrollbar { width: 8px; }
        ::-webkit-scrollbar-track { background: #0f0c29; }
        ::-webkit-scrollbar-thumb { background: #302b63; border-radius: 4px; }
        ::-webkit-scrollbar-thumb:hover { background: #ff416c; }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">
    <div class="container mt-4 mb-4">
        <div class="row justify-content-center">
            <div class="col-md-7 col-lg-5">
                <div class="card border-0 shadow-lg">
                    <div class="card-body p-5">
                        
                        <div class="mb-4">
                            <a href="${pageContext.request.contextPath}/home" class="text-decoration-none text-secondary small">
                                <i class="bi bi-arrow-left"></i> Quay lại Trang chủ
                            </a>
                        </div>
                        
                        <div class="text-center mb-5">
                            <h3 class="fw-bold text-danger text-uppercase">Đăng Ký</h3>
                            <p class="text-muted">Tham gia cộng đồng PolyOE ngay</p>
                        </div>

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/register" method="POST" novalidate>
                            
                            <div class="form-floating mb-4">
                                <input type="text" class="form-control ${not empty errors.username ? 'is-invalid' : ''}" id="username" name="username" value="${bean.username}" placeholder="Username">
                                <label for="username">Tên đăng nhập</label>
                                <div class="invalid-feedback">${errors.username}</div>
                            </div>

                            <div class="form-floating mb-4">
                                <input type="text" class="form-control ${not empty errors.name ? 'is-invalid' : ''}" id="fullname" name="name" value="${bean.name}" placeholder="Họ và tên">
                                <label for="fullname">Họ và tên đầy đủ</label>
                                <div class="invalid-feedback">${errors.name}</div>
                            </div>

                            <div class="form-floating mb-4">
                                <input type="text" class="form-control ${not empty errors.email ? 'is-invalid' : ''}" id="email" name="email" value="${bean.email}" placeholder="name@example.com">
                                <label for="email">Địa chỉ Email</label>
                                <div class="invalid-feedback">${errors.email}</div>
                            </div>

                            <div class="mb-4">
                                <label for="password" class="form-label small text-muted ps-1">Mật khẩu</label>
                                <div class="input-group">
                                    <input type="password" 
                                           class="form-control ${not empty errors.password ? 'is-invalid' : ''}" 
                                           id="password" name="password" 
                                           placeholder="Nhập mật khẩu"
                                           style="border-top-right-radius: 0; border-bottom-right-radius: 0;">
                                    <button class="btn btn-outline-secondary" type="button" 
                                            onclick="togglePasswordVisibility('password')"
                                            style="border-top-right-radius: 12px; border-bottom-right-radius: 12px;">
                                        <i class="bi bi-eye-slash-fill" id="togglepassword"></i>
                                    </button>
                                    <div class="invalid-feedback">${errors.password}</div>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label for="confirmPassword" class="form-label small text-muted ps-1">Xác nhận mật khẩu</label>
                                <div class="input-group">
                                    <input type="password" 
                                           class="form-control ${not empty errors.confirmPassword ? 'is-invalid' : ''}" 
                                           id="confirmPassword" name="confirmPassword" 
                                           placeholder="Nhập lại mật khẩu"
                                           style="border-top-right-radius: 0; border-bottom-right-radius: 0;">
                                    <button class="btn btn-outline-secondary" type="button" 
                                            onclick="togglePasswordVisibility('confirmPassword')"
                                            style="border-top-right-radius: 12px; border-bottom-right-radius: 12px;">
                                        <i class="bi bi-eye-slash-fill" id="toggleconfirmPassword"></i>
                                    </button>
                                    <div class="invalid-feedback">${errors.confirmPassword}</div>
                                </div>
                            </div>
                            
                            <div class="d-grid gap-2 mb-4 mt-5">
                                <button class="btn btn-danger btn-lg" type="submit">
                                    Tạo tài khoản
                                </button>
                            </div>
                        </form>

                        <div class="text-center border-top border-secondary pt-4 mt-4" style="border-color: rgba(255,255,255,0.1) !important;">
                            <span class="text-muted">Đã có tài khoản?</span>
                            <a href="${pageContext.request.contextPath}/login" class="text-decoration-none fw-bold ms-1">Đăng nhập ngay</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function togglePasswordVisibility(fieldId) {
            const inputField = document.getElementById(fieldId);
            const toggleIcon = document.getElementById('toggle' + fieldId);
            
            const type = inputField.getAttribute('type') === 'password' ? 'text' : 'password';
            inputField.setAttribute('type', type);
            
            // Đổi icon mắt
            if (type === 'text') {
                toggleIcon.classList.remove('bi-eye-slash-fill');
                toggleIcon.classList.add('bi-eye-fill');
            } else {
                toggleIcon.classList.remove('bi-eye-fill');
                toggleIcon.classList.add('bi-eye-slash-fill');
            }
        }
    </script>
    
    <jsp:include page="/common/footer.jsp"/> 
</body>
</html>