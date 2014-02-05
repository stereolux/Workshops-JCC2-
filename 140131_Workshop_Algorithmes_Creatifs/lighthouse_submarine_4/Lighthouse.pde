class Lighthouse extends PVector {

  float angle, vel;
  float arcLength;

  Lighthouse(float x, float y, float arcLength_) {
    super(x, y);
    arcLength = arcLength_;
    angle = random(PI);
    vel = random(0.007, 0.013);
  }

  void drawBeam() {
    angle = (angle +.01) % TWO_PI;
    //PVector dif = new PVector(mouseX, mouseY);
    //dif.sub(this);
    //angle = dif.heading();
    //if (angle < 0) angle += TWO_PI;

    PVector p1 = new PVector(width, 0);
    PVector p2 = new PVector(width, 0);
    p1.rotate(angle-arcLength*.5); 
    p2.rotate(angle+arcLength*.5);

    beginShape();
    noStroke();    
    fill(200, 70, 70, 250);
    vertex(this.x, this.y);
    fill(255, 0);
    vertex(this.x+p1.x, this.y+p1.y);
    vertex(this.x+p2.x, this.y+p2.y);
    endShape(CLOSE);  

    //arc(this.x, this.y, width*3, width*3, angle-arcLength*.5, angle+arcLength*.5);
  }

  void draw() {
    //fill(155,150,0);
    //ellipse(this.x, this.y, 10, 10);
  }
}

