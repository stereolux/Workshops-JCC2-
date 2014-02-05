class Flecha {
  
  float x, y;
  float l;
  int estado;
  
  boolean encima;
  boolean bolaEncima;
 
  Flecha(float x_, float y_, float l_) {
    x = x_;
    y = y_;
    l = l_;
    estado = floor(random(4));
  } 
  
  void draw() {
    float l_ = l*0.15;
    if (dist(mouseX, mouseY, x, y) < l_) {
      encima = true;
      fill(200);
    }
    else {
      encima = false;
      fill(50);
    }
    
    if (bolaEncima) {
      fill(200, 0, 0);
    }
    bolaEncima = false; // Hasta que una bola pase por encima
    
    noStroke();
    if (estado == 0) {
      triangle(x + 2*l_, y, 
                 x - l_, y + l_, 
                 x - l_, y - l_);
    }
    if (estado == 1) {
      triangle(  x - l_, y - l_, 
                 x + l_, y - l_,
                     x, y + 2*l_);
    }
    if (estado == 2) {
      triangle(x - 2*l_, y, 
                 x + l_, y + l_, 
                 x + l_, y - l_);
    }
    if (estado == 3) {
      triangle(  x - l_, y + l_, 
                 x + l_, y + l_,
                     x, y - 2*l_);
    }
  }
  
}
