// Algorithmes créatifs - Abelardo Gil-Fournier, 2014
// http://abelardogfournier.org
// http://github.org/abe-

class Traveler {

  int now, target;

  Traveler(int now_) {
    now = now_;
    target = floor(random(sys.nodes.size()));
  } 

  void update() {
    Node n1 = (Node) sys.nodes.get( now );
    Node n2 = (Node) sys.nodes.get( target );
    if (now != target) {
      ArrayList <Node> path = new ArrayList();

      path = sys.bfs(n1, n2);
      if (path.size() > 1) {
        Node n = path.get(path.size()-2);
        now = sys.nodes.indexOf(n);
      }
    }
  }
  
  void draw() {
    Node n = (Node)sys.nodes.get(now);
    Atom a = null;
    for (Atom atom : atoms) {
      if (atom.node == n) {
        a = atom;
      }
    }
    noStroke();
    fill(0, 100, 0, 100);
    ellipse(a.x, a.y, 20, 20);
  }  
}

