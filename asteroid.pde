/**Classe q representa um asteroid, melhor nao bater neles*/
public class Asteroid extends GameEntity {
  float points[][] = new float[8][3];

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
    eWidth = (maxX - minX)/2;
    eHeight = (maxY - minY)/2;
    eDepth = (maxZ - minZ);

    x=abs(x-eWidth);
    y=abs(y-eHeight);
  }

  /**Retorna true se nao ta mais aparecendo na tela, otimizacao de memoria: nem todo mundo tem um mac*/
  public boolean isNoLongerVisible() {
    return (z > thresholdForRemoval);
  }

  /**Logica antes de desenhar, atualiza a posicao */
  public void beforeDraw() {
    z += deltaZ;
  }

  /**desenha os vertices, quase 100% randomico */
  public void drawVertex() {
    beginShape();

    vertex(points[0][0]-(eWidth), points[0][1]-(eHeight), points[0][2]-(eDepth));
    vertex(points[1][0]-(eWidth), points[1][1]-(eHeight), points[1][2]-(eDepth));
    vertex(points[2][0]-(eWidth), points[2][1]-(eHeight), points[2][2]-(eDepth));
    vertex(points[3][0]-(eWidth), points[3][1]-(eHeight), points[3][2]-(eDepth));

    vertex(points[0][0]-(eWidth), points[0][1]-(eHeight), points[0][2]-(eDepth));
    vertex(points[1][0]-(eWidth), points[1][1]-(eHeight), points[1][2]-(eDepth));
    vertex(points[5][0]-(eWidth), points[5][1]-(eHeight), points[5][2]-(eDepth));
    vertex(points[4][0]-(eWidth), points[4][1]-(eHeight), points[4][2]-(eDepth));

    vertex(points[0][0]-(eWidth), points[0][1]-(eHeight), points[0][2]-(eDepth));
    vertex(points[4][0]-(eWidth), points[4][1]-(eHeight), points[4][2]-(eDepth));
    vertex(points[7][0]-(eWidth), points[7][1]-(eHeight), points[7][2]-(eDepth));
    vertex(points[3][0]-(eWidth), points[3][1]-(eHeight), points[3][2]-(eDepth));

    vertex(points[3][0]-(eWidth), points[3][1]-(eHeight), points[3][2]-(eDepth));
    vertex(points[2][0]-(eWidth), points[2][1]-(eHeight), points[2][2]-(eDepth));
    vertex(points[6][0]-(eWidth), points[6][1]-(eHeight), points[6][2]-(eDepth));
    vertex(points[7][0]-(eWidth), points[7][1]-(eHeight), points[7][2]-(eDepth));

    vertex(points[1][0]-(eWidth), points[1][1]-(eHeight), points[1][2]-(eDepth));
    vertex(points[2][0]-(eWidth), points[2][1]-(eHeight), points[2][2]-(eDepth));
    vertex(points[6][0]-(eWidth), points[6][1]-(eHeight), points[6][2]-(eDepth));
    vertex(points[5][0]-(eWidth), points[5][1]-(eHeight), points[5][2]-(eDepth));

    vertex(points[4][0]-(eWidth), points[4][1]-(eHeight), points[4][2]-(eDepth));
    vertex(points[7][0]-(eWidth), points[7][1]-(eHeight), points[7][2]-(eDepth));
    vertex(points[6][0]-(eWidth), points[6][1]-(eHeight), points[6][2]-(eDepth));
    vertex(points[5][0]-(eWidth), points[5][1]-(eHeight), points[5][2]-(eDepth));

    endShape();
  }

  /**Renderiza o asteroide */
  public void draw() {
    pushMatrix();
    beforeDraw();
    translate(x, y, z);
    // Adiciona rotações em todos os eixos
    // Corpos em movimento permanecem em movimento
    /*  rotateX(frameCount * 0.0004);
     rotateY(frameCount * 0.0004);
     rotateZ(frameCount * 0.0001); */
    drawVertex();
    //println("Asteroid ", this, "in X ", x, " Y ", y, " Z ", z);
    popMatrix();
  }
}
