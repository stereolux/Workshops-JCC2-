class Atom  {

  ArrayList <Atom> incoming;
  int counter;
  float rank;
  float diam = EDGE_LENGTH*.25;
  Particle p;
  Node node;

  Atom(float x, float y) {
    node = new Node(x, y);
    sys.nodes.add(node);
    incoming = new ArrayList();

    p = physics.makeParticle();
    p.position().set(x, y, 0);
    for (Atom other : atoms) {
      physics.makeAttraction( this.p, other.p, -REPULSION_STRENGTH, diam );
    }
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

  void link(Atom other) {
    this.node.connectBoth(other.node);
    physics.makeSpring( this.p, other.p, EDGE_STRENGTH, EDGE_STRENGTH, EDGE_LENGTH );
  }

  void update() {
    //this.x = p.position().x();
    //this.y = p.position().y();
  }

  void draw() {
    noStroke();
    fill(255, 100);  
    //if (t.target > -1 && this.node == (Node)sys.nodes.get(t.target)) fill(255, 0, 0, 100);  
    ellipse(p.position().x(), p.position().y(), diam+rank*200, diam+rank*200);
    fill(0);
    //text(rank, x, y);
  }
}

