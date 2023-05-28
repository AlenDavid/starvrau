/**Classe q representa um asteroid, melhor nao bater neles*/
public class Asteroid extends GameEntity {
  float points[][] = new float[8][3];
  int life = 5;

  public Asteroid(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;

    for (int i = 0; i < 8; i++) {
      points[i][0]=random(100, 400);
      points[i][1]=random(100, 400);
      points[i][2]=random(100, 400);
    }
    // Inicializar os valores mínimos e máximos dos eixos
    float minX = 0.0;
    float maxX = 0.0;
    float minY = 0.0;
    float maxY = 0.0;
    float minZ = 0.0;
    float maxZ = 0.0;

    // Encontrar os valores mínimos e máximos para cada eixo
    for (int i = 1; i < 8; i++) {
      minX = min(minX, points[i][0]);
      maxX = max(maxX, points[i][0]);
      minY = min(minY, points[i][1]);
      maxY = max(maxY, points[i][1]);
      minZ = min(minZ, points[i][2]);
      maxZ = max(maxZ, points[i][2]);
    }

    // Calcular as dimensões da bounding box
    entityWidth = (maxX - minX)/2;
    entityHeight = (maxY - minY)/2;
    entityDepth = (maxZ - minZ);

    x=abs(x-entityWidth);
    y=abs(y-entityHeight);
  }

  /**Retorna true se nao ta mais aparecendo na tela, otimizacao de memoria: nem todo mundo tem um mac*/
  public boolean isNoLongerVisible() {
    return (z > thresholdForRemoval);
  }

  /**Checa se um laser acertou o asteroid */
  public void checkCollision() {
    for (i = lasers.size()-1; i >= 0; i--) {
      Laser laser = lasers.get(i);
      if (checkIntersection(this, laser)) {
        stroke(255, 0, 0);
        hitSounds.get((int)random(0,4)).play();
        lasers.remove(laser);
        life--;
        if (life == 0) {
           asteroids.remove(this);
           explosionSounds.get((int)random(0,4)).play();
        }
        stroke(255);
      }
    }
  }

  /**Logica antes de desenhar, atualiza a posicao */
  public void beforeDraw() {
    z += deltaZ;
  }

  /**desenha os vertices, quase 100% randomico */
  public void drawVertex() {
    beginShape();

    vertex(points[0][0]-(entityWidth), points[0][1]-(entityHeight), points[0][2]-(entityDepth));
    vertex(points[1][0]-(entityWidth), points[1][1]-(entityHeight), points[1][2]-(entityDepth));
    vertex(points[2][0]-(entityWidth), points[2][1]-(entityHeight), points[2][2]-(entityDepth));
    vertex(points[3][0]-(entityWidth), points[3][1]-(entityHeight), points[3][2]-(entityDepth));

    vertex(points[0][0]-(entityWidth), points[0][1]-(entityHeight), points[0][2]-(entityDepth));
    vertex(points[1][0]-(entityWidth), points[1][1]-(entityHeight), points[1][2]-(entityDepth));
    vertex(points[5][0]-(entityWidth), points[5][1]-(entityHeight), points[5][2]-(entityDepth));
    vertex(points[4][0]-(entityWidth), points[4][1]-(entityHeight), points[4][2]-(entityDepth));

    vertex(points[0][0]-(entityWidth), points[0][1]-(entityHeight), points[0][2]-(entityDepth));
    vertex(points[4][0]-(entityWidth), points[4][1]-(entityHeight), points[4][2]-(entityDepth));
    vertex(points[7][0]-(entityWidth), points[7][1]-(entityHeight), points[7][2]-(entityDepth));
    vertex(points[3][0]-(entityWidth), points[3][1]-(entityHeight), points[3][2]-(entityDepth));

    vertex(points[3][0]-(entityWidth), points[3][1]-(entityHeight), points[3][2]-(entityDepth));
    vertex(points[2][0]-(entityWidth), points[2][1]-(entityHeight), points[2][2]-(entityDepth));
    vertex(points[6][0]-(entityWidth), points[6][1]-(entityHeight), points[6][2]-(entityDepth));
    vertex(points[7][0]-(entityWidth), points[7][1]-(entityHeight), points[7][2]-(entityDepth));

    vertex(points[1][0]-(entityWidth), points[1][1]-(entityHeight), points[1][2]-(entityDepth));
    vertex(points[2][0]-(entityWidth), points[2][1]-(entityHeight), points[2][2]-(entityDepth));
    vertex(points[6][0]-(entityWidth), points[6][1]-(entityHeight), points[6][2]-(entityDepth));
    vertex(points[5][0]-(entityWidth), points[5][1]-(entityHeight), points[5][2]-(entityDepth));

    vertex(points[4][0]-(entityWidth), points[4][1]-(entityHeight), points[4][2]-(entityDepth));
    vertex(points[7][0]-(entityWidth), points[7][1]-(entityHeight), points[7][2]-(entityDepth));
    vertex(points[6][0]-(entityWidth), points[6][1]-(entityHeight), points[6][2]-(entityDepth));
    vertex(points[5][0]-(entityWidth), points[5][1]-(entityHeight), points[5][2]-(entityDepth));

    endShape();
  }

  /**Renderiza o asteroide */
  public void draw() {
    pushMatrix();
    beforeDraw();
    checkCollision();
    translate(x, y, z);
    // Adiciona rotações em todos os eixos
    // Corpos em movimento permanecem em movimento
    rotateX(frameCount * 0.01);
    rotateY(frameCount * 0.01);
    rotateZ(frameCount * 0.01);
    drawVertex();
    //println("Asteroid ", this, "in X ", x, " Y ", y, " Z ", z);
    popMatrix();
  }
}
