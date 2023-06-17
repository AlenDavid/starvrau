boolean haveIpressedSpacebar = false;

//TODO: refactor this methods into a class object
//TODO: Refactor Title Screen Imputs from the Game Screen
void keyPressed() {
  //INputs on title screen
  if (titleScreen) {
   inputsForTitleScreen();
  } else if(gameOverScreen){
    inputsForGameOverScreen();
  } else {
    if (key == 'w') player.deltaY = -currentDeltaForPlayer;
    if (key == 's') player.deltaY = currentDeltaForPlayer;
    if (key == 'a') player.deltaX = -currentDeltaForPlayer;
    if (key == 'd') player.deltaX = currentDeltaForPlayer;
    if (key == ' ') {
      haveIpressedSpacebar = true;
      lasers.add(new Laser(player.x, player.y, 0));
    }
  }
}

void keyReleased() {
  if (key == 'w') player.deltaY = 0.0;
  if (key == 's') player.deltaY = 0.0;
  if (key == 'a') player.deltaX = 0.0;
  if (key == 'd') player.deltaX = 0.0;
  if (key == ' ') {
    haveIpressedSpacebar = false;
  }

}
