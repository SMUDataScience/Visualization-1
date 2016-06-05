/** 
 * Abstract class for building
 * Verlet surfaces.
 * By: Ira Greenberg 
 * December 2010
 */

abstract class VerletSurface {

  PVector loc;
  Dimension3D dim;
  // for tethering surface
  PVector[] anchors;
  boolean[] isFixedIndex;

  // for verlet sticks
  float tension = .4;

  VerletBall[] vBalls;
  VerletBall[][] vBalls2D; // convenience datatype
  PVector[] vBallInitPos;
  VerletStick[] vSticks; 
  PVector[][] uvs; // UV Texturing

  // Used to calculate vertex normals for smooth shading
  Triangle3D[] tris;
  //PVector[] sNorms;
  PVector[] vNorms;

  // Used for applied force to surface
  float theta = 0.0;

  public VerletSurface() {
  }

  public VerletSurface(PVector loc, Dimension3D dim) {
    this.loc = loc;
    this.dim = dim;
  }

  // implement these in subclass
  abstract void init();
  abstract void createVBalls();
  abstract void createVSticks();
  abstract void createTris();
  abstract void createAnchors();
  abstract void setAnchors();
  abstract void render(boolean isBallVisible, boolean isStickVisible, boolean isSurfaceVisible);

  public void createVertexNormals() {
    for (int i=0; i<vBalls.length; i++) {
      PVector vn = new PVector();
      int triCntr = 0;
      for (int j=0; j<tris.length; j++) {
        if (vBalls[i].pos == tris[j].v0 || vBalls[i].pos == tris[j].v1 || vBalls[i].pos == tris[j].v2) {
          triCntr++;
          vn.add(tris[j].getNormal());
        }
      }
      vn.div(triCntr);
      vNorms[i] = vn;
    }
  }

  // apply mouse touch (2D screen coord) to object deformation (3D model coord)
  // use gluProject
  public void applyForce(int mx, int my, float amp, float freq) {
    int id = 0;
    float x = screenX(vBalls[0].pos.x, vBalls[0].pos.y, vBalls[0].pos.z);
    float y = screenY(vBalls[0].pos.x, vBalls[0].pos.y, vBalls[0].pos.z);
    float d = dist(mx, my, x, y);
    for (int i=1; i<vBalls.length; i++) {
      x = screenX(vBalls[i].pos.x, vBalls[i].pos.y, vBalls[i].pos.z);
      y = screenY(vBalls[i].pos.x, vBalls[i].pos.y, vBalls[i].pos.z);
      float d2 = dist(mx, my, x, y);
      if(d2<d) {
        id = i;
        d = d2;
      }
    }
    vBalls[id].pos.y = vBallInitPos[id].y+cos(theta)*amp;
    theta+=freq*PI/180;
  }

  // Starts Verlet and constraints, including anchors
  public  void start() {
    // start verlet
    for (int i=0; i<vBalls.length; i++) {
      vBalls[i].verlet();
      setAnchors();
    }

    // Start constrain
    for (int i=0; i<vSticks.length; i++) {
      vSticks[i].constrainLen();
    }
  }

  Triangle3D[] getTris() {
    if (tris != null) {
      return tris;
    }
    return null;
  }

  VerletBall[] getVBalls() {
    return vBalls;
  }
  
  PVector[] getVNorms() {
    return vNorms;
  }
}

