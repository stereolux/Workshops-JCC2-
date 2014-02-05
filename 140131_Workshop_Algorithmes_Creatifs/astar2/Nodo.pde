class Nodo {
  
  String nombre;
  ArrayList <String> mensajes;
  boolean femenino;
  Particle p;
  Node node;
  ArrayList <Nodo> links;
  boolean inicializado;
  boolean overBoton;
  float wBoton, hBoton;
  
  Nodo(String nombre_, int genero) {
    nombre = nombre_;
    mensajes = new ArrayList();
    femenino = (genero == 1);
    links = new ArrayList();
    textSize(14);
    wBoton = textWidth(nombre.toUpperCase())*1.2;
    hBoton = (textAscent()+textDescent())*1.2;
  }
  
  void addMensaje(String mensaje) {
    mensajes.add(mensaje);
  }
  
  void connect(Nodo n) {
    if (p == null) {
      p = addBaseNode();
    }
    if (n.p == null) {
      n.p = addNode(this.p, 1);
    }
    links.add(n);
  }
  
  void update() {
    if (inicializacion && node != null && !inicializado) {
      inicializado = true;
      for (Nodo n : this.links) {
        node.connectBoth(n.node);
      }
    }
    else if (inicializacion && node == null) {
      node = new Node(p.position().x(), p.position().y());
      bfs.nodes.add(node);
    }
  }
  
  void boton(float x, float y) {
    overBoton = (mouseX == constrain(mouseX, x-wBoton*.5, x+wBoton*.5)
      && mouseY == constrain(mouseY, y-hBoton*.5, y+hBoton*.5));
    
    textSize(14);
    textAlign(CENTER, CENTER);
    noFill();
    if (overBoton) fill(0);
    else fill(100);
    text(nombre.toUpperCase(), x, y);
  }
  

  boolean containsPoint(float x, float y) {
    if (p == null) return false;
    else {
      return (dist(p.position().x(), p.position().y(), x, y) < NODE_SIZE);
    }
  }
  
}
