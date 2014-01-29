// cette fois ci nous allons attacher à créer un effet "lumineux"
// nous allons devoir créer un group de points pour chaque lettre
// puis nous pourrons définir un point d'ancrage et enfin nous relierons
// notre point d'ancrage à chaque point de notre groupe.


import geomerative.*;


RShape[] grp; // this time we use an array of groups
RPoint[] points;

void setup() {

  size(800, 400, P2D);
  frameRate(24);

  RG.init(this);

  grp = new RShape[12]; // initialize the size of our group array (size == number of letters)

  // for each letter we create a specific group of points
  for (int i = 0 ; i <12 ;i++) {
    switch(i) {
    case 0: 
      grp[i] = RG.getText("C", "FreeSans.ttf", 100, CENTER);
      break;
    case 1: 
      grp[i] = RG.getText("O", "FreeSans.ttf", 100, CENTER);
      break;
    case 2: 
      grp[i] = RG.getText("D", "FreeSans.ttf", 100, CENTER);
      break;
    case 3: 
      grp[i] = RG.getText("E", "FreeSans.ttf", 100, CENTER);
      break;
    case 4: 
      grp[i] = RG.getText(" ", "FreeSans.ttf", 100, CENTER);
      break;
    case 5: 
      grp[i] = RG.getText("C", "FreeSans.ttf", 100, CENTER);
      break;
    case 6: 
      grp[i] = RG.getText("R", "FreeSans.ttf", 100, CENTER);
      break;
    case 7: 
      grp[i] = RG.getText("E", "FreeSans.ttf", 100, CENTER);
      break;
    case 8: 
      grp[i] = RG.getText("A", "FreeSans.ttf", 100, CENTER);
      break;
    case 9: 
      grp[i] = RG.getText("T", "FreeSans.ttf", 100, CENTER);
      break;
    case 10: 
      grp[i] = RG.getText("I", "FreeSans.ttf", 100, CENTER);
      break;
    case 11: 
      grp[i] = RG.getText("F", "FreeSans.ttf", 100, CENTER);
      break;
    }
  }

  smooth();
}

void draw() {

  background(0);
  noFill();

  RG.setPolygonizerStep(2);
  RG.setPolygonizerLength(3);

  // for each group we get the points
  for (int i =0 ; i < 12 ; i++) {
    points = grp[i].getPoints();
    pushMatrix();
    translate(width*(i+1)/13, 3*height/4); // translatation now depends on "i" ie the letter we are drawing

    fill(0, 50);
    strokeWeight(5);
    stroke(255, 10);
    
    if (points != null) {   
      // now we draw our lines
      for (int j=0; j<points.length; j++) {  
        line(0, -200, points[j].x, points[j].y); // fixed point depending on the translate command above
        // try uncommenting the following line
        //line(mouseX-width/2, mouseY-height/2, points[j].x, points[j].y);
      }
    }
    popMatrix();
  }
}

void keyPressed() {
  if (key == 's') {
    saveFrame("CreativeCoding.png");
  }
}

