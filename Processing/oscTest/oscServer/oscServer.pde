import oscP5.*;
import netP5.*;

OscP5 oscP5;
int myListeningPort = 32000;

void setup() {
  oscP5 = new OscP5(this, myListeningPort);
  frameRate(25);
}

void draw() {
  background(0);
}

void oscEvent(OscMessage theOscMessage) {
  /* check if the address pattern fits any of our patterns */
  if (theOscMessage.addrPattern().equals("/myPattern")) {
    println(theOscMessage.get(0).intValue()); // do stuff with incoming data
  }
}