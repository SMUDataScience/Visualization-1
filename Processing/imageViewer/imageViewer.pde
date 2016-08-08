/*************************************************
* Simple ImageViewer example with infinite scroll
* Ira Greenberg, 2016
*
* Notes: 
* 1. The strip is built automatically based on 
*    images in data directory. 
* 2. This version doesn't include 
*    clickable control of indivdiual images.
*************************************************/


ImageSlider slider;

void setup() {
  size(1300, 45);
  slider = new ImageSlider(Alignment.TOP, 45);
}

void draw(){
  background(255);
  slider.display();
}