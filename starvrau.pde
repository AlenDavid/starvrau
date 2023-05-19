Player player;
float currentDeltaForPlayer=4.0;
float thresholdForRemoval=-50;
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
  fill(0);

  player = new Player();
  
}

void draw(){
  
  beginCamera();
  camera();
  fov = PI/2.5;
  cameraZ = (height/2.0) / tan(fov/2.0);
  nearPlane = cameraZ / 20.0;
  horizon = cameraZ * 20.0;
  perspective(fov, float(width)/float(height), nearPlane, horizon);
  rotateX(PI/20);
  endCamera();

  background(0);
  
  //Cria as estrelas para dar um efeito do movimento
  //Afinal o espaço nao eh tao vazio assim
  if (frameCount % 10 == 0) {
    stars.add(new BackgroundStar(random(width), random(height)));
    }

  //Cria os asteroides, precisa de uma lógica de geraçao melhor, talvez orientado a dificuldade
  //nao sei
  if (frameCount % 300 == 0) {
    Asteroid asteroid = new Asteroid(random(100,width), random(100,height), -7000);
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

  //renderiza o player
  player.drawThis(); 

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

boolean checkLineIntersection(SpaceLine line1, SpaceLine line2) {
  // Pontos das linhas
  float x1 = line1.startX;
  float y1 = line1.startY;
  float z1 = line1.startZ;
  float x2 = line1.endX;
  float y2 = line1.endY;
  float z2 = line1.endZ;
  float x3 = line2.startX;
  float y3 = line2.startY;
  float z3 = line2.startZ;
  float x4 = line2.endX;
  float y4 = line2.endY;
  float z4 = line2.endZ;

  float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
  float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

  // Verificar se a interseção está dentro dos segmentos
  if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) { 
    return true;
  }

  // Não há interseção
  return false;
}
,3
/**Resolvi q vou fazer a deteccao do jeito mais legal, essa classe representa uma linha do poligono */
public class SpaceLine {

  float startX,startY,startZ,endX,endY,endZ;

    public SpaceLine (float startX, float startY, float startZ, float endX, float endY, float endZ){
      this.startX=startX;
      this.startY=startY;
      this.startZ=startZ;
      this.endX=endX;
      this.endX=endY;
      this.endX=endZ;
    }

}

/**Classe Abstrata base prar as entidades no jogo */
abstract class GameEntity {
  float x, y, z, deltaX=0.0, deltaY=0.0,  deltaZ=0.0;
  
  void beforeDraw(){}
  void drawVertex(){}
  void drawThis(){}
}

/**Classe q representa o player, uma nave simples*/
public class Player extends GameEntity{

  float mainMeasure = 50.0;
  ArrayList<SpaceLine> lines = new ArrayList<SpaceLine>();

  public Player (){
    x=width/2;
    y=height/1.2;
    z=0.0;
  }

  /**Lógica antes de desenhar a nave*/
  public void beforeDraw(){
    x+=deltaX;
    y+=deltaY;
    z-=deltaZ;
    lines.clear();
    generateLines();
  }

  /**Gera as linhas, mas só pra face de cima, otimizaco */
  public void generateLines(){
    lines.add(new SpaceLine(-mainMeasure+x, -mainMeasure/3+y, -mainMeasure+z,
      mainMeasure+x, -mainMeasure/3+y, -mainMeasure+z));

    lines.add(new SpaceLine(mainMeasure+x, -mainMeasure/3+y, -mainMeasure+z,
      x, y, mainMeasure+z));

    lines.add(new SpaceLine( x, y, mainMeasure+z,
      -mainMeasure+x, -mainMeasure/3+y, -mainMeasure+z));
  }

  /**Checa se um asteroid bateu na nave */
  public void checkCollision() {

    for (i = asteroids.size()-1; i >= 0; i--) {
      Asteroid asteroid = asteroids.get(i);
      for (SpaceLine playerLine : player.lines) {
        for (SpaceLine asteroidLine : asteroid.lines) {
          if (checkLineIntersection(playerLine, asteroidLine)) {
            println("Player colidiu com o asteroid ", asteroid);
            asteroids.remove(asteroid);
          }
        }
      }
    }
  }

  /**Vértices da Nave */
  public void drawVertex(){
    beginShape();

    vertex( mainMeasure, -mainMeasure/3, mainMeasure);
    vertex( mainMeasure,  mainMeasure/3, mainMeasure);
    vertex(   0,    0,  -mainMeasure);

    vertex( mainMeasure, mainMeasure/3, mainMeasure);
    vertex(-mainMeasure, mainMeasure/3, mainMeasure);
    vertex(   0,   0,  mainMeasure);

    vertex(-mainMeasure,  mainMeasure/3, mainMeasure);
    vertex(-mainMeasure, -mainMeasure/3, mainMeasure);
    vertex(   0,    0,  -mainMeasure);

    vertex(-mainMeasure, -mainMeasure/3, mainMeasure);
    vertex( mainMeasure, -mainMeasure/3, mainMeasure);
    vertex(   0,    0,  -mainMeasure);
    endShape();
  }

  /**Renderiza a Nave */
  public void drawThis(){
    //Garante q as alteracoes acontecao na nave aenas
    pushMatrix();
    beforeDraw();
    translate(x, y, z);
    //ajusta o angulo do poligono da nave
    //rotateX(PI);
    checkCollision();
    drawVertex();
    //println("Player in X ", x, " Y ", y, " Z ", z);
    popMatrix();
  }

}

/**Classe q representa um asteroid, melhor nao bater neles*/
public class Asteroid extends GameEntity {
  float points[][] = new float[8][3];
  ArrayList<SpaceLine> lines = new ArrayList<SpaceLine>();
  
  public Asteroid(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;

    for(int i = 0; i < 8; i++){
        points[i][0]=random(100,width);
        points[i][1]=random(100,height);
        points[i][2]=random(100,400);
    }
  }

  /**Retorna true se nao ta mais aparecendo na tela, otimizacao de memoria: nem todo mundo tem um mac*/
  public boolean isNoLongerVisible(){
    return (z > thresholdForRemoval);
  }
  
  /**Logica antes de desenhar, atualiza a posicao */
  public void beforeDraw() {
    z += deltaZ;
    lines.clear();
    generateLines();
  }

  /**Gera um grafo k8 com os ponto, da pra melhorar */
  public void generateLines(){
    for(int i = 0; i < 8; i++){
      for(int j = 0; i < 8; i++){
        lines.add(new SpaceLine(points[i][0]+x,points[i][1]+y,points[i][2]-z,
        points[j][0]+x, points[j][0]+y, points[j][0]-z));
        println(points[i][0]+x,points[i][1]+y,points[i][2]-z, points[j][0]+x, points[j][0]+y, points[j][0]-z);
      }
    }

  }

  /**desenha os vertices, quase 100% randomico */
  public void drawVertex() {
    beginShape();

    vertex(points[0][0],points[0][1],points[0][2]);
    vertex(points[1][0],points[1][1],points[1][2]);
    vertex(points[2][0],points[2][1],points[2][2]);
    vertex(points[3][0],points[3][1],points[3][2]);

    vertex(points[0][0],points[0][1],points[0][2]);
    vertex(points[1][0],points[1][1],points[1][2]);
    vertex(points[5][0],points[5][1],points[5][2]);
    vertex(points[4][0],points[4][1],points[4][2]);

    vertex(points[0][0],points[0][1],points[0][2]);
    vertex(points[4][0],points[4][1],points[4][2]);
    vertex(points[7][0],points[7][1],points[7][2]);
    vertex(points[3][0],points[3][1],points[3][2]);

    vertex(points[3][0],points[3][1],points[3][2]);
    vertex(points[2][0],points[2][1],points[2][2]);
    vertex(points[6][0],points[6][1],points[6][2]);
    vertex(points[7][0],points[7][1],points[7][2]);

    vertex(points[1][0],points[1][1],points[1][2]);
    vertex(points[2][0],points[2][1],points[2][2]);
    vertex(points[6][0],points[6][1],points[6][2]);
    vertex(points[5][0],points[5][1],points[5][2]);

    vertex(points[4][0],points[4][1],points[4][2]);
    vertex(points[7][0],points[7][1],points[7][2]);
    vertex(points[6][0],points[6][1],points[6][2]);
    vertex(points[5][0],points[5][1],points[5][2]);
    
    endShape();
  }

  /**Renderiza o asteroide */
  public void drawThis() {
    pushMatrix();
    beforeDraw();
    translate(x, y, z);

    // Adiciona rotações em todos os eixos
    // Corpos em movimento permanecem em movimento
    rotateX(frameCount * 0.0004);
    rotateY(frameCount * 0.0004);
    rotateZ(frameCount * 0.0001);
    
    drawVertex();
    //println("Asteroid ", this, "in X ", x, " Y ", y, " Z ", z);
    popMatrix();
  }
}

public class BackgroundStar extends GameEntity{

  public BackgroundStar (float x, float y){
    this.x = x;
    this.y = y;
    this.z = -7000;
    this.deltaZ=1000;
  }

  /**Retorna true se nao ta mais aparecendo na tela, otimizacao de memoria: nem todo mundo tem um mac*/
  public boolean isNoLongerVisible(){
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
