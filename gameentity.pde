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
}
