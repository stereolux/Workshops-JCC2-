// Algorithmes créatifs - Abelardo Gil-Fournier, 2014
// http://abelardogfournier.org
// http://github.org/abe-
//
// Each Atom will host a particle of the traer.physics system. The
// physics particle will be in charge of updating the position of the
// atom.

class Atom extends PVector {

  float diam = EDGE_LENGTH;
  Particle p;
  ArrayList <Atom> incoming;

  Atom(float x, float y) {
    super(x, y);

    p = physics.makeParticle();
    p.position().set(x, y, 0);
    for (Atom other : atoms) {
      physics.makeAttraction( this.p, other.p, -REPULSION_STRENGTH, diam );
    }
    
    incoming = new ArrayList();
  }  

  void link(Atom other) {
    physics.makeSpring( this.p, other.p, EDGE_STRENGTH, EDGE_STRENGTH, EDGE_LENGTH );
    incoming.add(other);
    other.incoming.add(this);
  }

  void update() {
    this.x = p.position().x();
    this.y = p.position().y();
  }

  void draw() {  
    fill(0);
    noStroke();
    ellipse(x, y, diam, diam);
  }
}
