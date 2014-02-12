////////////////////////////////////////////////
///////////Eric Languenou 2014        //////////
////////////////////////////////////////////////

//////// PGraphic 1 2D



//-------------var globales----------
PGraphics pg;
int nbPoints = 10000;




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
 // image(pg, 0, 0); 
  noLoop();
}//method
//----------------------------
void draw() {
  pg.loadPixels();
  int x, y;

  fill(153, 255, 0);
  for (int i = 0; i<nbPoints;i++) { 
    x = (int) random(width);
    y = (int)random(height);
    // print(".");   
    if ( pg.pixels[(y * width) +  x] != color(0)) {
      ellipse(x, y, 10, 10);
      //  print("_");
    }//end if
  }//end for i
}//method


