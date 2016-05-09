import processing.core.*;
import java.util.ArrayList;

public class Toroid extends Geom3 {

  private float outerRadius, ringRadius;
  private int outerDetail, ringDetail;

  public Toroid() {
  }

  public Toroid(PApplet p, RGBA col, String tex, float outerRadius, 
    float ringRadius, int outerDetail, int ringDetail) {

    super(p, col, tex);
    this.outerRadius = outerRadius;
    this.ringRadius = ringRadius;
    this.outerDetail = outerDetail;
    this.ringDetail = ringDetail;

    _init();
  }

  public void _init() {
    // note: Geometry technically not closed
    verts = new ArrayList<Vertex>();
    inds = new ArrayList<Index>();
    faces = new ArrayList<Face>();

    // verts
    float theta = 0.0f;
    for (int i=0; i<ringDetail; i++) {
      float phi = 0.0f;
      float x = outerRadius + p.cos(theta)*ringRadius;
      float y = p.sin(theta)*ringRadius;
      float z = 0;
      for (int j=0; j<outerDetail; j++) {
        float pz = - p.sin(phi)*x;
        float px = p.cos(phi)*x;

        // vertices
        verts.add(new Vertex(new PVector(px, y, pz), new PVector(), col, new UV((float)((theta+1.0))*.75f, (float)((phi+1.0))*1.35f)));
        // overlap 1st and last pt to avoid seam
        phi += p.TWO_PI/(outerDetail-1);
      }
      // overlap 1st and last pt to avoid seam
      theta += p.TWO_PI/(ringDetail-1);
    }

    // indices
    for (int i=0; i<ringDetail; i++) {
      for (int j=0; j<outerDetail; j++) {
        int k = i*outerDetail + j;
        int l = (i+1)*outerDetail + j;
        int m = (i+1)*outerDetail + j+1;
        int n = i*outerDetail + j+1;
        if (i<ringDetail-1 && j<outerDetail-1) {
          // tri 1
          inds.add(new Index(k, l, m));
          // tri 2
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