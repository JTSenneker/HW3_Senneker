//SpriteSheet tileSheet;
Level level;
Player player;
Pathfinder pathfinder;
void setup() {
  TileHelper.app = this;

  size(544, 416,P2D);

  level = new Level();
  player = new Player();
  pathfinder = new Pathfinder();

  //tileSheet = new SpriteSheet("TileSheet.png");
}

void draw() {
  //UPDATE
  player.update();
  
  //DRAW
  background(0); 
  level.draw();
  player.draw();
  //tileSheet.draw();
}

void mousePressed() {
  Point p = TileHelper.pixelToGrid(new PVector(mouseX, mouseY));

  player.setTargetPosition(p);
}

