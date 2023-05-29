/**Classe q representa um asteroid, melhor nao bater neles*/
public class Explosion extends GameEntity {
  float points[][] = new float[8][3];
  float deltasX[] = new float[6];
  float deltasY[] = new float[6]; 

  public Explosion(Asteroid a) {
    this.x = a.x;
    this.y = a.y;
    this.z = a.z;

    for (int i = 0; i < 6; i++) {
      deltasX[i]=random(-100, +100);
      deltasY[i]=random(-100, +100);
    }

    this.points=a.points;

  }

  /**Retorna true se nao ta mais aparecendo na tela, otimizacao de memoria: nem todo mundo tem um mac*/
  public boolean isNoLongerVisible() {
    return (z > thresholdForRemoval);
  }

  /**Logica antes de desenhar, atualiza a posicao */
  public void beforeDraw() {
    z += deltaZ;
    for (int i = 0; i < 6; i++) {
      deltasX[i]+=deltasX[i];
      deltasY[i]+=deltasY[i];
    }
  }

  /**desenha os vertices, quase 100% randomico */
  public void drawVertex() {
    
    pushMatrix();
    translate(x+deltasX[0],y+deltasY[0], z);
    rotateX(frameCount * 0.07);
    rotateY(frameCount * 0.07);
    rotateZ(frameCount * 0.07);
    beginShape();
    vertex(points[0][0]-(entityWidth), points[0][1]-(entityHeight), points[0][2]-(entityDepth));
    vertex(points[1][0]-(entityWidth), points[1][1]-(entityHeight), points[1][2]-(entityDepth));
    vertex(points[2][0]-(entityWidth), points[2][1]-(entityHeight), points[2][2]-(entityDepth));
    vertex(points[3][0]-(entityWidth), points[3][1]-(entityHeight), points[3][2]-(entityDepth));
    endShape();
    popMatrix();

    pushMatrix();
    translate(x+deltasX[1],y+deltasY[1], z);
    rotateX(frameCount * 0.07);
    rotateY(frameCount * 0.07);
    rotateZ(frameCount * 0.07);
    beginShape();
    vertex(points[0][0]-(entityWidth), points[0][1]-(entityHeight), points[0][2]-(entityDepth));
    vertex(points[1][0]-(entityWidth), points[1][1]-(entityHeight), points[1][2]-(entityDepth));
    vertex(points[5][0]-(entityWidth), points[5][1]-(entityHeight), points[5][2]-(entityDepth));
    vertex(points[4][0]-(entityWidth), points[4][1]-(entityHeight), points[4][2]-(entityDepth));
    endShape();
    popMatrix();

    pushMatrix();
    translate(x+deltasX[2],y+deltasY[2], z);
    rotateX(frameCount * 0.07);
    rotateY(frameCount * 0.07);
    rotateZ(frameCount * 0.07);
    beginShape();
    vertex(points[0][0]-(entityWidth), points[0][1]-(entityHeight), points[0][2]-(entityDepth));
    vertex(points[4][0]-(entityWidth), points[4][1]-(entityHeight), points[4][2]-(entityDepth));
    vertex(points[7][0]-(entityWidth), points[7][1]-(entityHeight), points[7][2]-(entityDepth));
    vertex(points[3][0]-(entityWidth), points[3][1]-(entityHeight), points[3][2]-(entityDepth));
    endShape();
    popMatrix();

    pushMatrix();
    translate(x+deltasX[3],y+deltasY[3], z);
    rotateX(frameCount * 0.07);
    rotateY(frameCount * 0.07);
    rotateZ(frameCount * 0.07);
    beginShape();
    vertex(points[3][0]-(entityWidth), points[3][1]-(entityHeight), points[3][2]-(entityDepth));
    vertex(points[2][0]-(entityWidth), points[2][1]-(entityHeight), points[2][2]-(entityDepth));
    vertex(points[6][0]-(entityWidth), points[6][1]-(entityHeight), points[6][2]-(entityDepth));
    vertex(points[7][0]-(entityWidth), points[7][1]-(entityHeight), points[7][2]-(entityDepth));
    endShape();
    popMatrix();

    pushMatrix();
    translate(x+deltasX[4],y+deltasY[4], z);
    rotateX(frameCount * 0.07);
    rotateY(frameCount * 0.07);
    rotateZ(frameCount * 0.07);
    beginShape();
    vertex(points[1][0]-(entityWidth), points[1][1]-(entityHeight), points[1][2]-(entityDepth));
    vertex(points[2][0]-(entityWidth), points[2][1]-(entityHeight), points[2][2]-(entityDepth));
    vertex(points[6][0]-(entityWidth), points[6][1]-(entityHeight), points[6][2]-(entityDepth));
    vertex(points[5][0]-(entityWidth), points[5][1]-(entityHeight), points[5][2]-(entityDepth));
    endShape();
    popMatrix();

    pushMatrix();
    translate(x+deltasX[5],y+deltasY[5], z);
    rotateX(frameCount * 0.07);
    rotateY(frameCount * 0.07);
    rotateZ(frameCount * 0.07);
    beginShape();
    vertex(points[4][0]-(entityWidth), points[4][1]-(entityHeight), points[4][2]-(entityDepth));
    vertex(points[7][0]-(entityWidth), points[7][1]-(entityHeight), points[7][2]-(entityDepth));
    vertex(points[6][0]-(entityWidth), points[6][1]-(entityHeight), points[6][2]-(entityDepth));
    vertex(points[5][0]-(entityWidth), points[5][1]-(entityHeight), points[5][2]-(entityDepth));
    endShape();
    popMatrix();
  }

  /**Renderiza o asteroide */
  public void draw() {
    pushMatrix();
    beforeDraw();
    drawVertex();
    //println("Asteroid ", this, "in X ", x, " Y ", y, " Z ", z);
    popMatrix();
  }
}