ArrayList <Atom> atoms;

void setup() {
  size(600, 600);

  atoms = new ArrayList();
  Atom a = new Atom(width/4, height/2, 10);
  atoms.add(a);
}


void draw() {
  background(255);
  
  addNew();
  
  for (Atom a : atoms) {
    a.draw();
  }
}


void addNew() {
  PVector pos = new PVector(random(width), random(height));
  float r = random(5, 10);

  Atom closest = null;
  float closestDist = 1000000;

  for (Atom a : atoms) {
    float d = a.dist(pos);
    if (d < closestDist) {
      closest = a;
      closestDist = d;
    }
  }    

  PVector next = pos.get();
  next.sub(closest);
  next.setMag(closest.diam/2 + r);
  next.add(closest);

  Atom newAtom = new Atom(next.x, next.y, 2*r);
  atoms.add(newAtom);
}
