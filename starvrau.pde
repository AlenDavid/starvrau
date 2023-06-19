void setup () {
  smooth();
  stroke(255);
  strokeWeight(1);
  size(800, 600, P3D);
  frameRate(60);

  font = createFont("font.ttf", 128);
  textFont(font);
  
  setupMusic();

  player = new Player();
}

void draw() {
  if (titleScreen) {
    drawTitleScreen();
  } else if (gameOverScreen) {
    drawGameOverScreen();
  } else {
    resetMatrix();
    beginCamera();
    camera();
    fov = PI/2.9;
    cameraZ = (height/2.0) / tan(fov/2.0);
    nearPlane = cameraZ / 20.0;
    horizon = cameraZ * 20.0;
    perspective(fov, float(width)/float(height), nearPlane, horizon);
    //rotateX(PI/20);
    endCamera();

    background(0);
    fill(0);

    //render the player
    player.draw();


    /**Make the stars, so it has a nice movement effect
     after all, space isn't that empty */
    if (frameCount % 1 == 0) {
      stars.add(new BackgroundStar(random(width), random(height)));
    }

    //Calculates the current frequency of asteroids generation
    currentFrequency = initialFrequency - (frameCount / 500) * frequencyIncrement;

    if (currentFrequency<=0) currentFrequency=10;

    // Verifies if should creat an ansteroid
    if (frameCount % currentFrequency == 0) {
      Asteroid asteroid = new Asteroid(random(100, width), random(100, height), -7000);
      asteroid.deltaZ = 40.0;
      asteroids.add(asteroid);
    }


    /**Remove the stars no longer visible
     iterates the array backward to avoid concurrent call
     Java as it is
     */
    for (int i = stars.size()-1; i >= 0; i--) {
      BackgroundStar s = stars.get(i);
      s.draw();
      if (s.isNoLongerVisible()) {
        stars.remove(s);
      }
    }

    /**Remove the lasers no longer visible
     iterates the array backward to avoid concurrent call
     Java as it is
     */
    for (int i = lasers.size()-1; i >= 0; i--) {
      GameEntity s = lasers.get(i);
      s.draw();
      if (s.isNoLongerVisible()) {
        lasers.remove(s);
      }
    }

    /**Remove the asteroids no longer visible
     iterates the array backward to avoid concurrent call
     Java as it is
     */
    for (int i = asteroids.size()-1; i >= 0; i--) {
      Asteroid s = asteroids.get(i);
      s.draw();
      //println(asteroids.size(), ' ', i);
      if (s.isNoLongerVisible()) {
        asteroids.remove(s);
      }
    }

    /**Remove the explosions no longer visible
     iterates the array backward to avoid concurrent call
     Java as it is
     */
    for (int i = explosions.size()-1; i >= 0; i--) {
      Explosion s = explosions.get(i);
      s.draw();
      if (s.isNoLongerVisible()) {
        explosions.remove(s);
      }
    }

    /*It prints the player health ans player.score */
    fill(255);
    textSize(10);
    text("Life: " + player.life, width/2, 5);
    text("Score: " + player.score, width/2, 30);
  }
}


boolean checkIntersection(GameEntity entity1, GameEntity entity2) {
  float x1 = entity1.x - entity1.entityWidth/2;
  float y1 = entity1.y - entity1.entityHeight/2;
  float z1 = entity1.z - entity1.entityDepth/2;
  float x2 = entity2.x - entity2.entityWidth/2;
  float y2 = entity2.y - entity2.entityHeight/2;
  float z2 = entity2.z - entity2.entityDepth/2;

  if (debug) {
    pushMatrix();
    translate(entity1.x, entity1.y, entity1.z);
    noFill();
    stroke(255, 0, 0); // Box in red
    box(entity1.entityWidth, entity1.entityHeight, entity1.entityDepth);
    sphere(10);
    popMatrix();

    pushMatrix();
    translate(entity2.x, entity2.y, entity2.z);
    noFill();
    stroke(0, 255, 0); //Box in green
    box(entity2.entityWidth, entity2.entityHeight, entity2.entityDepth);
    popMatrix();

    stroke(255);
  }

  return (abs(x1 - x2) < (entity1.entityWidth + entity2.entityWidth)) &&
    (abs(y1 - y2)  < (entity1.entityHeight + entity2.entityHeight)) &&
    (abs(z1 - z2)  < (entity1.entityDepth + entity2.entityDepth));

  /*return (abs(x1 - x2) < (entity1.entityWidth + entity2.entityWidth)) &&
   (abs(y1 - y2)  < (entity1.entityHeight + entity2.entityHeight)) &&
   (abs(z1 - z2)  < (entity1.entityDepth + entity2.entityDepth));*/
}
