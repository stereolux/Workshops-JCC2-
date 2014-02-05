// int
// sin, cos, atan2
// distMin
// append

float[] x, y;
float estado;
float x2, y2, ancho2;

void setup() {
  size(600, 600);
  x = new float[1];
  y = new float[x.length];
  x[0] = width/2;
  y[0] = height/2; 
  
  x2 = 10;
  y2 = 10;
  ancho2 = 0;
}

void draw() {
  background(255);
  
  line(x2, y2, x2+ancho2, y2);
  ancho2 = ancho2 + 6;
  if (ancho2 > 50) {
    estado = 1;
    ancho2 = 0;
  }
  else {
    estado = 0;
  }
  
  if (estado == 1) {
    float angle = random(0, TWO_PI);
    float nuevoX = width/2 +300*cos(angle);
    float nuevoY = height/2+300*sin(angle);
    float distMin = 1000000;
    int nMin = 0;
    for (int n = 0; n < x.length; n++) {
      float d = dist(nuevoX, nuevoY, x[n], y[n]);
      if (d < distMin) {
        distMin = d;
        nMin = n;
        angle = atan2(nuevoY-y[n], nuevoX-x[n]);
      }
    }
    nuevoX = x[nMin] + 10*cos(angle);
    nuevoY = y[nMin] + 10*sin(angle);
    
    x = append(x,nuevoX);
    y = append(y,nuevoY);
  }
  
  for (int n = 0; n < x.length; n++) {
    ellipse(x[n], y[n], 10, 10);
  }
}

void mouseReleased() {
  save("dla.jpg");
}
