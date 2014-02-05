class Particle extends PVector {

  float life;
  PVector vel;
  
  Particle(float x, float y) {
    super(x, y);
    vel = new PVector();
    life = 1;
  }
  
  void update() {
    life -= .002;
  }
  
  void draw() {
    if (this.x < 0) this.x = width-1;
    if (this.y < 0) this.y = height-1;
    if (this.x > width) this.x = 0;
    if (this.y > height) this.y = 0;
    
    PVector acc = vf.getVector(x, y);
    vel.add(acc);
    vel.limit(3);
    this.add(vel);
    colorMode(HSB, 360, 100, 100);
    fill(degrees(vel.heading()+PI), 30, 90, 140); // small saturation
    noStroke();
    ellipse(this.x, this.y, 30*life, 30*life);
    colorMode(RGB, 255, 255, 255);
  }
  
}
