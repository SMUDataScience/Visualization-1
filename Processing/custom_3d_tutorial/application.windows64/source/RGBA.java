public class RGBA {
  public float r, g, b, a;

  public RGBA() {
  }

  public RGBA(float r, float g, float b, float a) {
    this.r = r;
    this.g = g;
    this.b = b;
    this.a = a;
  }

  public RGBA(float r, float g, float b) {
    this.r = r;
    this.g = g;
    this.b = b;
    this.a = 1;
  }

  public RGBA(int rgb) {
    r = rgb & 0xFF;
    g = rgb & 0xFF00F >> 8;
    b = rgb & 0xFF0000 >> 16;
    a = 1;
  }
}