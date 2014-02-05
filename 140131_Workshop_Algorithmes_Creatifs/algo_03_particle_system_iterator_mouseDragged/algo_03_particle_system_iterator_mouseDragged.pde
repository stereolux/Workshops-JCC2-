// Algorithmes créatifs - Abelardo Gil-Fournier, 2014
// http://abelardogfournier.org
// http://github.org/abe-
//
// We are now going to work with collections of vectors.
// A reticular array of vectors will constitute a vector field.
// We'll work on them later. A list of particles will conform
// a particle system. That's what we are going to work with now.

ArrayList <Particle> particles;  // We'll work in "plural mode" now
                                 // with collections instead of 
void setup() {                   // singular entities. One of those
  size(400, 400);                // collections is the ArrayList
  particles = new ArrayList();
}

void draw() {
  background(255);

  // We have introduced a "life" variable inside the Particle
  // class. Particles with life == 0 are dead, so we should remove
  // them from the Particle System. We need to remove them with 
  // an Iterator, for technical reasons. Daniel Shiffman, in The
  // Nature of Code, explains why very clearly (as he does, always). 
  java.util.Iterator iter = particles.iterator();
  while (iter.hasNext ()) {
    Particle p = (Particle) iter.next();
    if (p.life == 0) iter.remove();
  }

  // We are going to link particles with each other. We'll
  // use the easing "follow" function we have to make each
  // particle follow the next one. 
  for (int n = 0; n < particles.size(); n++) {
    Particle p = particles.get(n);
    Particle p2 = null;
    if (n == particles.size()-1) {
      p2 = particles.get(0);
    }
    else {
      p2 = particles.get(n+1);
    }
    if (p2 != null) p.follow(p2);  // That's a wonder of inheritance!
    p.update();
    p.draw();
  }
  
}

void mouseDragged() {
  Particle p = new Particle(mouseX, mouseY);
  p.vel.set(mouseX-pmouseX, mouseY-pmouseY);
  particles.add(p);
}

