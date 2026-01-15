<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Video đã thích - PolyOE</title>
    <jsp:include page="/common/head.jsp"/>
    
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --neon-red: #ff416c;
            --neon-purple: #ff4b2b;
            --text-main: #e0e0e0;
            --glass-bg: rgba(255, 255, 255, 0.05);
            --glass-border: rgba(255, 255, 255, 0.1);
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: linear-gradient(135deg, #0f0c29 0%, #302b63 50%, #24243e 100%) fixed;
            color: var(--text-main);
            min-height: 100vh;
        }

        /* 1. Page Title */
        h3.text-uppercase {
            letter-spacing: 1px;
            background: linear-gradient(to right, #fff, var(--neon-red));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 0 30px rgba(255, 65, 108, 0.3);
            border-left-color: var(--neon-red) !important;
        }
        
        .bi-heart-fill {
            filter: drop-shadow(0 0 10px var(--neon-red));
        }

        /* 2. Glass Cards */
        .card-video {
            background: var(--glass-bg) !important;
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border) !important;
            border-radius: 20px !important;
            overflow: hidden;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        .card-img-top {
            transition: transform 0.6s ease;
            opacity: 0.9;
        }

        .card-body {
            position: relative;
            z-index: 2;
            background: linear-gradient(to top, rgba(0,0,0,0.8), transparent);
        }

        /* 3. Typography inside Card */
        .card-title a {
            color: #fff !important;
            transition: 0.3s;
        }
        .card-title a:hover {
            color: var(--neon-red) !important;
            text-shadow: 0 0 10px var(--neon-red);
        }
        .text-muted { color: rgba(255, 255, 255, 0.6) !important; }

        /* 4. Hover Effects */
        .card-video:hover {
            transform: translateY(-10px) scale(1.02);
            border-color: var(--neon-red) !important;
            box-shadow: 0 15px 40px rgba(255, 65, 108, 0.25);
            background: rgba(255, 255, 255, 0.1) !important;
        }
        .card-video:hover .card-img-top {
            transform: scale(1.1);
            opacity: 1;
        }

        /* 5. Buttons */
        .btn-outline-danger {
            color: var(--neon-red);
            border-color: var(--neon-red);
            border-radius: 50px;
            font-size: 0.8rem;
            font-weight: 600;
            backdrop-filter: blur(5px);
        }
        .btn-outline-danger:hover {
            background: var(--neon-red);
            color: #fff;
            box-shadow: 0 0 15px var(--neon-red);
            transform: translateY(-2px);
        }

        /* 6. Empty State */
        .empty-state-icon {
            font-size: 6rem;
            background: linear-gradient(to bottom, rgba(255,255,255,0.5), rgba(255,255,255,0.1));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            animation: float 4s ease-in-out infinite;
        }
        
        .btn-primary {
            background: linear-gradient(90deg, #00d2ff 0%, #3a7bd5 100%);
            border: none;
            padding: 10px 30px;
            border-radius: 50px;
            font-weight: bold;
            box-shadow: 0 5px 15px rgba(0, 210, 255, 0.3);
            transition: 0.3s;
        }
        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(0, 210, 255, 0.5);
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }
    </style>
</head>
<body>
    <jsp:include page="/common/header.jsp"/>

    <div class="container mt-5 mb-5">
        <h3 class="mb-5 border-start border-4 ps-4 fw-bold text-uppercase d-flex align-items-center">
            <i class="bi bi-heart-fill text-danger me-3" style="color: var(--neon-red) !important;"></i> 
            Video đã thích
        </h3>

        <c:if test="${empty videos}">
            <div class="text-center py-5">
                <i class="bi bi-emoji-frown empty-state-icon mb-3 d-block"></i>
                <h4 class="text-white fw-bold">Danh sách trống trơn!</h4>
                <p class="mb-4 text-muted fs-6">Hãy thả tim cho những video bạn yêu thích để lưu lại đây nhé.</p>
                <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">
                    <i class="bi bi-compass me-2"></i>Khám phá ngay
                </a>
            </div>
        </c:if>

        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
            <c:forEach var="v" items="${videos}">
                <div class="col">
                    <div class="card h-100 border-0 shadow-sm card-video">
                        <div class="position-relative overflow-hidden">
                            <a href="${pageContext.request.contextPath}/video/detail?id=${v.id}">
                                <img src="${v.poster}" class="card-img-top" alt="${v.title}" style="height: 180px; object-fit: cover;">
                            </a>
                        </div>
                        <div class="card-body d-flex flex-column">
                            <h6 class="card-title text-truncate fw-bold mb-3">
                                <a href="${pageContext.request.contextPath}/video/detail?id=${v.id}" class="text-decoration-none stretched-link">
                                    ${v.title}
                                </a>
                            </h6>
                            <div class="mt-auto d-flex justify-content-between align-items-center">
                                <small class="text-muted"><i class="bi bi-eye-fill me-1"></i>${v.viewcount}</small>
                                
                                <%-- 
                                    SỬA LỖI Ở ĐÂY: 
                                    Thêm style="position: relative; z-index: 10;" 
                                    để nút này nổi lên trên lớp 'stretched-link', giúp bấm được.
                                --%>
                                <a href="${pageContext.request.contextPath}/video/unlike?id=${v.id}" 
                                   class="btn btn-sm btn-outline-danger"
                                   style="position: relative; z-index: 10;" 
                                   onclick="return confirm('Bỏ thích video này?');">
                                    <i class="bi bi-heart-break-fill me-1"></i> Bỏ thích
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <jsp:include page="/common/footer.jsp"/>
</body>
</html>