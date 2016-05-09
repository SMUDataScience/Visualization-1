ArrayList<PVector> vecs = new ArrayList<PVector>();
int slices = 12;
int stacks = 12;
float radius = 180;

void setup() {
  size(800, 800, P3D);
  strokeWeight(7);
  float theta = -PI/2.0f; // start at pole
  float x = 0;
  float y = 0;
  float z = 0;
  for (int i=0; i<=stacks; i++) {
    float phi = 0.0f;
    // initial arc around z-axis
    x = cos(theta)*radius;
    y = sin(theta)*radius;
    for (int j=0; j<=slices; j++) {
      // sweep arc around y-axis
      float pz = cos(phi)*z - sin(phi)*x;
      float px = sin(phi)*z + cos(phi)*x;
      float py = y;
      vecs.add(new PVector(px, py, pz));
      phi += TWO_PI/slices;
    }
    theta += PI/stacks;
  }
}


void draw() {
  background(255);
  translate(width/2, height/2);
  rotateX(frameCount*PI/360.0);
  for (PVector v : vecs) {
    point(v.x, v.y, v.z);
  }
}