/**Abstract Class of a game entity*/
abstract class GameEntity {
  float x, y, z, deltaX=0.0, deltaY=0.0, deltaZ=0.0;
  float entityWidth, entityHeight, entityDepth;

  void beforeDraw() {
  }
  void drawVertex() {
  }
  void draw() {
  }
  boolean isNoLongerVisible() {
    return false;
  }


  boolean checkIntersection(GameEntity other) {
    float x1 = this.x - this.entityWidth/2;
    float y1 = this.y - this.entityHeight/2;
    float z1 = this.z - this.entityDepth/2;
    float x2 = other.x - other.entityWidth/2;
    float y2 = other.y - other.entityHeight/2;
    float z2 = other.z - other.entityDepth/2;

    if (debug) {
      pushMatrix();
      translate(this.x, this.y, this.z);
      noFill();
      stroke(255, 0, 0); // Box in red
      box(this.entityWidth, this.entityHeight, this.entityDepth);
      sphere(10);
      popMatrix();

      pushMatrix();
      translate(other.x, other.y, other.z);
      noFill();
      stroke(0, 255, 0); //Box in green
      box(other.entityWidth, other.entityHeight, other.entityDepth);
      popMatrix();

      stroke(255);
    }

    return (abs(x1 - x2) < (this.entityWidth + other.entityWidth)) &&
      (abs(y1 - y2)  < (this.entityHeight + other.entityHeight)) &&
      (abs(z1 - z2)  < (this.entityDepth + other.entityDepth));
  }
}
