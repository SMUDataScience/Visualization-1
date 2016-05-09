class VerletOrg {
  int nodeCount;
  float radius;
  color fillCol;
  color strokeCol;
  boolean isSupportVisible;
  VerletNode[] nodes;
  ArrayList<VerletStick>sticks;
  int bonds;

  VerletOrg(int nodeCount, float radius, color fillCol, color strokeCol, boolean isSupportVisible) {
    this.nodeCount = nodeCount;
    this.radius = radius;
    this.fillCol = fillCol;
    this.strokeCol = strokeCol;
    this.isSupportVisible = isSupportVisible;
    
    nodes = new VerletNode[nodeCount];
    sticks = new ArrayList<VerletStick>();
    bonds = nodeCount + nodeCount/2;
  }


  void nudge(int id, PVector v) {
    nodes[id].pos.add(v);
  }


  void display() {
    for (int i=0; i<sticks.size(); i++) {
    sticks.get(i).render();
    sticks.get(i).constrainLen();
  }

  for (int i=0; i<particles; i++) {
    nodes[i].verlet();
    nodes[i].render();
    nodes[i].boundsCollision();
  }
  }


  void verlet() {
  }
}