// Algorithmes créatifs - Abelardo Gil-Fournier, 2014
// http://abelardogfournier.org
// http://github.org/abe-
//
// When working with VectorFields, we want to be able to modify
// them with our mouse, for example. Here we will introduce a 
// function that aligns vectors in the proximity of the mouse
// to the direction of the mouse movement. Additionally, and in
// order to relate each vector with its neighbours, we'll introduce
// a smoothing function: an averaging of alignments that will
// attach to the grid of individuals a collective behaviour. 

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
