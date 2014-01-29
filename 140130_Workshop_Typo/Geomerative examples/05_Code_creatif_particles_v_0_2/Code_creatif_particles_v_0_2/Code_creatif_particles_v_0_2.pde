// Maintenant nous allons utiliser une classe, ou plutôt deux, puisque pour chaque point nous allons dessiner un système à particules
// L'écriture des classes décrivant le système à particules sort du cadre de ce workshop, mais processing regorge de ressources sur le web
// une excellente introduction aux systèmes particules à été écrité par Daniel Shiffman

import geomerative.*;

RShape grp;
RPoint[] points;

Particle_sys[] ps; // an array of objects coming from our class

void setup() { 
  size(800, 400, P2D);


  fill(255, 102, 0);
  stroke(0);
  colorMode(HSB, 360, 100, 100);

  RG.init(this);
  //  Load the font file we want to use (the file must be in the data folder in the sketch floder), with the size 60 and the alignment CENTER
  grp = RG.getText("CODE CREATIF", "FreeSans.ttf", 90, CENTER);
  RG.setPolygonizerLength(5);
  RG.setPolygonizerStep(1);

  // we will gets our points right now to draw a small particle system at each point
  points = grp.getPoints();
  ps = new Particle_sys[points.length];

  for (int i=0; i<points.length ; i++) {
    // we create a particle system at each point coordinate, with a specific color, each ps
    // will hold 15 particles.
    ps[i] = new Particle_sys(points[i].x, points[i].y, color(random(360), 0, 100, 180), 15);
  }

  // Enable smoothing
  smooth();
  background(0);
}

void draw() {
  // this effect is a cheap blur, its intensity is based on position of the mouse
  float alpha = map(mouseX, 0, width, 10, 255);
  fill(0, alpha);
  noStroke();
  rect(0, 0, width, height);

  // Set the origin to draw in the middle of the sketch
  translate(width*1/2, 3*height/4);

  // Draw the group of shapes
  noFill();
  stroke(0, 0, 200, 150);

  if (points != null) {
    for (int i=0; i<points.length ; i++) {
      // call the mehods of each particle system to calculate position of each particle
      // and display them.
      ps[i].run(); 
      ps[i].display();
      if (mousePressed) {
        ps[i].reset();
      }
    }
  }
}


void keyPressed() {
  if (key == 's') {
    saveFrame("Particules.png");
  }
}





