// When the user scrolls the page, execute myFunction

window.onscroll = function () {
  myFunction();
};

var container = document.querySelector(".header-container");

// Function para manejar los eventos de scroll
function myFunction() {
  var scrollPosition = window.pageYOffset || document.documentElement.scrollTop;

  if (scrollPosition >= stickyOffset) {
    container.classList.add("sticky");
  } else {
    container.classList.remove("sticky");
  }
}

// Attach scroll event listener
window.addEventListener("scroll", myFunction);
