Player player;
float currentDeltaForPlayer=4.0;
float thresholdForRemoval=500;
int i;



//Variavies dos sons
SoundFile backgroundMusic;
ArrayList<SoundFile> laserShootSounds = new ArrayList<SoundFile>();
ArrayList<SoundFile> hitSounds = new ArrayList<SoundFile>();
ArrayList<SoundFile> explosionSounds = new ArrayList<SoundFile>();
ArrayList<SoundFile> barrelRowSounds = new ArrayList<SoundFile>();

//Variaveis para o FOV da camera, a coodernada Z da camera
//o Plano da camera e o horizonte do mundo
float fov, cameraZ, nearPlane, horizon;

ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
ArrayList<BackgroundStar> stars = new ArrayList<BackgroundStar>();
ArrayList<Laser> lasers = new ArrayList<Laser>();


// TODO: use this later.
ArrayList<GameEntity> entities = new ArrayList<GameEntity>();
