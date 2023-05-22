
public class BackgroundStar extends GameEntity {
  public BackgroundStar (float x, float y) {
    this.x = x;
    this.y = y;
    this.z = -7000;
    this.deltaZ=1000;
  }

  /**Retorna true se nao ta mais aparecendo na tela, otimizacao de memoria: nem todo mundo tem um mac*/
  public boolean isNoLongerVisible() {
    return (z > cameraZ);
  }

  /**Logica antes de desenhar, atualiza a posicao */
  public void beforeDraw() {
    z += deltaZ;
  }

  /**desenha os vertices, vulgo esfera */
  public void drawVertex() {
    sphere(3);
  }

  /**Renderiza o asteroide */
  void drawThis() {

    pushMatrix();
    beforeDraw();
    translate(x, y, z);
    drawVertex();
    popMatrix();
  }
}
