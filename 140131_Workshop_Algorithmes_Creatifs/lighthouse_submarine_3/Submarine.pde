class Submarine extends PVector {

  PVector vel;
  boolean visible;

  Submarine(float x, float y) {
    super(x, y);
    vel = new PVector(random(.1,.2), 0);
  }

  void draw() {
    this.add(vel);
    if (this.x > width) this.x = 0;
    
    visible = false;
    for (Lighthouse lh : lhs) {
      PVector dif = new PVector(this.x, this.y);
      dif.sub(lh);
      
      float ang = dif.heading();
      if (ang < 0) ang += TWO_PI;
      
      float ang1 = lh.angle-lh.arcLength*.5;
      float ang2 = lh.angle+lh.arcLength*.5;
  
      if (ang1 < 0) {
        if (ang < PI) ang += TWO_PI;
        ang1 += TWO_PI;
        ang2 += TWO_PI;
      }
      if (ang2 > TWO_PI) {
        if (ang > PI) ang -= TWO_PI;
        ang1-= TWO_PI;
        ang2 -= TWO_PI;
      }
      
      if (ang == constrain(ang, ang1, ang2)) {
        visible = true;
      }
    }
    noStroke();
    if (visible) fill(0, 150, 150);
    else noFill();
    ellipse(this.x, this.y, 10, 10);
  }
}

