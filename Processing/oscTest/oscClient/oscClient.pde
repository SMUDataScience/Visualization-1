import oscP5.*;
import netP5.*;

OscP5 oscP5;

/* a NetAddress contains the ip address and port number of a remote location in the network. */
NetAddress myBroadcastLocation; 

void setup() {
  size(400, 400);
  frameRate(25);
  oscP5 = new OscP5(this, 12000);
  myBroadcastLocation = new NetAddress("127.0.0.1", 32000);
}


void draw() {
  background(0);
  if (mousePressed) {
    OscMessage myOscMessage = new OscMessage("/myPattern"); // test pattern to recognize
    myOscMessage.add(int(random(1000)));  // substitute music or whatever data you want to send here
    oscP5.send(myOscMessage, myBroadcastLocation);
  }
}