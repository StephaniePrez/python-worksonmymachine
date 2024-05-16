let currentFrame = 0;
let W = window.innerWidth;
let H = window.innerHeight;
const canvas = document.getElementById("canvas");
const context = canvas.getContext("2d");
const maxConfettis = 100;
const particles = [];

const possibleColors = ["White"];

function randomFromTo(from, to) {
  return Math.floor(Math.random() * (to - from + 1) + from);
}

function confettiParticle() {
  this.x = Math.random() * W;
  this.y = Math.random() * H - H;
  this.r = randomFromTo(11, 33);
  this.d = Math.random() * maxConfettis + 11;
  this.color =
    possibleColors[Math.floor(Math.random() * possibleColors.length)];
  this.tilt = Math.floor(Math.random() * 33) - 11;
  this.tiltAngleIncremental = Math.random() * 0.07 + 0.05;
  this.tiltAngle = 0;

  this.draw = function() {
    context.beginPath();
    context.lineWidth = this.r / 2;
    context.strokeStyle = this.color;
    context.moveTo(this.x + this.tilt + this.r / 3, this.y);
    context.lineTo(this.x + this.tilt, this.y + this.tilt + this.r / 5);
    return context.stroke();
  };
}

function Draw() {
  const results = [];
  context.clearRect(0, 0, W, H);

  for (var i = 0; i < maxConfettis; i++) {
    results.push(particles[i].draw());
  }

  let particle = {};
  let remainingFlakes = 0;
  for (var i = 0; i < maxConfettis; i++) {
    particle = particles[i];

    particle.tiltAngle += particle.tiltAngleIncremental;
    particle.y += (Math.cos(particle.d) + 3 + particle.r / 2) / 2;
    particle.tilt = Math.sin(particle.tiltAngle - i / 3) * 15;

    if (particle.y <= H) remainingFlakes++;

    if (particle.x > W + 30 || particle.x < -30 || particle.y > H) {
      particle.x = Math.random() * W;
      particle.y = -30;
      particle.tilt = Math.floor(Math.random() * 10) - 20;
    }
  }
  currentFrame++;

  return results;
}

window.addEventListener(
  "resize",
  function() {
    W = window.innerWidth;
    H = window.innerHeight;
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
  },
  false
);

for (var i = 0; i < maxConfettis; i++) {
  particles.push(new confettiParticle());
}

canvas.width = W;
canvas.height = H;

let touchStartY = 0;
let touchEndY = 0;

window.addEventListener(
  "touchstart",
  function(event) {
    touchStartY = event.touches[0].clientY;
  },
  false
);

window.addEventListener(
  "touchend",
  function(event) {
    touchEndY = event.changedTouches[0].clientY;
    handleTouchScroll();
  },
  false
);

window.addEventListener(
  "wheel",
  function(event) {
    if (event.deltaY > 0) {
      currentFrame = Math.max(0, currentFrame - 1); // Scroll hacia abajo
      Draw();
    } else {
      Draw(); // Scroll hacia arriba
    }
  },
  false
);

function handleTouchScroll() {
  if (touchEndY < touchStartY) {
    Draw(); // Scroll hacia arriba
  } else if (touchEndY > touchStartY) {
    currentFrame = Math.max(0, currentFrame - 1); // Scroll hacia abajo
    Draw();
  }
}

Draw();