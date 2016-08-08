/**
 * Euler Integration (v01)
 * Pos  +=  spd 
 */


EulerBall ball;

void setup() {
  size(400, 400);
  PVector pos = new PVector(width/2, height/2);
  PVector spd = new PVector(random(-3, 3), random(-3, 3));
  ball = new EulerBall(pos, spd, 10);
}

void draw() {
  background(255);
  //fill(255, 2);
  //rect(-1, -1, width+1, height+1);
  fill(0);
  ball.move();
  ball.render();
  ball.boundsCollision();
}


