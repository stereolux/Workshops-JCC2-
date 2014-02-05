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
    for (int i = 1; i < v.length; i++) {
      for (int j = 1; j < v[0].length; j++) {
        int im1 = (i == 0) ? v.length-1 : i-1;
        int ip1 = (i == v.length-1) ? 0 : i+1;
        int jm1 = (j == 0) ? v[0].length-1 : j-1;
        int jp1 = (j == v[0].length-1) ? 0 : j+1;
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
    float maxRot = -1;
    int iMax = -1, jMax = 1;
    for (int i = 0; i < v.length-1; i++) {
      for (int j = 0; j < v[0].length-1; j++) {
        int ip1 = i+1;
        int jp1 = j+1;
        PVector w = v[i][j].get().cross(new PVector(-1, -1));
        w.add(v[ip1][j].cross(new PVector(1, -1)));
        w.add(v[i][jp1].cross(new PVector(-1, 1)));
        w.add(v[ip1][jp1].cross(new PVector(1, 1)));
        rot[i][j] = w.mag()*5;
        if (rot[i][j] > maxRot) {
          maxRot = rot[i][j];
          iMax = i;
          jMax = j;
        }
      }
    }

    float dx = width/v.length;
    float dy = height/v[0].length;
    ps.emitter.set((iMax+1)*dx, (jMax+1)*dy);
  }

  void divergence() {
    float maxDv = 0;
    int iMax = -1, jMax = -1;
    for (int i = 0; i < v.length-1; i++) {
      for (int j = 0; j < v[0].length-1; j++) {
        int ip1 = i+1;
        int jp1 = j+1;
        dv[i][j] = 0;
        PVector w = v[i][j].get();
        dv[i][j] += w.dot(new PVector(-1, -1));
        w.set(v[ip1][j]);
        dv[i][j] += w.dot(new PVector(1, -1));
        w.set(v[i][jp1]);
        dv[i][j] += w.dot(new PVector(-1, 1));
        w.set(v[ip1][jp1]);
        dv[i][j] += w.dot(new PVector(1, 1));
        dv[i][j] *= 5;
        if (dv[i][j] > maxDv) {
          maxDv = dv[i][j];
          iMax = i; 
          jMax = j;
        }
        //dv[i][j] = abs(dv[i][j]);
      }
    }
  }

  void update() {
    //initVectors();
    smoothVectors(0.125);
    divergence();
    rotational();
  }

  void draw() {
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
        //int st = min(round(ang/frac), numStates-1);
        fill(map(degrees(ang), 0, 359, 300, 420)%360, 100, 100, 50); // porque 359?
        colorMode(RGB, 255, 255, 255);
        if (i % 5 == 0 || j % 9 == 0) 
        //rect((i+.5)*dx, (j+.5)*dy, dx*5, dy*5);

        //strokeWeight(3);
        //point((i+.5)*dx, (j+.5)*dy);
        strokeWeight(1);
        stroke(50);
        line((i+.5)*dx, (j+.5)*dy, (i+.5)*dx+v[i][j].x*l, (j+.5)*dy+v[i][j].y*l);

        noStroke();
        if (abs(dv[i][j]) > 5) { // in order to save frames
          if (dv[i][j] > 0) fill(255, 255, 100, 100);
          else fill(200, 200, 100, 100);
          ellipse((i+1)*dx, (j+1)*dy, dv[i][j]*5, dv[i][j]*5);
        }
        
        if (rot[i][j] > 5) { // in order to save frames
          fill(250, 100);
          pushMatrix();
          translate((i+1)*dx, (j+1)*dy);
          rotate(frameCount*.01*rot[i][j]);
          for (int n = 0; n < rot[i][j]*.75; n++) {
            float a = TWO_PI/floor(rot[i][j]*.75);
            rotate(a);
            rect(rot[i][j]*1.5, 0, rot[i][j]*0.5, rot[i][j]*0.25);
          }
          popMatrix();
        }


        //PVector w = new PVector(1, 0);
        //w.rotate(st*frac);
        //stroke(255, 0, 0);
        //line((i+.5)*dx, (j+.5)*dy, (i+.5)*dx+w.x*l, (j+.5)*dy+w.y*l);
      }
    }
  }

  PVector getVector(float x, float y) {
    float dx = width/v.length;
    float dy = height/v[0].length;
    return v[min(floor(x/dx),v.length-1)][min(floor(y/dy),v[0].length-1)];
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
  
  void twist(float x, float y) {
    int sg = random(-1,1) > 0 ? 1 : -1;
    float dx = width/v.length;
    float dy = height/v[0].length;    
    for (int i = 0; i < v.length; i++) {
      for (int j = 0; j < v[0].length; j++) {
        float d = dist(x, y, (i+.5)*dx, (j+.5)*dy);
        if (d < 150) {
          PVector w = new PVector((i+.5)*dx-x, (j+.5)*dy-y);
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

