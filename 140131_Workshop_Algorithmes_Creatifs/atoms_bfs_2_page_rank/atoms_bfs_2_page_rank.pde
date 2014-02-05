import ai.pathfinder.*;
import traer.physics.*;


ParticleSystem physics;
Pathfinder sys;
ArrayList <Atom> atoms;
float REPULSION_STRENGTH = 1000;
float EDGE_STRENGTH = 0.02; 
float EDGE_LENGTH = 50;

Traveler t;

void setup() {
  size( 800, 800 );

  sys = new Pathfinder();
  physics = new ParticleSystem( 0, 0.1 );
  physics.clear();

  float b = 50;
  atoms = new ArrayList();  
  for (int n = 0; n < 20; n++) {
    Atom a = new Atom(random(b, width-2*b), random(b, height-2*b));
    atoms.add(a);
  }

  for (int i = 0; i < atoms.size(); i++) {
    Atom a1 = atoms.get(i);
    for (int j = i+1; j < atoms.size(); j++) {
      Atom a2 = atoms.get(j);
      if (a1 != a2 && random(1) > .85) {
        a1.link(a2);
      }
    }
  }
  sys.radialDisconnectUnwalkables();

  t = new Traveler(0);
}

void update() {
  for (Atom atom : atoms) {
    atom.reset();
  }

  for (Atom atom1 : atoms) {
    for (Atom atom2 : atoms) {
      if (atom1.node.connectedTo(atom2.node)) {
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
  physics.tick(); 

  background(200);
  for (int i = 0; i < atoms.size(); i++) {
    Atom atom1 = atoms.get(i);
    atom1.update();
    atom1.draw();
    for (int j = i+1; j < atoms.size(); j++) {
      Atom atom2 = atoms.get(j);
      if (atom1.node.connectedTo(atom2.node)) {
        stroke(0, 200, 0, 50);
        float  x1 = atom1.p.position().x();
        float  y1 = atom1.p.position().y();
        float  x2 = atom2.p.position().x();
        float  y2 = atom2.p.position().y();
        line(x1, y1, x2, y2);
        float dx = lerp(x1, x2, .95);
        float dy = lerp(y1, y2, .95);
        //ellipse(dx, dy, 5, 5);
      }
    }
  }

  for (Atom atom : atoms) {
    if (dist(atom.p.position().x(), atom.p.position().y(), mouseX, mouseY) < atom.diam) {
      t.target = sys.nodes.indexOf(atom.node);
    }
  } 
  if (frameCount % 10 == 0) t.update();  
  t.draw();
}


