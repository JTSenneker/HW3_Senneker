class Level {

  int[][] level;
  Tile[][] tiles;


  Level() {
    //loadLevel(LevelDefs.LEVEL1);
  }
  void draw() {
    for(int Y= 0; Y < tiles.length; Y++){
      for(int X= 0; X < tiles.length; X++){
       tiles[Y][X].draw(); 
      }
    }
  }
}

