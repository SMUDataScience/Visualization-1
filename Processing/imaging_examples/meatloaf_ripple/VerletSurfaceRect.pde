/** 
 * VerletSurface subclass for creating 
 * rectanglular surfaces with corner anchors.
 * By: Ira Greenberg 
 * December 2010
 */

class VerletSurfaceRect extends VerletSurface {

  int rows, cols;
  PImage img;

  TimeBomb[] tBombs;
  int dynamicCount;
  int timeIn;

  VerletSurfaceRect() {
  }

  VerletSurfaceRect(PVector loc, Dimension3D dim, int rows, int cols) {
    super(loc, dim);
    this.rows = rows;
    this.cols = cols;
    isFixedIndex = new boolean[4];
    init();
  }

  VerletSurfaceRect(PVector loc, Dimension3D dim, int rows, int cols, boolean[] isFixedIndex, float tension) {
    super(loc, dim);
    this.rows = rows;
    this.cols = cols;
    this.isFixedIndex = isFixedIndex;
    this.tension = tension;
    init();
  }

  void init() {
    vBalls = new VerletBall[rows*cols];
    vBallInitPos = new PVector[rows*cols];
    vBalls2D = new VerletBall[rows][cols];
    uvs = new PVector[rows][cols];

    tBombs = new TimeBomb[60];
    int r = rows-1;
    int c = cols-1;
    int stickCount = cols*r + rows*c + r*c;
    vSticks = new VerletStick[stickCount];
    tris = new Triangle3D[r*c*2];

    //sNorms = new PVector[tris.length];
    vNorms = new PVector[rows*cols]; 

    anchors = new PVector[4];

    createVBalls();
    createVSticks();
    createTris();
    createAnchors();
    setAnchors();
    createTimeBombs();


    img = loadImage("portrait.jpg");
    //img = loadImage("old_clock_face.jpg");
   // img = loadImage("clockface2.jpg");

    timeIn = millis();
  }

  // Instantiate Vertex balls
  void createVBalls() {
    float xShift = dim.w/(cols-1);
    float zShift = dim.d/(rows-1);

    // UV Texturing
    float uShift = 1.0/(cols-1);
    float vShift = 1.0/(rows-1);

    float x = -dim.w/2;
    float z = -dim.d/2;
    //int center = int((rows)/2)*(cols) + int((cols)/2);
    for (int i=0; i<rows; i++) {
      for (int j=0; j<cols; j++) {
        float bx = x + xShift*j;
        float bz = z + zShift*i;
        println("bx = " + bx + ", bz = " + bz);
        PVector pos = new PVector(bx, 0, bz); 
        vBallInitPos[i*cols+j] = new PVector(bx, 0, bz);
        vBalls2D[i][j] = new VerletBall(pos, 2.0);
        // set 1D arr version to point to same mem addresses
        vBalls[i*cols+j] = vBalls2D[i][j];

        // new UV code
        float bu = uShift*j;
        float bv = vShift*i;
        uvs[i][j] = new PVector(bu, bv);
      }
    }
  }

  // Instantiate Vertex sticks.
  void createVSticks() {
    int stickCounter = 0;
    for (int i=0; i<rows; i++) {
      for (int j=0; j<cols; j++) {

        if (i<rows-1) {
          // anchor top left corner:  | stick
          if (i==0 && j==0 && isFixedIndex[0]) {
            vSticks[stickCounter++] = new VerletStick(vBalls2D[i][j], vBalls2D[i+1][j], .1, new Tuple2D(0.0, 1.0));
          } 
          // anchor top right corner:  | stick
          else if (i==0 && j==cols-1 && isFixedIndex[1]) {
            vSticks[stickCounter++] = new VerletStick(vBalls2D[i][j], vBalls2D[i+1][j], .1, new Tuple2D(0.0, 1.0));
          } 
          // anchor bottom right corner:  | stick
          else if (i==rows-2 && j==cols-1 && isFixedIndex[2]) {
            vSticks[stickCounter++] = new VerletStick(vBalls2D[i][j], vBalls2D[i+1][j], .1, new Tuple2D(1.0, 0.0));
          } 
          // anchor bottom left corner:  | stick
          else if (i==rows-2 && j==0 && isFixedIndex[3]) {
            vSticks[stickCounter++] = new VerletStick(vBalls2D[i][j], vBalls2D[i+1][j], .1, new Tuple2D(1.0, 0.0));
          } 
          // no anchors
          else {
            vSticks[stickCounter++] = new VerletStick(vBalls2D[i][j], vBalls2D[i+1][j], tension);
          }
        } 

        if (j<cols-1) {
          // anchor top left corner:  -- stick
          if (i==0 && j==0 && isFixedIndex[0]) {
            vSticks[stickCounter++] = new VerletStick(vBalls2D[i][j], vBalls2D[i][j+1], .1, new Tuple2D(0.0, 1.0));
          }  // anchor top right corner:  -- stick
          else if (i==0 && j==cols-2 && isFixedIndex[1]) {
            vSticks[stickCounter++] = new VerletStick(vBalls2D[i][j], vBalls2D[i][j+1], .1, new Tuple2D(1.0, 0.0));
          }  // anchor bottom right corner:  -- stick
          else if (i==rows-1 && j==cols-2 && isFixedIndex[2]) {
            vSticks[stickCounter++] = new VerletStick(vBalls2D[i][j], vBalls2D[i][j+1], .1, new Tuple2D(1.0, 0.0));
          }  // anchor bottom left corner:  -- stick
          else if (i==rows-1 && j==0 && isFixedIndex[3]) {
            vSticks[stickCounter++] = new VerletStick(vBalls2D[i][j], vBalls2D[i][j+1], .1, new Tuple2D(0.0, 1.0));
          } 
          // no anchors
          else {
            vSticks[stickCounter++] = new VerletStick(vBalls2D[i][j], vBalls2D[i][j+1], tension);
          }
        }
      }
    }
    // diagonal sticks
    for (int i=0; i<rows-1; i++) {
      for (int j=0; j<cols-1; j++) {
        vSticks[stickCounter++] = new VerletStick(vBalls2D[i][j], vBalls2D[i+1][j+1], tension);
      }
    }
  }

  // Creates triangle faces
  void createTris() {
    int triCounter = 0;
    for (int i=0; i<vBalls2D.length-1; i++) {
      for (int j=0; j<vBalls2D[i].length-1; j++) {
        tris[triCounter] = new Triangle3D(vBalls2D[i][j].pos, vBalls2D[i][j+1].pos, vBalls2D[i+1][j+1].pos);
        //sNorms[triCounter] = tris[triCounter].getNormal();
        triCounter++;
        tris[triCounter] = new Triangle3D(vBalls2D[i][j].pos, vBalls2D[i+1][j+1].pos, vBalls2D[i+1][j].pos);
        //sNorms[triCounter] = tris[triCounter].getNormal();
        triCounter++;
      }
    }
  }

  // Grab surface corner postions for anchors
  void createAnchors() {
    // LT anchor
    anchors[0] = new PVector(vBalls[0].pos.x, vBalls[0].pos.y, vBalls[0].pos.z);
    // RT anchor
    anchors[1] = new PVector(vBalls[cols-1].pos.x, vBalls[cols-1].pos.y, vBalls[cols-1].pos.z);
    // RB anchor
    anchors[2] = new PVector(vBalls[vBalls.length-1].pos.x, vBalls[vBalls.length-1].pos.y, vBalls[vBalls.length-1].pos.z);
    // LB anchor
    int index = vBalls.length-1-(cols-1);
    anchors[3] = new PVector(vBalls[index].pos.x, vBalls[index].pos.y, vBalls[index].pos.z);
  }

  // Apply anchors to surface corners, based on flags
  void setAnchors() {

    for (int i=0; i<vBalls.length; i++) {
      // attach corners to anchors - based on flag in isFixedIndex array
      if (i==0 && isFixedIndex[0]) {
        vBalls[i].pos.x = anchors[0].x;
        vBalls[i].pos.y = anchors[0].y;
        vBalls[i].pos.z = anchors[0].z;
      } 
      else if (i==cols-1 && isFixedIndex[1]) {
        vBalls[i].pos.x = anchors[1].x;
        vBalls[i].pos.y = anchors[1].y;
        vBalls[i].pos.z = anchors[1].z;
      } 
      else if (i==vBalls.length-1 && isFixedIndex[2]) {
        vBalls[i].pos.x = anchors[2].x;
        vBalls[i].pos.y = anchors[2].y;
        vBalls[i].pos.z = anchors[2].z;
      } 
      else if (i==vBalls.length-1 - (cols-1) && isFixedIndex[3]) {
        vBalls[i].pos.x = anchors[3].x;
        vBalls[i].pos.y = anchors[3].y;
        vBalls[i].pos.z = anchors[3].z;
      }
    }
  }

  void createTimeBombs() {
    PVector pos;
    float th = 0.0;
    float rad = dim.w/3.0;
    for (int i=0; i<tBombs.length; i++) {
      pos = new PVector(sin(th)*rad, -850, cos(th)*rad);
      tBombs[i] = new TimeBomb(pos, new Dimension3D(4, 4, 4), .4);
      th += TWO_PI/60.0;
    }
  }


  // Convenience no args render
  void render() {
    render(true, true, true);
  }

  // Selectively render point cloud, wireframe and/or surface
  void render(boolean isBallVisible, boolean isStickVisible, boolean isSurfaceVisible) {
    createVertexNormals();

    pushMatrix();
    translate(loc.x, loc.y, loc.z);
    int ctr = 0;

    // if surface rendering flag true
    if (isSurfaceVisible) {
      fill(255);
      textureMode(NORMALIZED);
      beginShape(TRIANGLES);
      texture(img);
      for (int i=0; i<rows-1; i++) {
        for (int j=0; j<cols-1; j++) {

          normal(vNorms[i*cols + j].x, vNorms[i*cols + j].y, vNorms[i*cols + j].z);
          vertex(vBalls2D[i][j].pos.x, vBalls2D[i][j].pos.y, vBalls2D[i][j].pos.z, uvs[i][j].x, uvs[i][j].y);
          normal(vNorms[i*cols + j+1].x, vNorms[i*cols + j+1].y, vNorms[i*cols + j+1].z);
          vertex(vBalls2D[i][j+1].pos.x, vBalls2D[i][j+1].pos.y, vBalls2D[i][j+1].pos.z, uvs[i][j+1].x, uvs[i][j+1].y);
          normal(vNorms[(i+1)*cols + j+1].x, vNorms[(i+1)*cols + j+1].y, vNorms[(i+1)*cols + j+1].z);
          vertex(vBalls2D[i+1][j+1].pos.x, vBalls2D[i+1][j+1].pos.y, vBalls2D[i+1][j+1].pos.z, uvs[i+1][j+1].x, uvs[i+1][j+1].y);
          normal(vNorms[i*cols + j].x, vNorms[i*cols + j].y, vNorms[i*cols + j].z);
          vertex(vBalls2D[i][j].pos.x, vBalls2D[i][j].pos.y, vBalls2D[i][j].pos.z, uvs[i][j].x, uvs[i][j].y);
          normal(vNorms[(i+1)*cols + j+1].x, vNorms[(i+1)*cols + j+1].y, vNorms[(i+1)*cols + j+1].z);
          vertex(vBalls2D[i+1][j+1].pos.x, vBalls2D[i+1][j+1].pos.y, vBalls2D[i+1][j+1].pos.z, uvs[i+1][j+1].x, uvs[i+1][j+1].y);
          normal(vNorms[(i+1)*cols + j].x, vNorms[(i+1)*cols + j].y, vNorms[(i+1)*cols + j].z);
          vertex(vBalls2D[i+1][j].pos.x, vBalls2D[i+1][j].pos.y, vBalls2D[i+1][j].pos.z, uvs[i+1][j].x, uvs[i+1][j].y);
        }
      }
      endShape();
    }
    // balls
    if (isBallVisible) {
      fill(200, 100, 0);
      for (int i=0; i<vBalls.length; i++) {
        vBalls[i].render();
      }
    }
    // stick
    if (isStickVisible) {
      stroke(100);
      for (int i=0; i<vSticks.length; i++) {
        vSticks[i].render();
      }
    }
    popMatrix();
  }
}

