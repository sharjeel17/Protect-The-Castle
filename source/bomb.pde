//Monster class which takes from PMonster
class Bomb extends PMonster {
  float explodeX, explodeY;
  float explodeCounter;
  float xt, yt;
  float imgCounter;
  PImage[] bombs = new PImage[4];//array of images for my bomb monster
  PImage[] explosions =new PImage[4];//array of explosions


  void bombimg() {//Loads array of bomb images
    for (int i = 0; i < 4; i++) {
      bombs[i] = loadImage("bomb" + i + ".png");
    }
  }

  void display() {//Loops through to animate images
    if (imgCounter < 10) {
      image(bombs[0], x-30, y-20);
    } else if (imgCounter < 20) {
      image(bombs[1], x-30, y-20);
    } else if (imgCounter < 30) {
      image(bombs[2], x-30, y-20);
    } else if (imgCounter < 39) {
      image(bombs[3], x-30, y-20);
    } else {
      image(bombs[3], x-30, y-20);
      imgCounter = 0;
    }
    imgCounter++;
  }

  void run() {//Displays the bomb and animates
    bombimg();
    display();
  }

  // Resets the position of the monster to a random location
  void reset() {
    x = random(width);
    y = random(height-100, height);
  }

  //Makes bomb go up and move towards the x and y of the castle
  void Monstermove(float bSpeed) { //if bomb already in accepted x region
    if (x >= 200 && x <= 600) {//Makes bomb stay within castle width
      if (y>50) {
        {
          // Is the centre close to the target?
          if ( (x-xt)*(x-xt) + (y-yt)*(y-yt) < 1 ) {//This is the more complex ememy movement which makes the spider bomb launch randomly rather than just walk
            yt = y + random( 600, 400 );
          }
          y = yt * 0.05 + y*0.95 ;
        }
        y=y-bSpeed;
      }
    } else if (x < 200) {
      if (y>50) {
        y=y-bSpeed;
      }
      if ( x < 200) {
        x = x+bSpeed;
      }
    } else if (x > 200) {
      if (y>50) {
        y=y-bSpeed;
      }
      if (x > 200) {
        x = x-bSpeed;
      }
    }
    if (y < 55) {
      reset(); //When castle is reached the bomb resets
    }
  }

  void explosionimg() {//Loads the explosion images
    for (int i = 0; i < 4; i++) {
      explosions[i] = loadImage("explosion" + (i+1) + ".png");
    }
  }

  void excounting() {//Loops through to animate explosion
    if (explodeCounter!=0) {
      if (explodeCounter < 10) {
        image(explosions[0], explodeX-30, explodeY-15);
      } else if (explodeCounter < 20) {
        image(explosions[1], explodeX-30, explodeY-15);
      } else if (explodeCounter < 30) {
        image(explosions[2], explodeX-30, explodeY-15);
      } else if (explodeCounter < 39) {
        image(explosions[3], explodeX-30, explodeY-15);
      } else {
        image(explosions[3], explodeX-30, explodeY-15);
        explodeCounter = -1;
      }
      explodeCounter++;
    }
  }

  void collision() {//When collided the bomb respawns and the health goes down
    if (dist(mouseX, mouseY, x, y)<=50) {
      explodeCounter+=1;
      explodeX=x;
      explodeY=y;
      reset();
      health=health-19;
      decreaseHealth();
    }
  }

  void explosions() {//Makes explosion happen when collided with mouse
    collision();
    explosionimg();
    excounting();
  }
}
