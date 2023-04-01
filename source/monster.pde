//Monster class which takes from PMonster
class Monster extends PMonster {
  PImage[] monsters = new PImage[4];
  float imgCounter;


  void monsterimg() {//Monster image array called from directory for animation
    for (int i = 0; i < 4; i++) {
      monsters[i] = loadImage("mummy" + i + ".png");
    }
  }

  void display() { //Animates monster
    if (imgCounter < 10) {
      image(monsters[0], x-25, y-30);//Changed x and y slightly to make the images in line with the circle hitbox that was there
    } else if (imgCounter < 20) {
      image(monsters[1], x-25, y-30);
    } else if (imgCounter < 30) {
      image(monsters[2], x-25, y-30);
    } else if (imgCounter < 39) {
      image(monsters[3], x-25, y-30);
    } else {
      image(monsters[3], x-25, y-30);
      imgCounter = 0;
    }
    imgCounter++;
  }

  void reset() {   // Resets the position of the monster to a random location
    x = random(width);
    y = random(height-250, height);
  }

  //Makes monsters go up and move towards the x and y of the castle
  void Monstermove(float mSpeed) {
    if (x >= 200 && x <= 600) { //If monsters already in accepted x region makes it go forward
      if (y>50) {
        y=y-mSpeed;
      }
    } else if (x < 200) {
      if (y>50) {
        y=y-mSpeed;
      }
      if ( x < 200) {
        x = x+mSpeed;
      }
    } else if (x > 200) {
      if (y>50) {
        y=y-mSpeed;
      }
      if (x > 200) {
        x = x-mSpeed;
      }
    }
  }
  void run() { //Used to call the monster animation
    monsterimg();
    display();
  }
  void explosions() {//Put explosions here because they have to be called but not used by the monster
  }
}
