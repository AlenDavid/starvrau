void setupMusic() {
  backgroundMusic = new SoundFile(this, "lasermonia.wav");

  titleMusic= new SoundFile(this, "hazeroid.wav");
  titleMusic.loop();

  for (int i = 0; i < 4; i++) {
    laserShootSounds.add(
      new SoundFile(this, String.format("laser%s.wav", i+1)));
  }

  for (int i = 0; i < 4; i++) {
    hitSounds.add(
      new SoundFile(this, String.format("hit%s.wav", i+1)));
  }

  for (int i = 0; i < 2; i++) {
    barrelRollSounds.add(
      new SoundFile(this, String.format("roll%s.wav", i+1)));
  }

  for (int i = 0; i < 4; i++) {
    explosionSounds.add(
      new SoundFile(this, String.format("explosion%s.wav", i+1)));
  }
}
