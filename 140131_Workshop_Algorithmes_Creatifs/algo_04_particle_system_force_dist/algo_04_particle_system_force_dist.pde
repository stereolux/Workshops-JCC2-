// Algorithmes créatifs - Abelardo Gil-Fournier, 2014
// http://abelardogfournier.org
// http://github.org/abe-
//
// Let's make space matter by adding forces
// located in static positions. The visual  
// response to our movements will somehow
// visualize the latent energy inside the canvas.

ParticleSystem ps;             // We've moved all the particles
                               // collection code to a new class:
void setup() {                 // ParticleSystem.
  size(400, 400);
  ps = new ParticleSystem();
}

void draw() {
  background(55);
  ps.update();
  ps.draw();
}

void mouseDragged() {
  Particle p = new Particle(mouseX, mouseY);
  p.vel.set(mouseX-pmouseX, mouseY-pmouseY);
  ps.particles.add(p);
}

