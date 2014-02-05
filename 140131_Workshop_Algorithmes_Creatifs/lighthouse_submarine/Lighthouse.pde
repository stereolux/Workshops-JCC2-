class Lighthouse {
  
  PVector pos;
  float angle;
  float arcLength;
  
  Lighthouse(float x, float y, float arcLength_) {
    pos = new PVector(x, y);
    arcLength = arcLength_;
  }
  
  void draw() {
    angle = (angle +.01) % TWO_PI;
    //PVector dif = new PVector(mouseX, mouseY);
    //dif.sub(pos);
    //angle = dif.heading();
    //if (angle < 0) angle += TWO_PI;
    noStroke();
    fill(50, 70, 70);
    arc(pos.x, pos.y, width*3, width*3, angle-arcLength*.5, angle+arcLength*.5);
    fill(200, 70, 70);
    ellipse(pos.x, pos.y, 30, 30);
  }
  
}
