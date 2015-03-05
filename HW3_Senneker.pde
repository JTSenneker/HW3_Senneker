//SpriteSheet tileSheet;
Level level;
void setup() {
  size(544,416);
  
  level = new Level();
  TileHelper.app = this;
  //tileSheet = new SpriteSheet("TileSheet.png");
}

void draw(){
  println(level.level[0].length);
 background(0); 
 level.draw();
 //tileSheet.draw();
}
