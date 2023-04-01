//Knight class
class Knight {
  int x;
  int y;
  float imgCounter;
  PImage[] knights = new PImage[4];

  void Kupdate() { // Move the knight towards the mouse
    x = x + (mouseX - x) ;
    y = y + (mouseY - y) ;
  }

  //Animations
  void knightimg() {//Knight image array called from directory for animation
    for (int i = 0; i < 4; i++) {
      knights[i] = loadImage("Run" + i + ".png");
      knights[i].resize(60, 70);
    }
  }
  void display() {//Loops through to animate images
    if (imgCounter < 10) {
      image(knights[0], x-30, y-20);
    } else if (imgCounter < 20) {
      image(knights[1], x-30, y-20);
    } else if (imgCounter < 30) {
      image(knights[2], x-30, y-20);
    } else if (imgCounter < 39) {
      image(knights[3], x-30, y-20);
    } else {
      image(knights[3], x-30, y-20);
      imgCounter = 0;
    }
    imgCounter++;
  }

  void run() {//Animates knight and updates position
    knightimg();
    display();
    Kupdate();
  }
}
