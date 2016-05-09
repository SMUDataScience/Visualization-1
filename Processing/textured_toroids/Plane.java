import processing.core.*;
import java.util.ArrayList;

public class Plane extends Geom3 {
  private float w, h;

  public Plane() {
  }

  public Plane(PApplet p, RGBA col, String tex, float w, float h) {

    super(p, col, tex);
    this.w = w;
    this.h = h;

    _init();
  }

  public void _init() {
    verts = new ArrayList<Vertex>();
    inds = new ArrayList<Index>();
    faces = new ArrayList<Face>();

    // verts
    float theta = -p.PI/4.0f;
    for (int i=0; i<4; i++) {
      verts.add(new Vertex(new PVector(p.cos(theta)*w/2, p.sin(theta)*h/2, 0.0f), new PVector(), col, 
        new UV((float)((p.cos(theta)+1.0)), (float)((p.sin(theta)+1.0)))));
        theta += p.TWO_PI/4;
    }

    // indices
    // tri 1
    inds.add(new Index(0, 1, 2));
    // tri 2
    inds.add(new Index(0, 2, 3));


    // faces
    for (Index i : inds) {
      faces.add(new Face(verts.get(i.elem0), verts.get(i.elem1), verts.get(i.elem2)));
    }

    calcVertNorms();
  }
}