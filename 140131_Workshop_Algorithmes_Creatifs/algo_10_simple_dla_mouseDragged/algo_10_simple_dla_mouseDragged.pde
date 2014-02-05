// Algorithmes créatifs - Abelardo Gil-Fournier, 2014
// http://abelardogfournier.org
// http://github.org/abe-
//
// The DLA system we have exhibits interesting behaviours when
// make it attach new particles constantly following the mouse
// coordinates (instead of random seeds).
//
// If we doubleclick, we'll be able additionally to create
// new regions of DLA sensitive atoms.

ArrayList <Atom> atoms;


void setup() {
  size(800, 800);
  smooth();

  atoms = new ArrayList();

  Atom a = new Atom(width/2, height/2, 20);
  atoms.add(a);
}


void draw() {
  background(255);

  strokeWeight(0.5);
  //noFill();

  // draw them
  for (Atom atom : atoms) {
    atom.draw();
  }
}

void addNew() {
  PVector pos = new PVector(mouseX, mouseY);
  float r = random(5, 10);

  if (frameCount % 5 == 0) {
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
      Atom newAtom = new Atom(next.x, next.y, 2*r);
      atoms.add(newAtom);
    }
  }
}

void mouseDragged() {
  if (frameCount % 5 == 0) addNew();
}

void mousePressed(MouseEvent e) {
  if (e.getClickCount()==2) {
    Atom newAtom = new Atom(mouseX, mouseY, 20);
    atoms.add(newAtom);
  }
}

