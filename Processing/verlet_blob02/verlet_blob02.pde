/*
 * Verlet Integration - stable Form
 * Pos  = pos + (pos-posOld)
 * alternative to  x += speed
 */

VerletOrg org;

void setup() {
  size(900, 900);
  org = new VerletOrg(20, 240.0, .5, color(255, 127, 0, 35), color(127, 110, 140), true);
  org.nudge(new PVector(25.5, 5.5));
}


void draw() {
  fill(255, 35);
  rect(-1, -1, width+1, height+1);
  translate(width/2, height/2);
  org.verlet();
  org.display();
}