document.addEventListener("DOMContentLoaded", function () {
  // Scroll-based fade-in effect
  const elements = document.querySelectorAll(".fade-target");
  
  function handleScroll() {
    elements.forEach(el => {
      const rect = el.getBoundingClientRect();
      if (rect.top <= window.innerHeight * 0.85) {
        el.classList.add("fade-in");
      }
    });
  }
  
  window.addEventListener("scroll", handleScroll);
  handleScroll(); // Initial check on page load

  // Mobile menu toggle
  const mobileMenuBtn = document.querySelector(".mobile-menu-btn");
  const navMenu = document.querySelector(".nav-menu");
  const navButtons = document.querySelector(".nav-buttons");
  
  if (mobileMenuBtn) {
    mobileMenuBtn.addEventListener("click", function() {
      this.classList.toggle("active");
      
      if (this.classList.contains("active")) {
        // Create mobile menu overlay
        const overlay = document.createElement("div");
        overlay.className = "mobile-menu-overlay";
        
        const mobileNav = document.createElement("div");
        mobileNav.className = "mobile-nav";
        
        // Clone navigation items
        const navClone = navMenu.cloneNode(true);
        const buttonsClone = navButtons.cloneNode(true);
        
        mobileNav.appendChild(navClone);
        mobileNav.appendChild(buttonsClone);
        overlay.appendChild(mobileNav);
        
        document.body.appendChild(overlay);
        document.body.style.overflow = "hidden"; // Prevent scrolling
        
        // Animation
        setTimeout(() => {
          overlay.classList.add("active");
        }, 10);
        
        // Close button
        const closeBtn = document.createElement("button");
        closeBtn.className = "mobile-close-btn";
        closeBtn.innerHTML = "×";
        mobileNav.prepend(closeBtn);
        
        closeBtn.addEventListener("click", closeMobileMenu);
        overlay.addEventListener("click", function(e) {
          if (e.target === this) {
            closeMobileMenu();
          }
        });
      } else {
        closeMobileMenu();
      }
    });
  }
  
  function closeMobileMenu() {
    const overlay = document.querySelector(".mobile-menu-overlay");
    if (overlay) {
      overlay.classList.remove("active");
      setTimeout(() => {
        document.body.removeChild(overlay);
        document.body.style.overflow = "";
      }, 300);
      
      if (mobileMenuBtn) {
        mobileMenuBtn.classList.remove("active");
      }
    }
  }
  
  // Smooth scrolling for anchor links
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
      const targetId = this.getAttribute('href');
      
      if (targetId !== "#") {
        e.preventDefault();
        
        const targetElement = document.querySelector(targetId);
        if (targetElement) {
          window.scrollTo({
            top: targetElement.offsetTop - 80, // Account for header height
            behavior: 'smooth'
          });
        }
      }
    });
  });
  
  // Add floating animation to the logos
  const logoCards = document.querySelectorAll('.logo-card');
  logoCards.forEach((logo, index) => {
    // Add random delays to make the animation more natural
    logo.style.animationDelay = `${index * 0.3}s`;
  });
});
  