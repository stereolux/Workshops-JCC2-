////////////////////////////////////////////////
///////////Eric Languenou 2014        //////////
////////////////////////////////////////////////

//////// PGraphic 1 3D placement de forme et  animation

import peasy.*;

//-------------var globales----------
PeasyCam cam;

PGraphics pg;
int nbPoints = 100;
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
float noiseScale = 0.2;
float amp = 20;
//----------------------------
void draw() {
  rotateX(-.5);
  rotateY(-.5);
  background(255);
  noFill();
  stroke(0);
  strokeWeight(1);
  float dep = amp * noise(frameCount*noiseScale);

  for (int i = 0; i<nbPoints;i++) { 
    fill(153, 255, 0);
    ellipse(PointsArray[i].x, PointsArray[i].y, 10, 10);
    noFill();
    bezier(
    PointsArray[i].x , PointsArray[i].y, 0,
    PointsArray[i].x, PointsArray[i].y, 20, 
    PointsArray[i].x + dep, PointsArray[i].y + dep, 40, 
    PointsArray[i].x +2*dep, PointsArray[i].y +2*dep, 60
      );
//    beginShape();
//    vertex(PointsArray[i].x, PointsArray[i].y, 0);
//    vertex(PointsArray[i].x + 0.5*dep, PointsArray[i].y +0.5*dep, 10);
//    vertex(PointsArray[i].x + dep, PointsArray[i].y + dep, 40);
//    vertex(PointsArray[i].x +2*dep, PointsArray[i].y +2*dep, 60);
//    endShape();
  }//end for
}//method

