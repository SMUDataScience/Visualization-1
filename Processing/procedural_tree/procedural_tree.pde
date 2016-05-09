static int NODE_COUNT = 0;
ArrayList<PVector> nodes = new ArrayList<PVector>();

void setup() {
  size(800, 600);
  background(255);
  noFill();

  branch(width/2, height/2, 125, 115, 2);
}

void branch(float x, float y, float len, float totalSpanAngle, int subBranches) {
  if (NODE_COUNT++ < 5) {
    float theta = PI/2.0+radians(totalSpanAngle/2.0);
    float subTheta = radians(totalSpanAngle/(subBranches-1));
    for (int i=0; i<subBranches; i++) {
      float tx = x+cos(-theta + subTheta*i)*len;
      float ty = y+sin(-theta + subTheta*i)*len;
      beginShape();
      vertex(x, y);
      vertex(tx, ty);
      endShape();
      ellipse(x, y, 3, 3);
      branch(tx, ty, 125, 115, 2);
    }
  }
}