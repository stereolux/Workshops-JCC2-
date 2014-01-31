import oscP5.*;
import netP5.*;

OscP5 oscar;
NetAddress destination_adresse;

Boule b1 = new Boule();
Boule b2 = new Boule();
Boule b3 = new Boule();
Boule b4 = new Boule();

void setup() {
  size(400,400);
  frameRate(25);
  oscar = new OscP5(this, 12000); 
  destination_adresse = new NetAddress("127.0.0.1",57120);
}

void draw() {
  background(0);
  b1.deplacer();
  b1.dessiner();
  b2.deplacer();
  b2.dessiner();
  b3.deplacer();
  b3.dessiner();
  b4.deplacer();
  b4.dessiner();
}

void mousePressed() {
  b1.reset();
  b2.reset();
  b3.reset();
  b4.reset();
}

class Boule {
  float x, y;
  float vx, vy;
  
  Boule() {
    x = random(width);
    y = random(height);
    vx = random(2, 12);
    vy = random(2, 12);
  }
  
  void deplacer() {
    x += vx;
    y += vy;
    if ( (x < 0) || (x > width) ) {
      vx = -vx;
      //declencher_note(y*2+150);
      declencher_note(abs(vx*vx*vx + vy*vy*vy));
    }
    if ( (y < 0) || (y > height) ) {
      vy = -vy;
      //declencher_note(x*10+1000);
      declencher_note(abs(vx*vx*vx + vy*vy*vx));
    }
  }
  
  void dessiner() {
    stroke(255);
    fill(255);
    ellipse(x, y, 20, 20);
  }
  
  void declencher_note(float freq) {
    OscMessage message = new OscMessage("/frequence");
    message.add(freq);
    oscar.send(message, destination_adresse); 
  }
  
  void reset() {
    vx = random(2, 12);
    vy = random(2, 12);
  }
}
