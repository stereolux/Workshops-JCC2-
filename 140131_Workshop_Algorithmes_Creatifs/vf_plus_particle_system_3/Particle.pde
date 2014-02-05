class Particle extends PVector {

  float life;
  PVector vel;
  float fase;
  
  Particle(float x, float y) {
    super(x, y);
    vel = new PVector();
    life = 1;
    fase = random(PI);
  }
  
  void update() {
    life -= .002;
  }
  
  void draw() {
    if (this.x < 0) this.x = width-1;
    if (this.y < 0) this.y = height-1;
    if (this.x > width) this.x = 0;
    if (this.y > height) this.y = 0;
    PVector past = this.get();
    PVector acc = vf.getVector(x, y);
    vel.add(acc);
    vel.limit(3);
    this.add(vel);
    colorMode(HSB, 360, 100, 100);
    fill(degrees(vel.heading()+PI), 30, 90, 200); // small saturation
    noStroke();
    float ang = vel.heading();
    float mg = vel.mag()*0.3*(1+.5*sin(frameCount*0.1+fase));
    arc(this.x, this.y, 50*life, 50*life, ang-mg, ang+mg);
    //ellipse(this.x, this.y, 30*life, 30*life);
    colorMode(RGB, 255, 255, 255);
    
    vf.modify(10, x, y, past.x, past.y);
  }
  
}
