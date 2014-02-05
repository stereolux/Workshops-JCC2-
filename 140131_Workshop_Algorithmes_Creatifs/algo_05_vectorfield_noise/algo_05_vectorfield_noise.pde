// Algorithmes créatifs - Abelardo Gil-Fournier, 2014
// http://abelardogfournier.org
// http://github.org/abe-
//
// A Vector Field is a reticular array of vectors that
// fill a space. The vf has the possibility then to affect
// to each point within the space. It is a very useful 
// abstraction to build immersive experiences of interaction,
// model fluid phenomena, etc.

VectorField vf;

void setup() {
  size(600, 400, P2D);             // We'll use a stroke gradients
  vf = new VectorField(30, 20);    // to represent vectors, so we
}                                  // to work in the OPENGL context

void draw() {
  background(50);
  vf.update();
  vf.draw();
}
