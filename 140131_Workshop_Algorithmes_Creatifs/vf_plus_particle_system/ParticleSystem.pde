class ParticleSystem {

  ArrayList <Particle> ps;
  PVector emitter;
  
  ParticleSystem() {
    emitter = new PVector(width/2, height/2);
    ps = new ArrayList();
    for (int n = 0; n < 10; n++) {
      Particle p = new Particle(emitter.x, emitter.y);
      ps.add(p);
    }
  }
  
  void update() {
    if (frameCount % 5 == 0) {
      Particle p = new Particle(emitter.x, emitter.y);
      ps.add(p);
    }
    
    java.util.Iterator iter = ps.iterator();
    while( iter.hasNext() ) {
      Particle p = (Particle) iter.next();
      if (p.life < 0) iter.remove();
    } 
  }
  
  void draw() {
    for (Particle p : ps) {
      p.update();
      p.draw();
    }
  }

}
