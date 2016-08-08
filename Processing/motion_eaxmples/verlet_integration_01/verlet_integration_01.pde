/**
 * Verlet Integration
 * Pos  = pos + (pos-posOld)
 * alternative to  x += speed
 */


VerletBall ball;

void setup() {
  size(400, 400);
  float shapeR = 40;
  PVector push = new PVector(1.5, 2.2);
  PVector p = new PVector(width/2, height/2);
  ball = new VerletBall(p, push, 10);
}

void draw() {
  background(255);
  ball.verlet();
  ball.render();
  ball.boundsCollision();
}



