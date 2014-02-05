// Algorithmes créatifs - Abelardo Gil-Fournier, 2014
// http://abelardogfournier.org
// http://github.org/abe-
//
// Vector fields have inherent phaenomena: alignment with
// neighbours, explosion/implosion, whirls...
// Two tools allow us to detect and work with them:
// Divergence (explosion/implosion) and Rotational (whirls)
// We'll learn now how to implement them, by using, respectively,
// the dot product and the cross product between vectors.

VectorField vf;

void setup() {
  size(1200, 800, P2D);
  vf = new VectorField(60, 40);
}

void draw() {
  background(50);
  vf.update();
  vf.draw();
}

void mouseDragged() {
  vf.modify(mouseX, mouseY, pmouseX, pmouseY);
}

void mousePressed(MouseEvent e) {
  if (e.getClickCount() == 2) {
    vf.twist(mouseX, mouseY);
  }
}
