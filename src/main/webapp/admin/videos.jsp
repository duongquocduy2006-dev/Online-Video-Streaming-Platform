<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Quản lý Video - Command Center</title>
    <jsp:include page="/common/head.jsp"/>
    
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=Outfit:wght@400;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css" rel="stylesheet">

    <style>
        /* Style dùng chung của Admin - Copy từ users.jsp để đồng bộ */
        :root {
            --neon-cyan: #00d2ff;
            --neon-pink: #ff416c;
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
        
        .panel-header {
            margin-bottom: 2.5rem; border-bottom: 1px solid rgba(255,255,255,0.05); padding-bottom: 20px;
            display: flex; justify-content: space-between; align-items: flex-end;
        }

        .panel-title {
            font-family: 'Outfit', sans-serif; font-size: 1.8rem; font-weight: 800;
            text-transform: uppercase; letter-spacing: 1px; color: #fff;
            text-shadow: 0 0 20px rgba(255, 65, 108, 0.3); /* Pink Glow */
        }

        /* Table */
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

        /* Thumb & Info */
        .vid-thumb { width: 80px; height: 45px; object-fit: cover; border-radius: 8px; border: 1px solid rgba(255,255,255,0.2); }
        .vid-title { font-weight: 600; color: #fff; max-width: 250px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        
        .badge-pill { padding: 5px 10px; border-radius: 50px; font-size: 0.75rem; font-weight: 700; text-transform: uppercase; }
        .badge-cat { background: rgba(0, 210, 255, 0.1); color: var(--neon-cyan); border: 1px solid rgba(0, 210, 255, 0.3); }

        .btn-icon {
            width: 34px; height: 34px; border-radius: 8px; display: inline-flex; align-items: center; justify-content: center;
            border: 1px solid rgba(255,255,255,0.1); background: rgba(255,255,255,0.05); color: var(--text-muted); text-decoration: none; transition: 0.2s;
        }
        .btn-view:hover { color: var(--neon-cyan); border-color: var(--neon-cyan); }
        .btn-delete:hover { color: var(--neon-pink); border-color: var(--neon-pink); background: rgba(255, 65, 108, 0.1); }
        
        @keyframes fadeIn { from {opacity: 0; transform: translateY(20px);} to {opacity: 1; transform: translateY(0);} }
    </style>
</head>
<body>
    <jsp:include page="/common/header.jsp"/>

    <div class="container master-container">
        <div class="glass-panel">
            <div class="panel-header">
                <div>
                    <h2 class="panel-title"><i class="ri-movie-2-fill me-2 text-danger"></i> Video Control</h2>
                    <p class="text-muted small mb-0 mt-1">Kiểm soát nội dung toàn hệ thống.</p>
                </div>
                <div class="px-3 py-1 border border-secondary rounded-pill text-white small">
                    <i class="ri-database-line me-1"></i> Total: <strong>${videos.size()}</strong>
                </div>
            </div>

            <div class="table-responsive">
                <table class="master-table">
                    <thead>
                        <tr>
                            <th class="ps-4">Nội dung</th>
                            <th>Người đăng</th>
                            <th>Danh mục</th>
                            <th>Lượt xem</th>
                            <th>Tình trạng</th>
                            <th class="text-end pe-4">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="v" items="${videos}">
                            <tr>
                                <td class="ps-4">
                                    <div class="d-flex align-items-center gap-3">
                                        <img src="${v.poster}" class="vid-thumb" onerror="this.src='https://via.placeholder.com/80x45?text=Error'">
                                        <div>
                                            <div class="vid-title" title="${v.title}">${v.title}</div>
                                            <small class="text-muted" style="font-family: monospace;">ID: #${v.id}</small>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="d-flex align-items-center gap-2">
                                        <img src="https://ui-avatars.com/api/?name=${v.user.name}&size=24&background=random" class="rounded-circle">
                                        <span class="small text-white">${v.user.name}</span>
                                    </div>
                                </td>
                                <td><span class="badge-pill badge-cat">${v.category.name}</span></td>
                                <td class="fw-bold text-white">${v.viewcount}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${v.status}">
                                            <span class="text-success small fw-bold"><i class="ri-checkbox-circle-fill"></i> Online</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-warning text-dark border-0">
                                                <i class="ri-hourglass-fill"></i> Chờ duyệt
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td class="text-end pe-4">
                                    <div class="d-flex justify-content-end gap-2">
                                        <a href="${pageContext.request.contextPath}/video/detail?id=${v.id}" target="_blank" 
                                           class="btn-icon btn-view" data-bs-toggle="tooltip" title="Xem nội dung">
                                            <i class="ri-external-link-line"></i>
                                        </a>
                                        
                                        <a href="${pageContext.request.contextPath}/admin/video/status?id=${v.id}" 
                                           class="btn-icon" 
                                           style="${v.status ? 'color: #ff416c; border-color: #ff416c;' : 'color: #00ff9d; border-color: #00ff9d; background: rgba(0,255,157,0.1);'}"
                                           data-bs-toggle="tooltip" 
                                           title="${v.status ? 'Gỡ xuống (Ẩn)' : 'DUYỆT NGAY'}">
                                            <i class="${v.status ? 'ri-eye-off-line' : 'ri-check-double-line fw-bold'}"></i>
                                        </a>

                                        <a href="${pageContext.request.contextPath}/admin/video/delete?id=${v.id}" 
                                           class="btn-icon btn-delete" 
                                           onclick="return confirm('CẢNH BÁO: Xóa vĩnh viễn video [${v.title}]? Hành động này không thể hoàn tác.');"
                                           data-bs-toggle="tooltip" title="Xóa vĩnh viễn">
                                            <i class="ri-delete-bin-5-line"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                 <c:if test="${empty videos}">
                    <div class="text-center py-5 text-muted">
                        <i class="ri-film-line display-4"></i>
                        <p class="mt-2">Hệ thống chưa có video nào.</p>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
    
    <jsp:include page="/common/footer.jsp"/>
    <script>
        // Init Bootstrap Tooltips
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
          return new bootstrap.Tooltip(tooltipTriggerEl)
        })
    </script>
</body>
</html>