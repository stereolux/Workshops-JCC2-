VectorField vf;

void setup() {
  size(600, 400);
  vf = new VectorField(30, 20);
}

void draw() {
  background(200);
  vf.draw();
}

