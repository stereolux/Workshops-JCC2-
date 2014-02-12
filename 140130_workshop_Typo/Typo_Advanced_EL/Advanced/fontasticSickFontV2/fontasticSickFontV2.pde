////////////////////////////////////////////////
///////////Eric Languenou 2014        //////////
////////////////////////////////////////////////
//////////////////////////DIFF N CIRCLES

import fontastic.*;
import geomerative.*;

//-------------var globales----------

RShape shp1;
RShape shp2;
RShape shp3;

Fontastic f;
RFont font;

PFont myFont;
int charWidth = 512;
int version = 0;



//----------------------------
void setup() {
  size(600, 400);
  fill(0);


  RG.init(this);

  // load the initial font
  font = new RFont("FreeSans.ttf", 150);                             
  RCommand.setSegmentLength(200);
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);
  RG.setPolygonizer(RG.ADAPTATIVE);

  f = new Fontastic(this, "sickFont" + nf(version, 4));

  for (char c : Fontastic.alphabet) {
    f.addGlyph(c);
  }

  for (char c : Fontastic.alphabetLc) {
    f.addGlyph(c);
  }
  f.setAuthor("Eric Languenou");
  f.setVersion("0.1");
  f.setAdvanceWidth(int(charWidth));

  generateFont();
}//method

//----------------------------
void draw() {
  background(255);
  translate(width/4., height/4.);
  if (mousePressed) {
    println(".");
    fill( 0, 220, 0, 30 );
    stroke( 0, 120, 0 );
    RG.shape(shpCircle);

    fill( 220, 0, 0, 30 );
    stroke( 120, 0, 0 );
    RG.shape(shp);
  }
  else {
    fill( 220 );
    stroke( 120 );
    RG.shape(shpDiff);
  }
}//method
//------------------------------
RShape shpCircle;
RShape shp;
RShape shpDiff;
int randomX = 30;
int randomY = 30;
//----------------------------- <<<<<<<<<<<
RShape subCircle(RShape rs) {
  RPoint center = shp.getCentroid(); 
  //println("centroid : " + center.x + "  "+ center.y);
  shpCircle = RShape.createCircle(0, 0, 20);
  shpCircle.translate(center.x + random(randomX), center.y + random(randomY));
  RShape shpDiff = RG.diff(rs, shpCircle);
  return(shpDiff);
}//end method
//----------------------------
RShape subCircleRec(RShape rs, int n) {
  if (n==0){
    return(rs);
  }
  else{
    return(subCircleRec( subCircle(rs),n-1));   
  }  
}//end method
//-----------------------------
void glyphTreat(char c) {


  RPoint[] pnts = new RPoint[0];

  println("generating character " + c);
  shp = font.toShape(c);
  translate(width/2, height/2);

  try {  
    //shpDiff = RG.diff(shp, shpCircle);
    //shpDiff =  subCircle(shp);  //<<<<<<<<<
    shpDiff =  subCircleRec(shp,3);  //<<<<<<<<<
    
    fill(0, 0, 127);
    RG.shape(shpDiff);  
    pnts = shpDiff.getPoints();
  }
  catch (NullPointerException e) {
    println("Problem with setSegmentOffset at Character "+c);
  }//end catch

  PVector[] points = new PVector[0];
  for (int i=0; i<pnts.length-1; i++) {
    RPoint p = pnts[i];
    points = (PVector[]) append(points, new PVector(p.x * 5, -p.y * 5));
  }
  f.getGlyph(c).clearContours();
  f.getGlyph(c).addContour(points);
}

//------------------------------
void generateFont() {

  shpCircle = RShape.createCircle(15, 0, 20);
  for (char c : Fontastic.alphabet) {
    glyphTreat(c);
  }//end for char c
  for (char c : Fontastic.alphabetLc) {
    glyphTreat(c);
  }//end for char c
}//end method
//-------------------------------
void keyPressed() {

  f.buildFont(); // write ttf file
  f.cleanup();   // delete all glyph files that have been created while building the font

  myFont = createFont(f.getTTFfilename(), 200); // set the font to be used for rendering
  println("font " + f.getTTFfilename() + " build");
}

