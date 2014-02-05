// Algorithmes créatifs - Abelardo Gil-Fournier, 2014
// http://abelardogfournier.org
// http://github.org/abe-
//
// This class particle implements easing movement
// between the particle and a target position, basic
// operations with vectors are used. 

class Particle extends PVector {

  PVector vel;

  Particle(float x, float y) {
    super(x, y);
    vel = new PVector(random(-1, 1), random(-1, 1));
  }

  void update() {
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
    colorMode(HSB, 360, 100, 100);      // Let's visualize the 
    fill(degrees(ang+PI), 30, 90, 200); // heading angle using
    noStroke();                         // the 360 degrees
    arc(x, y, 40, 40, ang-0.4, ang+0.4);// representation of hue 
    colorMode(RGB, 255, 255, 255);      // in HSB mode
  }
}

