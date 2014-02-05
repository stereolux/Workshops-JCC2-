VectorField vf;
ParticleSystem ps;

void setup() {
  size(1200, 800, P2D);
  vf = new VectorField(60, 40);
  ps = new ParticleSystem();
}

void draw() {
  background(50);
  vf.update();
  vf.draw();
  ps.update();
  ps.draw();
  if (frameCount % 50 == 0)  println(frameRate);
//  if (frameCount % 50 == 0) vf.twist(300, 200);
//  if (frameCount % 75 == 0) vf.twist(800, 500);
//  if (frameCount % 45 == 0) vf.twist(240, 550);
}

void mouseDragged() {
  vf.modify(50, mouseX, mouseY, pmouseX, pmouseY);
}

void mousePressed(MouseEvent e) {
  if (e.getClickCount()==2) { 
    println("<double click>");
    vf.twist(mouseX, mouseY);
  }
}


