<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Danh mục Hệ thống - Command Node</title>
    <jsp:include page="/common/head.jsp"/>
    
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=Outfit:wght@400;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css" rel="stylesheet">

    <style>
        :root {
            --neon-purple: #bd34fe;
            --neon-blue: #3b82f6;
            --neon-red: #ff416c;
            --neon-green: #00ff9d;
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

        .page-container { padding-top: 3rem; padding-bottom: 3rem; }

        /* --- 1. GLASS CARD (Panel) --- */
        .glass-panel {
            background: var(--card-glass);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: var(--border-glass);
            border-radius: 24px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.6);
            height: 100%;
            position: relative;
            overflow: hidden;
            animation: slideUp 0.6s ease-out;
        }

        /* Top Line Glow */
        .glass-panel::before {
            content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 2px;
            background: linear-gradient(90deg, transparent, var(--neon-purple), transparent); opacity: 0.6;
        }

        .panel-title {
            font-family: 'Outfit', sans-serif; font-size: 1.25rem; font-weight: 700; text-transform: uppercase;
            color: #fff; display: flex; align-items: center; gap: 10px; margin-bottom: 1.5rem;
            text-shadow: 0 0 15px rgba(189, 52, 254, 0.3);
        }

        /* --- 2. FORM ELEMENTS --- */
        .input-dark {
            background: rgba(0,0,0,0.3);
            border: 1px solid rgba(255,255,255,0.1);
            border-radius: 12px; padding: 12px 16px;
            color: #fff; font-weight: 500; transition: 0.3s;
        }
        .input-dark:focus {
            background: rgba(0,0,0,0.5); border-color: var(--neon-purple);
            box-shadow: 0 0 15px rgba(189, 52, 254, 0.2); outline: none;
        }
        .input-dark::placeholder { color: rgba(255,255,255,0.3); }

        .btn-neon {
            background: linear-gradient(90deg, #bd34fe 0%, #d946ef 100%);
            color: #fff; border: none; border-radius: 12px; padding: 12px;
            font-weight: 700; text-transform: uppercase; letter-spacing: 1px;
            box-shadow: 0 5px 15px rgba(189, 52, 254, 0.3); transition: 0.3s; width: 100%;
        }
        .btn-neon:hover {
            transform: translateY(-2px); box-shadow: 0 10px 25px rgba(189, 52, 254, 0.5); color: #fff;
        }

        .btn-glass-cancel {
            background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1);
            color: var(--text-muted); border-radius: 12px; padding: 12px; font-weight: 600;
            text-align: center; text-decoration: none; transition: 0.3s; width: 100%; display: block;
        }
        .btn-glass-cancel:hover { background: rgba(255,255,255,0.1); color: #fff; border-color: #fff; }

        /* --- 3. TABLE STYLING --- */
        .master-table { width: 100%; border-collapse: separate; border-spacing: 0 8px; }
        
        .master-table thead th {
            font-size: 0.75rem; text-transform: uppercase; letter-spacing: 1.5px;
            color: var(--text-muted); padding: 0 20px 12px 20px; border: none;
        }

        .master-table tbody tr {
            background: rgba(255,255,255,0.03); transition: all 0.3s ease;
        }
        .master-table tbody tr:hover {
            transform: translateY(-3px); background: rgba(255,255,255,0.08);
            box-shadow: 0 10px 20px -5px rgba(0,0,0,0.5);
            position: relative; z-index: 10;
        }
        .master-table tbody tr:hover td { border-top: 1px solid rgba(189, 52, 254, 0.3); border-bottom: 1px solid rgba(189, 52, 254, 0.3); }
        .master-table tbody tr:hover td:first-child { border-left: 1px solid rgba(189, 52, 254, 0.3); }
        .master-table tbody tr:hover td:last-child { border-right: 1px solid rgba(189, 52, 254, 0.3); }

        .master-table td { padding: 16px 20px; vertical-align: middle; border: 1px solid transparent; color: var(--text-main); }
        .master-table td:first-child { border-top-left-radius: 12px; border-bottom-left-radius: 12px; }
        .master-table td:last-child { border-top-right-radius: 12px; border-bottom-right-radius: 12px; }

        /* Components */
        .hash-id {
            font-family: monospace; font-weight: 700; color: var(--neon-purple);
            background: rgba(189, 52, 254, 0.1); padding: 4px 8px; border-radius: 6px;
            border: 1px solid rgba(189, 52, 254, 0.2);
        }

        .btn-action {
            width: 34px; height: 34px; display: inline-flex; align-items: center; justify-content: center;
            border-radius: 8px; transition: 0.2s; border: 1px solid rgba(255,255,255,0.1);
            background: rgba(255,255,255,0.05); color: var(--text-muted); text-decoration: none;
        }
        .btn-edit:hover { background: rgba(59, 130, 246, 0.2); color: var(--neon-blue); border-color: var(--neon-blue); box-shadow: 0 0 10px rgba(59, 130, 246, 0.3); }
        .btn-delete:hover { background: rgba(255, 65, 108, 0.2); color: var(--neon-red); border-color: var(--neon-red); box-shadow: 0 0 10px rgba(255, 65, 108, 0.3); }

        /* Status Dot */
        .status-pill { display: inline-flex; align-items: center; gap: 8px; font-size: 0.8rem; font-weight: 600; }
        .dot { width: 6px; height: 6px; border-radius: 50%; box-shadow: 0 0 8px currentColor; }
        .status-active { color: var(--neon-green); }
        .status-hidden { color: var(--text-muted); }

        @keyframes slideUp { from {opacity: 0; transform: translateY(20px);} to {opacity: 1; transform: translateY(0);} }
        
        /* Alert */
        .alert-danger-dark {
            background: rgba(255, 65, 108, 0.1); border: 1px solid rgba(255, 65, 108, 0.3);
            color: #ff8fa3; border-radius: 12px; font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <jsp:include page="/common/header.jsp"/>

    <div class="container page-container">
        
        <div class="d-flex align-items-center justify-content-between mb-5">
            <div>
                <h2 class="fw-bold mb-1 text-white" style="font-family: 'Outfit'; text-transform: uppercase; letter-spacing: 1px;">
                    <i class="ri-node-tree me-2 text-info"></i>Danh Mục
                </h2>
                <p class="text-muted mb-0 small" style="letter-spacing: 0.5px;">Cấu trúc phân loại dữ liệu hệ thống</p>
            </div>
            <div class="d-flex align-items-center gap-2 px-3 py-2 rounded-pill border" style="background: rgba(0,0,0,0.3); border-color: rgba(255,255,255,0.1) !important;">
                <span class="fw-bold text-white">${categories.size()}</span>
                <span class="text-muted small text-uppercase fw-bold">Nodes</span>
            </div>
        </div>

        <div class="row g-4">
            
            <div class="col-md-4">
                <div class="glass-panel p-4">
                    <div class="panel-title">
                        <i class="ri-edit-circle-fill" style="color: var(--neon-purple);"></i>
                        ${not empty category ? 'Hiệu Chỉnh Node' : 'Khởi Tạo Node'}
                    </div>

                    <form action="${pageContext.request.contextPath}/admin/category/save" method="POST" novalidate>
                        
                        <c:if test="${not empty category}">
                            <input type="hidden" name="id" value="${category.id}">
                        </c:if>
                        
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger-dark mb-4 p-3 d-flex align-items-center">
                                <i class="ri-error-warning-fill me-2 fs-5"></i> ${error}
                            </div>
                        </c:if>

                        <div class="mb-4">
                            <label for="name" class="form-label small fw-bold text-muted text-uppercase ms-1 mb-2">Tên định danh</label>
                            <input type="text" 
                                   class="form-control input-dark ${not empty errors.name ? 'is-invalid' : ''}" 
                                   id="name" name="name" 
                                   value="${not empty bean ? bean.name : category.name}" 
                                   placeholder="Nhập tên danh mục...">
                            <div class="invalid-feedback fw-bold small ms-1">${errors.name}</div>
                        </div>
                        
                        <div class="d-flex flex-column gap-3 mt-5">
                            <button class="btn-neon" type="submit">
                                <i class="ri-save-3-line me-2"></i> ${not empty category ? 'Lưu Cấu Hình' : 'Thêm Mới'}
                            </button>
                            
                            <c:if test="${not empty category}">
                                <a href="${pageContext.request.contextPath}/admin/categories" class="btn-glass-cancel">
                                    Hủy thao tác
                                </a>
                            </c:if>
                        </div>
                    </form>
                    
                    <div style="position: absolute; bottom: -30px; right: -30px; opacity: 0.05; transform: rotate(-15deg);">
                        <i class="ri-price-tag-3-fill" style="font-size: 12rem; color: #fff;"></i>
                    </div>
                </div>
            </div>

            <div class="col-md-8">
                <div class="glass-panel p-0"> 
                    <div class="p-4 pb-2 border-bottom border-secondary border-opacity-10">
                        <div class="text-white small fw-bold text-uppercase text-muted">
                            <i class="ri-database-2-line me-1"></i> Dữ liệu hiện hành
                        </div>
                    </div>

                    <div class="table-responsive p-4 pt-2">
                        <table class="master-table">
                            <thead>
                                <tr>
                                    <th class="ps-4">Index</th>
                                    <th>Tên hiển thị</th>
                                    <th>Trạng thái</th>
                                    <th class="text-end pe-4">Điều khiển</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="c" items="${categories}" varStatus="loop">
                                    <tr>
                                        <td class="ps-4">
                                            <span class="hash-id" title="System ID: ${c.id}">
                                                #${loop.index + 1}
                                            </span>
                                        </td>
                                        <td>
                                            <span class="fw-bold text-white" style="font-size: 1rem;">${c.name}</span>
                                        </td>
                                        <td>
                                            <div class="status-pill ${c.status ? 'status-active' : 'status-hidden'}">
                                                <div class="dot"></div>
                                                ${c.status ? 'ONLINE' : 'HIDDEN'}
                                            </div>
                                        </td>
                                        <td class="text-end pe-4">
                                            <div class="d-flex justify-content-end gap-2">
                                                <a href="${pageContext.request.contextPath}/admin/category/edit?id=${c.id}" 
                                                   class="btn-action btn-edit" data-bs-toggle="tooltip" title="Chỉnh sửa">
                                                    <i class="ri-pencil-fill"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/admin/category/delete?id=${c.id}" 
                                                   class="btn-action btn-delete"
                                                   onclick="return confirm('Xóa Node: ${c.name}? Hành động này không thể hoàn tác.');"
                                                   data-bs-toggle="tooltip" title="Xóa dữ liệu">
                                                    <i class="ri-delete-bin-5-fill"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        
                        <c:if test="${empty categories}">
                            <div class="text-center py-5 opacity-50">
                                <i class="ri-folder-unknow-line display-4 text-muted"></i>
                                <p class="mt-3 fw-bold small text-muted">Hệ thống trống</p>
                            </div>
                        </c:if>
                    </div>
                </div>
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