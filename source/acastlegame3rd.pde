import java.util.Arrays;
// Declare and initialize global variables
PImage backGround; //Load background image grass
int bgX = 0;
int level=1; //Makes level and sets it to 1
int highscore; //Makes highscore a variable
int score = 0; //Makes score an integer and start at zero
int gameScreenNum=0;//Set game screen to 0 which is the start game, screen 1 will be the gamescreen then last would be screen 2
int gameOver=0;//Ints gameover screen
int healthBarWidth = 100;
int maxHealth = 250;
float health = 250;
float healthDecrease = 1;
float mSpeed=3;//Speed of monster
float bSpeed=6;//Speed of bomb monster
PrintWriter scores;//Use to write score

//Declare and initialize objects
Castle castle = new Castle();
Knight knight = new Knight();
PMonster[] monster= new PMonster[5];

void setup() {
  size(800, 800); //size of the screen
  for (int i = 0; i < 5; i++) {
    if (i<3) {
      monster[i]=new Monster();//Load in array of regular monsters
    } else {
      monster[i]=new Bomb();//Load in array of bomb monsters
    }
  }
  String[] Scores=loadStrings("HIGHSCORE.txt");//loads the textfile with the name HIGHSCORE
  highscore=int(Scores[0]);
  backGround = loadImage("grass.jpg");//Loads the grass background
  backGround.resize(width, height);//makes the background big enough for the game screen which is 800x800
  castle.x = 400;
  castle.y = 400;
  for (int i = 0; i < 5; i++) {
    monster[i].reset();//Resets all monsters
  }
}

void draw() {  // Display the contents of the current screens
  if (gameScreenNum == 0) {//Press to start screen
    initScreen();//initalize screen
  } else if (gameScreenNum == 1) {//This will draw the main game screen
    gameScreen();
    for (int i = 0; i < 5; i++) {
      if (i<3) {
        monster[i].Monstermove(mSpeed);//Makes monsters move and sets speed of the monsters
      } else {
        monster[i].Monstermove(bSpeed);//Makes bomb monster move and sets speed of the bomb monsters
      }
    }
  } else if (gameScreenNum == 2) {//Calls the game over screen
    gameOverScreen();
  }
}

void initScreen() {
  background(0, 30, 30);//Creates a background for the menu screen
  textAlign(CENTER);//Centers text
  fill(255, 0, 50);//Makes the text a red colour
  textSize(70);//Size of text
  text("Protect Your Castle", width/2, height/2);//Centers the texts because of height and width over 2
  textSize(15);
  text("Press any key to start", width/2, height-30);//Centers text then the - 30 makes it slightly higher
}

void gameScreen() {
  image(backGround, bgX, 0);//Draws grass in background
  castle.run();
  knight.run();
  knight.Kupdate();// Update the knight's position
  damage();//Damage of the monsters when on castle
  levels();
  for (int i = 0; i < 5; i++) {//Draws monster animations both monsters and bomb monsters
    monster[i].run();
  }
  for (int i = 3; i < 5; i++) {
    monster[i].explosions(); //Draws animations for bomb monster explosions
  }
  if (gameScreenNum==1)//Draws health, score, level when game is started
    drawStats();

  }

void gameOverScreen() {//What displays during the game over screen
  background(0, 30, 30);
  if (score<highscore) {//If score is less than highscore
    textSize(30);
    text("YOUR SCORE: "+score, width/2, height/2); //display score
    textSize(20);
    text("HIGHEST SCORE: "+highscore, width/2, height/2 - 50);//display last highscore
  }
  if (score>highscore) {//If score is higher than highscore than save score as highscore
    scores = createWriter("HIGHSCORE.txt");//save into textfile named highscore
    scores.println(score);
    scores.close();//saves and closes file
    gameOver=1;
    textSize(30);
    text("NEW HIGHSCORE: "+score, width/2, height/2);//Displays current score which will be saved over as highscore
    textSize(20);
    text("PREVIOUS HIGHSCORE: "+highscore, width/2, height/2-50 );//Shows the previous highscore
  }
  textSize(15);
  text("Press any key to restart", width/2, height-30);//Centers text then the - 30 makes it slightly higher
  gameOver=1;
    mSpeed=3;//restarts speeds and levels
    bSpeed=6;
    level=1;
}

void drawStats() {//score,healthbar,levels
  fill(255, 255, 255);
  textSize(25);
  text("SCORE: "+score, 60, 30);// Draws the score
  text("LEVEL: "+level, 60, 790);//Draws level
  textSize(15);
  text(health, 700, 50);//Shows value of health rather than just the health bar
  rectMode(CORNER);
  fill(200, 200, 200);//Bar behind health so you can see whether health has decreased
  rect(700-(healthBarWidth/2), 50 - 30, healthBarWidth, 10);
  if (health > (maxHealth/2)) { //When health exceeds 50 percent then the colour will change to orange
    fill(46, 204, 113);
  } else if (health > (maxHealth/2.5)) { //When the health goes bellow health over 2.5 then the colour will start changing to a more red tone
    fill(230, 126, 34);
  } else {
    fill(255, 76, 60);//Fills bar red
  }
  rectMode(CORNER);
  rect(700-(healthBarWidth/2), 50 - 30, healthBarWidth*(health/maxHealth), 10);//The outer bar
}

// Check if the knight has reached the monster
void mousePressed() {
  for (int i = 0; i < 3; i++) {
    if (dist(knight.x, knight.y, monster[i].x, monster[i].y) < 30) { //If the knight is touching the monster and the mouse is pressed within 25 pixels distance then
      monster[i].reset();//Reset monster
      score++;//Increase the score by one
    }
  }
}

void decreaseHealth() {//Loss of health
  health=health-healthDecrease;
  if ( health<= 0) {
    gameScreenNum = 2;//If the health is less than 0 then game ends and goes to gameScreenNum
  }
}

void damage() { //Checks whether monster has reached castle then monster does damage to castle
  for (int i = 0; i < 3; i++) {
    if (monster[i].y < 54 && (monster[i].x >= (castle.x-200) && monster[i].x <= (castle.x-200+400)))
    {
      decreaseHealth();//Decrease health and when health is bellow 0 the game ends
    }
  }
}

void restart() { //Resets the score, health back to 0 and enemy objects
  score = 0;
  health = maxHealth;
  gameScreenNum = 1;
  for (int i = 0; i < 5; i++) {
    monster[i].reset();
  }
}

void levels(){
  if (score>10) {
    mSpeed=4; // When score exceeds 10 the speed of monster increases This will count as level 2
    level=2;
  }
  if (score>30) {
    mSpeed=5; // When score exceeds 30 the speed of monster increases This will count as level 3
    level=3;
  }
  if (score>50) {
    mSpeed=6;  //When score exceeds 50 the speed of monster increases This will count as level 4
    level=4;
  }
  if (score>70) {
    mSpeed=10; //When score exceeds 70 the speed of monster increases This will count as level 5
    level=5;
  }
  if (score>100) {
    mSpeed=12; //When score exceeds 100 the speed of monster increases This will count as level 6
    level=6;
  }
  if  (score>150) {
    bSpeed = 24; //When score exceeds 150 the speed of monster increases This will count as level this will be level 7 the final level
    level=7;
}
}

public void keyPressed() {
  if (gameScreenNum==0) {  //If on the initial screen when key pressed, start the game
    startGame();
  }
  if (gameOver==1)
  {
    gameOver=0;
    restart();
    gameScreenNum=0;//If the game is over then restart when key pressed
  }
}

void startGame() {//Start the game
  gameScreenNum=1;
  gameOver = 0;
}
