ArrayList <Atom> atoms;

void setup() {
  size(1200, 500);
  atoms = new ArrayList();
}

void draw() {
  background(255);
  for (Atom a : atoms) {
    a.draw();
  }
}

void mousePressed() {
//  atoms.clear();
  Atom a = new Atom(mouseX, mouseY, 20);
  a.type = 1;
  atoms.add(a);
}

void mouseDragged() {
  Atom a = null;
  int count = 1;
  if (atoms.size() > 0) {
    while (a == null || a.type == 0) {
      a = atoms.get(atoms.size()-count);
      count++;
    }
  }

  if (dist(a.x, a.y, mouseX, mouseY) > 10) {
    Atom b = new Atom(mouseX, mouseY, 10);
    b.type = 1;
    atoms.add(b);
  }

  if (frameCount % 5 == 0) {
    PVector pos = new PVector(200, 0);
    pos.set(random(width), random(height));

    float r = random(5, 15);
    float distMin = 1000000;
    Atom closest = null;
    for (Atom b : atoms) {
      float d = b.dist(pos);
      if (d < distMin) {
        closest = b;
        distMin = d;
      }
    }

    pos.sub(closest);
    PVector next = closest.get();
    pos.normalize();
    pos.mult(closest.r/2+r/2);
    next.add(pos);
    Atom nw = new Atom(next.x, next.y, r);
    atoms.add(nw);
  }
}

