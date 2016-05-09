import processing.core.*;

public class Vertex {
  public PVector pos, n;
  public RGBA col;
  public UV uv;
  
  public Vertex() {
  }

  public Vertex(PVector pos, PVector n, RGBA col, UV uv) {
    this.pos = pos;
    this.n = n;
    this.col = col;
    this.uv = uv;
  }
}