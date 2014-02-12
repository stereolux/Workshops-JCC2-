////////////////////////////////////////////////
///////////version animée arrow typo //////////
///////////Eric Languenou 2014        //////////
////////////////////////////////////////////////

import java.util.Iterator;
import toxi.geom.*;
import geomerative.*;

//------variables globales------------
RFont font;
int nbPoints = 400;

Vec2D Mv1 ;
Vec2D Mdir;

RGroup grp;

//-----end global---------
//////////////////////////////////////////
void setup() {
  size(1200, 800);
  background(0);
  RG.init(this);
  smooth();

  font = new RFont( "FreeSans.ttf", 100, RFont.CENTER);
  grp = font.toGroup("TYPOGRAPHIE");
  fontInit();
}
//////////////////////////////////////////
void draw() {
  noFill();      
  fontDraw();
}
//////////////////////////////////////////
RPoint[]  pnts; 
RPoint []  tgs;
PShape s;
//////////////////////////////////////////
void fontInit()
{
  s = loadShape("arrow_v1.svg");

  pnts = new RPoint[nbPoints]; 
  tgs = new RPoint[nbPoints];

  //--- reglage du decoupage des contours
  RCommand.setSegmentLength(25);
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);
  println("segmentor initialized");

  //--recuperation des points et tangentes sur la totalité des contours
  for (int i = 0; i < nbPoints; i++ ) {
    pnts[i] = grp.getPoint(float(i)/float(nbPoints));
    tgs[i] = grp.getTangent(float(i)/float(nbPoints));
  }//end for i
}//end method
//////////////////////////////////////////
void fontDraw()
{

  int nbPointDrawn;
  //---mapping entre mouseX et le nombre de points sur le contour

  float limiteDown = width/4;
  float limiteUp =   width/2;
  if      (mouseX < limiteDown ) {
    nbPointDrawn = nbPoints;
  }
  else if ((mouseX > limiteDown) && (mouseX < limiteUp)) {
    nbPointDrawn = (int) map(mouseX, limiteDown, limiteUp, nbPoints, nbPoints/6);
  }
  else {//ici mouseX > limiteUp
    nbPointDrawn = nbPoints/6;
  }

  //println("nb :" + nbPointDrawn);       

  translate(width/2, height/2);
  if (grp.getWidth() > 0) {
    for (int i = 0; i < nbPointDrawn; i++ ) {
      pushMatrix();
      translate(pnts[i].x, pnts[i].y);
      Mv1 = new Vec2D(0, 0);
      Mdir = new Vec2D(tgs[i].x, tgs[i].y); 
      Mdir = Mdir.getNormalized();
      rotate(atan2(Mdir.y, Mdir.x ));
      //--l'echelle est randomisée en fonction de la position de la souris
      float svgScale = 10. + random(((float)width)*((float) mouseX/width));
      shape(s, 0, 0, svgScale, svgScale);  //print(i+";");
      popMatrix();
    }
  } 
  else {
    println("grp width = 0");
  } 
}
//////////////////////////////////////////
