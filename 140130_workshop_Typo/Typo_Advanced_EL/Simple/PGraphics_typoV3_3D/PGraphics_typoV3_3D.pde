////////////////////////////////////////////////
///////////Eric Languenou 2014        //////////
////////////////////////////////////////////////

//////// PGraphic 1 3D placement de forme 

import peasy.*;

//-------------var globales----------
PeasyCam cam;

PGraphics pg;
int nbPoints = 1000;
PVector[] PointsArray;

int pgWidth = 800;
int pgHeight = 300;

//----------------------------
void setup() {
  size(800, 500, P3D);
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(30);
  cam.setMaximumDistance(800);

  pg = createGraphics(pgWidth, pgHeight);
  pg.beginDraw();
  pg.background(0);
  pg.fill(255);
  pg.textSize(155);
  pg.text("Stereolux", 40, 200);
  pg.endDraw();
  pg.loadPixels();
  
  PointsArray = new PVector[nbPoints];
  initPointsArray(nbPoints);
}//method
//---------------------------
void initPointsArray(int n) {
  pg.loadPixels();
  int x, y;
  int i = 0;
  while (i < n) {

    x = (int) random(pgWidth);
    y = (int) random(pgHeight); 
    if ( pg.pixels[(y * width) +  x] != color(0)) {
      //we 've got a winner;
      println("# " + i);
      PointsArray[i] = new PVector(x - pgWidth/2., y - pgHeight/2.);
      i++;
    }//end if
  }//end while
}//end method

//----------------------------
void draw() {
  rotateX(-.5);
  rotateY(-.5);
  background(0);
  fill(153, 255, 0);

  for (int i = 0; i<nbPoints;i++) { 
    ellipse(PointsArray[i].x, PointsArray[i].y, 10, 10);
  }//end for
}//method

