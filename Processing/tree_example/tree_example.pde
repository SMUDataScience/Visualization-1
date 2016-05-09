PVector node;
  static int NODE_COUNT = 0;

void setup(){
  size(800, 600);
  background(255);
  noFill();
  
  Node node = new Node(new PVector(width/2, height/2), 125, 115, 3);
  node.display(); 
    
}