import ai.pathfinder.*;
import traer.physics.*;

final float NODE_SIZE = 10;
final float EDGE_LENGTH = 20;
final float EDGE_STRENGTH = 0.2;
final float SPACER_STRENGTH = 1000;

// TRAER physics
ParticleSystem physics;
float scale = 1;
float centroidX = 0;
float centroidY = 0;

// AILibrary bfs
Pathfinder bfs;
PFont font;
Nodo bot, target;

// Nodos con BFS y física
HashMap <Integer, Nodo> nodos;
boolean inicializacion;

// Narrativa
ArrayList <Nodo> nodosVisibles;
String[] mensajes;
int numMax = 10;

// Fuente
PFont fuente;

void setup(){
  size(600, 600);
  physics = new ParticleSystem( 0, 0.1 );
  bfs = new Pathfinder();
  fuente = loadFont("OCRAExtended-20.vlw");
  textFont(fuente);
  
  nodos = new HashMap();
  mensajes = new String[0];
  nodosVisibles = new ArrayList();
  
  Nodo ventanaSalon = new Nodo("Ventana del salón", 1);
  ventanaSalon.addMensaje("Veo alguien en la calle. Seguro que son");
  ventanaSalon.addMensaje("malas noticias de nuevo.");
  nodos.put(0, ventanaSalon);
  
  Nodo radio = new Nodo("Radio", 1);
  radio.addMensaje("No vale la pena encenderla. Sólo suena esa");
  radio.addMensaje("música horrible.");
  nodos.put(1, radio);

  Nodo sillon = new Nodo("Sillón", 0);
  sillon.addMensaje("No puedo quedarme aquí todo el día.");
  nodos.put(2, sillon);

  Nodo mesaPeriodico = new Nodo("Mesa con periódico", 1);
  mesaPeriodico.addMensaje("No cuenta nada de lo que pasó ayer.");
  nodos.put(3, mesaPeriodico);

  Nodo dormitorio = new Nodo("Dormitorio", 0);
  dormitorio.addMensaje("No quiero entrar. Estarán durmiendo todavía.");
  dormitorio.addMensaje("Ayer llegaron agotados.");
  nodos.put(4, dormitorio);

  Nodo puertaCocina = new Nodo("Puerta de la cocina", 1);
  nodos.put(5, puertaCocina);
  Nodo mesaCocina = new Nodo("Mesa de la cocina", 1);
  nodos.put(6, mesaCocina);
  Nodo ventanaCocina = new Nodo("Ventana de la cocina", 1);
  nodos.put(7, ventanaCocina);
  Nodo nevera = new Nodo("Nevera", 1);
  nodos.put(8, nevera);
  Nodo puertaCasa = new Nodo("Puerta de casa", 1);
  nodos.put(9, puertaCasa);
  Nodo calle = new Nodo("Calle", 1);
  nodos.put(10, calle);

  sillon.connect(ventanaSalon);
  sillon.connect(radio);
  sillon.connect(mesaPeriodico);
  mesaPeriodico.connect(dormitorio);
  mesaPeriodico.connect(puertaCasa);
  mesaPeriodico.connect(puertaCocina);
  puertaCasa.connect(calle);
  puertaCocina.connect(mesaCocina);
  mesaCocina.connect(ventanaCocina);
  mesaCocina.connect(nevera);

  bot = sillon;
  target = null;

  String mensajeInicial = "Estoy en " + (bot.femenino ? "la " : "el ") + bot.nombre.toLowerCase() + ".";
  mensajes = append(mensajes, mensajeInicial);

  nodosVisibles.addAll(bot.links);  
}

void draw() {
  if (frameCount > 100) inicializacion = true;
  
  for (Nodo n : nodos.values()) {
    n.update();
  }
  
  physics.tick(); 
  if ( physics.numberOfParticles() > 1 )
    updateCentroid();
  if (frameCount%50 == 0) updateBot();      
    
  background( 255 );
  
  if (true) {
    pushMatrix();
    translate( width/4.*3. , height/4. );
    translate( -centroidX, -centroidY );
    
    // muestro el grafo
    drawNetwork();
   
    // muestro la posición actual y el destino
    noStroke();
    fill(240, 40, 40);
    if (target != null) ellipse(target.p.position().x(), target.p.position().y(), 10, 10);
    fill(40, 40, 240);
    ellipse(bot.p.position().x(), bot.p.position().y(), 10, 10);    
    
    popMatrix();
  }
  
  fill(50);
  textAlign(RIGHT);
  float x = 20;
  float y = height-100;
  for (Nodo nv : nodosVisibles) {
    nv.boton(x + nv.wBoton*.5, y);
    x += nv.wBoton*1;
    if (x > width-180) {
      y += nv.hBoton*1.2;
      x = 20;
    }
  }
  
  fill(100);
  textAlign(LEFT);
  textSize(20);
  for (int n = 0; n < mensajes.length; n++) {
    text(mensajes[n], 50, 70+(textAscent()+textDescent())*1.5*n);
  }  
}

void drawNetwork() {      
  // draw vertices
  fill( 160 );
  noStroke();
  for ( int i = 0; i < physics.numberOfParticles(); ++i ) {
    Particle v = physics.getParticle( i );
    ellipse( v.position().x(), v.position().y(), NODE_SIZE, NODE_SIZE );
  }

  // draw edges 
  stroke( 0 );
  beginShape( LINES );
  for ( int i = 0; i < physics.numberOfSprings(); ++i ) {
    Spring e = physics.getSpring( i );
    Particle a = e.getOneEnd();
    Particle b = e.getTheOtherEnd();
    vertex( a.position().x(), a.position().y() );
    vertex( b.position().x(), b.position().y() );
  }
  endShape();
}


void updateBot(){
  if(target != null && bot != target && target.node.walkable){
    ArrayList path = new ArrayList();    
    path = bfs.bfs(bot.node, target.node);
    // a path starts at finish and ends at start, so the next move would be one away from the end of the path
    if(path.size() > 1){
      Node nbot = (Node) path.get(path.size()-2);
      for (Nodo n : nodos.values()) {
        if (n.node == nbot) {
          bot = n;
          // Crecen los nodos visibles
          for (Nodo nl : bot.links) {
            if (!nodosVisibles.contains(nl)) {
              nodosVisibles.add(nl);
            }
          }
          
          // Feedback mensaje
          String verbo = "Paso por ";
          String articulo = bot.femenino ? "la " : "el ";
          if (bot == target) {
            verbo = "Llego a ";           
          }
          appendDisplayMensajes(verbo + articulo + bot.nombre.toLowerCase()+".");
          
          if (bot == target) {
            for (String msg : bot.mensajes) {
              appendDisplayMensajes(msg);
            }            
          }
          else if (path.size() == 3) { // La siguiente es target
              appendDisplayMensajes("\n");
          }
        }
      }
    }
  }
}


void appendDisplayMensajes(String mensaje) {
  // Parser post-producción
  mensaje = mensaje.replace(" a el ", " al ");
  mensaje = mensaje.replace(" de el ", " del ");
  
  // Añade el mensaje al display
  mensajes = append(mensajes, mensaje);
  if (mensajes.length > numMax) {
    mensajes = subset(mensajes, 1, mensajes.length-1);
  }
}

void mouseMoved() {
  /*
  if (inicializacion) {
    for (Nodo n : nodos.values()) {
      if (n.containsPoint(mouseX-width/2+centroidX, mouseY-height/2+centroidY)) {
        target = n;
      } 
    }
  }
  */
}


void mouseReleased() {
  if (inicializacion) {
    appendDisplayMensajes("\n");
    for (Nodo n : nodos.values()) {
      if (n.overBoton) target = n;
    }
  }
}





// PHYS ////////////////////////////////////////////

void updateCentroid() {
  float 
    xMax = Float.NEGATIVE_INFINITY, 
    xMin = Float.POSITIVE_INFINITY, 
    yMin = Float.POSITIVE_INFINITY, 
    yMax = Float.NEGATIVE_INFINITY;

  for ( int i = 0; i < physics.numberOfParticles(); ++i )   {
    Particle p = physics.getParticle( i );
    xMax = max( xMax, p.position().x() );
    xMin = min( xMin, p.position().x() );
    yMin = min( yMin, p.position().y() );
    yMax = max( yMax, p.position().y() );
  }
  float deltaX = xMax-xMin;
  float deltaY = yMax-yMin;
  
  centroidX = xMin + 0.5*deltaX;
  centroidY = yMin +0.5*deltaY;
  
  if ( deltaY > deltaX )
    scale = height/(deltaY+50);
  else
    scale = width/(deltaX+50);
}


void addSpacersToNode( Particle p, Particle r ) {
  for ( int i = 0; i < physics.numberOfParticles(); ++i )   {
    Particle q = physics.getParticle( i );
    if ( p != q && p != r)
      physics.makeAttraction( p, q, -SPACER_STRENGTH, 20 );
  }
}



void addSpacersToNew( Particle p ) {
  for ( int i = 0; i < physics.numberOfParticles(); ++i )   {
    Particle q = physics.getParticle( i );
    if ( p != q )
      physics.makeAttraction( p, q, -SPACER_STRENGTH, 20 );
  }
}


void makeEdgeBetween( Particle a, Particle b, int relacion ) {
  float f = map(relacion, 1, 19, 1, 5);
  physics.makeSpring( a, b, EDGE_STRENGTH, EDGE_STRENGTH, EDGE_LENGTH * f );
}


void initialize() {
  physics.clear();
}


Particle addNode(Particle base, int relacion) { 
  Particle p = physics.makeParticle();
  addSpacersToNode( p, base );
  makeEdgeBetween( p, base, relacion);
  p.position().set( base.position().x() + random( -1, 1 ), base.position().y() + random( -1, 1 ), 0 );
  return p;
}


Particle addBaseNode() {
  Particle p = physics.makeParticle();
  if (physics.numberOfParticles() > 1) {
    addSpacersToNew(p);
  }
  return p;
}
