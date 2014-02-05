import java.util.*;

ArrayList <Lighthouse> lhs;
ArrayList <Submarine> subs;
ArrayList <Follower> planes;
HashMap <Integer, PVector> bonds;

void setup() {
  size( 1000, 800, P2D );

  lhs = new ArrayList();
  Lighthouse lh1 = new Lighthouse(550, 500, radians(40));
  Lighthouse lh2 = new Lighthouse(100, 100, radians(40));
  lhs.add(lh1);
  lhs.add(lh2);

  subs = new ArrayList();
  for (int n = 0; n < 10; n++) {
    Submarine sub = new Submarine(random(width), random(height));
    subs.add(sub);
  }

  planes = new ArrayList();
  for (int n = 0; n < 7; n++) {
    Follower f = new Follower(n, random(width), random(height));
    planes.add(f);
  }

  bonds = new HashMap();
  for (Follower plane : planes) {
    int n = planes.indexOf(plane);
    Submarine sub = subs.get(n);
    bonds.put(n, sub);
  }
}

void draw() {
  background(220);

  for (Lighthouse lh : lhs) {
    lh.drawBeam();
  }
  for (Lighthouse lh : lhs) {
    lh.draw();
  }

  Iterator iter = bonds.entrySet().iterator();
  while( iter.hasNext() ) {
    Map.Entry bond = (Map.Entry) iter.next();
    if (bond.getValue() instanceof Submarine) {
      Submarine sub = (Submarine) bond.getValue();
      Follower plane = planes.get((Integer) bond.getKey());
      //if (plane.dist(sub) < 10) sub.visible = 0;
      if (sub.visible == 0) {
        iter.remove();
      }
    }
  }

  for (Submarine sub : subs) {
    sub.draw();
    if (sub.visible > 0) {
      if (!bonds.containsValue(sub) && bonds.size() < planes.size()) {
        int n = 0;
        while(bonds.containsKey(n)) n = (n+1) % planes.size();
        Follower plane = planes.get(n);
        bonds.put(plane.id, sub);
        println(plane.id);
      }
    }
  }
  
  //println(bonds.size());

  for (Follower plane : planes) {
    int n = planes.indexOf(plane);
    if (!bonds.containsKey(n)) {
      int m = (n+1) % planes.size();
      //bonds.put(n, planes.get(m));
      Follower nextPlane = planes.get(m);
      if (plane.dist(nextPlane) > 50 && n != 0)
        plane.seek(nextPlane.x, nextPlane.y);
    }
    else {
      PVector pos = bonds.get(n);
      plane.seek(pos.x, pos.y);
    }    
    plane.draw();
  }
}

