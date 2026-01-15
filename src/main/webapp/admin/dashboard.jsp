<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<title>Command Center - PolyOE Universe</title>
<jsp:include page="/common/head.jsp" />

<link
	href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;600;800&family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css"
	rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
:root {
	--neon-cyan: #00d2ff;
	--neon-purple: #bd34fe;
	--neon-pink: #ff416c;
	--neon-green: #00ff9d;
	--bg-dark: #0f0c29;
	--card-glass: rgba(255, 255, 255, 0.03);
	--border-glass: 1px solid rgba(255, 255, 255, 0.08);
	--text-main: #e0e0e0;
	--text-muted: rgba(255, 255, 255, 0.5);
}

body {
	font-family: 'Plus Jakarta Sans', sans-serif;
	background: linear-gradient(135deg, #0f0c29 0%, #302b63 50%, #24243e 100%)
		fixed;
	color: var(--text-main);
	min-height: 100vh;
	overflow-x: hidden;
}

/* --- 1. BACKGROUND GLOW (Ambient Light) --- */
.ambient-glow {
	position: fixed;
	top: -20%;
	left: -10%;
	width: 50%;
	height: 50%;
	background: radial-gradient(circle, rgba(0, 210, 255, 0.15) 0%,
		transparent 70%);
	filter: blur(80px);
	z-index: -1;
	animation: pulseGlow 10s infinite alternate;
}

.ambient-glow-2 {
	position: fixed;
	bottom: -20%;
	right: -10%;
	width: 50%;
	height: 50%;
	background: radial-gradient(circle, rgba(189, 52, 254, 0.15) 0%,
		transparent 70%);
	filter: blur(80px);
	z-index: -1;
	animation: pulseGlow 10s infinite alternate-reverse;
}

@keyframes pulseGlow { 0% {
	opacity: 0.5;
	transform: scale(1);
}

100


%
{
opacity


:


0
.8
;


transform


:


scale
(


1
.1


)
;


}
}

/* --- 2. HOLOGRAPHIC CARDS --- */
.holo-card {
	background: var(--card-glass);
	backdrop-filter: blur(20px);
	-webkit-backdrop-filter: blur(20px);
	border: var(--border-glass);
	border-radius: 24px;
	padding: 30px;
	height: 100%;
	position: relative;
	overflow: hidden;
	box-shadow: 0 20px 50px -10px rgba(0, 0, 0, 0.5);
	transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
}

/* Hover Effect: Cyber Scan */
.holo-card::after {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: linear-gradient(135deg, rgba(255, 255, 255, 0.1) 0%,
		transparent 100%);
	opacity: 0;
	transition: 0.4s;
	pointer-events: none;
}

.holo-card:hover {
	transform: translateY(-5px);
	background: rgba(255, 255, 255, 0.07);
	border-color: rgba(255, 255, 255, 0.2);
	box-shadow: 0 0 30px rgba(0, 0, 0, 0.6);
}

.holo-card:hover::after {
	opacity: 1;
}

/* Specific Glows */
.glow-cyan:hover {
	box-shadow: 0 10px 40px -10px rgba(0, 210, 255, 0.2);
	border-color: rgba(0, 210, 255, 0.3);
}

.glow-purple:hover {
	box-shadow: 0 10px 40px -10px rgba(189, 52, 254, 0.2);
	border-color: rgba(189, 52, 254, 0.3);
}

.glow-pink:hover {
	box-shadow: 0 10px 40px -10px rgba(255, 65, 108, 0.2);
	border-color: rgba(255, 65, 108, 0.3);
}

/* --- 3. STATS & ICONS --- */
.stat-label {
	font-size: 0.8rem;
	font-weight: 700;
	text-transform: uppercase;
	letter-spacing: 2px;
	color: var(--text-muted);
	margin-bottom: 5px;
}

.stat-value {
	font-family: 'Outfit', sans-serif;
	font-size: 3.5rem;
	font-weight: 800;
	line-height: 1;
	color: #fff;
	text-shadow: 0 0 20px rgba(255, 255, 255, 0.2);
}

.icon-box {
	width: 70px;
	height: 70px;
	border-radius: 20px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 2rem;
	background: rgba(0, 0, 0, 0.2);
	border: 1px solid rgba(255, 255, 255, 0.1);
	transition: 0.4s;
}

/* Icon Colors */
.icon-cyan {
	color: var(--neon-cyan);
	box-shadow: inset 0 0 20px rgba(0, 210, 255, 0.1);
}

.icon-purple {
	color: var(--neon-purple);
	box-shadow: inset 0 0 20px rgba(189, 52, 254, 0.1);
}

.icon-pink {
	color: var(--neon-pink);
	box-shadow: inset 0 0 20px rgba(255, 65, 108, 0.1);
}

.holo-card:hover .icon-box {
	transform: scale(1.1) rotate(10deg);
	background: rgba(0, 0, 0, 0.4);
}

/* --- 4. BUTTONS --- */
.btn-cyber {
	background: rgba(255, 255, 255, 0.05);
	border: 1px solid rgba(255, 255, 255, 0.1);
	color: #fff;
	padding: 10px 24px;
	border-radius: 50px;
	font-weight: 600;
	transition: 0.3s;
}

.btn-cyber:hover {
	background: var(--neon-cyan);
	border-color: var(--neon-cyan);
	color: #000;
	box-shadow: 0 0 20px var(--neon-cyan);
}

/* --- 5. ANIMATIONS --- */
.reveal-up {
	animation: revealUp 0.8s ease-out forwards;
	opacity: 0;
	transform: translateY(30px);
}

@keyframes revealUp {to { opacity:1;
	transform: translateY(0);
}

}
.d-100 {
	animation-delay: 0.1s;
}

.d-200 {
	animation-delay: 0.2s;
}

.d-300 {
	animation-delay: 0.3s;
}

.chart-box {
	position: relative;
	height: 350px;
	width: 100%;
}

/* Custom Tooltip Chart */
#chartjs-tooltip {
	opacity: 1;
	position: absolute;
	background: rgba(0, 0, 0, 0.8);
	border: 1px solid rgba(255, 255, 255, 0.2);
	color: white;
	border-radius: 8px;
	pointer-events: none;
	transform: translate(-50%, 0);
	transition: all .1s ease;
	backdrop-filter: blur(5px);
}
</style>
</head>
<body>
	<div class="ambient-glow"></div>
	<div class="ambient-glow-2"></div>

	<jsp:include page="/common/header.jsp" />

	<div class="container mt-5 mb-5">



		[Image of Admin Dashboard Wireframe]

		<div
			class="d-flex justify-content-between align-items-end mb-5 reveal-up">
			<div>
				<div class="d-flex align-items-center gap-2 mb-2">
					<span
						class="badge bg-transparent border border-secondary text-light rounded-pill px-3 py-1 text-uppercase"
						style="font-size: 0.7rem; letter-spacing: 1px;"> <i
						class="ri-radar-fill me-1 text-success"></i> System Online
					</span>
				</div>
				<h2 class="display-5 fw-bold text-white mb-0"
					style="font-family: 'Outfit', sans-serif; text-transform: uppercase; letter-spacing: 1px;">
					Command Center</h2>
			</div>
			<a href="${pageContext.request.contextPath}/admin/export"
				class="btn btn-cyber d-flex align-items-center gap-2 text-decoration-none">
				<i class="ri-download-cloud-2-line"></i> Xuất Báo Cáo
			</a>
		</div>

		<div class="row g-4 mb-5">
			<div class="col-xl-4 col-md-6 reveal-up d-100">
				<div class="holo-card glow-cyan">
					<div class="d-flex justify-content-between align-items-start h-100">
						<div class="d-flex flex-column justify-content-between h-100">
							<div>
								<div class="stat-label">Tổng Users</div>
								<div class="stat-value">${totalUsers}</div>
							</div>
							<div class="d-flex align-items-center gap-2 mt-4">
								<span
									class="text-success fw-bold d-flex align-items-center gap-1"
									style="text-shadow: 0 0 10px rgba(0, 255, 157, 0.5);"> <i
									class="ri-pulse-line"></i> Live
								</span> <span class="text-muted small">Hệ thống đang hoạt động</span>
							</div>
						</div>
						<div class="icon-box icon-cyan">
							<i class="ri-user-star-line"></i>
						</div>
					</div>
				</div>
			</div>

			<div class="col-xl-4 col-md-6 reveal-up d-200">
				<div class="holo-card glow-purple">
					<div class="d-flex justify-content-between align-items-start h-100">
						<div class="d-flex flex-column justify-content-between h-100">
							<div>
								<div class="stat-label">Videos</div>
								<div class="stat-value">${totalVideos}</div>
							</div>
							<div class="d-flex align-items-center gap-2 mt-4">
								<span class="text-info fw-bold d-flex align-items-center gap-1">
									<i class="ri-database-2-fill"></i> Ổn định
								</span> <span class="text-muted small">trên máy chủ</span>
							</div>
						</div>
						<div class="icon-box icon-purple">
							<i class="ri-movie-2-line"></i>
						</div>
					</div>
				</div>
			</div>

			<div class="col-xl-4 col-md-6 reveal-up d-300">
				<div class="holo-card glow-pink">
					<div class="d-flex justify-content-between align-items-start h-100">
						<div class="d-flex flex-column justify-content-between h-100">
							<div>
								<div class="stat-label">Tương Tác</div>
								<div class="stat-value">${totalComments}</div>
							</div>
							<div class="d-flex align-items-center gap-2 mt-4">
								<span
									class="text-danger fw-bold d-flex align-items-center gap-1"
									style="color: #ff416c !important;"> <i
									class="ri-fire-fill"></i> Sôi nổi
								</span> <span class="text-muted small">thời gian thực</span>
							</div>
						</div>
						<div class="icon-box icon-pink">
							<i class="ri-message-3-line"></i>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="row g-4">
			<div class="col-lg-8 reveal-up d-300">
				<div class="holo-card">
					<div class="d-flex justify-content-between align-items-center mb-4">
						<div>
							<h5 class="fw-bold text-white mb-1">
								<i class="ri-bar-chart-grouped-line me-2 text-primary"></i>Phân
								tích Lưu lượng
							</h5>
						</div>
					</div>
					<div class="chart-box">
						<canvas id="viewsChart"></canvas>
					</div>
				</div>
			</div>

			<div class="col-lg-4 reveal-up d-300">
				<div class="holo-card d-flex flex-column">
					<h5 class="fw-bold text-white mb-4">
						<i class="ri-pie-chart-2-line me-2 text-warning"></i>Trạng thái
						User
					</h5>
					<div
						class="flex-grow-1 position-relative d-flex justify-content-center align-items-center">
						<div style="width: 260px; height: 260px;">
							<canvas id="statusChart"></canvas>
						</div>
						<div class="position-absolute text-center"
							style="pointer-events: none;">
							<div class="display-6 fw-bold mb-0 text-white"
								style="font-family: 'Outfit';">${totalUsers}</div>
							<small class="text-uppercase fw-bold text-muted"
								style="font-size: 0.7rem; letter-spacing: 2px;">ACCOUNTS</small>
						</div>
					</div>
					<div class="mt-3 text-center">
						<span
							class="d-inline-flex align-items-center gap-2 px-3 py-1 rounded-pill"
							style="background: rgba(255, 255, 255, 0.05); border: 1px solid rgba(255, 255, 255, 0.1);">
							<span
							style="width: 8px; height: 8px; background: #00ff9d; border-radius: 50%; box-shadow: 0 0 10px #00ff9d;"></span>
							<span class="small fw-bold text-light">Hệ thống đang hoạt
								động</span>
						</span>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="/common/footer.jsp" />

	<script>
        // --- DARK COMMAND CENTER CHART CONFIG ---
        Chart.defaults.font.family = "'Plus Jakarta Sans', sans-serif";
        Chart.defaults.color = 'rgba(255, 255, 255, 0.5)';
        Chart.defaults.scale.grid.color = 'rgba(255, 255, 255, 0.05)';

        // 1. Line Chart (Neon Flow)
        const ctxViews = document.getElementById('viewsChart').getContext('2d');
        
        // Gradient Fill (Cyan to Transparent)
        let gradientFill = ctxViews.createLinearGradient(0, 0, 0, 400);
        gradientFill.addColorStop(0, 'rgba(0, 210, 255, 0.2)'); 
        gradientFill.addColorStop(1, 'rgba(0, 210, 255, 0.0)');

        // Gradient Stroke (Cyan to Purple)
        let gradientStroke = ctxViews.createLinearGradient(0, 0, 600, 0);
        gradientStroke.addColorStop(0, '#00d2ff');
        gradientStroke.addColorStop(1, '#bd34fe');

        new Chart(ctxViews, {
            type: 'line',
            data: {
				labels: [${chartLabels}],
            	datasets: [{
                    label: 'Video mới đăng',
					data: [${chartData}],
                    borderColor: gradientStroke,
                    backgroundColor: gradientFill,
                    borderWidth: 3,
                    pointBackgroundColor: '#0f0c29',
                    pointBorderColor: '#00d2ff',
                    pointBorderWidth: 2,
                    pointRadius: 6,
                    pointHoverRadius: 10,
                    pointHoverBackgroundColor: '#fff',
                    pointHoverBorderColor: '#00d2ff',
                    fill: true,
                    tension: 0.4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false },
                    tooltip: {
                        backgroundColor: 'rgba(0,0,0,0.8)',
                        titleColor: '#fff',
                        bodyColor: '#ccc',
                        padding: 12,
                        borderColor: 'rgba(255,255,255,0.1)',
                        borderWidth: 1,
                        displayColors: false,
                    }
                },
                scales: {
                    y: { beginAtZero: true, border: { display: false } },
                    x: { grid: { display: false }, border: { display: false } }
                }
            }
        });

     // 2. Doughnut Chart (User Status - Đã sửa lấy dữ liệu thật)
        const ctxStatus = document.getElementById('statusChart').getContext('2d');
        new Chart(ctxStatus, {
            type: 'doughnut',
            data: {
                labels: ['Active (Hoạt động)', 'Inactive (Bị khóa)'], // Chỉ cần 2 nhãn
                datasets: [{
                    // SỬA Ở ĐÂY: Dùng biến activeUsers và inactiveUsers từ Controller
                    data: [${activeUsers}, ${inactiveUsers}], 
                    
                    backgroundColor: ['#00ff9d', '#ff416c'], // Xanh lá và Đỏ
                    borderWidth: 0,
                    hoverOffset: 10,
                    borderRadius: 20
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                cutout: '85%',
                plugins: { 
                    legend: { 
                        display: true, 
                        position: 'bottom',
                        labels: { color: '#ccc' }
                    } 
                }
            }
        });   
        </script>
</body>
</html>