class Atom extends PVector {
  
  float r;
  int type = 0;
  
  Atom(float x, float y, float r_) {
    super(x, y);
    r = r_;
  }
  
  void draw() {
    fill(50);
    ellipse(x, y, r, r);
  }
  
}
