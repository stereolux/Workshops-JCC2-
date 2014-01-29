// L'exercice ici est le même, la seule variante et que nous voulons pouvoir obtenir une
// image avec un fond transparent pour pouvoir l'utiliser dans d'autres logiciels de création
// graphique

import geomerative.*;

RFont f;
RShape grp;
RPoint[] points;
PShape tri ;
// create an object to be able to write an image
PGraphics pg;

void setup() {
  size(900, 400, P2D);
  frameRate(24);
  background(0);
  colorMode(HSB, 360, 100, 100);
  smooth();


  pg = createGraphics(900, 400, JAVA2D);//notice the mode to support export with no background !
  pg.smooth();

  RG.init(this);
  grp = RG.getText("PROCESSING", "FreeSans.ttf", 120, CENTER);


  tri = createShape();
  tri.disableStyle();
  tri.beginShape();
  for (float i=0; i<=TWO_PI ; i+=TWO_PI/3) {
    float xpos = 12 * cos(i);
    float ypos = 12 * sin(i);
    tri.vertex(xpos, ypos);
  }
  tri.endShape(CLOSE);
}

void draw() {
  background(0);

  RG.setPolygonizerLength(0);
  points = grp.getPoints();
  // we just add "pg." before each drawing function (the colored ones)
  // but first we need to say we are starting to draw
  pg.beginDraw();
  pg.translate(width/2, height/2);
  pg.colorMode(HSB, 360, 100, 100); // we nee to recallit each frame
  pg.fill(25, 100, 100);
  pg.stroke(0);

  if (points != null) {
    for (int i=0; i<points.length; i+=1) {
      pg.shape(tri, points[i].x, points[i].y);
    }
  }
  pg.endDraw();

  image(pg, 0, 0);
}

//handle key event
void keyPressed() {
  if (key == 's') { 
    pg.save("font-"+minute()+"m"+second()+"s"+millis()+".png"); // save our image with a time tag
  }
}

