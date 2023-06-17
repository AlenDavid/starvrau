void inputsForGameOverScreen(){
    if (key == ' ' ) {
        player = new Player();
        player.playerName="";
        player.score=0;
        asteroids.clear();
        titleScreen=true;
        gameOverScreen=false;
        titleMusic.loop();
    }
}

void drawGameOverScreen(){
    background(0);
    fill(255);
    textSize(30);
    textAlign(CENTER);
    text("Game Over!", width/2, height/2);
    textSize(15);
    text("Press SPACEBAR to restart", width/2, height/2+40);

    textSize(15);
    text("Your score:", width/2, height/2+40+30);

    textSize(20);
    fill(random(255),random(255),random(255));
    text(player.playerName + " " + player.score, width/2, height/2+40+60);
}