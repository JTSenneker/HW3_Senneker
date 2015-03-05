//SpriteSheet tileSheet;
Level level;
void setup() {
  size(800,800);
  
  level = new Level();
  TileHelper.app = this;
  //tileSheet = new SpriteSheet("TileSheet.png");
}

void draw(){
 background(0); 
 level.draw();
 //tileSheet.draw();
}
