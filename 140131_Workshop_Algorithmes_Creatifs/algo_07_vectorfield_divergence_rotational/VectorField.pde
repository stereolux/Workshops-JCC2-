class VectorField {

  PVector[][] v;
  float l = 10;
  float dx, dy;
  float[][] dv, rot;

  VectorField(int dimX, int dimY) {
    v = new PVector[dimX][dimY];
    dv = new float[dimX][dimY];
    rot = new float[dimX][dimY];
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

  // This function calculates at each point the so-called 
  // divergence of the field in that point. The divergence is
  // a measure of the expansion/contraction of the field
  // in each point of the field.
  // In order to calculate divergence, we sum dot products.
  void divergence() {
    for (int i = 0; i < v.length; i++) {
      for (int j = 0; j < v[0].length; j++) {
        int ip1 = (i == v.length-1) ? 0 : i+1;
        int jp1 = (j == v[0].length-1) ? 0 : j+1;
        dv[i][j] = 0;
        PVector w = v[i][j].get();
        dv[i][j] += w.dot(new PVector(-1, -1));
        w.set(v[ip1][j]);
        dv[i][j] += w.dot(new PVector(1, -1));
        w.set(v[ip1][jp1]);
        dv[i][j] += w.dot(new PVector(1, 1));
        w.set(v[i][jp1]);
        dv[i][j] += w.dot(new PVector(-1, 1));
      }
    }
  }

  // This function calculates at each point the magnitude of the 
  // rotational of the field in that point. The rotational is
  // a measure of how the field is twisted in each point of 
  // the field.
  // In order to calculate rotationals, we sum cross products.
  void rotational() {
    for (int i = 0; i < v.length; i++) {
      for (int j = 0; j < v[0].length; j++) {
        int ip1 = (i == v.length-1) ? 0 : i+1;
        int jp1 = (j == v[0].length-1) ? 0 : j+1;
        PVector w = v[i][j].get().cross(new PVector(-1, -1));
        w.add(v[ip1][j].cross(new PVector(1, -1)));
        w.add(v[ip1][jp1].cross(new PVector(1, 1)));
        w.add(v[i][jp1].cross(new PVector(-1, 1)));
        rot[i][j] = w.mag();
      }
    }
  }

  void update() {
    smoothVectors(0.025);
    divergence();
    rotational();
  }

  void draw() {
    for (int i = 0; i < v.length; i++) {
      for (int j = 0; j < v[0].length; j++) {
        float x = (i+.5)*dx;
        float y = (j+.5)*dy;

        // Let's display the points where the divergence
        // of the field has a large magnitude, differentiating
        // between positive divergence (the field is in expansion)
        // or negative (contracting)
        if (abs(dv[i][j]) > 1) {
          if (dv[i][j] > 0) fill(255, 255, 100, 100);
          else fill(155, 155, 100, 100);
          float f = 20;
          ellipse((i+1)*dx, (j+1)*dy, dv[i][j]*f, dv[i][j]*f);
        }
        
        // Let's display now the points where the rotational
        // is big enough.
        if (abs(rot[i][j]) > 1) {
          fill(255, 100);
          pushMatrix();
          translate(x, y);
          rotate(frameCount*0.01*rot[i][j]*5);
          float num = map(rot[i][j], 0, 4, 0, 6);
          for (int n = 0; n < num; n++) {
            float a = TWO_PI/num;
            rotate(a);
            rect(rot[i][j]*7.5, 0, rot[i][j]*2.5, rot[i][j]*1.25);
          }
          popMatrix();
        }

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

  void twist(float x, float y) {
    float sg = random(-1, 1) > 0 ? 1 : -1;
    for (int i = 0; i < v.length; i++) {
      for (int j = 0; j < v[0].length; j++) {
        float d = dist(x, y, (i+.5)*dx, (j+.5)*dy);
        if (d < 150) {
          PVector w = new PVector((i+.5)*dx - x, (j+.5)*dy - y);
          w.normalize();
          if (sg > 0) w.set(-w.y, w.x);
          else w.set(w.y, -w.x);
          w.mult(2);
          v[i][j].add(w);
          v[i][j].normalize();
        }
      }
    }
  }
}

