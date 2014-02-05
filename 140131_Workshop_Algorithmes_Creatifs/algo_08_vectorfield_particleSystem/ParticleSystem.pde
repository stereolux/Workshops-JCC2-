// Algorithmes créatifs - Abelardo Gil-Fournier, 2014
// http://abelardogfournier.org
// http://github.org/abe-
//
// All particles in this particle system will start their movement at a particular
// position, determined by the vector "emitter". 

class ParticleSystem {

  ArrayList <Particle> particles;
  PVector emitter;

  ParticleSystem() {
    particles = new ArrayList();
    emitter = new PVector(width/2, height/2);
  }

  void update() {
    java.util.Iterator iter = particles.iterator();
    while (iter.hasNext ()) {
      Particle p = (Particle) iter.next();
      if (p.life == 0) iter.remove();
    }
    
    if (frameCount % 5 == 0) {
      Particle p = new Particle(emitter.x, emitter.y);
      particles.add(p);
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

