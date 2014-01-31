import oscP5.*;
import netP5.*;

OscP5 oscar;
NetAddress destination_adresse;

void setup() {
  size(400,400);
  frameRate(25);
  oscar = new OscP5(this, 12000); 
  destination_adresse = new NetAddress("127.0.0.1",57120);
}

void draw() {
  background(0);
}

void mousePressed() {
  declencher_note(random(80, 8000));
}

void declencher_note(float freq) {
  OscMessage message = new OscMessage("/frequence");
  message.add(freq);
  oscar.send(message, destination_adresse); 
}
