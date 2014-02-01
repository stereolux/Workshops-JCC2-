// Dependencies: mesh library by Lee Byron
// the mesh library is available here: http://leebyron.com/else/mesh/

import megamu.mesh.*;

MPolygon[] arrondissements;
int numArrondissements = 20; // the 20 arrondissements of paris
int numExtraPoints = 15; // for adding some outer extra points for correcting the oval shape of central paris

Arrondissement[] arrt; // arrondissement object holding data

ArrayList data_titles; // titles of the different datasets
int selected_dataset = 0;

void setup() {
  
  size(960, 960);
  
  data_titles = new ArrayList<String>();  // Create an empty ArrayList
  
  float[][] points = new float[numArrondissements + numExtraPoints][2];
  // add the arrondissements centers in a spiral, counter-clockwise order
  for (int i = 0; i < numArrondissements; i++) {
    points[i][0] = width/2 + width/50.0 * i * sin(PI - 2.3 * TWO_PI * i/numArrondissements); // ith point, x
    points[i][1] = height/2 + height/50.0 * i * cos(PI - 2.3 * TWO_PI * i/numArrondissements); // ith point, y
  }
  for (int i = numArrondissements; i < numArrondissements+numExtraPoints; i++) {
    points[i][0] = width/2 + width * 0.6 * sin(- TWO_PI * i/numExtraPoints); // ith point, x
    points[i][1] = height/2 + height * 0.6 * cos(- TWO_PI * i/numExtraPoints); // ith point, y
  }
  Voronoi parisVoronoi = new Voronoi( points );
  arrondissements = parisVoronoi.getRegions();
  
  arrt = new Arrondissement[numArrondissements];
  for (int i = 0; i < arrt.length; i++) {
    arrt[i] = new Arrondissement();
  }

  
  readCSV("1004.csv");
}

void draw() {
background(230);
  for (int i = 0; i < numArrondissements; i++)
  {
    fill(2.55 * arrt[i].getDataPercent( (String) data_titles.get(selected_dataset) ));
    stroke(255);
    arrondissements[i].draw(this); // draw this shape
    
    fill(0);
    stroke(0);
    // an array of points
    float[][] regionCoordinates = arrondissements[i].getCoords();
    float[] center = new float[2];
    for (int j = 0; j < regionCoordinates.length; j++) {
      center[0] += regionCoordinates[j][0];
      center[1] += regionCoordinates[j][1];
    }
    center[0] /= regionCoordinates.length;
    center[1] /= regionCoordinates.length;
    text(i+1, center[0], center[1]);
  }
  stroke(0);
  text("dataset: " + data_titles.get(selected_dataset), 10, 10);
}


void keyPressed() {
  if(keyCode == RIGHT) selected_dataset++;
  else if(keyCode == LEFT) selected_dataset--;
  
  selected_dataset = abs(selected_dataset%data_titles.size());

}
