import ai.pathfinder.*;
import traer.physics.*;

ParticleSystem physics;
Pathfinder sys;
ArrayList <Atom> atoms;
float REPULSION_STRENGTH = 10;
float EDGE_STRENGTH = 0.5; 
float EDGE_LENGTH = 10;

Atom closest;
Traveler t;

PGraphics pg;

void setup() {
  size(1200, 800);
  smooth();
  //frameRate(10);

  sys = new Pathfinder();
  physics = new ParticleSystem( 0, 0.1 );
  physics.clear();

  atoms = new ArrayList();

  Atom a = new Atom(width/2, height/2);
  atoms.add(a);

  t = new Traveler(0);
  
  pg = createGraphics(width, height);
  pg.beginDraw();
  pg.background(0,0);
  pg.endDraw();
  
  frameRate(25);
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
  if (frameCount % 50 == 0) println(frameRate);
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
        strokeWeight(1);        
        stroke(120);
        line(a1.x, a1.y, a2.x, a2.y);
      }
    }
  }


  float closestDist = 100000000;
  // which circle is the closest?
  for (Atom a : atoms) {
    float newDist = dist(mouseX, mouseY, a.x, a.y);
    if (newDist < closestDist) {
      closest = a;
      closestDist = newDist;
    }
  }

  t.target = sys.nodes.indexOf(closest.node);

  if (frameCount % 1 == 0) t.update();  
  t.draw();

  ArrayList <Atom> children = new ArrayList(); 
  for (Atom a : atoms) {
    if (a.incoming.size() == 1) {
      Atom b = a.incoming.get(0);
      PVector dir = a.get();
      dir.sub(b);
      float ang = dir.heading() + PI;
      for (Atom other : atoms) {
        if (other != a) {
          PVector v = other.get();
          v.sub(a);
          float ang2 = v.heading() + PI;
          if (abs(ang-ang2) < 0.1) {

            float x_ = a.x - cos(ang) * floor(a.diam);
            float y_ = a.y - sin(ang) * floor(a.diam);

            fill(255, 255, 0);
            ellipse(x_, y_, 10, 10);
            if (frameCount % 5 == 0) children.add(new Atom(x_, y_));          
            break;
          }
        }
      }
    }
  }
  atoms.addAll(children);
  
  image(pg, 0, 0);
  
  //saveFrame("frames_2/frame-####.jpg");
}


void mouseReleased() {
  pg.beginDraw();
  pg.background(0,0);
  pg.endDraw();
}

void mouseDragged() {
  // create a radom set of parameters
  float newR = EDGE_LENGTH*.5;//random(5, 10);
  float newX = mouseX;//random(0+newR, width-newR);
  float newY = mouseY;//random(0+newR, height-newR);


  if (frameCount % 1 == 0) {
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
  
  pg.beginDraw();
  pg.stroke(0, 255, 0, 50);
  pg.line(mouseX, mouseY, pmouseX, pmouseY);
  pg.endDraw();
}

void mousePressed(MouseEvent e) {
  if (e.getClickCount()==2) {
    Atom newAtom = new Atom(mouseX, mouseY);
    atoms.add(newAtom);
  }
}

