/*
  Global JS Utilities for resqnet
  - Theme toggle (persisted)
  - Form validation helper
  - Password strength meter (hook-based)

  Architecture principles:
  * No framework assumptions
  * Progressive enhancement; safe to load at end of body
  * Small, pure helpers exported to window.resqnet for future extension
*/
(function () {
  const ns = (window.resqnet = window.resqnet || {});

  /* ================= Theme ================= */
  const THEME_KEY = "resqnet-theme";
  const prefersDark = window.matchMedia("(prefers-color-scheme: dark)");

  function applyTheme(theme) {
    const root = document.documentElement;
    if (theme === "dark") root.setAttribute("data-theme", "dark");
    else if (theme === "light") root.setAttribute("data-theme", "light");
    else root.removeAttribute("data-theme");
    updateThemeToggle();
  }
  function storedTheme() {
    return localStorage.getItem(THEME_KEY);
  }
  function setStoredTheme(val) {
    localStorage.setItem(THEME_KEY, val);
  }
  function cycleTheme() {
    const current =
      document.documentElement.getAttribute("data-theme") || "system";
    const next =
      current === "system" ? "dark" : current === "dark" ? "light" : "system";
    if (next === "system") localStorage.removeItem(THEME_KEY);
    else setStoredTheme(next);
    applyTheme(next);
  }
  function updateThemeToggle() {
    const btn = document.querySelector(".js-theme-toggle");
    if (!btn) return;
    const theme =
      document.documentElement.getAttribute("data-theme") || "system";
    const labelEl = btn.querySelector(".c-theme-toggle__label");
    const iconEl = btn.querySelector(".c-theme-toggle__icon");
    let iconName = "",
      text = "";
    switch (theme) {
      case "dark":
        iconName = "moon";
        text = "Dark";
        btn.setAttribute("aria-pressed", "true");
        break;
      case "light":
        iconName = "sun";
        text = "Light";
        btn.setAttribute("aria-pressed", "false");
        break;
      default:
        const systemDark = prefersDark.matches;
        iconName = systemDark ? "moon" : "sun";
        text = "Auto";
        btn.setAttribute("aria-pressed", systemDark ? "true" : "false");
    }
    if (iconEl && window.lucide) {
      iconEl.innerHTML = '';
      const iconSvg = window.lucide.createElement(window.lucide[iconName.charAt(0).toUpperCase() + iconName.slice(1)]);
      iconEl.appendChild(iconSvg);
    }
    if (labelEl) labelEl.textContent = text;
  }
  function initTheme() {
    const btn = document.querySelector(".js-theme-toggle");
    if (btn) {
      btn.addEventListener("click", cycleTheme);
      prefersDark.addEventListener("change", () => {
        if (!storedTheme()) updateThemeToggle();
      });
      const stored = storedTheme();
      if (stored) applyTheme(stored);
      else updateThemeToggle();
    }
  }

  ns.theme = { applyTheme, cycleTheme };

  /* ================= Form Validation ================= */
  function validateForm(form) {
    let valid = true;
    form.querySelectorAll(".c-field").forEach((fieldEl) => {
      const input = fieldEl.querySelector("input,textarea,select");
      const errorEl = fieldEl.querySelector(".c-field__error");
      if (input && !input.checkValidity()) {
        valid = false;
        if (errorEl) errorEl.textContent = input.validationMessage;
        fieldEl.classList.add("is-invalid");
      } else if (errorEl) {
        errorEl.textContent = "";
        fieldEl.classList.remove("is-invalid");
      }
    });
    return valid;
  }
  function attachValidation(form) {
    form.addEventListener("submit", (e) => {
      if (!validateForm(form)) e.preventDefault();
    });
  }
  ns.forms = { validateForm, attachValidation };

  /* ================= Password Strength ================= */
  function passwordScore(pw) {
    let score = 0;
    if (pw.length >= 8) score++;
    if (/[A-Z]/.test(pw)) score++;
    if (/[0-9]/.test(pw)) score++;
    if (/[^A-Za-z0-9]/.test(pw)) score++;
    return score;
  }
  function initPasswordMeter(inputSelector, meterSelector) {
    const input = document.querySelector(inputSelector);
    const meter = document.querySelector(meterSelector);
    if (!input || !meter) return;
    const label = meter.querySelector(".js-password-strength-label");
    input.addEventListener("input", () => {
      const val = input.value.trim();
      const score = passwordScore(val);
      const pct = (score / 4) * 100 + "%";
      meter.style.setProperty("--meter-pct", pct);
      meter.setAttribute("data-strength", String(score));
      const words = ["Very weak", "Weak", "Fair", "Good", "Strong"];
      if (label) label.textContent = words[score];
    });
  }
  ns.password = { passwordScore, initPasswordMeter };

  /* ================= Init (DOM Ready) ================= */
  document.addEventListener("DOMContentLoaded", () => {
    // Initialize Lucide icons
    if (window.lucide) {
      window.lucide.createIcons();
    }
    initTheme();
    document
      .querySelectorAll("form.js-validate")
      .forEach((f) => attachValidation(f));
  });
})();
