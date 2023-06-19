void inputsForTitleScreen() {
  if (key == ' ' && player.playerName.length()>2) {
    titleScreen=false;
    titleMusic.stop();
    backgroundMusic.loop();
    frameCount=0;
  }
  if (key == BACKSPACE && player.playerName.length()>0) {
    player.playerName = player.playerName.substring(0, max(0, player.playerName.length()-1));
  }
  if ((key >= 'A') && (key <= 'z')) {
    player.playerName= player.playerName + key;
  }
}

void drawTitleScreen() {
  background(0);
  fill(random(255), random(255), random(255));
  textSize(40);
  textAlign(CENTER);
  text("STAR VRAU", width/2, height/2);

  fill(255);
  textSize(10);
  text("Enter your name and ", width/2, height/2+40);
  text("Press SPACEBAR to start", width/2, height/2+40+25);

  textSize(40);
  fill(0, 200, 125);
  text(player.playerName, width/2, height/2+40+85);
}
