Imitator it;

void setup() {
  size( 400, 400 );
  it = new Imitator(100, 200, 0);
}

void draw() {
  background(255);
  it.draw();
}

void mousePressed() {
  it.resetMov();
}

void mouseDragged() {
  it.addPoint(mouseX-pmouseX, mouseY-pmouseY);
}

void mouseReleased() {
  it.startMov();
}
