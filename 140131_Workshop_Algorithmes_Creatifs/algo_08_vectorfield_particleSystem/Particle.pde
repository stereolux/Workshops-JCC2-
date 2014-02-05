// Algorithmes créatifs - Abelardo Gil-Fournier, 2014
// http://abelardogfournier.org
// http://github.org/abe-
//
// With their movement, particles will modify the VF. As
// butterflies modifying currents of wind in the space.

// Particles here will respond only the VF forces, and won't be
// easing-following no one.

class Particle extends PVector {

  PVector vel, acc;
  float life;
  float fase;

  Particle(float x, float y) {
    super(x, y);
    acc = new PVector();
    vel = new PVector(random(-1, 1), random(-1,1));
    life = 1;
    fase = random(PI);
  }

  void update() {
    PVector past = this.get();    
    
    life = max(0, life-0.002);
    acc.set(vf.getVector(x, y));
    vel.add(acc);
    vel.limit(3);
    this.add(vel);
    if (x > width-1) x = 0;
    if (x < 0) x = width-1;
    if (y < 0) y = height-1;
    if (y > height-1) y = 0;
    
    vf.modify(10, x, y, past.x, past.y);
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
    fill(degrees(ang+PI), 30, 90, 200);
    noStroke();
    
    float mg = vel.mag()*0.3*(1+.5*sin(frameCount*0.1+fase));
    arc(x, y, 50*life, 50*life, ang-mg, ang+mg);
    colorMode(RGB, 255, 255, 255);
  }
}

