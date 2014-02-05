// Algorithmes créatifs - Abelardo Gil-Fournier, 2014
// http://abelardogfournier.org
// http://github.org/abe-
//
// Atoms will contain a physics particle and an AI node.

class Atom extends PVector {

  float diam = EDGE_LENGTH;
  Particle p;
  ArrayList <Atom> incoming;
  Node node;

  Atom(float x, float y) {
    super(x, y);
    node = new Node(x, y);
    sys.nodes.add(node);
    p = physics.makeParticle();
    p.position().set(x, y, 0);
    for (Atom other : atoms) {
      physics.makeAttraction( this.p, other.p, -REPULSION_STRENGTH, diam );
    }

    incoming = new ArrayList();
  }  

  void link(Atom other) {
    this.node.connectBoth(other.node);
    physics.makeSpring( this.p, other.p, EDGE_STRENGTH, EDGE_STRENGTH, EDGE_LENGTH );
    incoming.add(other);
    other.incoming.add(this);
  }

  void update() {
    this.x = p.position().x();
    this.y = p.position().y();
  }

  void draw() {  
    if (incoming.size() == 1) {
      fill(255, 150, 50);
      noStroke();
      ellipse(x, y, diam, diam);
    }
  }
}

