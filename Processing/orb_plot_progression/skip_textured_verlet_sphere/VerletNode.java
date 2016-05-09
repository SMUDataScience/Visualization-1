import processing.core.*;

public class VerletNode {

  public PVector pos, posOld;
  public PVector push;
  public float radius;
  public PVector n;
  private PApplet p;

  public VerletNode() {
  }

  public VerletNode(PApplet p, PVector pos, PVector push, float radius) {
    this.p = p;
    this.pos = pos;
    this.push = push;
    this.radius = radius;
    this.posOld  = new PVector(pos.x, pos.y);

    // start motion
    pos.add(push);
    //pos.add(new PVector(2.1f, 2.1f));
  }
  
  public void _init() {
  }

  public void verlet() {
    PVector posTemp = new PVector(pos.x, pos.y);
    pos.x += (pos.x-posOld.x);
    pos.y += (pos.y-posOld.y);
    posOld.set(posTemp);
  }

  public void render() {
    p.ellipse(pos.x, pos.y, radius*2, radius*2);
  }

  public void boundsCollision() {
    if (pos.x>p.width-radius) {
      pos.x = p.width-radius;
      posOld.x = pos.x;
      pos.x -= push.x;
    } else if (pos.x<radius) {
      pos.x = radius;
      posOld.x = pos.x;
      pos.x += push.x;
    }

    if (pos.y<radius) {
      pos.y = radius;
      posOld.y = pos.y;
      pos.y += push.y;
    } else if (pos.y>p.height-radius) {
      pos.y = p.height-radius;
      posOld.y = pos.y;
      pos.y -= push.y;
    }
  }
}