/**
 * Verlet Integration - Collapsing Form
 * Pos  = pos + (pos-posOld)
 * alternative to  x += speed
 */

int particles = 4;
VerletBall[] balls = new VerletBall[particles];
int bonds = particles;
VerletStick[] sticks = new VerletStick[bonds];

void setup() {
  size(400, 400);
  float theta = PI/4.0;
  float shapeR = 80;
  float tension = .02;
  for (int i=0; i<particles; i++) {
    PVector push = new PVector(random(1, 3.5), random(1, 3.5));
    PVector p = new PVector(width/2+cos(theta)*shapeR, height/2+sin(theta)*shapeR);
    balls[i] = new VerletBall(p, push, 10);
    if (i>0){
      sticks[i-1] = new VerletStick(balls[i-1], balls[i], tension);
    }
    if (i== particles-1){
      sticks[i] = new VerletStick(balls[i], balls[0], tension);
    }
    theta += TWO_PI/particles;
  }
}

void draw() {
  background(255);
   for (int i=0; i<bonds; i++) {
    sticks[i].render();
    sticks[i].constrainLen();
  }
  
   for (int i=0; i<particles; i++) {
    balls[i].verlet();
    balls[i].render();
    balls[i].boundsCollision();
  }
}


