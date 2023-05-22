Player player;
float currentDeltaForPlayer=4.0;
float thresholdForRemoval=500;
int i;

//Variaveis para o FOV da camera, a coodernada Z da camera
//o Plano da camera e o horizonte do mundo
float fov, cameraZ, nearPlane, horizon;

ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
ArrayList<BackgroundStar> stars = new ArrayList<BackgroundStar>();
