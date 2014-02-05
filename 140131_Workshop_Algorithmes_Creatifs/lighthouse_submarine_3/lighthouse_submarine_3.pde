ArrayList <Lighthouse> lhs;
ArrayList <Submarine> subs;
ArrayList <Follower> planes;

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
  
  planes = new ArrayList();
  for (int n = 0; n < 10; n++) {
    Follower f = new Follower(random(width), random(height));
    planes.add(f);
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
  for (int n = 0; n < planes.size(); n++) {
    Follower plane = planes.get(n);
    Submarine sub = subs.get(n);
    if (sub.visible) {
      plane.seek(sub.x, sub.y);
    }
    else {
      plane.idle();
    }
    plane.draw();
  }
}
