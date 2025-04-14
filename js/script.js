// Simple scroll-based fade-in effect
document.addEventListener("DOMContentLoaded", function () {
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
    handleScroll();
  });
  
  // Optional fade-in animation CSS class
  const style = document.createElement('style');
  style.innerHTML = `
    .fade-in {
      opacity: 1;
      transform: translateY(0);
      transition: opacity 1s ease, transform 1s ease;
    }
   .fade-target {
  opacity: 1;
  transform: none;
}
  `;
  document.head.appendChild(style);
  