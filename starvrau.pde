import processing.sound.*;
boolean debug = true;

void setup () {
  smooth();
  stroke(255);
  strokeWeight(1);
  size(800, 600, P3D);
  frameRate(60);
  fill(0);

  //Inicia a musica de fundo
  backgroundMusic= new SoundFile(this, "lasermonia.wav");
  backgroundMusic.loop();

  //Inicia o array de sons dos lasers
  for(int i=0;i<4;i++){
    laserShootSounds.add(
      new SoundFile(this, String.format("laser%s.wav",i+1)));
  }

  //Inicia o array de sons dos hits
  for(int i=0;i<4;i++){
    hitSounds.add(
      new SoundFile(this, String.format("hit%s.wav",i+1)));
  }

  //Inicia o array de sons dos rolls
  for(int i=0;i<2;i++){
    barrelRollSounds.add(
      new SoundFile(this, String.format("roll%s.wav",i+1)));
  }

  //Inicia o array de sons das explosoes
  for(int i=0;i<4;i++){
    explosionSounds.add(
      new SoundFile(this, String.format("explosion%s.wav",i+1)));
  }


  player = new Player();
}

void draw() {
  resetMatrix();
  beginCamera();
  camera();
  fov = PI/2.7;
  cameraZ = (height/2.0) / tan(fov/2.0);
  nearPlane = cameraZ / 20.0;
  horizon = cameraZ * 20.0;
  perspective(fov, float(width)/float(height), nearPlane, horizon);
  //rotateX(PI/20);
  endCamera();

  background(0);

  //renderiza o player
  player.draw();

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
    s.draw();
    if (s.isNoLongerVisible()) {
      stars.remove(s);
    }
  }

  //Remove os lasers nao mais visiveis
  //Varre o array de tras pra frente pra evitar concorrencia
  //Java sendo Java
  for (i = lasers.size()-1; i >= 0; i--) {
    GameEntity s = lasers.get(i);
    s.draw();
    if (s.isNoLongerVisible()) {
      lasers.remove(s);
    }
  }

  //Remove os asteroides nao mais visiveis
  //Varre o array de tras pra frente pra evitar concorrencia
  //Java sendo Java
  for (i = asteroids.size()-1; i >= 0; i--) {
    Asteroid s = asteroids.get(i);
    s.draw();
    if (s.isNoLongerVisible()) {
      asteroids.remove(s);
    }
  }

}


boolean checkIntersection(GameEntity entity1, GameEntity entity2) {
  float x1 = entity1.x - entity1.entityWidth/2;
  float y1 = entity1.y - entity1.entityHeight/2;
  float z1 = entity1.z - entity1.entityDepth/2;
  float x2 = entity2.x - entity2.entityWidth/2;
  float y2 = entity2.y - entity2.entityHeight/2;
  float z2 = entity2.z - entity2.entityDepth/2;

  if (debug){
    pushMatrix();
    translate(entity1.x, entity1.y, entity1.z);
    noFill();
    stroke(255, 0, 0); // Cor vermelha
    box(entity1.entityWidth,  entity1.entityHeight, entity1.entityDepth);
    popMatrix();

    pushMatrix();
    translate(entity2.x, entity2.y, entity2.z);
    noFill();
    stroke(255, 0, 0);
    box(entity2.entityWidth,  entity2.entityHeight, entity2.entityDepth);
    popMatrix();

    stroke(255);
  }

  return (abs(x1 - x2) < (entity1.entityWidth + entity2.entityWidth)) &&
    (abs(y1 - y2)  < (entity1.entityHeight + entity2.entityHeight)) &&
    (abs(z1 - z2)  < (entity1.entityDepth + entity2.entityDepth));
}
