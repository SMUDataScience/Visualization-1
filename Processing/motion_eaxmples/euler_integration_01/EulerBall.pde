class EulerBall {

  PVector pos;
  PVector spd;
  float radius;

  EulerBall() {
  }

  EulerBall(PVector pos, PVector spd, float radius) {
    this.pos = pos;
    this.spd = spd;
    this.radius = radius;
  }

  void move() {
    pos.add(spd);
  }

  void render() {
    ellipse(pos.x, pos.y, radius*2, radius*2);
  }

  void boundsCollision() {
    if (pos.x>width-radius) {
      pos.x = width-radius;
      spd.x *=-1;
    } 
    else if (pos.x<radius) {
      pos.x = radius;
      spd.x *=-1;
    }

    if (pos.y<radius) {
      pos.y = radius;
      spd.y *=-1;
    } 

    if (pos.y>height-radius) {
      pos.y = height-radius;
      spd.y *=-1;
    }
  }
}

