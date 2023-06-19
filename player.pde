/**Class that represents the player, a simple ship*/
public class Player extends GameEntity {
  float mainMeasure = 50.0;
  int life = defaultStartingLife;
  String playerName = "";
  int score = 0;

  public Player () {
    entityWidth=mainMeasure*2;
    entityDepth=mainMeasure*2;
    entityHeight=mainMeasure/1.5;

    x=(float)(width/2);
    y=(float)(height/2);
    z=0.0;
  }

  /**Logic before draw the player */
  public void beforeDraw() {
    if (x + deltaX > 0.0 && x+deltaX < (float)width)
      x+=deltaX;

    if (y + deltaY > 0.0 && y+deltaY < (float)height)
      y+=deltaY;

    z-=deltaZ;
  }

  /**Checs collision with asteroids*/
  public void checkCollision() {
    for (int i = asteroids.size()-1; i >= 0; i--) {
      if (asteroids.size() > 0) {
        Asteroid asteroid = asteroids.get(i);
        if (this.checkIntersection(asteroid)) {
          stroke(255, 0, 0);
          explosionSounds.get((int)random(0, 4)).play();
          explosions.add(new Explosion(asteroid));
          asteroids.remove(asteroid);
          life--;

          if (life<=0) {
            gameOverScreen = true;
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
