Follower f;
Follower f2;

void setup() {
  size(400, 400);
  shapeMode(CENTER);
  f = new Follower(200, 200);
  f2 = new Follower(200, 400);
}

void draw() {
  background(200);
  f.seek(mouseX, mouseY);
  f2.seek(f.pos.x, f.pos.y);
  f.draw();
  f2.draw();
}
