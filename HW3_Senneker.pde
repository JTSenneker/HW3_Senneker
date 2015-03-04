SpriteSheet tileSheet;
void setup() {
  size(800,800);
  TileHelper.app = this;
  tileSheet = new SpriteSheet("TileSheet.png");
}

void draw(){
 background(0); 
 tileSheet.draw();
}
