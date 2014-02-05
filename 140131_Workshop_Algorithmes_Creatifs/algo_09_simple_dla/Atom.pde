// Algorithmes créatifs - Abelardo Gil-Fournier, 2014
// http://abelardogfournier.org
// http://github.org/abe-
//
// Again, we'll be working with a class created as an extension
// of PVector. We will be dealing then with Vectors that, 
// additionally, have diameter. In the next steps, we'll add
// more atributes, such as physics properties, etc.

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
