class VerletStick {
  VerletBall b1, b2;
  float stiffness;
  VerletBall[] balls = new VerletBall[2];
  PVector vecOrig;
  float len;

  VerletStick() {
  }

  VerletStick(VerletBall b1, VerletBall b2, float stiffness) {
    balls[0] = this.b1 = b1;
    balls[1] = this.b2 = b2;
    this.stiffness = stiffness;
    vecOrig  = new PVector(b2.pos.x-b1.pos.x, b2.pos.y-b1.pos.y);
    len = dist(b1.pos.x, b1.pos.y, b2.pos.x, b2.pos.y);
  }

  void render() {
    beginShape();
    vertex(b1.pos.x, b1.pos.y);
    vertex(b2.pos.x, b2.pos.y);
    endShape();
  }

  void constrainLen() {

    // collision code 
    for (int ii=0; ii<5; ii++) {

      PVector delta = new PVector(b2.pos.x-b1.pos.x, b2.pos.y-b1.pos.y);
      float deltaLength = delta.mag();
      float difference = ((deltaLength - len) / deltaLength);
      b1.pos.x += delta.x * (0.5f * stiffness * difference);
      b1.pos.y += delta.y * (0.5f * stiffness * difference);
      b2.pos.x -= delta.x * (0.5f * stiffness * difference);
      b2.pos.y -= delta.y * (0.5f * stiffness * difference);

      for (int i=0; i<balls.length; i++) {
        if (balls[i].pos.x>width-balls[i].radius) {
          balls[i].pos.x = width-balls[i].radius;
        } 
        else if(balls[i].pos.x<balls[i].radius) {
          balls[i].pos.x = balls[i].radius;
        }

        if (balls[i].pos.y>height-balls[i].radius) {
          balls[i].pos.y = height-balls[i].radius;
          balls[i].posOld.y = balls[i].pos.y;
          balls[i].pos.sub(balls[i].push);
        } 
        else if(balls[i].pos.y<balls[i].radius) {
          balls[i].pos.y = balls[i].radius;
        }
      }
    }
  }
}





