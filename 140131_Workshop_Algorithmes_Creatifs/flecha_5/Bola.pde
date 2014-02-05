class Bola {

  float x, y, d;
  float vx, vy;
  float vel;
  
  color c;
 
  Bola(float x_, float y_, float d_, float vel_) {
    x = x_; y = y_; d = d_;
    vel = vel_;
    c = color(200, 200, 0);
  }

  void velocidad() {
    for (int i = 0; i < flechas.size(); i++) {
      Flecha f = flechas.get(i);
      if (dist(f.x, f.y, x, y) < 5) {
        if (f.estado == 0) {
          vx = vel;
          vy = 0;
        }
        if (f.estado == 1) {
          vx = 0;
          vy = vel;
        }
        if (f.estado == 2) {
          vx = -vel;
          vy = 0;
        }
        if (f.estado == 3) {
          vx = 0;
          vy = -vel;
        }        
      }
      
      if (dist(f.x, f.y, x, y) < 2*f.l) {      
        f.bolaEncima = true;
      }
    }
  }

  void draw() {
    
    velocidad();
    
    x = x + vx;
    y = y + vy;
    
    if (x > width) x = 0;
    if (x < 0) x = width;
    if (y > height) y = 0;
    if (y < 0) y = height;
    
    noFill();
    strokeWeight(1);
    stroke(c);
    ellipse(x, y, d, d);
  }
}
