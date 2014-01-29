class Particle_sys extends Particle {
  int particleNum;
  Particle[] particles;

  Particle_sys(float x, float y, color pcol, int particleNum) {
    super(x, y, pcol);
    this.particleNum =  particleNum;
    particles = new Particle[particleNum];

    for (int i = 0; i<particleNum; i++) {
      particles[i] = new Particle(x, y, pcol);
    }
  }

  void run() {

    for (int i = 0; i<particleNum; i++) {
      particles[i].run();
    }
  }

  void display() {
    for (int i = 0; i<particleNum; i++) {
      particles[i].display();
    }
  }

  void reset() {
    for (int i = 0; i<particleNum; i++) {
      particles[i].reset();
    }
  }
}

