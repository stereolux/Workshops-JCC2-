// Algorithmes créatifs - Abelardo Gil-Fournier, 2014
// http://abelardogfournier.org
// http://github.org/abe-
//
// We are going to attach physics to our system. DLA growth exhibits
// an intrinsic movement, which can be displayed visually by letting
// the particles flow in the space, while they hold their constrains
// with the system. We will then add repulsion distance forces among
// each particle (they'll be all negative charged, let's say), and
// we will connect with springs those particles that are in contact
// in the system.
// We'll use the simple traer.physics library, as it allows very
// easily to use distance forces as well as springs between particles.

// Traer physics can be downloaded here: 
// http://murderandcreate.com/physics/

import traer.physics.*;

ParticleSystem physics;

ArrayList <Atom> atoms;
float REPULSION_STRENGTH = 10;
float EDGE_STRENGTH = 0.5; 
float EDGE_LENGTH = 10;


void setup() {
  size(800, 800);
  smooth();

  physics = new ParticleSystem( 0, 0.1 );
  physics.clear();

  atoms = new ArrayList();

  Atom a = new Atom(width/2, height/2);
  atoms.add(a);
}

void update() {
  for (Atom a1 : atoms) {
    for (Atom a2 : atoms) {
      if (a1 != a2 && !a1.incoming.contains(a2)) {
        if (a1.dist(a2) < 0.6*(a1.diam+a2.diam)) {
          a1.link(a2);
        }
      }
    }
  }
}

void draw() {
  background(255);
  update();
  physics.tick(); 

  for (Atom atom : atoms) {
    atom.update();
    atom.draw();
  }
}


void addNew() {
  PVector pos = new PVector(mouseX, mouseY);
  float r = random(5, 10);

  Atom closest = null;
  float closestDist = 100000000;

  for (Atom a : atoms) {
    float d = pos.dist(a);
    if (d < closestDist) {
      closest = a;
      closestDist = d;
    }
  }

  PVector next = pos.get();
  next.sub(closest);
  next.setMag(closest.diam/2 + r);
  next.add(closest);

  boolean addit = true;
  for (Atom b : atoms) {
    if (closest != b && next.dist(b) < r+b.diam*.5) {
      addit = false;
    }
  }

  if (addit) {
    Atom newAtom = new Atom(next.x, next.y);
    atoms.add(newAtom);
    newAtom.link(closest);
  }
}


void mouseDragged() {
  if (frameCount % 1 == 0) addNew();
}

void mousePressed(MouseEvent e) {
  if (e.getClickCount()==2) {
    Atom newAtom = new Atom(mouseX, mouseY);
    atoms.add(newAtom);
  }
}

