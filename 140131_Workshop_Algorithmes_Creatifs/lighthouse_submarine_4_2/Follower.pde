class Follower extends PVector {

  PVector vel;
  float angle;
  PShape icon;
  int id;

  Follower(int id_, float x, float y) {
    super(x, y);
    id = id_;
    vel = new PVector();
    icon = loadShape("airplane.svg");
    icon.rotate(HALF_PI);
    icon.disableStyle();
  }
  
  void seek(float x, float y) {
    float vx = 0, vy = 0;
    vel.set(signum(x-this.x)*3, signum(y-this.y)*3);
//    vel = new PVector(x, y);
//    vel.sub(this);
//    vel.mult(0.025);
    vel.limit(3);
    this.add(vel);
    float lastAngle = angle;
    angle = vel.heading();
    icon.rotate(angle-lastAngle);
  }
  
  int signum(float a) {
    if (a > 5) return 1;
    else if (a < -5) return -1;
    else return 0;
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
    fill(240);
    shape(icon, this.x, this.y, 15, 15);
  }
}
