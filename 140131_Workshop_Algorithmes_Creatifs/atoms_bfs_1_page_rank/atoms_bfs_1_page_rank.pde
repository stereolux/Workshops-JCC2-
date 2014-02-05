import ai.pathfinder.*;
import traer.physics.*;


ParticleSystem physics;
Pathfinder sys;
ArrayList <Atom> atoms;
float REPULSION_STRENGTH = 1000;
float EDGE_STRENGTH = 0.02; 
float EDGE_LENGTH = 50;

void setup() {
  size( 800, 800 );

  sys = new Pathfinder();
  physics = new ParticleSystem( 0, 0.1 );
  physics.clear();
  
  float b = 50;
  atoms = new ArrayList();  
  for (int n = 0; n < 10; n++) {
    Atom a = new Atom(random(b, width-2*b), random(b, height-2*b));
    atoms.add(a);
  }
  
  for (Atom a1 : atoms) {
    for (Atom a2 : atoms) {
      if (a1 != a2 && random(1) > .85) {
        a1.link(a2);
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
  physics.tick(); 

  background(200);
  for (Atom atom1 : atoms) {
    atom1.update();
    atom1.draw();
    for (Atom atom2 : atoms) {
      if (atom1.connectedTo(atom2)) {
        stroke(0, 200, 0, 50);
        line(atom1.x, atom1.y, atom2.x, atom2.y);
        float dx = lerp(atom1.x, atom2.x, .95);
        float dy = lerp(atom1.y, atom2.y, .95);
        //ellipse(dx, dy, 5, 5);
      }
    }
  }
}

