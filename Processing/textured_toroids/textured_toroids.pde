// 3D Geom Tutorial in Java mode
// Construct a lit and textured smooth Toroid and ground plane
// textures: http://img09.deviantart.net/5cd4/i/2009/173/9/f/seamless_wall_texture_06_by_caym.jpg, http://img04.deviantart.net/efba/i/2012/086/3/a/seamless_tileable_grass_texture_by_demolitiondan-d4u41a9.jpg

// Ira Greenberg, 2015

/*** Data Structures ***/
// Vertex: PVector(x, y, z), PVector(nx, ny, nz), RGBA(r, g, b, a), UV(u, v)
// Index: elem0, elem1, elem2
// Face: v0, v1, v2
// abstract Geom3

/*** Instructions ***/
// Up arrow for smooth render
// Down arrow for faceted render (default)

Plane p;


Toroid[] ts;
int cols = 2, rows = 2;
int toroidCount = cols*rows;
PVector[] locs;

void setup() {
  size(1024, 800, P3D);
  p = new Plane(this, new RGBA(50, 50, 50, 255), "grass.jpg", 4200, 4200);
  ts = new Toroid[toroidCount];
  locs = new PVector[toroidCount];
  float gapW = width*3/cols;
  float gapH = height*3/rows;

  for (int i=0; i<cols; i++) {
    for (int j=0; j<rows; j++) {
      int k = i*rows+j;
      ts[k] = new Toroid(this, new RGBA(120, 120, 120, 255), "stone.jpg", 180, 75, 18, 18);
      locs[k] = new PVector(i*gapW, j*gapH, 0);
      println( locs[k]);
    }
  }
  noStroke();
}
void draw() {
  background(0);
  ambientLight(85, 85, 85);
  emissive(30, 0, 0);
  lightSpecular(255, 255, 255);
  pointLight(255, 255, 255, -100, -100, 800);
  pointLight(150, 150, 150, -100, 100, 800);
  specular(255, 255, 255);
  shininess(20);

  pushMatrix();
  translate(width/2, height/2, -1000);
  rotateX(PI/3);
  rotateZ(frameCount*PI/1360);
  scale(1.2, 1.2);
  p.display();
  popMatrix();

  pushMatrix();
  translate(width/2, height/2.75, 0);
  rotateY(frameCount*PI/520);
  rotateX(-frameCount*PI/720);
  scale(.25);
  for (int i=0; i<toroidCount; i++) {
    pushMatrix();
    translate(locs[i].x, locs[i].y, locs[i].z);
    ts[i].display();
    popMatrix();
  }
  popMatrix();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      // t.setSmooth(true);
    } else if (keyCode == DOWN) {
      // t.setSmooth(false);
    }
  }
}