class Lighthouse {
  
  PVector pos;
  float angle, vel;
  float arcLength;
  
  Lighthouse(float x, float y, float arcLength_) {
    pos = new PVector(x, y);
    arcLength = arcLength_;
    angle = random(PI);
    vel = random(0.007, 0.013);
  }
  
  void drawBeam() {
    angle = (angle +.01) % TWO_PI;
    //PVector dif = new PVector(mouseX, mouseY);
    //dif.sub(pos);
    //angle = dif.heading();
    //if (angle < 0) angle += TWO_PI;
    noStroke();
    fill(200, 70, 70, 50);
    //arc(pos.x, pos.y, width*3, width*3, angle-arcLength*.5, angle+arcLength*.5);
    PVector p = new PVector(width, 0);
    p.rotate(angle);
    PVector p1 = new PVector(p.x, p.y);
    PVector p2 = new PVector(p.x, p.y);
    p1.rotate(-arcLength*.5); 
    p2.rotate(arcLength*.5);
    beginShape();
    fill(200, 70, 70, 250);
    vertex(pos.x, pos.y);
    fill(255,0);
    vertex(pos.x+p1.x, pos.y+p1.y);
    vertex(pos.x+p2.x, pos.y+p2.y);
    endShape(CLOSE);
    
  }
  
  void draw() {
    fill(155,150,0);
    //ellipse(pos.x, pos.y, 10, 10);
  }
  
}
