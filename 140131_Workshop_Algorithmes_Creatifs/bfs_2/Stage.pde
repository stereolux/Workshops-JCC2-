class Stage extends Node {

  float counter;
  float diam = 20;
  
  Stage(float x, float y) {
    super(x, y);
    pathfinder.nodes.add(this);
  }
  
  void draw() {
    counter = max(0, counter-0.005);
    if (walkable) {
      noStroke();
      fill(240);
      //ellipse(this.x, this.y, diam, diam);
      fill(40, 40, 240);
      ellipse(this.x, this.y, 5+counter, 5+counter);
    }
    else {
      noStroke();
      rectMode(CENTER);
      fill(230);
      rect(x, y, diam, diam);
    }
  }

}
