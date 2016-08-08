/**
 * Euler Integration (v02)
 * Pos  +=  spd 
 */


EulerBall ball;

void setup() {
  size(400, 400);
  PVector pos = new PVector(width/2, 0);
  PVector spd = new PVector(random(-3, 3), random(-3, 3));
  ball = new EulerBall(pos, spd, 10);
  //ball.setAccel(.4);
}

void draw() {
  background(255);
  ball.move();
  ball.render();
  ball.boundsCollision();
}


