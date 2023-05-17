Player player;
float currentDeltaForPlayer=4.0;
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
  noFill();

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
  
  if (frameCount % 10 == 0) {
    stars.add(new BackgroundStar(random(width), random(height)));
    }

  if (frameCount % 300 == 0) {
    Asteroid asteroid = new Asteroid(random(100,width), random(100,height), -7000);
    asteroid.deltaZ = 10.0;  // Velocidade de aproximação do asteroide
    asteroids.add(asteroid);
  }

  for (i = stars.size()-1; i >= 0; i--) {
      BackgroundStar s = stars.get(i);
      s.drawThis();
      if (s.isNoLongerVisible()) {
        stars.remove(s);
      }
    }

  for (i = asteroids.size()-1; i >= 0; i--) {
        Asteroid s = asteroids.get(i);
        s.drawThis();
        if (s.isNoLongerVisible()) {
          stars.remove(s);
        }
      }

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

abstract class GameEntity {
  float x, y, z, deltaX=0.0, deltaY=0.0,  deltaZ=0.0;
  void beforeDraw(){}
  void drawVertex(){}
  void drawThis(){}
}

public class Player extends GameEntity{

  public Player (){
    x=width/2;
    y=height/1.2;
    z=0.0;
  }

  public void beforeDraw(){
    x+=deltaX;
    y+=deltaY;
    z-=deltaZ;
  }

  public void drawVertex(){
    beginShape();
    vertex(-50, -50/3, -50);
    vertex( 50, -50/3, -50);
    vertex(   0,    0,  50);

    vertex( 50, -50/3, -50);
    vertex( 50,  50/3, -50);
    vertex(   0,    0,  50);

    vertex( 50, 50/3, -50);
    vertex(-50, 50/3, -50);
    vertex(   0,   0,  50);

    vertex(-50,  50/3, -50);
    vertex(-50, -50/3, -50);
    vertex(   0,    0,  50);
    endShape();
  }

  public void drawThis(){
    pushMatrix();
    beforeDraw();
    translate(x, y, z);
    rotateX(PI);
    drawVertex();
    println("Player in X ", x, " Y ", y, " Z ", z);
    popMatrix();

  }

}

public class Asteroid extends GameEntity {
  float points[][] = new float[8][3];
  
  public Asteroid(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;

    for(int i = 0; i < 8; i++){
      for(int j = 0; j < 3; j++){
        points[i][j]=random(100,height);
      }
    }

  }

  public boolean isNoLongerVisible(){
    return (z > cameraZ);
  }
  
  public void beforeDraw() {
    z += deltaZ;
  }

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

  
  public void drawThis() {
    pushMatrix();
    beforeDraw();
    translate(x, y, z);

    // Adiciona rotações em todos os eixos
    rotateX(frameCount * 0.004);
    rotateY(frameCount * 0.004);
    rotateZ(frameCount * 0.01);
    
    drawVertex();
    println("Asteroid in X ", x, " Y ", y, " Z ", z);
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

  public boolean isNoLongerVisible(){
    return (z > cameraZ);
  }

  public void beforeDraw() {
    z += deltaZ;
  }

  public void drawVertex() {
    sphere(3);
    fill(65);
  }

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
