import ai.pathfinder.*;

Pathfinder sys;
ArrayList <Atom> atoms;

void setup() {
  size( 500, 500 );

  sys = new Pathfinder();
  atoms = new ArrayList();

  float b = 50;
  for (int n = 0; n < 10; n++) {
    Atom atom = new Atom(b+random(width-2*b), b+random(height-2*b));
    atoms.add(atom);
  }

  for (int n = 0; n < sys.nodes.size(); n++) {
    for (int m = 0; m < sys.nodes.size(); m++) {
      if (n != m && random(1) > .8) {
        Node n1 = (Node) sys.nodes.get(n);
        Node n2 = (Node) sys.nodes.get(m);
        n1.connect(n2);
      }
    }
  }
}

void update() {
  for (Atom atom : atoms) {
    atom.reset();
  }
  
  for (Atom atom1 : atoms) {
    for (Atom atom2 : atoms) {
      if (atom1.connectedTo(atom2)) {
        atom2.incoming.add(atom1);
        atom1.counter++;
      }
    }
  }
  
  for (Atom atom : atoms) {
    atom.calcRank();
  }  
}

void draw() {
  update();
  
  background(200);
  for (Atom atom1 : atoms) {
    atom1.draw();
    for (Atom atom2 : atoms) {
      if (atom1.connectedTo(atom2)) {
        stroke(0, 200, 0);
        line(atom1.x, atom1.y, atom2.x, atom2.y);
        float dx = lerp(atom1.x, atom2.x, .95);
        float dy = lerp(atom1.y, atom2.y, .95);
        ellipse(dx, dy, 5, 5);
      }
    }
  }
}

