//package org.protobyte.util;
//
//import java.io.Serializable;

public class Dimension {
  public float w, h;
  
  public Dimension(){
  }
  
  public Dimension(float w, float h){
    this.w = w;
    this.h = h;
  }

  public void setTo(Dimension dim) {
    w = dim.w;
    h = dim.h;
  }
  
  public float getW() {
    return w;
  }

  public void setW(float w) {
    this.w = w;
  }

  public float getH() {
    return h;
  }

  public void setH(float h) {
    this.h = h;
  }
  

}

