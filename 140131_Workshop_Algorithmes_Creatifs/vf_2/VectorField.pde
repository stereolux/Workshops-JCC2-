class VectorField {

  PVector[][] v;
  float[][] dv, rot;
  float l = 10;

  VectorField(int dimX, int dimY) {
    v = new PVector[dimX][dimY];
    dv = new float[dimX][dimY];
    rot = new float[dimX][dimY];
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

  void smoothVectors(float f) {
    for (int i = 1; i < v.length-1; i++) {
      for (int j = 1; j < v[0].length-1; j++) {
        int im1 = i-1;
        int ip1 = i+1;
        int jm1 = j-1;
        int jp1 = j+1;
        PVector w = v[im1][j].get();
        w.add(v[ip1][j]);
        w.add(v[i][jm1]);
        w.add(v[i][jp1]);
        w.mult(.25*f);
        v[i][j].mult(1.-f);
        v[i][j].add(w);
        v[i][j].normalize();
      }
    }
  }

  void rotational() {
    for (int i = 0; i < v.length-1; i++) {
      for (int j = 0; j < v[0].length-1; j++) {
        int ip1 = i+1;
        int jp1 = j+1;
        PVector w = v[i][j].get().cross(new PVector(-1,-1));
        w.add(v[ip1][j].cross(new PVector(1,-1)));
        w.add(v[i][jp1].cross(new PVector(-1,1)));
        w.add(v[ip1][jp1].cross(new PVector(1,1)));
        rot[i][j] = w.mag()*5;
      }
    }
  }

  void divergence() {
    for (int i = 0; i < v.length-1; i++) {
      for (int j = 0; j < v[0].length-1; j++) {
        int ip1 = i+1;
        int jp1 = j+1;
        dv[i][j] = 0;
        PVector w = v[i][j].get();
        dv[i][j] += w.dot(new PVector(-1,-1));
        w.set(v[ip1][j]);
        dv[i][j] += w.dot(new PVector(1,-1));
        w.set(v[i][jp1]);
        dv[i][j] += w.dot(new PVector(-1,1));
        w.set(v[ip1][jp1]);
        dv[i][j] += w.dot(new PVector(1,1));
        dv[i][j] *= 5;
        dv[i][j] = abs(dv[i][j]);
      }
    }
  }

  void draw() {
    //initVectors();
    smoothVectors(0.25);
    divergence();
    rotational();
    float dx = width/v.length;
    float dy = height/v[0].length;
    int numStates = 6;
    float frac = TWO_PI/numStates;
    for (int i = 0; i < v.length; i++) {
      for (int j = 0; j < v[0].length; j++) {
        rectMode(CENTER);
        noStroke();
        colorMode(HSB, 360, 100, 100);
        float ang = v[i][j].heading()+PI;
        int st = min(round(ang/frac), numStates-1);
        fill(map(degrees(st*frac), 0, 359, 300, 420)%360, 100, 100); // porque 359?
        colorMode(RGB, 255, 255, 255);
       // rect((i+.5)*dx, (j+.5)*dy, dx, dy);

        strokeWeight(3);
        point((i+.5)*dx, (j+.5)*dy);
        strokeWeight(1);
        stroke(0);
        line((i+.5)*dx, (j+.5)*dy, (i+.5)*dx+v[i][j].x*l, (j+.5)*dy+v[i][j].y*l);
              
        if (dv[i][j] > 5) { // in order to save frames
          fill(255, 255, 100);
          ellipse((i+1)*dx, (j+1)*dy, dv[i][j], dv[i][j]);
        }
        if (rot[i][j] > 5) { // in order to save frames
          fill(0, 255, 255);
          ellipse((i+1)*dx, (j+1)*dy, rot[i][j], rot[i][j]);
        }
        
        PVector w = new PVector(1, 0);
        w.rotate(st*frac);
        stroke(255, 0, 0);
        //line((i+.5)*dx, (j+.5)*dy, (i+.5)*dx+w.x*l, (j+.5)*dy+w.y*l);
      }
    }
  }

  void modify() {
    float dx = width/v.length;
    float dy = height/v[0].length;
    for (int i = 0; i < v.length; i++) {
      for (int j = 0; j < v[0].length; j++) {
        float d = dist(mouseX, mouseY, (i+.5)*dx, (j+.5)*dy);
        if (d < 50) {
          PVector w = new PVector(mouseX-pmouseX, mouseY-pmouseY);
          w.normalize();
          w.mult(1-d/50.);
          v[i][j].add(w);
          v[i][j].normalize();
        }
      }
    }
  }
}

