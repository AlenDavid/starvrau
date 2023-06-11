
public class BackgroundStar extends GameEntity {
  public BackgroundStar (float x, float y) {
    this.x = x;
    this.y = y;
    this.z = -7000;
    this.deltaZ=1000;
  }

  /**Check if entity is no longer visible*/
  public boolean isNoLongerVisible() {
    return (z > cameraZ);
  }

  /**Logic before draw, calculates the movement*/
  public void beforeDraw() {
    z += deltaZ;
  }

  /**draw the vertexes*/
  public void drawVertex() {
    sphere(3);
  }

  /**Renders the asteroids*/
  void draw() {

    pushMatrix();
    beforeDraw();
    translate(x, y, z);
    drawVertex();
    popMatrix();
  }
}
