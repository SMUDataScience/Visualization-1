int interval = 10;
void setup() {
}

void draw() {
  // assume frame rate of 60 fps
  if (frameCount%(60*interval) == 0) {
    println(frameCount/60);
  }
}