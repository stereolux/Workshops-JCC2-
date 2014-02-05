class Imitator {

  PVector pos;
  int id;
  PVector[] mov, nextMov;
  int movId, nextMovId;
  int memory = 100;
  
  Imitator(float x, float y, int id_) {
    pos = new PVector(x, y);
    id = id_;
    mov = new PVector[memory];
    nextMov = new PVector[memory];
    for (int n = 0; n < mov.length; n++) {
      mov[n] = new PVector(0, 0);
      nextMov[n] = new PVector(0, 0);
    }
  }
  
  void draw() {
    PVector p = pos.get();
    beginShape();
    strokeWeight(10);
    strokeJoin(ROUND);
    for (int n = movId-mov.length+1; n < movId; n++) {
      int m = (n < 0) ? n + mov.length : n;
      p.add(mov[m]);
      vertex(p.x, p.y);
    }
    endShape();
    movId = (movId + 1) % mov.length;
    //noStroke();
    //fill(230);
    //ellipse(p.x, p.y, 10, 10); 
  }
  
  void resetMov() {
    for (int n = 0; n < mov.length; n++) {
      nextMov[n] = new PVector(0, 0);
    }
  }
  
  void addPoint(float x, float y) {
    nextMov[nextMovId] = new PVector(x, y);
    nextMovId = (nextMovId+1) % nextMov.length;
  }

  void startMov() {
    arrayCopy(nextMov, mov);
  }
}

