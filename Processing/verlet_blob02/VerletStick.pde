class VerletStick {
  VerletNode n1, n2;
  float tension;
  boolean isVisible;

  PVector vecOrig;
  float len;

  VerletStick() {
  }

  VerletStick(VerletNode n1, VerletNode n2, float tension, boolean isVisible) {
    this.n1 = n1;
    this.n2 = n2;
    this.tension = tension;
    this.isVisible = isVisible;
    vecOrig  = new PVector(n2.pos.x-n1.pos.x, n2.pos.y-n1.pos.y);
    len = dist(n1.pos.x, n1.pos.y, n2.pos.x, n2.pos.y);
  }

  void render() {
    if (isVisible) {
      beginShape();
      vertex(n1.pos.x, n1.pos.y);
      vertex(n2.pos.x, n2.pos.y);
      endShape();
    }
  }

  void constrainLen() {
    PVector delta = new PVector(n2.pos.x-n1.pos.x, n2.pos.y-n1.pos.y);
    float deltaLength = delta.mag();
    float difference = ((deltaLength - len) / deltaLength);
    n1.pos.x += delta.x * (0.5f * tension * difference);
    n1.pos.y += delta.y * (0.5f * tension * difference);
    n2.pos.x -= delta.x * (0.5f * tension * difference);
    n2.pos.y -= delta.y * (0.5f * tension * difference);
  }
}