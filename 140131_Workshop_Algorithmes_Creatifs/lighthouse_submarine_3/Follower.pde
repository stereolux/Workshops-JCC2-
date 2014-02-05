class Follower extends PVector {

  PVector vel;
  float angle;
  PShape icon;

  Follower(float x, float y) {
    super(x, y);
    vel = new PVector();
    icon = loadShape("airplane.svg");
    icon.rotate(HALF_PI);
    icon.disableStyle();
  }
  
  void seek(float x, float y) {
    vel = new PVector(x, y);
    vel.sub(this);
    vel.mult(0.05);
    vel.limit(2);
    this.add(vel);
    float lastAngle = angle;
    angle = vel.heading();
    icon.rotate(angle-lastAngle);
  }
  
  void idle() {
    this.add(vel);
    if (this.x > width) this.x = 0;
    if (this.x < 0) this.x = width;
    if (this.y > height) this.y = 0;
    if (this.y < 0) this.y = height;
  }
  
  void draw() {
    noStroke();
    fill(0, 150, 75);
    shape(icon, this.x, this.y, 20, 20);
  }
}
