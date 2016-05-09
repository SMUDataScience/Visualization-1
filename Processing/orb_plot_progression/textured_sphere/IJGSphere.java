import processing.core.*;
import java.util.ArrayList;

public class IJGSphere extends Geom3 {

  private float radius;
  private int slices, stacks;

  public IJGSphere() {
  }

  public IJGSphere(PApplet p, RGBA col, String tex, float radius, 
    int slices, int stacks) {

    super(p, col, tex);
    this.radius = radius;
    this.slices = slices;
    this.stacks = stacks;

    _init();
  }

  public void _init() {
    // note: Geometry technically not closed
    verts = new ArrayList<Vertex>();
    inds = new ArrayList<Index>();
    faces = new ArrayList<Face>();

    // verts
    float theta = -p.PI/2.0f; // start at pole
    for (int i=0, k=0; i<stacks; i++) {
      float phi = 0.0f;
      // initial arc around z-axis
      float x = p.cos(theta)*radius;
      float y = p.sin(theta)*radius;
      float z = 0;
      for (int j=0; j<slices; j++) {
        // sweep arc around y-axis
        float pz = p.cos(phi)*z - p.sin(phi)*x;
        float px = p.sin(phi)*z + p.cos(phi)*x;
        float u = (float)((phi+1.0))*.25f;
        float v = (float)((theta+1.0))*.25f;
        verts.add(new Vertex(new PVector(px, y, pz), new PVector(), col, new UV(u, v)));
        phi += p.TWO_PI/(slices-1); // make sure texture seams join up.
      }
      theta += p.PI/(stacks-1);
    }

    // indices
    for (int i=0; i<stacks-1; i++) {
      for (int j=0; j<slices; j++) {
        int k = i*slices+j;
        int l = (i+1)*slices+j;
        int m = (i+1)*slices+j+1;
        int n = i*slices+j+1;
        if (j<slices-1) {
          inds.add(new Index(k, l, m));
          inds.add(new Index(k, m, n));
        }
      }
    }

    // faces
    for (Index i : inds) {
      faces.add(new Face(verts.get(i.elem0), verts.get(i.elem1), verts.get(i.elem2)));
    }

    calcVertNorms();
  }
}