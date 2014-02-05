// Si pulsamos una tecla cuando cuando el ratón
// está sobre una flecha aparece una bola.
// ArrayList para bolas

ArrayList <Flecha> flechas;
ArrayList <Bola> bolas;

void setup() {
  size(800, 400);
  smooth();
  
  flechas = new ArrayList(); 
  
  int h = 20;
  for (int x = h; x < width; x = x + h) {
    for (int y = h; y < height; y = y + h) {
      Flecha f = new Flecha(x, y, 30);
      flechas.add(f);
    }
  }
  
  bolas = new ArrayList();
  Bola b = new Bola(40, 40, 10, 2);
  bolas.add(b);
}

void draw() {
  background(245);
  
  for (int i = 0; i < flechas.size(); i++) {
    Flecha f = flechas.get(i);
    f.draw();
  }
  
  for (int i = 0; i < bolas.size(); i++) {
    Bola b = bolas.get(i);
    b.draw();
  }
}

void mouseReleased() {
  for (int i = 0; i < flechas.size(); i++) {  
    Flecha f = flechas.get(i);    
    if (f.encima) {
     // f.estado = f.estado + 1;
      if (f.estado > 3) {
       // f.estado = 0;
      }
    }
  }
}

void mouseDragged() {
  int dx = mouseX-pmouseX;
  int dy = mouseY-pmouseY;
  
  for (int i = 0; i < flechas.size(); i++) {  
    Flecha f = flechas.get(i);    
    if (f.encima) {
      if (abs(dx) > abs(dy)) {
        if (dx > 0) {
          f.estado = 0;
        }
        else {
          f.estado = 2;
        }
      }
      else {
        if (dy > 0) {
          f.estado = 1;
        }
        else {
          f.estado = 3;
        }
      }
    }
  }
}
void keyReleased() {
  for (int i = 0; i < flechas.size(); i++) {  
    Flecha f = flechas.get(i);    
    if (f.encima) {
      Bola b = new Bola(f.x, f.y, 10, random(2,4));
      b.c = color(0, 200, 200);
      bolas.add(b);
    }
  }  
}
