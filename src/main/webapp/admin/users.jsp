<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Quản lý Users - Command Center</title>
    <jsp:include page="/common/head.jsp"/>
    
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=Outfit:wght@400;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css" rel="stylesheet">

    <style>
        :root {
            --neon-cyan: #00d2ff;
            --neon-green: #00ff9d;
            --neon-red: #ff416c;
            --neon-orange: #ff9f43;
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

        /* --- 1. CONTAINER --- */
        .master-container { margin-top: 3rem; margin-bottom: 3rem; }

        .glass-panel {
            background: var(--card-glass);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: var(--border-glass);
            border-radius: 24px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.6);
            padding: 2.5rem;
            position: relative;
            overflow: hidden;
            animation: fadeIn 0.6s ease-out;
        }
        
        /* Header Glow Line */
        .glass-panel::before {
            content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 2px;
            background: linear-gradient(90deg, transparent, var(--neon-cyan), transparent); opacity: 0.5;
        }

        .panel-header {
            margin-bottom: 2.5rem;
            display: flex; justify-content: space-between; align-items: flex-end; gap: 20px;
            border-bottom: 1px solid rgba(255,255,255,0.05); padding-bottom: 20px;
        }

        .panel-title {
            font-family: 'Outfit', sans-serif;
            font-size: 1.8rem; font-weight: 800; text-transform: uppercase; letter-spacing: 1px;
            color: #fff; text-shadow: 0 0 20px rgba(0, 210, 255, 0.3);
            white-space: nowrap;
        }
        
        /* --- SEARCH BOX STYLE --- */
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
            border-color: var(--neon-cyan);
            box-shadow: 0 0 10px rgba(0, 210, 255, 0.2);
            outline: none;
        }
        .search-icon-admin {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
        }

        .counter-badge {
            background: rgba(0, 210, 255, 0.1); border: 1px solid rgba(0, 210, 255, 0.3);
            color: var(--neon-cyan); padding: 5px 15px; border-radius: 50px;
            font-size: 0.85rem; font-weight: 700; box-shadow: 0 0 10px rgba(0, 210, 255, 0.1);
            white-space: nowrap;
        }

        /* --- 2. TABLE DESIGN (Floating Dark Rows) --- */
        .master-table { width: 100%; border-collapse: separate; border-spacing: 0 12px; }

        .master-table thead th {
            font-size: 0.75rem; font-weight: 700; text-transform: uppercase; letter-spacing: 1.5px;
            color: var(--text-muted); padding: 0 24px 10px 24px; border: none;
        }

        .master-table tbody tr {
            background: rgba(255, 255, 255, 0.03);
            transition: all 0.3s ease;
        }

        /* Hover Effect: Neon Border */
        .master-table tbody tr:hover {
            transform: translateY(-3px) scale(1.005);
            background: rgba(255, 255, 255, 0.08);
            box-shadow: 0 10px 30px -10px rgba(0, 0, 0, 0.5);
            position: relative; z-index: 10;
        }
        
        .master-table tbody tr:hover td {
            border-top: 1px solid rgba(0, 210, 255, 0.3);
            border-bottom: 1px solid rgba(0, 210, 255, 0.3);
        }
        .master-table tbody tr:hover td:first-child { border-left: 1px solid rgba(0, 210, 255, 0.3); }
        .master-table tbody tr:hover td:last-child { border-right: 1px solid rgba(0, 210, 255, 0.3); }

        .master-table td {
            padding: 15px 24px; vertical-align: middle;
            border-top: 1px solid transparent; border-bottom: 1px solid transparent;
            color: var(--text-main);
        }

        /* Rounded Corners */
        .master-table td:first-child { border-top-left-radius: 12px; border-bottom-left-radius: 12px; border-left: 1px solid transparent; }
        .master-table td:last-child { border-top-right-radius: 12px; border-bottom-right-radius: 12px; border-right: 1px solid transparent; }

        /* --- 3. COMPONENTS --- */
        
        /* Avatar */
        .avatar-box {
            width: 45px; height: 45px; border-radius: 50%; object-fit: cover;
            border: 2px solid rgba(255,255,255,0.1); transition: 0.3s;
        }
        .master-table tr:hover .avatar-box { border-color: var(--neon-cyan); box-shadow: 0 0 10px var(--neon-cyan); }

        .text-main-bold { font-weight: 600; color: #fff; font-size: 0.95rem; }
        .text-sub-small { font-size: 0.85rem; color: var(--text-muted); font-family: monospace; }

        /* Role Badges (Neon Style) */
        .role-btn {
            padding: 6px 14px; border-radius: 6px; font-size: 0.75rem; font-weight: 700;
            display: inline-flex; align-items: center; gap: 8px; transition: 0.2s;
            border: 1px solid transparent; text-decoration: none; cursor: pointer; text-transform: uppercase;
        }

        .role-admin { background: rgba(255, 159, 67, 0.1); color: var(--neon-orange); border-color: rgba(255, 159, 67, 0.3); }
        .role-creator { background: rgba(0, 210, 255, 0.1); color: var(--neon-cyan); border-color: rgba(0, 210, 255, 0.3); }
        .role-user { background: rgba(255, 255, 255, 0.05); color: var(--text-muted); border-color: rgba(255, 255, 255, 0.1); }

        .role-btn:hover:not(.role-admin) { 
            background: rgba(255, 255, 255, 0.1); border-color: #fff; color: #fff; 
            box-shadow: 0 0 10px rgba(255,255,255,0.3);
        }

        /* Status Indicators (Glowing Dots) */
        .status-pill {
            display: inline-flex; align-items: center; gap: 10px;
            font-size: 0.85rem; font-weight: 600;
        }
        .dot { width: 8px; height: 8px; border-radius: 50%; box-shadow: 0 0 8px currentColor; }
        
        .status-active { color: var(--neon-green); }
        .status-blocked { color: var(--neon-red); }

        /* Action Buttons */
        .btn-icon {
            width: 36px; height: 36px; border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            border: 1px solid rgba(255,255,255,0.1); background: rgba(255,255,255,0.05);
            color: var(--text-muted); transition: 0.2s; text-decoration: none;
        }
        
        /* Lock -> Red Glow */
        .btn-lock:hover { background: rgba(255, 65, 108, 0.1); color: var(--neon-red); border-color: var(--neon-red); box-shadow: 0 0 15px rgba(255, 65, 108, 0.4); }
        /* Unlock -> Green Glow */
        .btn-open:hover { background: rgba(0, 255, 157, 0.1); color: var(--neon-green); border-color: var(--neon-green); box-shadow: 0 0 15px rgba(0, 255, 157, 0.4); }

        /* Dropdown Dark */
        .dropdown-menu-dark-custom {
            background: #1a1a2e; border: 1px solid rgba(255,255,255,0.1);
            box-shadow: 0 10px 30px rgba(0,0,0,0.5); border-radius: 12px; padding: 8px;
        }
        .dropdown-item { border-radius: 6px; color: #ccc; font-size: 0.85rem; transition: 0.2s; }
        .dropdown-item:hover { background: rgba(255,255,255,0.1); color: #fff; }

        @keyframes fadeIn { from {opacity: 0; transform: translateY(20px);} to {opacity: 1; transform: translateY(0);} }
    </style>
</head>
<body>
    <jsp:include page="/common/header.jsp"/>

    <div class="container master-container">
        
        <div class="glass-panel">
            <div class="panel-header">
                <div>
                    <h2 class="panel-title"><i class="ri-shield-user-fill text-info"></i> User Control</h2>
                    <p class="text-muted small mb-0 mt-1" style="letter-spacing: 0.5px;">Trung tâm quản lý nhân sự.</p>
                </div>
                
                <form action="${pageContext.request.contextPath}/admin/users" method="GET" class="search-box-admin">
                    <i class="ri-search-2-line search-icon-admin"></i>
                    <input type="text" name="keyword" class="search-input-admin" 
                           placeholder="Tìm theo Username hoặc Họ tên..." 
                           value="${param.keyword}">
                </form>
                <div class="counter-badge">
                    <i class="ri-radar-line me-1"></i> ${users.size()} ACTIVE UNITS
                </div>
            </div>

            <div class="table-responsive">
                <table class="master-table">
                    <thead>
                        <tr>
                            <th class="ps-4">Nhân sự</th>
                            <th>Định danh Email</th>
                            <th>Cấp bậc</th>
                            <th>Tín hiệu</th>
                            <th class="text-end pe-4">Điều khiển</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="u" items="${users}">
                            <tr>
                                <td class="ps-4">
                                    <div class="d-flex align-items-center gap-3">
                                        <img src="https://ui-avatars.com/api/?name=${u.name}&background=random&size=128&bold=true&color=fff" class="avatar-box">
                                        <div>
                                            <div class="text-main-bold">${u.username}</div>
                                            <div class="text-sub-small" style="opacity: 0.7;">${u.name}</div>
                                        </div>
                                    </div>
                                </td>

                                <td class="text-sub-small" style="color: var(--neon-cyan);">
                                    ${u.email}
                                </td>

                                <td>
                                    <c:choose>
                                        <c:when test="${u.role == 'admin'}">
                                            <span class="role-btn role-admin">
                                                <i class="ri-vip-crown-2-fill"></i> ADMIN
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="dropdown">
                                                <button class="role-btn ${u.role == 'creator' ? 'role-creator' : 'role-user'} dropdown-toggle" 
                                                        type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                    <i class="${u.role == 'creator' ? 'ri-movie-2-fill' : 'ri-user-3-fill'}"></i> 
                                                    ${u.role.toUpperCase()}
                                                </button>
                                                <ul class="dropdown-menu dropdown-menu-dark-custom">
                                                    <li><h6 class="dropdown-header text-uppercase small fw-bold text-muted" style="font-size: 0.65rem;">Thăng/Giáng cấp</h6></li>
                                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/user/setrole?id=${u.id}&role=creator">
                                                        <i class="ri-arrow-up-circle-line me-2 text-info"></i> Lên Creator
                                                    </a></li>
                                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/user/setrole?id=${u.id}&role=user">
                                                        <i class="ri-arrow-down-circle-line me-2 text-muted"></i> Xuống User
                                                    </a></li>
                                                </ul>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td>
                                    <div class="status-pill ${u.status ? 'status-active' : 'status-blocked'}">
                                        <div class="dot"></div>
                                        ${u.status ? 'ONLINE' : 'OFFLINE'}
                                    </div>
                                </td>

                                <td class="text-end pe-4">
                                    <c:if test="${u.username != sessionScope.currentUser.username}">
                                        <a href="${pageContext.request.contextPath}/admin/user/toggle?id=${u.id}" 
                                           class="btn-icon ${u.status ? 'btn-lock' : 'btn-open'}"
                                           data-bs-toggle="tooltip" title="${u.status ? 'Vô hiệu hóa' : 'Kích hoạt'}">
                                            <i class="${u.status ? 'ri-lock-2-line' : 'ri-lock-unlock-line'}" style="font-size: 1.1rem;"></i>
                                        </a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
                <c:if test="${empty users}">
                    <div class="text-center py-5 text-muted">
                        <i class="ri-user-search-line display-4"></i>
                        <p class="mt-2">
                            ${not empty param.keyword ? 'Không tìm thấy user nào khớp với từ khóa.' : 'Danh sách user trống.'}
                        </p>
                        <c:if test="${not empty param.keyword}">
                            <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-sm btn-outline-light mt-2 rounded-pill">Hiện tất cả</a>
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