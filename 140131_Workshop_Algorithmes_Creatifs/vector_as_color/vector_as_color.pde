

void setup() {
  size( 400, 400 );
}

void draw() {
  PVector v = new PVector(mouseX-width*.5, mouseY-height*.5);
  colorMode(HSB, 360, 100, 100);
  background(degrees(v.heading()+PI), 100, 100);
}
