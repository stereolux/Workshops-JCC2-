Follower[] f;

void setup() {
  size(400, 400);
  f = new Follower[10];
  for (int n = 0; n < f.length; n++) {
    f[n] = new Follower(100, 100);
  }
}

void draw() {
  background(255);
  f[0].arrive(new PVector(mouseX, mouseY));
  for (int n = 0; n < f.length; n++) {
    if (n != 0) f[n].arrive(new PVector(f[n-1].pos.x, f[n-1].pos.y));
    f[n].update();
    f[n].draw();
  }
}
