public class Laser extends GameEntity {
  public Laser(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;

    this.entityWidth=10;
    this.entityHeight=10;
    this.entityDepth=50;

    //Som do tiro
    laserShootSounds.get((int)random(0,4)).play();
  }

  /**Retorna true se nao ta mais aparecendo na tela, otimizacao de memoria: nem todo mundo tem um mac*/
  public boolean isNoLongerVisible() {
    return (z < -1000);
  }

  public void drawVertex() {
    //line(0, 0, z, 0, 0, this.z-this.entityDepth);
    box(1,1,entityDepth);
    
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
