/**
 * Verlet Integration - ragdoll chain
 * Pos  = pos + (pos-posOld)
 * alternative to  x += speed
 *  -with free rotational velocity
 */

int particles = 20;
VerletBall[] balls = new VerletBall[particles];
int bonds = particles-1;
VerletStick[] sticks = new VerletStick[bonds];

void setup() {
  size(400, 400);
  float shapeR = 40;
  float tension = .9;
  for (int i=0; i<particles; i++) {
    PVector push = new PVector(random(3, 6.5), random(3, 6.5));
    PVector p = new PVector(width/2+shapeR*i, height/2);
    balls[i] = new VerletBall(p, push, 5);
    
    if (i>0) {
      sticks[i-1] = new VerletStick(balls[i-1], balls[i], tension);
    } 
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

