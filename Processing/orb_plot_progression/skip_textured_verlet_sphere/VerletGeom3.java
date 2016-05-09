import processing.core.*;
import java.util.ArrayList;

public abstract class VerletGeom3 {
  protected PApplet p;
  protected RGBA col;
  protected UV uv;
  protected String tex;
  protected ArrayList<VerletNode> nodes;
  protected ArrayList<VerletStick> sticks;
  protected ArrayList<Index> inds;
  protected ArrayList<Face> faces;
  protected PImage texImg;
  protected boolean isSmooth;


  public VerletGeom3() {
  }

  public VerletGeom3(PApplet p, RGBA col, String tex) {
    this.p = p;
    this.col = col;
    this.tex = tex;
    texImg = p.loadImage(tex);
  }

  // Override
  protected abstract void _init();

  // for smooth rendering
  protected void calcVertNorms() {
    for (VerletNode node : nodes) {
      PVector vn = new PVector();
      for (Face f : faces) {
        // test by address
        if (node.pos == f.v0.pos || node.pos == f.v1.pos || node.pos == f.v2.pos) {
          // test by position
          //if (v.pos.dist(f.v0.pos)<1 || v.pos.dist(f.v1.pos)<1 || v.pos.dist(f.v2.pos)<1) {
          vn.add(f.getNorm());
        }
      }
      node.n.set(vn.normalize());
    }
  }

  public void setSmooth(boolean isSmooth) {
    this.isSmooth = isSmooth;
  }

  public void display() {
    for (int i=0; i<sticks.size(); i++) {
      sticks.get(i).constrainLen();
    }

    for (int i=0; i<nodes.size(); i++) {
      nodes.get(i).verlet();
    }

    p.fill(col.r, col.g, col.b, col.a); // not doing much
    p.beginShape(p.TRIANGLES);
    p.textureMode(p.NORMAL);
    p.textureWrap(p.REPEAT);
    p.texture(texImg);
    for (Face f : faces) {
      if (isSmooth) {
        p.normal(f.v0.n.x, f.v0.n.y, f.v0.n.z);
      } // else use Processing's default surface norms
      p.vertex(f.v0.pos.x, f.v0.pos.y, f.v0.pos.z, f.v0.uv.u, f.v0.uv.v);
      if (isSmooth) {
        p.normal(f.v1.n.x, f.v1.n.y, f.v1.n.z);
      }
      p.vertex(f.v1.pos.x, f.v1.pos.y, f.v1.pos.z, f.v1.uv.u, f.v1.uv.v);
      if (isSmooth) {
        p.normal(f.v2.n.x, f.v2.n.y, f.v2.n.z);
      }
      p.vertex(f.v2.pos.x, f.v2.pos.y, f.v2.pos.z, f.v2.uv.u, f.v2.uv.v);
    }
    p.endShape();


    //p.strokeWeight(5);
    //for (int i=0; i< verts.size(); i++) {
    //  p.stroke(255);
    //  p.point(verts.get(i).pos.x, verts.get(i).pos.y, verts.get(i).pos.z);
    //}

    //for (int i=0; i< vecs.size(); i++) {
    //  p.stroke(255);
    // // p.point(vecs.get(i).x, vecs.get(i).y, vecs.get(i).z);
    //}
  }
}