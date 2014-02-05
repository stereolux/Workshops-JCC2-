ArrayList <Lighthouse> lhs;
ArrayList <Submarine> subs;

void setup() {
  size( 800, 800, P2D );
  
  lhs = new ArrayList();
  Lighthouse lh1 = new Lighthouse(550, 500, radians(40));
  Lighthouse lh2 = new Lighthouse(100, 100, radians(40));
  lhs.add(lh1);
  lhs.add(lh2);
  
  subs = new ArrayList();
  for (int n = 0; n < 10; n++) {
    Submarine sub = new Submarine(random(width), random(height));
    subs.add(sub);
  }
}

void draw() {
  background(220);
  for (Lighthouse lh : lhs) {
    lh.drawBeam();
  }
  for (Lighthouse lh : lhs) {
    lh.draw();
  }
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
