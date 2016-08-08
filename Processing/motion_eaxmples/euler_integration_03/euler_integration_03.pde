/**
 * Euler Integration (v03)
 * Pos  +=  spd 
 */


int ballCount = 300;
EulerBall[] balls = new EulerBall[ballCount];

void setup() {
  size(400, 400);
  for (int i=0; i<ballCount; i++) {
    balls[i] = new EulerBall(new PVector(random(width), random(20)), new PVector(random(-3, 3), random(-3, 3)), random(2, 10));
    balls[i].setAccel(.02);
  }
}

void draw() {
  background(255);
  for (int i=0; i<ballCount; i++) {
    balls[i].move();
    balls[i].render();
    balls[i].boundsCollision();
  }
}

