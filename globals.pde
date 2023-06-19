// set to 'true' to enable debugging;
boolean debug = false;

int dificulty = -7000;
int defaultStartingLife = 10;
float currentDeltaForPlayer = 11.0;
float thresholdForRemoval = 500;
boolean titleScreen = true;
boolean gameOverScreen = false;

boolean haveIpressedSpacebar = false;

// Defines the frequency of asteroids
int initialFrequency = 120;
int frequencyIncrement = 10;
int currentFrequency = 0;

//FOV, camera Z, camera plane and horizon
float fov, cameraZ, nearPlane, horizon;

// Global instances
Player player;

PFont font;


// Sounds
SoundFile backgroundMusic;
SoundFile titleMusic;
ArrayList<SoundFile> laserShootSounds = new ArrayList<SoundFile>();
ArrayList<SoundFile> hitSounds = new ArrayList<SoundFile>();
ArrayList<SoundFile> explosionSounds = new ArrayList<SoundFile>();
ArrayList<SoundFile> barrelRollSounds = new ArrayList<SoundFile>();


// Entities
ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
ArrayList<Explosion> explosions = new ArrayList<Explosion>();
ArrayList<BackgroundStar> stars = new ArrayList<BackgroundStar>();
ArrayList<Laser> lasers = new ArrayList<Laser>();
