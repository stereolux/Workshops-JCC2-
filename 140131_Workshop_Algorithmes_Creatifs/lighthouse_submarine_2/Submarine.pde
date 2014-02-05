class Submarine {

  PVector pos, vel;

  Submarine(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector(random(.1,.2), 0);
  }

  void draw() {
    pos.add(vel);
    if (pos.x > width) pos.x = 0;
    
    boolean over = false;
    for (Lighthouse lh : lhs) {
      PVector dif = new PVector(pos.x, pos.y);
      dif.sub(lh.pos);
      
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
        over = true;
      }
    }
    noStroke();
    if (over) fill(0, 150, 150);
    else noFill();
    ellipse(pos.x, pos.y, 10, 10);
  }
}

