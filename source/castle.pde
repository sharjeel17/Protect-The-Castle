// Declare class
class Castle {
  int x;
  int y;
  PImage img;

  void setup() {//Loads in image of castle
    img = loadImage("castle.PNG");
  }

  void draw() {//Draws castle image at the location
    image(img, x-200, 0, 400, 50);
  }

  void run() {//runs the image and resizeing
    setup();
    draw();
  }
}
