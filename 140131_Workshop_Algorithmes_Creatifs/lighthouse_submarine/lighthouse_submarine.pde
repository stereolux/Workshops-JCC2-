Lighthouse lh;
ArrayList <Submarine> subs;

void setup() {
  size( 800, 500 );
  colorMode(HSB, 360, 100, 100);
  smooth();
  
  lh = new Lighthouse(100, 100, radians(20));
  subs = new ArrayList();
  for (int n = 0; n < 50; n++) {
    Submarine sub = new Submarine(random(width), random(height));
    subs.add(sub);
  }
}

void draw() {
  background(0, 0, 100);
  lh.draw();
  for (Submarine sub : subs) {
    sub.draw();
  }
}

float myAngleBetween(PVector v1, PVector v2) {
  float a = atan2(v2.y, v2.x) - atan2(v1.y, v1.x);
  if (a < 0) a += TWO_PI;
  //a = PVector.angleBetween(v1, v2);
  return a;
}
