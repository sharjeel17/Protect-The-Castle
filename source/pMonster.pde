abstract class PMonster { //This class is for both bomb and monster classes PMonster is a parent class
  float x;//makes x and y preset variables in monster and bomb
  float y;
  public abstract void explosions();//adds explosions
  public abstract void run();//animations
  public void reset() {//respawn
    print("helloni");
  }
  public abstract void Monstermove(float mSpeed);//movements and speed
}
