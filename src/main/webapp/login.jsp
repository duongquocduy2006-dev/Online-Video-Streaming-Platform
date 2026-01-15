<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng nhập - PolyOE</title>
    <jsp:include page="/common/head.jsp"/> 
    
    <style>
        /* 1. Global Setup */
        @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600;700;800&display=swap');
        
        body {
            /* Nền tối Gradient sâu thăm thẳm */
            background: linear-gradient(135deg, #0f0c29 0%, #302b63 50%, #24243e 100%) fixed;
            font-family: 'Montserrat', sans-serif;
            color: #e0e0e0;
        }

        /* 2. Glassmorphism Card (Hiệu ứng kính) */
        .card {
            background: rgba(255, 255, 255, 0.05) !important;
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.1) !important;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.6);
            border-radius: 24px !important;
            overflow: hidden;
            animation: zoomIn 0.6s ease-out; /* Hiệu ứng phóng to nhẹ khi load */
        }

        /* 3. Logo & Typography */
        h3.text-danger {
            /* Gradient Red Neon cho Logo */
            background: linear-gradient(to right, #ff416c, #ff4b2b);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 0 20px rgba(255, 65, 108, 0.4); /* Glow đỏ */
            font-weight: 800 !important;
            letter-spacing: 2px;
            text-transform: uppercase;
        }

        .text-muted { color: rgba(255, 255, 255, 0.6) !important; }
        
        /* Link quay lại */
        .text-secondary { color: rgba(255, 255, 255, 0.5) !important; transition: 0.3s; }
        .text-secondary:hover { 
            color: #00d2ff !important; 
            text-shadow: 0 0 10px rgba(0, 210, 255, 0.5); 
            transform: translateX(-5px); /* Di chuyển nhẹ sang trái */
            display: inline-block;
        }

        /* 4. Inputs & Labels */
        .form-control {
            background: rgba(0, 0, 0, 0.2) !important;
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: #fff !important;
            border-radius: 12px;
            height: 55px; /* Cao hơn chút cho sang */
            backdrop-filter: blur(5px);
            transition: all 0.3s;
        }

        .form-control:focus {
            background: rgba(0, 0, 0, 0.4) !important;
            border-color: #00d2ff; /* Viền xanh Cyan khi focus */
            box-shadow: 0 0 20px rgba(0, 210, 255, 0.2);
        }
        
        /* Floating Label Color */
        .form-floating label { color: rgba(255, 255, 255, 0.5); }
        .form-floating > .form-control:focus ~ label,
        .form-floating > .form-control:not(:placeholder-shown) ~ label {
            color: #00d2ff; /* Màu xanh Cyan cho label khi active */
            font-weight: 600;
        }

        /* 5. Primary Button (Cyan Gradient) */
        .btn-primary {
            background: linear-gradient(90deg, #00d2ff 0%, #3a7bd5 100%);
            border: none;
            padding: 14px;
            font-weight: bold;
            letter-spacing: 1px;
            text-transform: uppercase;
            border-radius: 12px;
            box-shadow: 0 10px 20px rgba(0, 210, 255, 0.3);
            transition: all 0.3s;
        }

        .btn-primary:hover {
            transform: translateY(-3px) scale(1.02);
            box-shadow: 0 15px 30px rgba(0, 210, 255, 0.5);
        }

        /* 6. Alerts */
        .alert-danger {
            background: rgba(255, 65, 108, 0.1);
            border: 1px solid rgba(255, 65, 108, 0.3);
            color: #ff8fa3;
            backdrop-filter: blur(5px);
            border-radius: 12px;
        }

        /* 7. Bottom Link */
        .mt-3 a {
            color: #00d2ff;
            font-weight: 600;
            transition: 0.3s;
        }
        .mt-3 a:hover {
            color: #fff;
            text-shadow: 0 0 10px #00d2ff;
            text-decoration: underline !important;
        }

        /* Animation Keyframe */
        @keyframes zoomIn {
            from { opacity: 0; transform: scale(0.9); }
            to { opacity: 1; transform: scale(1); }
        }
    </style>
</head>

<body class="d-flex flex-column min-vh-100 justify-content-center"> 
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-5 col-lg-4">
                <div class="card border-0 shadow-lg">
                    <div class="card-body p-5">
                        
                        <div class="mb-4">
                            <a href="${pageContext.request.contextPath}/home" class="text-decoration-none text-secondary small">
                                <i class="bi bi-arrow-left me-1"></i>Trang chủ
                            </a>
                        </div>
                        
                        <div class="text-center mb-5">
                            <h3 class="fw-bold text-danger mb-2">
                                <i class="bi bi-play-circle-fill me-2"></i>POLYOE
                            </h3>
                            <p class="text-muted small text-uppercase" style="letter-spacing: 2px;">Cổng thông tin trực tuyến</p>
                        </div>

                        <c:if test="${not empty message}">
                            <div class="alert alert-danger text-center mb-4">
                                <i class="bi bi-exclamation-circle me-1"></i> ${message}
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/login" method="POST" novalidate>
                            
                            <div class="form-floating mb-4">
                                <input type="text" 
                                       class="form-control ${not empty errors.username ? 'is-invalid' : ''}" 
                                       id="u" name="username" 
                                       value="${bean.username}" 
                                       placeholder="Username">
                                <label for="u"><i class="bi bi-person me-1"></i>Username / Email</label>
                                <div class="invalid-feedback">${errors.username}</div>
                            </div>

                            <div class="form-floating mb-4">
                                <input type="password" 
                                       class="form-control ${not empty errors.password ? 'is-invalid' : ''}" 
                                       id="p" name="password" 
                                       placeholder="Password">
                                <label for="p"><i class="bi bi-key me-1"></i>Mật khẩu</label>
                                <div class="invalid-feedback">${errors.password}</div>
                            </div>
                            
                            <div class="d-grid mb-4 pt-2">
                                <button class="btn btn-primary btn-lg" type="submit">
                                    Đăng Nhập <i class="bi bi-box-arrow-in-right ms-2"></i>
                                </button>
                            </div>
                        </form>
                        
                        <div class="text-center pt-3 border-top border-secondary" style="border-color: rgba(255,255,255,0.1) !important;">
                            <span class="text-muted small">Chưa có tài khoản?</span>
                            <a href="${pageContext.request.contextPath}/register" class="text-decoration-none ms-1">Đăng ký ngay</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="/common/footer.jsp"/> 
</body>
</html>