////////////////////////////////////////////////
///////////version de base arrow typo //////////
///////////Eric Languenou 2014        //////////
////////////////////////////////////////////////

import java.util.Iterator;
import toxi.geom.*;
import geomerative.*;

//------variables globales------------
RFont font;
int nbPoints = 400;
float svgScale = 15.;

Vec2D Mv1 ;
Vec2D Mdir;

RGroup grp;

RPoint[]  pnts; 
RPoint []  tgs;
PShape s;
//-----end global---------
//////////////////////////////////////////
void setup() {
  size(1200, 800);
  background(0);
  smooth();
  
  RG.init(this);

  font = new RFont( "FreeSans.ttf", 100, RFont.CENTER);
  grp = font.toGroup("TYPOGRAPHIE");
  s = loadShape("arrow_v1.svg");

  pnts = new RPoint[nbPoints]; 
  tgs = new RPoint[nbPoints];

  RCommand.setSegmentLength(25);
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);
  
  grp.getPoints();
  grp.getTangents();  
  
  println("segmentor initialized");
  for (int i = 0; i < nbPoints; i++ ) {
    pnts[i] = grp.getPoint(float(i)/float(nbPoints));
    tgs[i] = grp.getTangent(float(i)/float(nbPoints));
  }//end for i
  noLoop();
}
//////////////////////////////////////////
void draw() {
 noFill();      
 int nbPointDrawn = nbPoints;
  translate(width/2, height/2);
  if (grp.getWidth() > 0) {
    for (int i = 0; i < nbPointDrawn; i++ ) {
      pushMatrix();
      translate(pnts[i].x, pnts[i].y);
      Mv1 = new Vec2D(0, 0);
      Mdir = new Vec2D(tgs[i].x, tgs[i].y); 
      Mdir = Mdir.getNormalized();
      rotate(atan2(Mdir.y, Mdir.x ));
           shape(s, 0, 0, svgScale, svgScale);  //print(i+";");
      popMatrix();
    }
  } 
  else {
    println("grp width = 0");
  } 
}
//-------------------

