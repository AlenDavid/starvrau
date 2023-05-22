
/**Classe q representa o player, uma nave simples*/
public class Player extends GameEntity {

  float mainMeasure = 50.0;

  public Player () {
    x=width/2;
    y=height/1.2;
    z=0.0;
    eWidth=mainMeasure*2;
    eDepth=mainMeasure*2;
    eHeight=mainMeasure/1.5;
  }

  /**Lógica antes de desenhar a nave*/
  public void beforeDraw() {
    x+=deltaX;
    y+=deltaY;
    z-=deltaZ;
  }

  /**Checa se um asteroid bateu na nave */
  public void checkCollision() {
    for (i = asteroids.size()-1; i >= 0; i--) {
      Asteroid asteroid = asteroids.get(i);
      if (checkIntersection(this, asteroid)) {
        println("Player colidiu com o asteroide ", asteroid);
        stroke(255, 0, 0);
        asteroids.remove(asteroid);
      }
    }
  }

  /**Vértices da Nave */
  public void drawVertex() {
    beginShape();

    vertex( mainMeasure, -mainMeasure/3, mainMeasure);
    vertex( mainMeasure, mainMeasure/3, mainMeasure);
    vertex(   0, 0, -mainMeasure);

    vertex( mainMeasure, mainMeasure/3, mainMeasure);
    vertex(-mainMeasure, mainMeasure/3, mainMeasure);
    vertex(   0, 0, -mainMeasure);

    vertex(-mainMeasure, mainMeasure/3, mainMeasure);
    vertex(-mainMeasure, -mainMeasure/3, mainMeasure);
    vertex(   0, 0, -mainMeasure);

    vertex(-mainMeasure, -mainMeasure/3, mainMeasure);
    vertex( mainMeasure, -mainMeasure/3, mainMeasure);
    vertex(   0, 0, -mainMeasure);
    endShape();
  }

  /**Renderiza a Nave */
  public void drawThis() {
    //Garante q as alteracoes acontecao na nave aenas
    pushMatrix();
    beforeDraw();
    stroke(255);
    checkCollision();
    translate(x, y, z);
    //ajusta o angulo do poligono da nave
    //rotateX(PI);
    drawVertex();
    //println("Player in X ", x, " Y ", y, " Z ", z);
    popMatrix();
  }
}
