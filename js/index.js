document.addEventListener("DOMContentLoaded", function() {
// Evitar el desplazamiento de la página al hacer clic en los enlaces del footer
document.querySelectorAll('.link-no-scroll').forEach(function(link) {
  link.addEventListener('click', function(event) {
    event.preventDefault();
  });
});
  });
  