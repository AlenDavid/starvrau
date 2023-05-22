Player player;
float currentDeltaForPlayer=4.0;
float thresholdForRemoval=500;
int i;

//Variaveis para o FOV da camera, a coodernada Z da camera
//o Plano da camera e o horizonte do mundo
float fov, cameraZ, nearPlane, horizon;

ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
ArrayList<BackgroundStar> stars = new ArrayList<BackgroundStar>();

void setup () {
  smooth();
  stroke(255);
  strokeWeight(1);
  size(800, 600, P3D);
  frameRate(60);
  fill(0);

  player = new Player();
}

void draw() {

  resetMatrix();

  beginCamera();
  camera();
  fov = PI/2.5;
  cameraZ = (height/2.0) / tan(fov/2.0);
  nearPlane = cameraZ / 20.0;
  horizon = cameraZ * 20.0;
  perspective(fov, float(width)/float(height), nearPlane, horizon);
  //rotateX(PI/20);
  endCamera();

  background(0);

  //renderiza o player
  player.drawThis();

  //Cria as estrelas para dar um efeito do movimento
  //Afinal o espaço nao eh tao vazio assim
  if (frameCount % 10 == 0) {
    stars.add(new BackgroundStar(random(width), random(height)));
  }

  //Cria os asteroides, precisa de uma lógica de geraçao melhor, talvez orientado a dificuldade
  //nao sei
  if (frameCount % 300 == 0) {
    Asteroid asteroid = new Asteroid(random(100, width), random(100, height), -7000);
    asteroid.deltaZ = 70.0;  // Velocidade de aproximação do asteroide
    asteroids.add(asteroid);
  }

  //Remove as estrelas nao mais visiveis
  //Varre o array de tras pra frente pra evitar concorrencia
  //Java sendo Java
  for (i = stars.size()-1; i >= 0; i--) {
    BackgroundStar s = stars.get(i);
    s.drawThis();
    if (s.isNoLongerVisible()) {
      stars.remove(s);
    }
  }

  //Remove os asteroides nao mais visiveis
  //Varre o array de tras pra frente pra evitar concorrencia
  //Java sendo Java
  for (i = asteroids.size()-1; i >= 0; i--) {
    Asteroid s = asteroids.get(i);
    s.drawThis();
    if (s.isNoLongerVisible()) {
      asteroids.remove(s);
    }
  }
}

void keyPressed() {
  if (key == 'w') player.deltaY = -currentDeltaForPlayer;
  if (key == 's') player.deltaY = currentDeltaForPlayer;
  if (key == 'a') player.deltaX = -currentDeltaForPlayer;
  if (key == 'd') player.deltaX = currentDeltaForPlayer;
  //this is for test only, remove in the end
  if (key == '0') player.deltaZ = currentDeltaForPlayer;
}

void keyReleased() {
  if (key == 'w') player.deltaY = 0.0;
  if (key == 's') player.deltaY = 0.0;
  if (key == 'a') player.deltaX = 0.0;
  if (key == 'd') player.deltaX = 0.0;
}

boolean checkIntersection(GameEntity entity1, GameEntity entity2) {
  float x1 = entity1.x - entity1.eWidth/2;
  float y1 = entity1.y - entity1.eHeight/2;
  float z1 = entity1.z - entity1.eDepth/2;
  float x2 = entity2.x - entity2.eWidth/2;
  float y2 = entity2.y - entity2.eHeight/2;
  float z2 = entity2.z - entity2.eDepth/2;

  pushMatrix();
  translate(entity1.x, entity1.y, entity1.z);
  noFill();
  stroke(255, 0, 0); // Cor vermelha
  //box(entity1.eWidth,  entity1.eHeight, entity1.eDepth);
  popMatrix();

  pushMatrix();
  translate(entity2.x, entity2.y, entity2.z);
  noFill();
  stroke(255, 0, 0);
  //box(entity2.eWidth,  entity2.eHeight, entity2.eDepth);
  popMatrix();

  stroke(255);

  return (abs(x1 - x2) < (entity1.eWidth + entity2.eWidth)) &&
    (abs(y1 - y2)  < (entity1.eHeight + entity2.eHeight)) &&
    (abs(z1 - z2)  < (entity1.eDepth + entity2.eDepth));
}

/**Classe Abstrata base prar as entidades no jogo */
abstract class GameEntity {
  float x, y, z, deltaX=0.0, deltaY=0.0, deltaZ=0.0;
  float eWidth, eHeight, eDepth;

  void beforeDraw() {
  }
  void drawVertex() {
  }
  void drawThis() {
  }
}

/**Classe q representa o player, uma nave simples*/
public class Player extends GameEntity {

  float mainMeasure = 50.0;

  public Player () {
    x=width/2;
    y=height/1.2;
    z=0.0;
    eWidth=mainMeasure*2;
    eDepth=mainMeasure*2;
    eHeight=mainMeasure/1.5;
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
        asteroids.remove(asteroid);
      }
    }
  }

  /**Vértices da Nave */
  public void drawVertex() {
    beginShape();

    vertex( mainMeasure, -mainMeasure/3, mainMeasure);
    vertex( mainMeasure, mainMeasure/3, mainMeasure);
    vertex(   0, 0, -mainMeasure);

    vertex( mainMeasure, mainMeasure/3, mainMeasure);
    vertex(-mainMeasure, mainMeasure/3, mainMeasure);
    vertex(   0, 0, mainMeasure);

    vertex(-mainMeasure, mainMeasure/3, mainMeasure);
    vertex(-mainMeasure, -mainMeasure/3, mainMeasure);
    vertex(   0, 0, -mainMeasure);

    vertex(-mainMeasure, -mainMeasure/3, mainMeasure);
    vertex( mainMeasure, -mainMeasure/3, mainMeasure);
    vertex(   0, 0, -mainMeasure);
    endShape();
  }

  /**Renderiza a Nave */
  public void drawThis() {
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
  public void drawThis() {
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

public class BackgroundStar extends GameEntity {

  public BackgroundStar (float x, float y) {
    this.x = x;
    this.y = y;
    this.z = -7000;
    this.deltaZ=1000;
  }

  /**Retorna true se nao ta mais aparecendo na tela, otimizacao de memoria: nem todo mundo tem um mac*/
  public boolean isNoLongerVisible() {
    return (z > cameraZ);
  }

  /**Logica antes de desenhar, atualiza a posicao */
  public void beforeDraw() {
    z += deltaZ;
  }

  /**desenha os vertices, vulgo esfera */
  public void drawVertex() {
    sphere(3);
  }

  /**Renderiza o asteroide */
  void drawThis() {

    pushMatrix();
    beforeDraw();
    translate(x, y, z);
    drawVertex();
    popMatrix();
  }
}



/* Comentei pra nao perder a logica
 void keyPressed() {
 if (key == 'w') incX = 1;
 if (key == 's') incX = -1;
 if (key == 'a') incY = -1;
 if (key == 'd') incY = 1;
 }
 
 void keyReleased() {
 if (key == 'w') incX = 0;
 if (key == 's') incX = 0;
 if (key == 'a') incY = 0;
 if (key == 'd') incY = 0;
 }
 
 void draw() {
 background(0);
 
 posX += incX;
 posY += incY;
 rotateY(((posY-200.0)/100.0 * PI) - PI);
 rotateX(((posX-200.0)/100.0 * PI) - PI);
 
 }
 */
