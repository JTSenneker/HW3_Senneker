class Sprite {
  PImage img;
  PVector origin;
  PVector pos;

  float scale = 1;
  float rotation;

  public Sprite(String file) {
    this.img = loadImage(file);
    centerOrigin();
  }

  void draw() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(rotation);
    scale(scale);
    image(img, -origin.x, -origin.y);
    popMatrix();
  }

  void centerOrigin() {
    origin = new PVector(img.width/2, img.height/2);
  }
}

class SpriteSheet {
  PImage img;

  int frameWidth = 32;
  int frameHeight = 32;
  
  int framesPerRow;

  float framesPerSecond;
  float deltaTime;

  int currentFrame = 24;

  public SpriteSheet(String file) {
    this.img = loadImage(file);
    framesPerRow = floor(img.width/frameWidth);
  }

  void draw() {
    int row = floor(currentFrame%framesPerRow);
    int col= floor(currentFrame/framesPerRow);
    
    PImage currentSprite = img.get(row*frameWidth,col*frameHeight,frameWidth,frameHeight);
    image(currentSprite,mouseX,mouseY);
  }
}

