<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Kiểm duyệt Bình luận - PolyOE Admin</title>
    <jsp:include page="/common/head.jsp"/>
    
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=Outfit:wght@400;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css" rel="stylesheet">

    <style>
        :root {
            --neon-cyan: #00d2ff;
            --neon-pink: #ff416c;
            --neon-yellow: #f9ca24;
            --bg-dark: #0f0c29;
            --card-glass: rgba(255, 255, 255, 0.03);
            --border-glass: 1px solid rgba(255, 255, 255, 0.08);
            --text-main: #e0e0e0;
            --text-muted: rgba(255, 255, 255, 0.5);
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: linear-gradient(135deg, #0f0c29 0%, #302b63 50%, #24243e 100%) fixed;
            color: var(--text-main);
            min-height: 100vh;
        }

        .master-container { margin-top: 3rem; margin-bottom: 3rem; }

        .glass-panel {
            background: var(--card-glass);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: var(--border-glass);
            border-radius: 24px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.6);
            padding: 2.5rem;
            animation: fadeIn 0.6s ease-out;
        }
        
        /* Cập nhật Panel Header để chứa ô tìm kiếm */
        .panel-header {
            margin-bottom: 2.5rem; border-bottom: 1px solid rgba(255,255,255,0.05); padding-bottom: 20px;
            display: flex; justify-content: space-between; align-items: flex-end; gap: 20px;
        }

        .panel-title {
            font-family: 'Outfit', sans-serif; font-size: 1.8rem; font-weight: 800;
            text-transform: uppercase; letter-spacing: 1px; color: #fff;
            text-shadow: 0 0 20px rgba(249, 202, 36, 0.3); /* Yellow Glow */
            white-space: nowrap;
        }

        /* --- STYLE CHO Ô TÌM KIẾM --- */
        .search-box-admin {
            flex-grow: 1;
            max-width: 400px;
            position: relative;
        }
        .search-input-admin {
            width: 100%;
            background: rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: #fff;
            padding: 10px 15px 10px 40px;
            border-radius: 50px;
            transition: 0.3s;
        }
        .search-input-admin:focus {
            background: rgba(0, 0, 0, 0.5);
            border-color: var(--neon-yellow);
            box-shadow: 0 0 10px rgba(249, 202, 36, 0.2);
            outline: none;
        }
        .search-icon-admin {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
        }
        /* --------------------------- */

        /* Table Design */
        .master-table { width: 100%; border-collapse: separate; border-spacing: 0 12px; }
        .master-table thead th {
            font-size: 0.75rem; text-transform: uppercase; letter-spacing: 1.5px;
            color: var(--text-muted); padding: 0 24px 10px 24px; border: none;
        }
        .master-table tbody tr { background: rgba(255, 255, 255, 0.03); transition: 0.3s; }
        .master-table tbody tr:hover {
            transform: translateY(-3px); background: rgba(255, 255, 255, 0.08);
            box-shadow: 0 10px 20px -5px rgba(0,0,0,0.5);
        }
        .master-table td { padding: 15px 24px; vertical-align: middle; color: var(--text-main); }
        .master-table td:first-child { border-top-left-radius: 12px; border-bottom-left-radius: 12px; }
        .master-table td:last-child { border-top-right-radius: 12px; border-bottom-right-radius: 12px; }

        /* Content Styling */
        .comment-content {
            max-width: 350px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            color: #fff;
            font-style: italic;
        }
        
        .video-link {
            text-decoration: none; color: var(--neon-cyan); font-weight: 600; font-size: 0.9rem;
            display: flex; align-items: center; gap: 5px;
        }
        .video-link:hover { text-decoration: underline; color: #fff; text-shadow: 0 0 10px var(--neon-cyan); }

        .user-info { display: flex; align-items: center; gap: 10px; }
        .user-avatar { width: 35px; height: 35px; border-radius: 50%; border: 1px solid rgba(255,255,255,0.2); }

        .btn-icon {
            width: 34px; height: 34px; border-radius: 8px; display: inline-flex; align-items: center; justify-content: center;
            border: 1px solid rgba(255,255,255,0.1); background: rgba(255,255,255,0.05); color: var(--text-muted); text-decoration: none; transition: 0.2s;
        }
        .btn-delete:hover { color: var(--neon-pink); border-color: var(--neon-pink); background: rgba(255, 65, 108, 0.1); box-shadow: 0 0 10px rgba(255, 65, 108, 0.2); }

        @keyframes fadeIn { from {opacity: 0; transform: translateY(20px);} to {opacity: 1; transform: translateY(0);} }
    </style>
</head>
<body>
    <jsp:include page="/common/header.jsp"/>

    <div class="container master-container">
        <div class="glass-panel">
            <div class="panel-header">
                <div>
                    <h2 class="panel-title"><i class="ri-discuss-fill me-2 text-warning"></i> Moderation</h2>
                    <p class="text-muted small mb-0 mt-1">Kiểm soát bình luận và tương tác cộng đồng.</p>
                </div>

                <form action="${pageContext.request.contextPath}/admin/comments" method="GET" class="search-box-admin">
                    <i class="ri-search-2-line search-icon-admin"></i>
                    <input type="text" name="keyword" class="search-input-admin" 
                           placeholder="Tìm nội dung bình luận..." 
                           value="${param.keyword}">
                </form>
                <div class="px-3 py-1 border border-secondary rounded-pill text-white small" style="white-space: nowrap;">
                    <i class="ri-message-3-line me-1"></i> Total: <strong>${comments.size()}</strong>
                </div>
            </div>

            <div class="table-responsive">
                <table class="master-table">
                    <thead>
                        <tr>
                            <th class="ps-4">Người bình luận</th>
                            <th>Nội dung</th>
                            <th>Video</th>
                            <th>Thời gian</th>
                            <th class="text-end pe-4">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="c" items="${comments}">
                            <tr>
                                <td class="ps-4">
                                    <div class="user-info">
                                        <img src="https://ui-avatars.com/api/?name=${c.user.name}&size=32&background=random" class="user-avatar">
                                        <div>
                                            <div class="fw-bold text-white small">${c.user.name}</div>
                                            <div class="text-muted" style="font-size: 0.75rem;">@${c.user.username}</div>
                                        </div>
                                    </div>
                                </td>
                                
                                <td>
                                    <div class="comment-content" title="${c.content}">
                                        "${c.content}"
                                    </div>
                                </td>

                                <td>
                                    <a href="${pageContext.request.contextPath}/video/detail?id=${c.video.id}" target="_blank" class="video-link">
                                        <i class="ri-film-line"></i> ${c.video.title}
                                    </a>
                                </td>

                                <td class="text-muted small">
                                    <fmt:formatDate value="${c.createAt}" pattern="dd/MM/yyyy HH:mm"/>
                                </td>

                                <td class="text-end pe-4">
                                    <a href="${pageContext.request.contextPath}/admin/comment/delete?id=${c.id}" 
                                       class="btn-icon btn-delete" 
                                       onclick="return confirm('Xóa bình luận này của [${c.user.name}]?');"
                                       data-bs-toggle="tooltip" title="Xóa bình luận">
                                        <i class="ri-delete-bin-line"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <c:if test="${empty comments}">
                    <div class="text-center py-5 text-muted">
                        <i class="ri-search-eye-line display-4"></i>
                        <p class="mt-2">
                            ${not empty param.keyword ? 'Không tìm thấy bình luận nào khớp với từ khóa.' : 'Chưa có bình luận nào trong hệ thống.'}
                        </p>
                        <c:if test="${not empty param.keyword}">
                            <a href="${pageContext.request.contextPath}/admin/comments" class="btn btn-sm btn-outline-light mt-2 rounded-pill">Xóa bộ lọc</a>
                        </c:if>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
    
    <jsp:include page="/common/footer.jsp"/>
    
    <script>
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
          return new bootstrap.Tooltip(tooltipTriggerEl)
        })
    </script>
</body>
</html>