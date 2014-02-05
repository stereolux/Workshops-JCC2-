// Algorithmes créatifs - Abelardo Gil-Fournier, 2014
// http://abelardogfournier.org
// http://github.org/abe-
//
// Vectors are a very useful representation of both
// coordinates and directions. They can be used to manipulate 
// positions -points in the space- as well velocities and forces
// -movement and direction-. And also, they are very good at
// working with angles


PVector pos, vel;

void setup() {
  size( 400, 400 );
  pos = new PVector(200, 100);  // Vectors represent the same 
  vel = new PVector(2, 1);      // way positions and velocities.
}                               // A key feature when simulating  
                                // Natural phaenomena
void update() {
  pos.add(vel);                 // Adding the vel vector to the
}                               // position creates lineas movement

void draw() {
  background(255);
  update();
  float ang = vel.heading();    // Working with vectors means also
  fill(255, 0, 0);              // working with angles, directions
  noStroke();
  arc(pos.x, pos.y, 20, 20, ang-0.2, ang+.2);
}

void mouseReleased() {
  pos.set(mouseX, mouseY);      // With this simple sketch we
  vel.set(mouseX-pmouseX, mouseY-pmouseY); // transfer the user
  vel.limit(3);                 // gesture energy to the particle's
}
