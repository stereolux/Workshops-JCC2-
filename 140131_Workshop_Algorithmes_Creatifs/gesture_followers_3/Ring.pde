class Ring {

  ArrayList <Follower> fs;

  Ring() {
    fs = new ArrayList();
  }

  void draw() {
    for (int n = fs.size()-1; n > -1; n--) {
      int m = (n < fs.size()-1) ? n+1 : 0;
      Follower fn = fs.get(n);
      Follower fm = fs.get(m);
      fn.arrive(new PVector(fm.pos.x, fm.pos.y));
      fn.update();
      fn.draw();
    }
  }
  
  void resetMov() {
    fs.clear();
  }  
  
  void addPoint(float x, float y) {
    fs.add(new Follower(x, y));
  }

  void startMov() {
  }

}

