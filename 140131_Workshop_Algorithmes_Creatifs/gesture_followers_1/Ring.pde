class Ring {

  Follower[] f;
  int memory = 20;
  PVector[] nextMov;
  int nextMovId;

  Ring() {
    f = new Follower[memory];
    for (int n = 0; n < f.length; n++) {
      f[n] = new Follower(100, 100);
    }
    nextMov = new PVector[memory];
    for (int n = 0; n < nextMov.length; n++) {
      nextMov[n] = new PVector(0, 0);
    }
  }

  void draw() {
    for (int n = 0; n < f.length; n++) {
      int m = (n > 0) ? n-1 : f.length-1;
      f[n].arrive(new PVector(f[m].pos.x, f[m].pos.y));
      f[n].update();
      f[n].draw();
    }
  }
  
  void resetMov() {
    for (int n = 0; n < nextMov.length; n++) {
      nextMov[n] = new PVector(0, 0);
    }
  }  
  
  void addPoint(float x, float y) {
    nextMov[nextMovId] = new PVector(x, y);
    nextMovId = (nextMovId+1) % nextMov.length;
  }

  void startMov() {
    for (int n = 0; n < f.length; n++) {
      f[n].pos.set(nextMov[n]);
    }
  }

}

