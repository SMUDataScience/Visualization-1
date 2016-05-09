import processing.core.*;

public class VerletStick {
  public VerletNode vn1, vn2;
  public float stiffness;
  
  public PVector vecOrig;
  public float len;
  
  private PApplet p;

  public VerletStick(){
  }

  public VerletStick(PApplet p, VerletNode vn1, VerletNode vn2, float stiffness){
    this.p = p;
    this.vn1 = vn1;
    this.vn2 = vn2;
    this.stiffness = stiffness;
    vecOrig  = new PVector(vn2.pos.x-vn1.pos.x, vn2.pos.y-vn1.pos.y);
    len = p.dist(vn1.x,vn1.pos.y, vn2.pos.x, vn2.pos.y);
  }

  public void render(){
    p.beginShape();
    p.vertex(vn1.pos.x, vn1.pos.y);
    p.vertex(vn2.pos.x, vn2.pos.y);
    p.endShape();
  }

  public void constrainLen(){
    PVector delta = new PVector(vn2.pos.x-vn1.pos.x, vn2.pos.y-vn1.pos.y);
    float deltaLength = delta.mag();
    float difference = ((deltaLength - len) / deltaLength);
    vn1.pos.x += delta.x * (0.5f * stiffness * difference);
    vn1.pos.y += delta.y * (0.5f * stiffness * difference);
    vn2.pos.x -= delta.x * (0.5f * stiffness * difference);
    vn2.pos.y -= delta.y * (0.5f * stiffness * difference);
  }

}