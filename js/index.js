document.addEventListener("DOMContentLoaded", function() {
    const sidebarToggle = document.getElementById("sidebarToggle");
    const sidebar = document.querySelector(".bg-dark");
    
    sidebarToggle.addEventListener("click", function() {
      sidebar.classList.toggle("d-none");
    });
  
    document.addEventListener("click", function(event) {
      if (!sidebar.contains(event.target) && event.target !== sidebarToggle) {
        sidebar.classList.add("d-none");
      }
    });
  
    sidebarToggle.addEventListener("mouseenter", function() {
      sidebar.classList.remove("d-none");
    });
  
    sidebarToggle.addEventListener("mouseleave", function() {
      if (!sidebar.classList.contains("fixed-top")) {
        sidebar.classList.add("d-none");
      }
    });
  });
  