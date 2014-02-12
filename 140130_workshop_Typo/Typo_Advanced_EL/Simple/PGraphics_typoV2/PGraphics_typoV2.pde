////////////////////////////////////////////////
///////////Eric Languenou 2014        //////////
////////////////////////////////////////////////

//////// PGraphic 1 2D placement de forme svg et sauvegarde pdf

import processing.pdf.*;


//-------------var globales----------
PGraphics pg;
int nbPoints = 7000;
PShape s;  //<<<<<<<<<<
float svgScale = 13;




//----------------------------
void setup() {
  size(800, 300);
  pg = createGraphics(width, height);
  pg.beginDraw();
  pg.background(0);
  pg.fill(255);
  pg.textSize(155);
  pg.text("Stereolux", 40, 200);
  pg.endDraw();
  pg.loadPixels();
  //s = loadShape("star.svg");//<<<<<<<<<<<<<<<<<<<
  s = loadShape("starStroke.svg");//<<<<<<<<<<<<<<<<<<<
 
  noLoop();
}//method
//----------------------------
void draw() {
  beginRecord(PDF, "typo_stars.pdf"); 
  background(255);
  pg.loadPixels();
  int x, y;

  fill(255, 0, 0);
  for (int i = 0; i<nbPoints;i++) { 
    x = (int) random(width);
    y = (int)random(height);
  
    if ( pg.pixels[(y * width) +  x] != color(0)) {
      //ellipse(x, y, 10, 10);
      shape(s, x, y, svgScale, svgScale); 
      

    }//end if
  }//end for i
  endRecord();
}//method


