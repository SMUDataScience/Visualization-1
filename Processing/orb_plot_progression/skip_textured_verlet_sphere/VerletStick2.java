import processing.core.*;

public class VerletStick2 {
  public VerletBall b1, b2;
  public float stiffness;
  
  public PVector vecOrig;
  public float len;
  
  private PApplet p;

  public VerletStick2(){
  }

  public VerletStick2(PApplet p, VerletBall b1, VerletBall b2, float stiffness){
    this.p = p;
    this.b1 = b1;
    this.b2 = b2;
    this.stiffness = stiffness;
    vecOrig  = new PVector(b2.pos.x-b1.pos.x, b2.pos.y-b1.pos.y);
    len = p.dist(b1.pos.x, b1.pos.y, b2.pos.x, b2.pos.y);
  }

  public void render(){
    p.beginShape();
    p.vertex(b1.pos.x, b1.pos.y);
    p.vertex(b2.pos.x, b2.pos.y);
    p.endShape();
  }

  public void constrainLen(){
    PVector delta = new PVector(b2.pos.x-b1.pos.x, b2.pos.y-b1.pos.y);
    float deltaLength = delta.mag();
    float difference = ((deltaLength - len) / deltaLength);
    b1.pos.x += delta.x * (0.5f * stiffness * difference);
    b1.pos.y += delta.y * (0.5f * stiffness * difference);
    b2.pos.x -= delta.x * (0.5f * stiffness * difference);
    b2.pos.y -= delta.y * (0.5f * stiffness * difference);
  }

}