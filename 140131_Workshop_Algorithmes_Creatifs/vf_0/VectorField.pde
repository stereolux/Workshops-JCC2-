class VectorField {

  PVector[][] v;
  float l = 10;

  VectorField(int dimX, int dimY) {
    v = new PVector[dimX][dimY];
    for (int i = 0; i < v.length; i++) {
      for (int j = 0; j < v[0].length; j++) {
        v[i][j] = new PVector();
      }
    }
    initVectors();
  }

  void initVectors() {
    float sc = 0.01;
    float dx = width/v.length;
    float dy = height/v[0].length;
    for (int i = 0; i < v.length; i++) {
      for (int j = 0; j < v[0].length; j++) {
        float x = (i+.5)*dx+frameCount;
        float y = (j+.5)*dy+frameCount;
        v[i][j].set(noise(x*sc, y*sc)-.5, noise((width+x)*sc, y*sc)-.5);
        v[i][j].normalize();
      }
    }
  }

  void draw() {
    initVectors();
    float dx = width/v.length;
    float dy = height/v[0].length;
    for (int i = 0; i < v.length; i++) {
      for (int j = 0; j < v[0].length; j++) {
        strokeWeight(3);
        point((i+.5)*dx, (j+.5)*dy);
        strokeWeight(1);
        line((i+.5)*dx, (j+.5)*dy, (i+.5)*dx+v[i][j].x*l, (j+.5)*dy+v[i][j].y*l);
      }
    }
  }
}

