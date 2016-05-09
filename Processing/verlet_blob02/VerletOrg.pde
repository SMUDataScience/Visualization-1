class VerletOrg {
  int nodeCount;
  float radius;
  float tension;
  color fillCol;
  color strokeCol;
  boolean isSupportVisible;
  VerletNode[] nodes;
  ArrayList<VerletStick>sticks;
  ArrayList<VerletStick>support;
  int bonds;

  VerletOrg(int nodeCount, float radius, float tension, color fillCol, color strokeCol, boolean isSupportVisible) {
    this.nodeCount = nodeCount;
    this.radius = radius;
    this.tension = tension;
    this.fillCol = fillCol;
    this.strokeCol = strokeCol;
    this.isSupportVisible = isSupportVisible;

    nodes = new VerletNode[nodeCount];
    sticks = new ArrayList<VerletStick>();
    support = new ArrayList<VerletStick>();
    bonds = nodeCount + nodeCount/2;

    float theta = PI/4.0;

    // nodes
    for (int i=0; i<nodeCount; i++) {
      PVector p = new PVector(cos(theta)*radius, sin(theta)*radius);
      nodes[i] = new VerletNode(p, 2);
      theta += TWO_PI/nodeCount;
    }

    // sticks
    for (int i=0; i<nodeCount; i++) {
      if (i>0) {
        sticks.add(new VerletStick(nodes[i-1], nodes[i], tension, true));
      } 
      if (i==nodeCount-1) {
        sticks.add(new VerletStick(nodes[i], nodes[0], tension, true));
      }
    }

    // internal sticks for stability
    for (int i=nodeCount; i<bonds; i++) {
      if (i%1==0) {
        support.add(new VerletStick(nodes[i-nodeCount], nodes[i-nodeCount/2], tension, isSupportVisible));
      }
    }
  }

  // get moving
  void nudge(PVector v) {
    nodes[0].pos.add(v);
  }

  void display() {
    // draw softbody
    fill(fillCol);
    beginShape();
    curveVertex(nodes[nodes.length-2].pos.x, nodes[nodes.length-2].pos.y);
    curveVertex(nodes[nodes.length-1].pos.x, nodes[nodes.length-1].pos.y);
    for (int i=0; i<nodeCount; i++) {
      curveVertex(nodes[i].pos.x, nodes[i].pos.y);
    }
    curveVertex(nodes[0].pos.x, nodes[0].pos.y);
    endShape(CLOSE);

    for (int i=0; i<support.size(); i++) {
      support.get(i).render();
    }

    for (int i=0; i<nodeCount; i++) {
      if (isSupportVisible) {
        nodes[i].render();
      }
    }
  }


  void verlet() {
    for (int i=0; i<sticks.size(); i++) {
      sticks.get(i).constrainLen();
    }

    for (int i=0; i<support.size(); i++) {
      support.get(i).constrainLen();
    }

    for (int i=0; i<nodeCount; i++) {
      nodes[i].verlet();

      // bounds detection
      nodes[i].boundsCollision();
    }
  }
}