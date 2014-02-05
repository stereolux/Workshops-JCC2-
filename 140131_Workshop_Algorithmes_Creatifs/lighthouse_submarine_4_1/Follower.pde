class Follower extends PVector {
 
  PShape icon;
  PVector vel;
  PVector acc;
  
  int id;
  float r;
  float maxforce;
  float maxspeed;
 
  Follower(int id_, float x, float y) {
    super(x, y);
    id = id_;
    acc = new PVector(0,0);
    vel = new PVector(0,0);
    r = 2;
    
    maxspeed = 2;
    maxforce = 0.1;
    
    icon = loadShape("airplane.svg");
    icon.rotate(HALF_PI);
    icon.disableStyle();    
  }
 
  void update() {
    float lastAngle = vel.heading();
    vel.add(acc);
    vel.limit(maxspeed);
    this.add(vel);
    acc.mult(0);
    float angle = vel.heading();
    icon.rotate(angle-lastAngle);
  }
 
  void applyForce(PVector force) {
    acc.add(force);
  }
 
  void seek(PVector target) {
    PVector desired = PVector.sub(target,this);
    desired.normalize();
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired,vel);
    steer.limit(maxforce);
    applyForce(steer);
  }
  
  void arrive(PVector target) {
    PVector desired = PVector.sub(target,this);
    float d = desired.mag();
    desired.normalize();
    if (d < 100) {
      float m = map(d,0,100,0,maxspeed);
      desired.mult(m);
    } 
    else {
      desired.mult(maxspeed);
    }
 
    PVector steer = PVector.sub(desired,vel);
    steer.limit(maxforce);
    applyForce(steer);
  }
 
  void draw() {
    
    noStroke();
    fill(0, 150, 75);
    shape(icon, this.x, this.y, 30, 30);
  }
}
