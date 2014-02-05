// Algorithmes créatifs - Abelardo Gil-Fournier, 2014
// http://abelardogfournier.org
// http://github.org/abe-

class VectorField {

  PVector[][] v;
  float l = 10;
  float dx, dy;

  VectorField(int dimX, int dimY) {
    v = new PVector[dimX][dimY];
    for (int i = 0; i < v.length; i++) {
      for (int j = 0; j < v[0].length; j++) {
        v[i][j] = new PVector();
      }
    }

    dx = (float) width/dimX;
    dy = (float) height/dimY;

    initVectors();
  }

  void initVectors() {
    for (int i = 0; i < v.length; i++) {
      for (int j = 0; j < v[0].length; j++) {
        float x = (i+.5)*dx + frameCount;
        float y = (j+.5)*dy + frameCount;
        float vx = noise(x*0.01, y*0.01)-.5;
        float vy = noise((x+width)*0.01, y*0.01)-.5;
        v[i][j].set(vx, vy);
        v[i][j].normalize();
      }
    }
  }

  void smoothVectors(float f) {
   for (int i = 0; i < v.length; i++) {
      for (int j = 0; j < v[0].length; j++) {
        int im1 = (i == 0) ? v.length-1 : i-1;
        int ip1 = (i == v.length-1) ? 0 : i+1;
        int jm1 = (j == 0) ? v[0].length-1 : j-1;
        int jp1 = (j == v[0].length-1) ? 0 : j+1;
        
        PVector w = v[im1][j].get();
        w.add(v[ip1][j]);
        w.add(v[i][jm1]);
        w.add(v[i][jp1]);
        w.mult(.25*f);
        
        v[i][j].mult(1-f);
        v[i][j].add(w);
        v[i][j].normalize(); // reduntant. just in case
      }
    }
  }

  void update() {
   smoothVectors(0.25);   // The smoothing factor determines the
  }                       // the proportion of the neighbours
                          // effect in relation to the own value
  void draw() {
    for (int i = 0; i < v.length; i++) {
      for (int j = 0; j < v[0].length; j++) {
        float x = (i+.5)*dx;
        float y = (j+.5)*dy;
      
        float ang = v[i][j].heading()+PI; // Let's visualize with
        int st = round(ang/(TWO_PI/6.));  // colors the directions
        colorMode(HSB, 360, 100, 100);    // of vectors in the VF
        fill(map(st, 0, 5, 300, 400)%360, 70, 100);
        rectMode(CENTER);
        rect(x, y, dx, dy);
        
        colorMode(RGB);
        beginShape(LINES);
        stroke(200);
        vertex(x, y);
        stroke(200, 0);
        vertex(x+v[i][j].x*l, y+v[i][j].y*l);
        endShape();
      }
    }
  }

  void modify(float x, float y, float px, float py) {
    for (int i = 0; i < v.length; i++) {
      for (int j = 0; j < v[0].length; j++) {
        float d = dist(x, y, (i+.5)*dx, (j+.5)*dy);
        if (d < 50) {
          PVector w = new PVector(x-px, y-py);
          w.normalize();
          w.mult(1-d/50.);
          v[i][j].add(w);
          v[i][j].normalize();
        }
      }
    }
  }
}

