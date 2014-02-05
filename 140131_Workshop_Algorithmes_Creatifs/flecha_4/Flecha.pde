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
    
    if (dist(mouseX, mouseY, x, y) < l) {
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
      triangle(x + 2*l, y, 
                 x - l, y + l, 
                 x - l, y - l);
    }
    if (estado == 1) {
      triangle(  x - l, y - l, 
                 x + l, y - l,
                     x, y + 2*l);
    }
    if (estado == 2) {
      triangle(x - 2*l, y, 
                 x + l, y + l, 
                 x + l, y - l);
    }
    if (estado == 3) {
      triangle(  x - l, y + l, 
                 x + l, y + l,
                     x, y - 2*l);
    }
  }
  
}
