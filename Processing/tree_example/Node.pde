class Node {

  PVector pos;
  float len;
  float totalSpanAngle;
  int subBranches;

  ArrayList<Node> subNodes = new ArrayList<Node>();
  float theta;
  float subTheta;

  Node() {
  }

  Node(PVector pos, float len, float totalSpanAngle, int subBranches) {
    this.pos = pos;
    this.len = len;
    this.totalSpanAngle = totalSpanAngle;
    this.subBranches = subBranches;
    theta = PI/2.0+radians(totalSpanAngle/2.0); // set pen to top of U.C. with offset
    subTheta = radians(totalSpanAngle/(subBranches-1)); // Processing trig funcs moves CC

  }

  void display() {
    for (int i=0; i<subBranches; i++) {
       PVector tmp = new PVector(pos.x+cos(-theta + subTheta*i)*len, pos.y+sin(-theta + subTheta*i)*len);
      beginShape();
      vertex(pos.x, pos.y);
      vertex(tmp.x, tmp.y);
      endShape();
      ellipse(pos.x, pos.y, 3, 3);
    }
  }
}