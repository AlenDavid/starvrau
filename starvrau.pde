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
