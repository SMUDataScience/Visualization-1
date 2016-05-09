import processing.core.*;

public class Face {
  public Vertex v0, v1, v2;

  public Face() {
  }
  
  public Face(Vertex v0, Vertex v1, Vertex v2) {
    this.v0 = v0;
    this.v1 = v1;
    this.v2 = v2;
  }
  
  public PVector getNorm() {

    // clone v1
    PVector a = new PVector();
    a.set(v1.pos);

    // clone v2
    PVector b = new PVector();
    b.set(v2.pos);

    // make a and b relative to v0
    a.sub(v0.pos);
    b.sub(v0.pos);

    // make unit len
    a.normalize();
    b.normalize();

    // return surface normal
    return a.cross(b);
  }
}