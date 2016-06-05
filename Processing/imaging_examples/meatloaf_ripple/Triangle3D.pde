/** 
 * Simple 3D traingle face class
 * encapsulating three PVectors.
 * Includes own getNormal method.
 * By: Ira Greenberg 
 * December 2010
 */

class Triangle3D {
  PVector v0, v1, v2;
  PVector[] vs;
  PVector n;

  Triangle3D() {
  }

  Triangle3D(PVector v0, PVector v1, PVector v2) {
    this.v0 = v0;
    this.v1 = v1;
    this.v2 = v2;
    vs = new PVector[] {
      v0, v1, v2
    };
  }

  PVector getNormal() {
    n = new PVector();
    n = PVector.cross(PVector.sub(v1, v2), PVector.sub(v0, v2), null);
    n.normalize();
    return(n);
  }

  void render() {
    fill(127);
    //stroke(0);
    beginShape(TRIANGLES);
    for (int i=0;i<3; i++) {
      vertex(vs[i].x, vs[i].y, vs[i].z);
    }
    endShape();
  }

  void renderNorm(float len) {
    stroke(200, 100, 0);
    noFill();
    PVector n = getNormal();
    n.mult(len);
    PVector o = getOrigin();
    beginShape();
    vertex(o.x, o.y, o.z);
    vertex(o.x-n.x, o.y-n.y, o.z-n.z);
    endShape();
  }

  PVector getOrigin() {
    PVector origin = new PVector();
    origin.set(v0);
    origin.add(v1);
    origin.add(v2);
    origin.div(3);
    return origin;
  }
}

