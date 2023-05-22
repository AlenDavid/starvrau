// TODO: refactor this methods into a class object
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
