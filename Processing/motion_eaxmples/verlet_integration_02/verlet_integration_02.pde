/**
 * Verlet Integration
 * Pos  = pos + (pos-posOld)
 * alternative to  x += speed
 */

int particles = 2;
VerletBall[] balls = new VerletBall[particles];
int bonds = 1;
VerletStick[] sticks = new VerletStick[bonds];

void setup() {
  size(400, 400);
  float theta = PI/4.0;
  float shapeR = 40;
  PVector push = new PVector(1.5, 2.2);
  for (int i=0; i<particles; i++) {
    PVector p = new PVector(width/2+cos(theta)*shapeR, height/2+sin(theta)*shapeR);
    balls[i] = new VerletBall(p, push, 10);
    theta += TWO_PI/particles;
  }
  sticks[0] = new VerletStick(balls[0], balls[1]);
}

void draw() {
  background(255);
  sticks[0].render();
  sticks[0].constrainLen();

  balls[0].verlet();
  balls[0].render();
  balls[0].boundsCollision();

  balls[1].verlet();
  balls[1].render();
  balls[1].boundsCollision();
}



