import ai.pathfinder.*;
import traer.physics.*;

ParticleSystem physics;
Pathfinder sys;
ArrayList <Atom> atoms;
float REPULSION_STRENGTH = 1;
float EDGE_STRENGTH = 0.05; 
float EDGE_LENGTH = 10;

Atom closest;
Traveler t;

void setup() {
  size(800, 800);
  smooth();
  //frameRate(10);

  sys = new Pathfinder();
  physics = new ParticleSystem( 0, 0.1 );
  physics.clear();

  atoms = new ArrayList();

  Atom a = new Atom(width/2, height/2);
  atoms.add(a);

  t = new Traveler(0);
}

void update() {
  for (Atom a1 : atoms) {
    for (Atom a2 : atoms) {
      if (a1 != a2 && !a1.node.connectedTogether(a2.node)) { 
        if (dist(a1.x, a1.y, a2.x, a2.y) < 0.6*(a1.diam+a2.diam)) {
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

  strokeWeight(0.5);
  //noFill();

  // draw them
  for (Atom atom : atoms) {
    atom.update();
    atom.draw();
  }

  for (Atom a1 : atoms) {
    for (Atom a2 : atoms) {
      if (a1 != a2 && a1.node.connectedTogether(a2.node)) { 
        stroke(255);
        line(a1.x, a1.y, a2.x, a2.y);
      }
    }
  }


  for (Atom atom : atoms) {
    if (dist(atom.x, atom.y, mouseX, mouseY) < atom.diam) {
      t.target = sys.nodes.indexOf(atom.node);
    }
  } 
  if (frameCount % 1 == 0) t.update();  
  t.draw();
}



void mouseDragged() {
  // create a radom set of parameters
  float newR = EDGE_LENGTH*.5;//random(5, 10);
  float newX = mouseX;//random(0+newR, width-newR);
  float newY = mouseY;//random(0+newR, height-newR);


  if (frameCount % 5 == 0) {
    float closestDist = 100000000;
    // which circle is the closest?
    for (Atom a : atoms) {
      float newDist = dist(newX, newY, a.x, a.y);
      if (newDist < closestDist) {
        closest = a;
        closestDist = newDist;
      }
    }

    // show random position and line
    // fill(230);
    // ellipse(newX,newY,newR*2,newR*2);
    // line(newX,newY,x[closestIndex],y[closestIndex]);

    // aline it to the closest circle outline
    if (closest != null) {
      float angle = atan2(newY-closest.y, newX-closest.x);

      //
      // IMPORTANTE: floor en radios para que siempre estén conectados
      //
      float x_ = closest.x + cos(angle) * floor(closest.diam*.5+newR);
      float y_ = closest.y + sin(angle) * floor(closest.diam*.5+newR);

      boolean addit = true;
      for (Atom b : atoms) {
        if (closest != b && dist(b.x, b.y, x_, y_) < newR+b.diam*.5) {
          println(closest.dist(b));
          addit = false;
        }
      }

      if (addit) {
        Atom newAtom = new Atom(x_, y_);
        atoms.add(newAtom);
      }
    }
  }
}

void mousePressed(MouseEvent e) {
  if (e.getClickCount()==2) {
    Atom newAtom = new Atom(mouseX, mouseY);
    atoms.add(newAtom);
  }
}

