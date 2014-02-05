// Algorithmes créatifs - Abelardo Gil-Fournier, 2014
// http://abelardogfournier.org
// http://github.org/abe-
//
// This class builds a grid of vectors, and provides with a 
// function to initialize them following a noise field of values,
// as a way to start with a field that has a natural appearance.

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
  
  void update() {
    initVectors();         // As a movement effect, we'll update
  }                        // the noise function with frameCount
  
  void draw() {
    for (int i = 0; i < v.length; i++) {
      for (int j = 0; j < v[0].length; j++) {
        float x = (i+.5)*dx;
        float y = (j+.5)*dy;
        
        beginShape(LINES);    // Here we represent vectors as
        stroke(200);          // stroke gradients. 
        vertex(x, y);
        stroke(200, 0);
        vertex(x+v[i][j].x*l, y+v[i][j].y*l);
        endShape();
      }
    }    
  }
  
}
