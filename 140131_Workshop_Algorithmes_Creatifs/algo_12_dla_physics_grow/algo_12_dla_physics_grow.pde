// Algorithmes créatifs - Abelardo Gil-Fournier, 2014
// http://abelardogfournier.org
// http://github.org/abe-
//
// We saw in the last step of our system that it encouraged us, as users,
// to try to tie together the branches by building bridges among them. We
// can make the system make this for us. We can detect the atoms that 
// are linked only once (free radicals), and make the system follow their
// directions. Not every free radical will be allowed to grow, however. 
// Only those that detect that there are particles of the system in its
// direction. 

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
  
  grow();
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

void grow() {
  ArrayList <Atom> children = new ArrayList();
  for (Atom a : atoms) {
    if (a.incoming.size() == 1) { // if it is a free end
      Atom b = a.incoming.get(0);
      PVector dir = a.get();      
      dir.sub(b);            // distance b->a
      float ang = dir.heading() + PI;
      
      // Let's see if there's an Atom in the direction of this end
      for (Atom other : atoms) {   
        PVector v = other.get();
        v.sub(a);            // distance a->other
        float ang2 = v.heading() + PI;
        if (abs(ang-ang2) < 0.1) { // We compare the two directions
          dir.setMag(a.diam);
          dir.add(a);              // Next Atom stands at "a" in the direction of the end
          
          fill(255, 255, 0);
          ellipse(dir.x, dir.y, 10, 10); // visualize the next children 
          if (frameCount % 5 == 0) children.add(new Atom(dir.x, dir.y));          
          break;          
        }
      }
    }
  }
  atoms.addAll(children);
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

