// Avec une forme géométrique basique, on peut créer une image très riche. Il suffit de 
// dessiner beaucoup de formes se supperposant avec un peu de transparence.
// Dans cet exemple nous allons dessiner le mot processing avec un triangle, symbole du 
// bouton "run" ci-dessus.

import geomerative.*;

RShape grp;
RPoint[] points;

// we add a PShape object, with this object we can create a shape using vertices
// and store it in memory to recall it easily and fast ! (new feature in p 2.0)
PShape tri ;

void setup() {
  size(650, 400,P2D); // notice the "P2D" mode needed to create our PShape
  smooth();
  // Choice of colors
  background(0);
  colorMode(HSB, 360, 100, 100);
 
  RG.init(this);
  grp = RG.getText("Processing", "FreeSans.ttf", 120, CENTER);
  
  // create a new shape (a triangle)
  tri = createShape(); // we will specify a shape
  tri.disableStyle(); // no predefined styles they will be set before the drawing
  tri.beginShape(); // ok we start the shape !
  // we use polar coordinates and loop to specify 3 vertices (a triangle then)
  for (float i=0; i<=TWO_PI ; i+=TWO_PI/3) {
    // our shape will be centered, radius is hard-coded here (==20)
    float xpos = 20 * cos(i);
    float ypos = 20 * sin(i);
    tri.vertex(xpos, ypos);
  }
  tri.endShape(CLOSE);// we need to close our shape
}

void draw() {
  background(0);
  translate(width/2, height/2);
  
  stroke(0, 0, 0);
  fill(30, 100, 100,200);

  RG.setPolygonizerLength(0);
  points = grp.getPoints();

  if (points != null) {
    for (int i=0; i<points.length; i+=1) {
      shape(tri, points[i].x, points[i].y);    
    }
  }
}

//handle key event
void keyPressed() {
  if (key == 's') { 
    saveFrame("font-"+minute()+"m"+second()+"s"+millis()+".png"); // save our image with a time tag
  }
}

