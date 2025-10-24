<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>ResQnet – Disaster Management Platform</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/core.css"/>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap"
      rel="stylesheet"
    />
    <link rel="icon" type="image/svg+xml" src="${pageContext.request.contextPath}/static/assets/img/logo.svg" />
    <script src="https://unpkg.com/lucide@latest" defer></script>
    <style>
      /* Landing page specific styles leveraging core tokens */
      :root {
        --hero-max-width: 1280px;
        --section-spacing: clamp(4rem, 8vw, 7rem);
      }

      /* Hero Section */
      .hero {
        position: relative;
        min-height: 92vh;
        display: flex;
        align-items: center;
        background: linear-gradient(135deg, #fff 0%, #fafafa 100%);
        border-bottom: 1px solid var(--color-border);
      }
      .hero::before {
        content: "";
        position: absolute;
        top: 0;
        right: 0;
        width: 60%;
        height: 100%;
        background: radial-gradient(
          ellipse at top right,
          rgba(255, 204, 0, 0.08) 0%,
          transparent 60%
        );
        pointer-events: none;
      }
      .hero__container {
        max-width: var(--hero-max-width);
        margin: 0 auto;
        padding: 0 var(--space-6);
        width: 100%;
        position: relative;
        z-index: 1;
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: clamp(2rem, 5vw, 4rem);
        align-items: center;
      }
      .hero__content {
        max-width: 640px;
      }
      .hero__image {
        position: relative;
        width: 100%;
        height: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
      }
      .hero__image-wrapper {
        position: relative;
        width: 100%;
        max-width: 560px;
        aspect-ratio: 4/3;
        border-radius: var(--radius-lg);
        overflow: hidden;
        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.12);
        border: 1px solid var(--color-border);
      }
      .hero__image-wrapper img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        display: block;
      }
      .hero__image-accent {
        position: absolute;
        top: -20px;
        right: -20px;
        width: 120px;
        height: 120px;
        background: var(--color-accent);
        border-radius: 50%;
        opacity: 0.15;
        z-index: -1;
      }
      .hero__badge {
        display: inline-flex;
        align-items: center;
        gap: var(--space-2);
        background: var(--color-surface-alt);
        border: 1px solid var(--color-border);
        padding: 8px 16px;
        border-radius: var(--radius-pill);
        font-size: var(--font-size-xs);
        font-weight: 600;
        margin-bottom: var(--space-5);
        color: var(--color-text-subtle);
      }
      .hero__badge .icon {
        width: 16px;
        height: 16px;
        color: var(--color-accent);
      }
      .hero__title {
        font-size: clamp(2.5rem, 5vw, 4rem);
        font-weight: 700;
        line-height: 1.1;
        margin: 0 0 var(--space-5);
        color: var(--color-text);
        letter-spacing: -0.02em;
      }
      .hero__subtitle {
        font-size: clamp(1.05rem, 1.8vw, 1.25rem);
        line-height: 1.6;
        color: var(--color-text-subtle);
        margin: 0 0 var(--space-8);
        max-width: 560px;
      }
      .hero__actions {
        display: flex;
        gap: var(--space-4);
        flex-wrap: wrap;
      }
      .hero__actions .btn {
        padding: 16px 32px;
        font-size: var(--font-size-base);
      }
      .btn-large {
        padding: 16px 32px;
        font-size: var(--font-size-base);
      }

      /* Stats Section */
      .stats {
        padding: var(--section-spacing) 0;
        background: var(--color-surface-alt);
        border-bottom: 1px solid var(--color-border);
      }
      .stats__container {
        max-width: var(--hero-max-width);
        margin: 0 auto;
        padding: 0 var(--space-6);
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: var(--space-8);
      }
      .stat {
        text-align: center;
      }
      .stat__value {
        font-size: clamp(2rem, 3.5vw, 3rem);
        font-weight: 700;
        color: var(--color-text);
        margin: 0 0 var(--space-2);
        line-height: 1;
      }
      .stat__label {
        font-size: var(--font-size-sm);
        color: var(--color-text-subtle);
        font-weight: 500;
      }

      /* Features Section */
      .features {
        padding: var(--section-spacing) 0;
      }
      .features__container {
        max-width: var(--hero-max-width);
        margin: 0 auto;
        padding: 0 var(--space-6);
      }
      .section-header {
        text-align: center;
        max-width: 720px;
        margin: 0 auto var(--space-8);
      }
      .section-title {
        font-size: clamp(1.75rem, 3.2vw, 2.5rem);
        font-weight: 700;
        line-height: 1.2;
        margin: 0 0 var(--space-4);
        color: var(--color-text);
      }
      .section-subtitle {
        font-size: var(--font-size-lg);
        color: var(--color-text-subtle);
        line-height: 1.6;
        margin: 0;
      }
      .features__grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        gap: var(--space-6);
      }
      .feature-card {
        background: var(--color-surface);
        border: 1px solid var(--color-border);
        border-radius: var(--radius-lg);
        padding: var(--space-6);
        transition: transform var(--transition), box-shadow var(--transition);
      }
      .feature-card:hover {
        transform: translateY(-4px);
        box-shadow: var(--shadow-md);
      }
      .feature-card__icon {
        width: 48px;
        height: 48px;
        background: var(--color-accent);
        border-radius: var(--radius-md);
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: var(--space-4);
      }
      .feature-card__icon svg {
        width: 24px;
        height: 24px;
        color: #151515;
      }
      .feature-card__title {
        font-size: var(--font-size-lg);
        font-weight: 600;
        margin: 0 0 var(--space-3);
        color: var(--color-text);
      }
      .feature-card__desc {
        font-size: var(--font-size-sm);
        color: var(--color-text-subtle);
        line-height: 1.6;
        margin: 0;
      }

      /* CTA Section */
      .cta {
        padding: var(--section-spacing) 0;
        background: #111;
        color: #fff;
      }
      .cta__container {
        max-width: var(--hero-max-width);
        margin: 0 auto;
        padding: 0 var(--space-6);
        text-align: center;
      }
      .cta__title {
        font-size: clamp(1.75rem, 3.2vw, 2.5rem);
        font-weight: 700;
        line-height: 1.2;
        margin: 0 0 var(--space-4);
      }
      .cta__subtitle {
        font-size: var(--font-size-lg);
        color: #d1d1d1;
        margin: 0 0 var(--space-6);
        max-width: 600px;
        margin-left: auto;
        margin-right: auto;
      }
      .cta__actions {
        display: flex;
        gap: var(--space-4);
        justify-content: center;
        flex-wrap: wrap;
      }

      /* Footer */
      .footer {
        background: var(--color-surface-alt);
        border-top: 1px solid var(--color-border);
        padding: var(--space-8) 0 var(--space-6);
      }
      .footer__container {
        max-width: var(--hero-max-width);
        margin: 0 auto;
        padding: 0 var(--space-6);
      }
      .footer__grid {
        display: grid;
        grid-template-columns: 2fr 1fr 1fr 1fr;
        gap: var(--space-8);
        margin-bottom: var(--space-8);
      }
      .footer__brand {
        display: flex;
        align-items: center;
        gap: 0.65rem;
        margin-bottom: var(--space-3);
      }
      .footer__brand img {
        height: 32px;
        width: auto;
      }
      .footer__desc {
        font-size: var(--font-size-sm);
        color: var(--color-text-subtle);
        line-height: 1.6;
        margin: 0;
      }
      .footer__title {
        font-size: var(--font-size-sm);
        font-weight: 600;
        margin: 0 0 var(--space-4);
        text-transform: uppercase;
        letter-spacing: 0.05em;
        color: var(--color-text);
      }
      .footer__links {
        list-style: none;
        margin: 0;
        padding: 0;
      }
      .footer__links li {
        margin-bottom: var(--space-2);
      }
      .footer__links a {
        font-size: var(--font-size-sm);
        color: var(--color-text-subtle);
        text-decoration: none;
        transition: color var(--transition-fast);
      }
      .footer__links a:hover {
        color: var(--color-text);
      }
      .footer__bottom {
        border-top: 1px solid var(--color-border);
        padding-top: var(--space-5);
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: var(--space-4);
      }
      .footer__copyright {
        font-size: var(--font-size-xs);
        color: var(--color-text-subtle);
      }
      .footer__social {
        display: flex;
        gap: var(--space-3);
      }
      .social-link {
        width: 36px;
        height: 36px;
        display: flex;
        align-items: center;
        justify-content: center;
        border: 1px solid var(--color-border);
        border-radius: var(--radius-sm);
        color: var(--color-text-subtle);
        transition: all var(--transition-fast);
      }
      .social-link:hover {
        background: var(--color-surface);
        border-color: var(--color-border-strong);
        color: var(--color-text);
      }
      .social-link svg {
        width: 18px;
        height: 18px;
      }

      /* Responsive */
      @media (max-width: 968px) {
        .hero__container {
          grid-template-columns: 1fr;
          gap: var(--space-8);
        }
        .hero__image {
          order: -1;
        }
        .hero__image-wrapper {
          max-width: 100%;
        }
      }
      @media (max-width: 768px) {
        .hero {
          min-height: 80vh;
        }
        .hero__actions {
          flex-direction: column;
        }
        .hero__actions .btn {
          width: 100%;
        }
        .stats__container {
          grid-template-columns: repeat(2, 1fr);
          gap: var(--space-6);
        }
        .features__grid {
          grid-template-columns: 1fr;
        }
        .footer__grid {
          grid-template-columns: 1fr;
          gap: var(--space-6);
        }
        .footer__bottom {
          flex-direction: column;
          text-align: center;
        }
      }
    </style>
  </head>
  <body>
    <!-- Navigation Header -->
    <header class="site-header" role="banner">
      <div class="site-header__inner">
        <a href="landing.html" class="brand-inline" aria-label="ResQnet home">
          <img src="${pageContext.request.contextPath}/static/assets/img/logo.svg" alt="ResQnet logo" />
          <span class="sr-only">ResQnet</span>
        </a>
        <nav class="primary-nav" aria-label="Primary navigation">
          <ul>
            <li><a href="#features">Features</a></li>
            <li><a href="#about">About</a></li>
            <li><a href="#contact">Contact</a></li>
          </ul>
        </nav>
        <div class="header-actions">
          <a href="${pageContext.request.contextPath}/login" class="btn">Login</a>
          <a href="${pageContext.request.contextPath}/signup" class="btn btn-primary">Get Started</a>
        </div>
      </div>
    </header>

    <!-- Hero Section -->
    <section class="hero">
      <div class="hero__container">
        <div class="hero__content">
          <div class="hero__badge">
            <span class="icon" data-lucide="shield-check"></span>
            <span>Trusted Disaster Management Platform</span>
          </div>
          <h1 class="hero__title">
            Saving Lives Through<br />Smart Disaster Response
          </h1>
          <p class="hero__subtitle">
            ResQnet connects volunteers, NGOs, and communities in real-time to
            coordinate disaster relief, manage resources, and provide emergency
            assistance when it matters most.
          </p>
          <div class="hero__actions">
            <a href="roles.html" class="btn btn-primary btn-large">
              Join as Volunteer
              <span
                data-lucide="arrow-right"
                style="width: 18px; height: 18px"
              ></span>
            </a>
            <a href="index.html" class="btn btn-large">View Dashboard</a>
          </div>
        </div>
        <div class="hero__image">
          <div class="hero__image-wrapper">
            <img
              src="https://images.unsplash.com/photo-1593113598332-cd288d649433?w=800&q=80"
              alt="Emergency response team coordinating disaster relief"
              loading="eager"
            />
          </div>
          <div class="hero__image-accent"></div>
        </div>
      </div>
    </section>

    <!-- Stats Section -->
    <section class="stats">
      <div class="stats__container">
        <div class="stat">
          <div class="stat__value">24/7</div>
          <div class="stat__label">Emergency Hotline</div>
        </div>
        <div class="stat">
          <div class="stat__value">5,000+</div>
          <div class="stat__label">Active Volunteers</div>
        </div>
        <div class="stat">
          <div class="stat__value">150+</div>
          <div class="stat__label">Partner NGOs</div>
        </div>
        <div class="stat">
          <div class="stat__value">50K+</div>
          <div class="stat__label">Lives Impacted</div>
        </div>
      </div>
    </section>

    <!-- Features Section -->
    <section class="features" id="features">
      <div class="features__container">
        <div class="section-header">
          <h2 class="section-title">Complete Disaster Management Solution</h2>
          <p class="section-subtitle">
            Everything you need to respond effectively during emergencies and
            coordinate relief efforts across communities.
          </p>
        </div>
        <div class="features__grid">
          <div class="feature-card">
            <div class="feature-card__icon">
              <span data-lucide="line-chart"></span>
            </div>
            <h3 class="feature-card__title">Real-Time Forecasting</h3>
            <p class="feature-card__desc">
              Access live weather data, disaster predictions, and risk
              assessments to prepare communities before disasters strike.
            </p>
          </div>
          <div class="feature-card">
            <div class="feature-card__icon">
              <span data-lucide="users"></span>
            </div>
            <h3 class="feature-card__title">Volunteer Coordination</h3>
            <p class="feature-card__desc">
              Mobilize and manage volunteers efficiently with skill-based
              matching, scheduling, and real-time communication tools.
            </p>
          </div>
          <div class="feature-card">
            <div class="feature-card__icon">
              <span data-lucide="package"></span>
            </div>
            <h3 class="feature-card__title">Resource Management</h3>
            <p class="feature-card__desc">
              Track donations, manage inventory, and coordinate distribution of
              essential supplies to affected areas.
            </p>
          </div>
          <div class="feature-card">
            <div class="feature-card__icon">
              <span data-lucide="map-pin"></span>
            </div>
            <h3 class="feature-card__title">Safe Location Mapping</h3>
            <p class="feature-card__desc">
              Identify and share safe zones, evacuation routes, and emergency
              shelters with GPS-enabled mapping technology.
            </p>
          </div>
          <div class="feature-card">
            <div class="feature-card__icon">
              <span data-lucide="alert-triangle"></span>
            </div>
            <h3 class="feature-card__title">Incident Reporting</h3>
            <p class="feature-card__desc">
              Enable citizens to report disasters instantly with location data,
              photos, and severity levels for rapid response.
            </p>
          </div>
          <div class="feature-card">
            <div class="feature-card__icon">
              <span data-lucide="message-circle"></span>
            </div>
            <h3 class="feature-card__title">Community Forum</h3>
            <p class="feature-card__desc">
              Foster collaboration with discussion boards, resource sharing, and
              knowledge exchange among responders.
            </p>
          </div>
        </div>
      </div>
    </section>

    <!-- CTA Section -->
    <section class="cta" id="about">
      <div class="cta__container">
        <h2 class="cta__title">Ready to Make a Difference?</h2>
        <p class="cta__subtitle">
          Join thousands of volunteers and organizations working together to
          build resilient communities and save lives.
        </p>
        <div class="cta__actions">
          <a href="roles.html" class="btn btn-primary btn-large">
            Choose Your Role
          </a>
          <a
            href="#contact"
            class="btn btn-large"
            style="
              --btn-bg: transparent;
              --btn-color: #fff;
              --btn-border: rgba(255, 255, 255, 0.3);
            "
          >
            Contact Us
          </a>
        </div>
      </div>
    </section>

    <!-- Footer -->
    <footer class="footer" id="contact">
      <div class="footer__container">
        <div class="footer__grid">
          <div>
            <div class="footer__brand">
              <img src="./assets/img/logo.svg" alt="ResQnet" />
            </div>
            <p class="footer__desc">
              ResQnet is a comprehensive disaster management platform connecting
              communities, volunteers, and organizations to respond effectively
              during emergencies.
            </p>
          </div>
          <div>
            <h4 class="footer__title">Platform</h4>
            <ul class="footer__links">
              <li><a href="index.html">Dashboard</a></li>
              <li><a href="roles.html">Become a Volunteer</a></li>
              <li><a href="roles.html">Join as NGO</a></li>
              <li><a href="#features">Features</a></li>
            </ul>
          </div>
          <div>
            <h4 class="footer__title">Resources</h4>
            <ul class="footer__links">
              <li><a href="#">Documentation</a></li>
              <li><a href="#">Help Center</a></li>
              <li><a href="#">Community Forum</a></li>
              <li><a href="#">Safety Guidelines</a></li>
            </ul>
          </div>
          <div>
            <h4 class="footer__title">Company</h4>
            <ul class="footer__links">
              <li><a href="#">About Us</a></li>
              <li><a href="#">Contact</a></li>
              <li><a href="#">Privacy Policy</a></li>
              <li><a href="#">Terms of Service</a></li>
            </ul>
          </div>
        </div>
        <div class="footer__bottom">
          <div class="footer__copyright">
            © 2025 ResQnet. All rights reserved.
          </div>
          <div class="footer__social">
            <a href="#" class="social-link" aria-label="Facebook">
              <span data-lucide="facebook"></span>
            </a>
            <a href="#" class="social-link" aria-label="Twitter">
              <span data-lucide="twitter"></span>
            </a>
            <a href="#" class="social-link" aria-label="Instagram">
              <span data-lucide="instagram"></span>
            </a>
            <a href="#" class="social-link" aria-label="LinkedIn">
              <span data-lucide="linkedin"></span>
            </a>
          </div>
        </div>
      </div>
    </footer>

    <script>
      document.addEventListener("DOMContentLoaded", () => {
        if (window.lucide) window.lucide.createIcons();

        // Smooth scroll for anchor links
        document.querySelectorAll('a[href^="#"]').forEach((anchor) => {
          anchor.addEventListener("click", function (e) {
            const href = this.getAttribute("href");
            if (href !== "#") {
              e.preventDefault();
              const target = document.querySelector(href);
              if (target) {
                target.scrollIntoView({ behavior: "smooth", block: "start" });
              }
            }
          });
        });
      });
    </script>
  </body>
</html>
