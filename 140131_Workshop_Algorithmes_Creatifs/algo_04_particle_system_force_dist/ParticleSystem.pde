// Algorithmes créatifs - Abelardo Gil-Fournier, 2014
// http://abelardogfournier.org
// http://github.org/abe-

// In addition to the code we've written previously when
// building the collection of particles, we have introduced
// in this field two forces that show the effect of Newton's 
// law in the movement of easing particles that follows one 
// to each other. 

class ParticleSystem {

  ArrayList <Particle> particles;
  PVector pos, force;
  PVector pos2, force2;

  ParticleSystem() {
    particles = new ArrayList();
    initForces();
  }

  void initForces() {
    pos = new PVector(width/2+100, height/2+50);
    force = new PVector(-.5, 0);
    pos2 = new PVector(width/2-100, height/2+50);
    force2 = new PVector(.5, 0);
  }

  void forces() {
    noFill();
    stroke(200);
    ellipse(pos.x, pos.y, 150, 150);
    ellipse(pos2.x, pos2.y, 150, 150);

    for (Particle p : particles) {
      float d = p.dist(pos); 
      if (d < 75) {
        PVector f = force.get();
        f.mult(1-d/75.);
        p.acc.set(f);             // In a newtonian simulation, 
      }                           // forces become accelerations.
      d = p.dist(pos2);           // To read more on this, Daniel
      if (d < 75) {               // Shiffman's The Nature of Code
        PVector f = force2.get(); // is the place to start with.
        f.mult(1-d/75.);
        p.acc.set(f);
      }
    }
  }

  void update() {
    java.util.Iterator iter = particles.iterator();
    while (iter.hasNext ()) {
      Particle p = (Particle) iter.next();
      if (p.life == 0) iter.remove();
    }

    forces();

    for (int n = 0; n < particles.size(); n++) {
      Particle p = particles.get(n);
      Particle p2 = null;
      if (n == particles.size()-1) {
        p2 = particles.get(0);
      }
      else {
        p2 = particles.get(n+1);
      }
      if (p2 != null) p.follow(p2);
    }
    
    for (Particle p : particles) {
      p.update();
    }
  }

  void draw() {
    for (Particle p : particles) {
      p.draw();
    }
  }
}

