class Follower {
 
  PVector pos;
  PVector vel;
  PVector acc;
  
  float r;
  float maxforce;
  float maxspeed;
 
  Follower(float x, float y) {
    acc = new PVector(0,0);
    vel = new PVector(0,0);
    pos = new PVector(x,y);
    r = 3.0;
    
    maxspeed = 4;
    maxforce = 0.1;
  }
 
  void update() {
    vel.add(acc);
    vel.limit(maxspeed);
    pos.add(vel);
    acc.mult(0);
  }
 
  void applyForce(PVector force) {
    acc.add(force);
  }
 
  void seek(PVector target) {
    PVector desired = PVector.sub(target,pos);
    desired.normalize();
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired,vel);
    steer.limit(maxforce);
    applyForce(steer);
  }
  
  void arrive(PVector target) {
    PVector desired = PVector.sub(target,pos);
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
    float theta = vel.heading() + PI/2;
    fill(175);
    stroke(0);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(theta);
    beginShape();
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape(CLOSE);
    popMatrix();
  }
}
