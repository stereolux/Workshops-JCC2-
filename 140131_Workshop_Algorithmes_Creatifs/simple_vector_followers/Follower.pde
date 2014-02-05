class Follower {

  PVector pos;
  float angle;
  PShape icon;

  Follower(float x, float y) {
    pos = new PVector(x, y);
    icon = loadShape("airplane.svg"); 
    icon.rotate(HALF_PI);
  }
  
  void seek(float x, float y) {
    PVector dest = new PVector(x, y);
    dest.sub(pos);
    dest.mult(0.05);
    pos.add(dest);
    float lastAngle = angle;
    angle = dest.heading();
    icon.rotate(angle-lastAngle);
  }
  
  void draw() {
    shape(icon, pos.x, pos.y, 20, 20);
  }
}
