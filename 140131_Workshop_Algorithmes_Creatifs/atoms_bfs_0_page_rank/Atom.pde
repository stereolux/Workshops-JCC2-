class Atom extends Node {

  ArrayList <Atom> incoming;
  int counter;
  float rank;
  float diam = 50;

  Atom(float x, float y) {
    super(x, y);
    sys.nodes.add(this);
    incoming = new ArrayList();
  }  

  void reset() {
    rank = 1./atoms.size();
    counter = 0;
    incoming.clear();
  }
  
  void calcRank() {
    rank = 0;
    for (Atom other : incoming) {
      rank += other.rank/other.counter;
    }
  }

  void draw() {
    noStroke();
    fill(255, 100);    
    ellipse(x, y, diam+rank*200, diam+rank*200);
    fill(0);
    text(rank, x, y);
  }
}

