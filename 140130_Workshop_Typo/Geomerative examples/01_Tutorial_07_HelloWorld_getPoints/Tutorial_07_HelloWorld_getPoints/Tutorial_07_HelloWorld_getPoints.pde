
// import library
import geomerative.*;

// declare two objects specific to geomerative accessible all over the sketch
RShape grp; // object to load a string, a font amongst others
RPoint[] points; // an array of points ie coordinates

void setup() {
  // Initilaize the size of the window
  size(600, 400);
  // Choice of colors
  background(255);
  fill(255, 102, 0);
  stroke(0);

  // Initialize library
  RG.init(this);  
  //  Load the string we want to display, font file we want to use 
  //(the file must be in the data folder in the sketch floder),
  // with the size 60 and the alignment CENTER
  grp = RG.getText("Hello world!", "FreeSans.ttf", 72, CENTER);

  // Enable smoothing
  smooth();
}

void draw() {
  // Clean frame
  background(255);

  // Set the origin to draw in the middle of the sketch
  translate(width/2, 3*height/4);

  // Draw the group of shapes ie the string !
  noFill();
  stroke(0, 0, 200, 150);
  grp.draw();

  // Get the points on the curve's shape
  RG.setPolygonizerLength(map(mouseY, 0, height, 3, 200));
  points = grp.getPoints();

  // If there are any points
  if (points != null) {
    fill(0);
    stroke(0);   
    // loop through the points and draw and ellipse at the correct coordinates
    for (int i=0; i<points.length; i++) {
      ellipse(points[i].x, points[i].y, 10, 10);
    }
  }
}

