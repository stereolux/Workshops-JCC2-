VectorField vf;
ParticleSystem ps;

void setup() {
  size(640, 400);
  vf = new VectorField(30, 20);
  ps = new ParticleSystem();
}

void draw() {
  background(230,140,0);
  vf.update();
  vf.draw();
  ps.update();
  ps.draw();
  if (frameCount % 50 == 0)  println(frameRate);
}

void mouseDragged() {
  vf.modify();
}
