Player player;

float currentDeltaForPlayer=11.0;
float thresholdForRemoval=500;
boolean titleScreen = true;
boolean gameOverScreen = false;

// set to 'true' to enable debugging;
boolean debug = false;

//Sounds
SoundFile backgroundMusic;
SoundFile titleMusic;
ArrayList<SoundFile> laserShootSounds = new ArrayList<SoundFile>();
ArrayList<SoundFile> hitSounds = new ArrayList<SoundFile>();
ArrayList<SoundFile> explosionSounds = new ArrayList<SoundFile>();
ArrayList<SoundFile> barrelRollSounds = new ArrayList<SoundFile>();

//FOV, camera Z, camera plane and horizon
float fov, cameraZ, nearPlane, horizon;

ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
ArrayList<Explosion> explosions = new ArrayList<Explosion>();
ArrayList<BackgroundStar> stars = new ArrayList<BackgroundStar>();
ArrayList<Laser> lasers = new ArrayList<Laser>();

// Defines the frequency of asteroids
int initialFrequency = 120;
int frequencyIncrement = 10;
int currentFrequency=0;

PFont font;

// TODO: use this later.
ArrayList<GameEntity> entities = new ArrayList<GameEntity>();
