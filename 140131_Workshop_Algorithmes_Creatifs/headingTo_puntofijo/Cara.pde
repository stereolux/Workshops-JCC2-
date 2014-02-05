class Cara {

  float angle, angle0, angle1;
  float xCenter, yCenter;
  int pestaneo;
  
  float xPoint, yPoint;
 
  Cara(float x_, float y_) {
    xCenter = x_;
    yCenter = y_;
    pestaneo = 60;
  } 
  
  void persigue(float x_, float y_) {
    if (dist(xCenter, yCenter, x_, y_) > 100) {
      xCenter += .015 * (x_ - xCenter);
      yCenter += .015 * (y_ - yCenter);    
    }
  }
  
  void draw() { 
    persigue(xPoint, yPoint); 
    float x_ = xPoint;
    float y_ = yPoint;
    
    angle = atan2(y_-yCenter, x_-xCenter);
    angle0 = headingTo(angle, angle0, 0.15);
    angle1 = headingTo(angle, angle1, 0.3);

    pushMatrix();
    translate(xCenter, yCenter);
    rotate(angle0);
    stroke(50);
    fill(250);
    arc(0, 0, 50, 50, -HALF_PI, HALF_PI);
    fill(50);
    arc(0, 0, 50, 50, HALF_PI, 3*HALF_PI);
  
    if (frameCount % pestaneo < 5) {
      fill(250);
      pestaneo = floor(random(40, 120));
    }
    
    noStroke();
    ellipse(13, 10, 5, 8);
    ellipse(13, -10, 5, 8);  
    popMatrix();

    pushMatrix();
    translate(xCenter, yCenter);
    rotate(angle1);
    translate(40, 0);
  
    fill(80,0,0);
    float a = 5;
    beginShape();
    vertex(0, a);
    vertex(2*a, a);
    vertex(2*a, 2*a);
    vertex(4*a, 0);
    vertex(2*a, -2*a);
    vertex(2*a, -a);
    vertex(0, -a);
    endShape(CLOSE);
  
    popMatrix();  
  }

  float headingTo(float angleTo, float angleFrom, float easing) {
    angleTo %= TWO_PI;
    angleFrom %= TWO_PI;
    if (abs(angleTo - angleFrom) > PI) {
      if (angleTo > angleFrom) angleTo -= TWO_PI;
      else angleFrom -= TWO_PI;
    }
    return (angleFrom + easing * (angleTo - angleFrom)) % TWO_PI;  
  }
  
  
}
