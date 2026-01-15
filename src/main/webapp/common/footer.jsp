<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<footer class="cinematic-footer pt-5 pb-4 mt-5">
    <div class="container text-center text-md-start">
        <div class="row text-center text-md-start">
            
            <div class="col-md-3 col-lg-3 col-xl-3 mx-auto mt-3">
                <h5 class="text-uppercase mb-4 font-weight-bold footer-brand">
                    <i class="bi bi-play-circle-fill me-2"></i>PolyOE
                </h5>
                <p class="small footer-desc text-white-high-contrast">
                    Nền tảng chia sẻ video trực tuyến thế hệ mới. Nơi kết nối đam mê, chia sẻ khoảnh khắc và sáng tạo không giới hạn.
                </p>
            </div>

            <div class="col-md-2 col-lg-2 col-xl-2 mx-auto mt-3">
                <h6 class="text-uppercase mb-4 fw-bold footer-heading text-white">Khám phá</h6>
                <ul class="list-unstyled">
                    <li><a href="${pageContext.request.contextPath}/home" class="footer-link">Trang chủ</a></li>
                    <li><a href="#" class="footer-link">Thịnh hành</a></li>
                    <li><a href="#" class="footer-link">Mới nhất</a></li>
                    <li><a href="#" class="footer-link">Creators</a></li>
                </ul>
            </div>

            <div class="col-md-3 col-lg-2 col-xl-2 mx-auto mt-3">
                <h6 class="text-uppercase mb-4 fw-bold footer-heading text-white">Hỗ trợ</h6>
                <ul class="list-unstyled">
                    <li><a href="#" class="footer-link">Tài khoản</a></li>
                    <li><a href="#" class="footer-link">Chính sách bảo mật</a></li>
                    <li><a href="#" class="footer-link">Điều khoản</a></li>
                    <li><a href="#" class="footer-link">Trợ giúp</a></li>
                </ul>
            </div>

            <div class="col-md-4 col-lg-3 col-xl-3 mx-auto mt-3">
                <h6 class="text-uppercase mb-4 fw-bold footer-heading text-white">Liên hệ</h6>
                <p class="small mb-2 text-white-high-contrast"><i class="bi bi-geo-alt-fill me-2 text-cyan"></i> FPT Polytechnic, Cần Thơ</p>
                <p class="small mb-2 text-white-high-contrast"><i class="bi bi-envelope-fill me-2 text-cyan"></i> contact@polyoe.edu.vn</p>
                <p class="small mb-2 text-white-high-contrast"><i class="bi bi-telephone-fill me-2 text-cyan"></i> +84 123 456 789</p>
                
                <div class="mt-4 social-group">
                    <a href="#" class="social-btn"><i class="bi bi-facebook"></i></a>
                    <a href="#" class="social-btn"><i class="bi bi-twitter"></i></a>
                    <a href="#" class="social-btn"><i class="bi bi-youtube"></i></a>
                    <a href="#" class="social-btn"><i class="bi bi-instagram"></i></a>
                </div>
            </div>
        </div>

        <hr class="mb-4 footer-divider">

        <div class="row align-items-center">
            <div class="col-md-7 col-lg-8">
                <p class="small mb-0 text-white-high-contrast">
                    &copy; 2025 Bản quyền thuộc về 
                    <a href="#" class="brand-highlight"><strong>PolyOE Entertainment</strong></a>.
                </p>
            </div>
            <div class="col-md-5 col-lg-4">
                <p class="text-md-end small mb-0 text-white-high-contrast opacity-75">
                    High Contrast UI Design
                </p>
            </div>
        </div>
    </div>
</footer>

<style>
    /* Global Footer Variables - High Contrast */
    :root {
        --footer-bg: #050505; /* Đen gần như tuyệt đối */
        --neon-cyan: #00d2ff;
        --neon-pink: #ff416c;
        --text-bright: #e0e0e0; /* Xám rất sáng thay vì xám tối */
    }

    /* 1. Container Style - Nền đen đặc */
    .cinematic-footer {
        background-color: var(--footer-bg);
        border-top: 2px solid #333; /* Viền trên rõ ràng hơn */
        position: relative;
    }
    
    /* 2. Typography */
    .footer-brand {
        /* Giữ màu thương hiệu nhưng sáng rực rỡ */
        color: var(--neon-pink);
        text-shadow: 0 0 10px rgba(255, 65, 108, 0.6);
        letter-spacing: 1px;
        font-size: 1.5rem;
    }

    .footer-heading {
        letter-spacing: 1px;
        font-family: 'Outfit', sans-serif;
        border-bottom: 2px solid var(--neon-cyan); /* Gạch chân tiêu đề cột */
        display: inline-block;
        padding-bottom: 5px;
    }

    .text-white-high-contrast {
        color: #dcdcdc !important; /* Màu chữ nội dung sáng rõ */
        font-size: 0.95rem;
    }

    /* 3. Links Hover Effect */
    .footer-link {
        color: #bbbbbb; /* Link màu xám sáng */
        text-decoration: none;
        display: block;
        margin-bottom: 10px;
        transition: all 0.2s ease;
        font-size: 1rem; /* Chữ to hơn chút */
        font-weight: 500;
    }

    .footer-link:hover {
        color: #ffffff; /* Hover thành trắng tinh */
        padding-left: 8px; /* Dịch chuyển rõ rệt */
        text-shadow: 0 0 10px rgba(255, 255, 255, 0.5);
    }

    /* 4. Contact Icons */
    .text-cyan { 
        color: var(--neon-cyan) !important; 
        font-size: 1.1rem;
        filter: drop-shadow(0 0 5px rgba(0, 210, 255, 0.5));
    }

    /* 5. Social Buttons (Solid High Contrast) */
    .social-group { display: flex; gap: 12px; justify-content: center; }
    @media (min-width: 768px) { .social-group { justify-content: flex-start; } }

    .social-btn {
        width: 40px; height: 40px;
        border-radius: 50%;
        background: #222; /* Nền nút xám đậm */
        border: 1px solid #555; /* Viền nút rõ */
        display: flex; align-items: center; justify-content: center;
        color: #fff; text-decoration: none;
        transition: 0.3s;
        font-size: 1.1rem;
    }

    .social-btn:hover {
        background: var(--neon-cyan);
        color: #000;
        border-color: var(--neon-cyan);
        box-shadow: 0 0 15px var(--neon-cyan);
        transform: translateY(-3px);
    }

    /* 6. Bottom Divider & Copyright */
    .footer-divider {
        border-color: #444; /* Đường kẻ phân cách rõ hơn */
        opacity: 1;
    }

    .brand-highlight {
        color: var(--neon-cyan);
        text-decoration: none;
        font-weight: bold;
    }
    .brand-highlight:hover {
        color: #fff;
        text-decoration: underline;
    }
</style>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>