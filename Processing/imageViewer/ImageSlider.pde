

class ImageSlider {

  ImageStrip strip;
  float x;
  float livePos;
  float mx;
  float mouseIn;
  boolean isMouseInSettable = true;
  float offset;

  Alignment alignment;
  float ht;

  ImageSlider(Alignment alignment, float ht) {
    this.alignment = alignment;
    this.ht = ht;
    // we'll have a look in the data folder
    // Java irectory access code from: https://forum.processing.org/two/discussion/1747/reading-filesnames-from-a-folder
    java.io.File folder = new java.io.File(dataPath(""));

    // list the files in the data folder
    String[] filenames = folder.list();

    // get and display the number of jpg files
    PImage[] imgs = new PImage[filenames.length];

    for (int i = 0; i < filenames.length; i++) {
      imgs[i] = loadImage(filenames[i]);
    }

    strip = new ImageStrip(new PVector(width, ht), imgs);
  }

  ImageSlider() {
    // we'll have a look in the data folder
    // Java irectory access code from: https://forum.processing.org/two/discussion/1747/reading-filesnames-from-a-folder
    java.io.File folder = new java.io.File(dataPath(""));

    // list the files in the data folder
    String[] filenames = folder.list();

    // get and display the number of jpg files
    PImage[] imgs = new PImage[filenames.length];

    for (int i = 0; i < filenames.length; i++) {
      imgs[i] = loadImage(filenames[i]);
    }

    strip = new ImageStrip(new PVector(width, 75), imgs);
  }

  void display() {
    if (mousePressed) {
      if (isMouseInSettable) {
        mouseIn = mouseX;
        isMouseInSettable = false;
        x = livePos;
      }
      mx = mouseX-mouseIn;
    } else {
      isMouseInSettable = true;
    }
    offset = x+mx;
    strip.display(offset, 0);
    livePos = offset;

    // create infinite scroll
    if (strip.x> width || strip.x < -width) {
      x = livePos = 0;
    }
  }
}