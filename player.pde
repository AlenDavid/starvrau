
/**Classe q representa o player, uma nave simples*/
public class Player extends GameEntity {

  float mainMeasure = 50.0;

  public Player () {
    entityWidth=mainMeasure*2;
    entityDepth=mainMeasure*2;
    entityHeight=mainMeasure/1.5;

    x=0.0;
    y=0.0;
    z=0.0;
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
        hitSounds.get((int)random(0,4)).play();
        asteroids.remove(asteroid);
      }
    }
  }

  /**Vértices da Nave */
  public void drawVertex() {
    beginShape();

    vertex( mainMeasure, -(mainMeasure/3), mainMeasure);
    vertex( +mainMeasure, +(mainMeasure/3), mainMeasure);
    vertex(   0, 0, -mainMeasure);

    vertex( +mainMeasure, +(mainMeasure/3), mainMeasure);
    vertex(-mainMeasure, +(mainMeasure/3), mainMeasure);
    vertex(   0, 0, -mainMeasure);

    vertex(-mainMeasure, +(mainMeasure/3), mainMeasure);
    vertex(-mainMeasure, -(mainMeasure/3), mainMeasure);
    vertex(   0, 0, -mainMeasure);

    vertex(-mainMeasure, -(mainMeasure/3), mainMeasure);
    vertex( +mainMeasure, -(mainMeasure/3), mainMeasure);
    vertex(   0, 0, -mainMeasure);
    endShape();
  }

  /**Renderiza a Nave */
  public void draw() {
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
