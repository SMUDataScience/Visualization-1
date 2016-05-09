class Tree {
  
  PVector pos;
  PVector dim;
  int subDivs;

  ArrayList<Node> nodes = new ArrayList<Node>();
  
  Tree(){
  }
  
  Tree(PVector pos, PVector dim, int subDivs){
    this.pos = pos;
    this.dim = dim;
    this.subDivs = subDivs;
    
    //PVector pos, float len, float totalSpanAngle, int subBranches
    nodes.add(new Node(pos, dim.y/subDivs, random(10, 65), 3));
    int s = 0;
    while(s<subDivs){
      
    }
  }
  
}