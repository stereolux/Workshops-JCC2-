// Algorithmes créatifs - Abelardo Gil-Fournier, 2014
// http://abelardogfournier.org
// http://github.org/abe-

class Atom extends PVector {
  
  float diam;
  
  Atom(float x, float y, float diam_) {
    super(x, y);
    diam = diam_;
  }
  
  void draw() {
    fill(50);
    ellipse(x, y, diam, diam);
  }
  
}
