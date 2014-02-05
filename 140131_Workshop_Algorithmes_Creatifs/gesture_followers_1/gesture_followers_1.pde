Ring ring;
float lmouseX, lmouseY;

void setup() {
  size(400, 400);
  ring = new Ring();
}

void draw() {
  background(255);
  ring.draw();
}

void mousePressed() {
  ring.resetMov();
  lmouseX = mouseX;
  lmouseY = mouseY;
  ring.addPoint(mouseX, mouseY);
}

void mouseDragged() {
  if (dist(mouseX, mouseY, lmouseX, lmouseY) > 20) {
    ring.addPoint(mouseX, mouseY);
    lmouseX = mouseX;
    lmouseY = mouseY;
  }  
}

void mouseReleased() {
  ring.startMov();
}
