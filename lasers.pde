public class Laser extends GameEntity {
  public Laser(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;

    //Som do tiro
    laserShootSounds.get((int)random(1,4)).play();
  }

  public void drawVertex() {
    line(x, y, z, x, y, this.z-10);
  }

  /**Logica antes de desenhar, atualiza a posicao */
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
