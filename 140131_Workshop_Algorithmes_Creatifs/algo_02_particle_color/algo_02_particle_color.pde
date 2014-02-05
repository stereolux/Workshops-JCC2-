// Algorithmes créatifs - Abelardo Gil-Fournier, 2014
// http://abelardogfournier.org
// http://github.org/abe-
//
// Vectors as a class can be easily extended through 
//  standard Object Oriented techniques to produce 
// other very useful classes in more concrete contexts.
// Toxiclibs has been a wonderful example of this. 
// In our case, Particles can considered as extended vectors;
// vectors with atributes: velocity and acceleration.

Particle p;

void setup() {
  size(400, 400);
  p = new Particle(200, 200);
}

void draw() {
  background(255);
  p.update();
  p.draw();
}

void mouseMoved() {
  p.follow(new PVector(mouseX, mouseY));
}
