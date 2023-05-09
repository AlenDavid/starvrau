float posX, posY, incX=0.0, incY=0.0;

void setup () {
  // Re-creates the default perspective
  smooth();
  size(400, 400, P3D);
  noFill();
  draw();
}

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
  background(255);
  translate(200, 200, 0);

  posX += incY;
  posY += incX;

  rotateY(((posX-200.0)/100.0 * PI) - PI);
  rotateX(((posY-200.0)/100.0 * PI) - PI);
  box(180);
}
