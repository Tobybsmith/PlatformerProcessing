// platformer game jumps 3 up 3 over

// makes a grid
final int WIDTH = 40;
final int HEIGHT = 30;
int[][] level = new int[HEIGHT][WIDTH];
int[][] points = new int[HEIGHT][WIDTH];
int[][] collapse = new int[HEIGHT][WIDTH];
int[][] spike = new int[HEIGHT][WIDTH];
int[] scores = new int [2]; // score[0] is reserved for highscore
int score = 0;
int startX = WIDTH/2;
int startY  = HEIGHT/2;
int time; 
int tlimit; // time limit for extra points
int maxpoints = 1; // max number of points in level
int collected = 0;
int levels = 0; // which level 0 is menu 4 is final score

Player p1;
Level world;

boolean right = false;
boolean left = false;
boolean up = false;
boolean cheats = false;
boolean ldone = false;

void setup() 
{
  size(640, 480);
  p1 = new Player(startX*16, startY*16);
  world = new Level();
}
void draw() 
{
  world.backgrounds();
  p1.update();
  world.update();
  p1.show();
}


void keyPressed() 
{
  if (key == CODED && keyCode == UP)
  {
    up = true;
  }

  if (key == CODED && keyCode == LEFT)
  {
    left = true;
  }
  if (key == CODED && keyCode == RIGHT)
  {
    right = true;
  }
  if (key == 'w')
  {
    up = true;
  }
  if (key == 'a')
  {
    left = true;
  }
  if (key == 'd')
  {
    right = true;
  }
  if (key == 'r')
  {
    p1.death();
  }
}
void keyReleased() 
{
  if (key == CODED && keyCode == UP)
  {
    up = false;
  }
  if (key == CODED && keyCode == LEFT)
  {
    left = false;
  }
  if (key == CODED && keyCode == RIGHT)
  {
    right = false;
  }
  if (key == 'w')
  {
    up = false;
  }
  if (key == 'a')
  {
    left = false;
  }
  if (key == 'd')
  {
    right = false;
  }
  if (key == 'c')
  {
    cheats = true;
  }
}
void mousePressed() 
{
  //Left click creates/destroys a block
  if ( mouseButton == LEFT) 
  {
    world.cheats(cheats);
  }
}

