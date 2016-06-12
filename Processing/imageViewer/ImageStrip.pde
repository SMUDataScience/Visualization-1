class ImageStrip {
  float x;
  PImage[] imgs;
  PVector sz;
  PImage strip, edgeStrip;

  ImageStrip() {
  }

  ImageStrip(PVector sz, PImage[] imgs) {
    strip = createImage(int(sz.x), int(sz.y), RGB);
    this.sz = sz;
    this.imgs = imgs;

    float imgWidth = sz.x/imgs.length;

    for (int i=0; i<imgs.length; i++) {
      float ratioX = imgWidth/imgs[i].width;
      float ratioY = sz.y/imgs[i].height;
      strip.copy(imgs[i], 0, 0, imgs[i].width, imgs[i].height, int(imgWidth*i), 0, int(imgs[i].width*ratioX), int(imgs[i].height*ratioY));
    }
    // To use additional copies of image
    // edgeStrip = createImage(strip.width, strip.height, RGB);
    // edgeStrip.copy(strip, 0, 0, strip.width, strip.height, 0, 0, strip.width, strip.height);
  }

  void display(float mx, float my) {
    x = mx;
    image(strip, x, my);
    // add strip to left edge
    if (mx > 0 ) {
      image(strip, x-width, my);
      // add strip to right edge
    } else if (mx < 0 ) {
      image(strip, x+width, my);
    }
  }
}