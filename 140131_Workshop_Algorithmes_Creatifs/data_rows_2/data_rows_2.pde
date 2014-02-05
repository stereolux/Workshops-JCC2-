ArrayList<Row> rows;

void setup() {
  size(400, 500);
  
  rows = new ArrayList();
  for (int n = 0; n < 20; n++) {
    Row r = new Row(50 + n*20);
    rows.add(r);
  }
}

void draw() {
  background(230);
    
  for (Row r : rows) {
    r.update();
    r.draw();
  }
}
