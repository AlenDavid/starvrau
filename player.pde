
/**Class that represents the player, a simple ship*/
public class Player extends GameEntity {

  float mainMeasure = 50.0;
  int life = 20;
  String playerName="";
  int score=0;

  public Player () {
    entityWidth=mainMeasure*2;
    entityDepth=mainMeasure*2;
    entityHeight=mainMeasure/1.5;

    x=0.0;
    y=0.0;
    z=0.0;
  }

  /**Logic before draw the player */
  public void beforeDraw() {
    x+=deltaX;
    y+=deltaY;
    z-=deltaZ;
  }

  /**Checs collision with asteroids*/
  public void checkCollision() {
    for (int i = asteroids.size()-1; i >= 0; i--) {
      if (asteroids.size() > 0) {
        Asteroid asteroid = asteroids.get(i);
        if (checkIntersection(this, asteroid)) {
          //println("Player colidiu com o asteroide ", asteroid);
          stroke(255, 0, 0);
          explosionSounds.get((int)random(0, 4)).play();
          explosions.add(new Explosion(asteroid));
          asteroids.remove(asteroid);
          life--;
          if (life<=0) {
            gameOverScreen=true;
            backgroundMusic.stop();
          }
        }
      }
    }
  }

  /**Vertexes of th ship*/
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

  /**Renders the Ship*/
  public void draw() {
    pushMatrix();
    beforeDraw();
    stroke(255);
    checkCollision();
    translate(x, y, z);
    drawVertex();
    popMatrix();
  }
}
