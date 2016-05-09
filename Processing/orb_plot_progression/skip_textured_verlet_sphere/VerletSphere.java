import processing.core.*;
import java.util.ArrayList;

public class VerletSphere extends VerletGeom3 {

  private float radius;
  private int slices, stacks;

  public VerletSphere() {
  }

  public VerletSphere(PApplet p, RGBA col, String tex, float radius, 
    int slices, int stacks) {

    super(p, col, tex);
    this.radius = radius;
    this.slices = slices;
    this.stacks = stacks;
    _init();
  }

  public void _init() {
    // note: Geometry technically not closed
    //verts = new ArrayList<Vertex>();
    inds = new ArrayList<Index>();
    faces = new ArrayList<Face>();

    nodes = new ArrayList<VerletNode>();
    sticks = new ArrayList<VerletStick>();

    // verts
    float theta = -p.PI/2.0f; // start at pole
    float x = 0;
    float y = 0;
    float z = 0;
    for (int i=0; i<stacks; i++) {
      float phi = 0.0f;
      // initial arc around z-axis
      x = p.cos(theta)*radius;
      y = p.sin(theta)*radius;
      for (int j=0; j<slices; j++) {
        // sweep arc around y-axis
        float pz = p.cos(phi)*z - p.sin(phi)*x;
        float px = p.sin(phi)*z + p.cos(phi)*x;
        float py = y;
        float u = (float)((phi+1.0))*.75f;
        float v = (float)((theta+1.0))*.75f;
       //VerletNode(PApplet p, PVector pos, PVector push, float radius) {
       nodes.add(new Vertex(p, new PVector(px, py, pz), new PVector(0, 0), col, new UV(v, u)));
        // vecs.add(new PVector(px, py, pz));
        if (i==7 && j==8) {
          nodes.add(new VerletBall(p, verts.get(i).pos, new PVector(2.2f, 2.2f), 2));
        } else {
          nodes.add(new VerletBall(p, verts.get(i).pos, new PVector(0, 0), 2));
        }
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
      sticks.add(new VerletStick(p, nodes.get(i.elem0).pos, nodes.get(i.elem1).pos, .5f));
      sticks.add(new VerletStick(p, nodes.get(i.elem1).pos, nodes.get(i.elem2).pos, .5f));
      sticks.add(new VerletStick(p, nodes.get(i.elem0).pos, nodes.get(i.elem2).pos, .5f));
    }

    calcVertNorms();
  }
}