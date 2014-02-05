class Particle extends PVector {

  PVector vel, acc;
  float life;

  Particle(float x, float y) {
    super(x, y);
    acc = new PVector();
    vel = new PVector(random(-1, 1), random(-1,1));
    life = 1;
  }

  void update() {
    life = max(0, life-0.001);
    vel.add(acc);
    vel.limit(3);
    this.add(vel);
    if (x > width) x = 0;
    if (x < 0) x = width;
    if (y < 0) y = height;
    if (y > height) y = 0;
  }

  void follow(PVector p) { 
    // Easing algorithm for vectors
    PVector v = p.get();
    v.sub(this);
    v.mult(0.15);
    vel.set(v);
  }

  void draw() {
    float ang = vel.heading();
    colorMode(HSB, 360, 100, 100);
    fill(degrees(ang+PI), 30, 90, 100);
    noStroke();
    arc(x, y, 40*life, 40*life, ang-0.2, ang+.2);
    colorMode(RGB, 255, 255, 255);
  }
}

