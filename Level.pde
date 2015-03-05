class Level {

  int[][] level;
  Tile[][] tiles;


  Level() {
    loadLevel(LevelDefs.LEVEL1);
  }
  void draw() {
    for (int Y= 0; Y < tiles.length; Y++) {
      for (int X= 0; X < tiles.length; X++) {
        tiles[Y][X].draw();
      }
    }
  }

//return the tile at grid position (X,Y)
  Tile getTile(int X, int Y) {
    return getTile(new Point(X, Y));
  }
  Tile getTile(Point p) {
    if (p.x <0 || p.y < 0) return null;
    if (p.x >= tiles[0].length || p.y >= tiles.length) return null;
    return tiles[p.y][p.x];
  }
  //get center of tile at point
  PVector getTileCenterAt(Point p){
    Tile tile= getTile(p);
    if (tile == null) return new PVector();
    return tile.getCenter();
  }
  //determine whether tile is passable
  boolean isPassable(Point p){
    Tile tile = getTile(p);
    if(tile == null) return false;
    return tile.isPassable();
  }
  
  //reload the level. useful for re-establishing neigbhor relationship between tiles
  void reloadLevel(){
   loadLevel(level); 
  }
  
  void loadLevel(int[][] layout){
    level = layout; //cache the layout (to enable reloading levels)
    
    //build our multidemensional array of tiles:
    int ROWS = layout.length;
    int COLS = layout[0].length;
    tiles = new Tile[ROWS][COLS];
    for(int Y = 0; Y < ROWS; Y++){
     for (int X = 0; X < COLS; X++){
      Tile tile = new Tile(X,Y);
      tile.TERRAIN = layout[Y][X];
      tiles[Y][X] = tile;
     } 
    }
    //Set each tiles neighboring tiles
    for(int Y = 0; Y < ROWS; Y++){
     for (int X = 0; X < COLS; X++){
      tiles[Y][X].addNeighbors(new Tile[] {
          getTile(new Point(X, Y-1)), 
          getTile(new Point(X-1, Y)), 
          getTile(new Point(X+1, Y)), 
          getTile(new Point(X, Y+1))
        });
     } 
    }
  }
}

