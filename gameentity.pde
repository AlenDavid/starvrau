/**Classe Abstrata base prar as entidades no jogo */
abstract class GameEntity {
  float x, y, z, deltaX=0.0, deltaY=0.0, deltaZ=0.0;
  float eWidth, eHeight, eDepth;

  void beforeDraw() {}
  void drawVertex() {}
  void draw() {}
}
