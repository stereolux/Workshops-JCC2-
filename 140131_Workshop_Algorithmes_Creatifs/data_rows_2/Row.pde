class Row {

  ArrayList <Line> lines;
  HashMap <Line, Integer> iss;
  float d = 50;

  Row(float y) {
    lines = new ArrayList();
    iss = new HashMap();
    for (int n = 0; n < 10; n++) {
      float r = random(width-d);
      Line l = new Line(r, y, d);
      lines.add(l);
    }
  }

  void update() {
    // Count intersections
    iss.clear();
    for (int i = 0; i < lines.size(); i++) {
      Line l1 = lines.get(i);
      for (int j = i+1; j < lines.size(); j++) {
        Line l2 = lines.get(j);
        if (l1.p1.x+l1.d > l2.p1.x && l1.p1.x+l1.d < l2.p1.x+l2.d) {
          l1.d = max(0, l1.d-.25);
        } 
        if (l2.p1.x+l2.d > l1.p1.x && l2.p1.x+l2.d < l1.p1.x+l1.d) {
          l1.p1.x = l1.p1.x+0.25;
          l1.d = max(0, l1.d-.25);
        }
      }
    }
  }

  void draw() {
    for (Line l : lines) {
      int is = iss.containsKey(l) ? iss.get(l) : 0;
      stroke(50, 100);
      strokeWeight(5);
      strokeCap(SQUARE);
      line(l.p1.x, l.p1.y+is*10, l.p1.x+l.d, l.p1.y+is*10);
    }
  }
}

