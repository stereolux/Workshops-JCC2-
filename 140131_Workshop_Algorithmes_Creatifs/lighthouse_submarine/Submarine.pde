class Submarine {

  PVector pos;

  Submarine(float x, float y) {
    pos = new PVector(x, y);
    float ang = PVector.angleBetween(lh.pos, pos);
    println(degrees(ang));
  }

  void draw() {
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

    noStroke();
    noFill();
    if (ang == constrain(ang, ang1, ang2)) {
      fill(0, 0, 80);
    }
    ellipse(pos.x, pos.y, 10, 10);
  }
}

