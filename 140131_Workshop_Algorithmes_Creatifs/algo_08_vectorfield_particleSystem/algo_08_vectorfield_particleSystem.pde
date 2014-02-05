// Algorithmes créatifs - Abelardo Gil-Fournier, 2014
// http://abelardogfournier.org
// http://github.org/abe-
//
// Vector Fields and Particle Systems are complementary entities
// when building immersive environments. PS affected by the VF display
// with their movement the properties of the field, and viceversa, it
// is very interesting to make VF to react to the movement of particles.

VectorField vf;
ParticleSystem ps;

void setup() {
  size(1200, 800, P2D);
  vf = new VectorField(60, 40);
  ps = new ParticleSystem();
}

void draw() {
  background(50);
  vf.update();
  vf.draw();
  ps.update();
  ps.draw();  
}

void mouseDragged() {
  vf.modify(75, mouseX, mouseY, pmouseX, pmouseY);
}

void mousePressed(MouseEvent e) {
  if (e.getClickCount() == 2) {
    vf.twist(mouseX, mouseY);
  }
}
