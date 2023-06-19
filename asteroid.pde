/**Class that represents an asteroid, better not to hit that*/
public class Asteroid extends GameEntity {
  float points[][] = new float[8][3];
  float adjust = 1.5;
  int life = 2;

  public Asteroid(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;

    for (int i = 0; i < 8; i++) {
      points[i][0]=random(100, 250);
      points[i][1]=random(100, 250);
      points[i][2]=random(100, 250);
    }
    // Initializes Max and Min for axis
    float minX = 0.0;
    float maxX = 0.0;
    float minY = 0.0;
    float maxY = 0.0;
    float minZ = 0.0;
    float maxZ = 0.0;

    // Finde the max and min for each axis
    for (int i = 1; i < 8; i++) {
      minX = min(minX, points[i][0]);
      maxX = max(maxX, points[i][0]);
      minY = min(minY, points[i][1]);
      maxY = max(maxY, points[i][1]);
      minZ = min(minZ, points[i][2]);
      maxZ = max(maxZ, points[i][2]);
    }

    // Calculates the bounding box
    entityWidth = (maxX - minX)/2;
    entityHeight = (maxY - minY)/2;
    entityDepth = (maxZ - minZ);

    x=abs(x-entityWidth);
    y=abs(y-entityHeight);
  }

  /**Check if entity is no longer visible, heap optimization*/
  public boolean isNoLongerVisible() {
    return (z > thresholdForRemoval);
  }

  /**Checks collision with lasers*/
  public void checkCollision() {
    for (int i = lasers.size()-1; i >= 0; i--) {
      Laser laser = lasers.get(i);
      if (checkIntersection(this, laser)) {
        stroke(255, 0, 0);
        hitSounds.get((int)random(0, 4)).play();
        lasers.remove(laser);
        life--;
        if (life <= 0) {
          explosions.add(new Explosion(this));
          asteroids.remove(this);
          explosionSounds.get((int)random(0, 4)).play();
          player.score++;
        }
        stroke(255);
      }
    }
  }

  /**Logic befor draw, calculate the movement*/
  public void beforeDraw() {
    z += deltaZ;
  }

  /**draw the vertexes, almost ramdom*/
  public void drawVertex() {

    beginShape();

    vertex(points[0][0]-(entityWidth*adjust), points[0][1]-(entityHeight*adjust), points[0][2]-(entityDepth));
    vertex(points[1][0]-(entityWidth*adjust), points[1][1]-(entityHeight*adjust), points[1][2]-(entityDepth));
    vertex(points[2][0]-(entityWidth*adjust), points[2][1]-(entityHeight*adjust), points[2][2]-(entityDepth));
    vertex(points[3][0]-(entityWidth*adjust), points[3][1]-(entityHeight*adjust), points[3][2]-(entityDepth));

    vertex(points[0][0]-(entityWidth*adjust), points[0][1]-(entityHeight*adjust), points[0][2]-(entityDepth));
    vertex(points[1][0]-(entityWidth*adjust), points[1][1]-(entityHeight*adjust), points[1][2]-(entityDepth));
    vertex(points[5][0]-(entityWidth*adjust), points[5][1]-(entityHeight*adjust), points[5][2]-(entityDepth));
    vertex(points[4][0]-(entityWidth*adjust), points[4][1]-(entityHeight*adjust), points[4][2]-(entityDepth));

    vertex(points[0][0]-(entityWidth*adjust), points[0][1]-(entityHeight*adjust), points[0][2]-(entityDepth));
    vertex(points[4][0]-(entityWidth*adjust), points[4][1]-(entityHeight*adjust), points[4][2]-(entityDepth));
    vertex(points[7][0]-(entityWidth*adjust), points[7][1]-(entityHeight*adjust), points[7][2]-(entityDepth));
    vertex(points[3][0]-(entityWidth*adjust), points[3][1]-(entityHeight*adjust), points[3][2]-(entityDepth));

    vertex(points[3][0]-(entityWidth*adjust), points[3][1]-(entityHeight*adjust), points[3][2]-(entityDepth));
    vertex(points[2][0]-(entityWidth*adjust), points[2][1]-(entityHeight*adjust), points[2][2]-(entityDepth));
    vertex(points[6][0]-(entityWidth*adjust), points[6][1]-(entityHeight*adjust), points[6][2]-(entityDepth));
    vertex(points[7][0]-(entityWidth*adjust), points[7][1]-(entityHeight*adjust), points[7][2]-(entityDepth));

    vertex(points[1][0]-(entityWidth*adjust), points[1][1]-(entityHeight*adjust), points[1][2]-(entityDepth));
    vertex(points[2][0]-(entityWidth*adjust), points[2][1]-(entityHeight*adjust), points[2][2]-(entityDepth));
    vertex(points[6][0]-(entityWidth*adjust), points[6][1]-(entityHeight*adjust), points[6][2]-(entityDepth));
    vertex(points[5][0]-(entityWidth*adjust), points[5][1]-(entityHeight*adjust), points[5][2]-(entityDepth));

    vertex(points[4][0]-(entityWidth*adjust), points[4][1]-(entityHeight*adjust), points[4][2]-(entityDepth));
    vertex(points[7][0]-(entityWidth*adjust), points[7][1]-(entityHeight*adjust), points[7][2]-(entityDepth));
    vertex(points[6][0]-(entityWidth*adjust), points[6][1]-(entityHeight*adjust), points[6][2]-(entityDepth));
    vertex(points[5][0]-(entityWidth*adjust), points[5][1]-(entityHeight*adjust), points[5][2]-(entityDepth));

    endShape();
  }

  /**Renders the asteroid*/
  public void draw() {
    pushMatrix();
    beforeDraw();
    checkCollision();
    translate(x, y, z);
    drawVertex();
    popMatrix();
  }
}
