/** 
 * Point masses at Verlet surface
 * vertices. Verlet sticks each include 
 * a reference to two Verlet balls.
 * By: Ira Greenberg 
 * December 2010
 */

class VerletBall {

  PVector pos, posOld;
  float radius = 1;

  VerletBall() {
  }

  VerletBall(PVector pos) {
    this.pos = pos;
    posOld = new PVector(pos.x, pos.y, pos.z);
  }

  VerletBall(PVector pos, float radius) {
    this.pos = pos;
    this.radius = radius;
    posOld = new PVector(pos.x, pos.y, pos.z);
  }

  void verlet() {
    PVector posTemp = new PVector(pos.x, pos.y, pos.z);
    pos.x += (pos.x-posOld.x);
    pos.y += (pos.y-posOld.y);
    pos.z += (pos.z-posOld.z);
    posOld.set(posTemp);
  }

  void render() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    box(radius*2, radius*2, radius*2);
    popMatrix();
  }
}

