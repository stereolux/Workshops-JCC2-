class Particle {
  float x;
  float y;
  float vx;
  float vy;
  color pcol;
  float halfWidth;
  float halfHeight;

  Particle(float x, float y, color pcol) {
    vx = random(-0.9, 0.9);
    vy = random(-0.9, 0.9);

    this.x =x;
    this.y = y;
    this.pcol = pcol;
    halfWidth = x;
    halfHeight = y;
  }

  void run() {
    x += vx;
    y += vy;
    float dx = halfWidth - x;
    float dy = halfHeight - y;
    if (sqrt((dx * dx) + (dy * dy)) > 10) {
      //float ang = atan2(dy, dx) / PI * 180;
      vx *= -1;
      vy *= -1;
    }
  }

  void display() {
    noStroke();
    fill(pcol);
    ellipse(x, y, 1, 1);
  }

  void reset() {
    x = halfWidth;
    y = halfHeight;
  }
}

