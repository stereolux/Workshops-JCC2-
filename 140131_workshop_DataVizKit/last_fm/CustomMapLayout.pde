// Treemap with customisable layout. Based on Ben Fry's TreeMap.java with
// very minor modifications by Jo Wood to allow substitution of alternative MapLayouts.
class CustomTreemap
{
  private MapModel model;
  private MapLayout algorithm;
  private Rect bounds;

  public CustomTreemap(MapModel model, MapLayout algorithm, double x, double y, double w, double h) {
    this.model = model; 
    this.algorithm = algorithm;
    updateLayout(x, y, w, h);
  }

  public void setLayout(MapLayout algorithm) {
    this.algorithm = algorithm;
  }

  public void updateLayout() {
    algorithm.layout(model, bounds);
  }

  public void updateLayout(double x, double y, double w, double h) {
    bounds = new Rect(x, y, w, h);
    updateLayout();
  }

  public void draw() {
    Mappable[] items = model.getItems();
    for (int i = 0; i < items.length; i++) {
      items[i].draw();
    }
  }
}

