import controlP5.*;
import oscP5.*;
import netP5.*;

OscP5 oscar;
NetAddress destination_adresse;

ControlP5 cp5;
Slider2D s;

float freq1, freq2;

void setup() {
  size(400,400);
  frameRate(25);
  cp5 = new ControlP5(this);
  s = cp5.addSlider2D("wave").setPosition(30,40).setSize(100,100);  
  oscar = new OscP5(this, 12000); 
  destination_adresse = new NetAddress("127.0.0.1",57120);

}

void draw() {
  background(0);
  freq1 = s.arrayValue()[0] * 50;
  freq2 = s.arrayValue()[1] * 0.05; 
  envoyer_frequences(freq1, freq2);
  println(freq1 + " " + freq2);
}

void envoyer_frequences(float freq1, float freq2) {
  OscMessage message = new OscMessage("/frequences");
  message.add(freq1);
  message.add(freq2);
  oscar.send(message, destination_adresse); 
}













