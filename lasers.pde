public class Laser extends GameEntity {
  public Laser(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;

    this.entityWidth=10;
    this.entityHeight=10;
    this.entityDepth=50;

    //Shoot!
    laserShootSounds.get((int)random(0,4)).play();
  }

  /**Check if its no longer visible*/
  public boolean isNoLongerVisible() {
    return (z < -1000);
  }

  public void drawVertex() {
    box(1,1,entityDepth);
    
  }

  /**Logic Before draw*/
  public void beforeDraw() {
    z -= 10;
  }

  public void draw() {
    pushMatrix();
    beforeDraw();

    translate(x, y, z);

    drawVertex();
    popMatrix();
  }
}
