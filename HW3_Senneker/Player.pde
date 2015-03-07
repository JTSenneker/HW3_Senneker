class Player {

  float soundWaveRadius = 0;
  float maxSoundWaveRadius = .1;

  boolean sendSoundWave = false;

  PShader soundWaveShader;

  //grid-space coordinates
  Point gridP = new Point(2, 5);//current position on the grid
  Point gridT = new Point(2, 5);//target position on the grid

  //Pixel-space coordinates
  PVector pixlP = new PVector();//current pixel position

  ArrayList<Tile> path;
  boolean findPath = true;

  Player() {
    //soundWaveShader = loadShader("warp.glsl");
    teleportTo(gridP);
    path = new ArrayList<Tile>();
  }

  void teleportTo(Point gridP) {
    Tile tile = level.getTile(gridP);
    if (tile != null) {
      this.gridP = gridP.get();
      this.gridT = gridP.get();
      this.pixlP = tile.getCenter();
    }
  }

  void setTargetPosition(Point gridT) {
    this.gridT = gridT.get();
  }

  void update() {
  
    if (findPath == true) findPathAndTakeNextStep();
    updateMove();
  }

  void findPathAndTakeNextStep() {
    findPath = false;
    //find path to target grid position
    Tile start = level.getTile(gridP);
    Tile end = level.getTile(gridT);

    if (start == end) {
      path = null;
      return;
    } 

    path = pathfinder.findPath(start, end);

    if (path != null && path.size() > 1) {
      Tile tile = path.get(1);
      if (tile.isPassable()) { 
        gridP = new Point(tile.X, tile.Y);
      }
    }
    //change current grid position to next step towards target
  }

  void updateMove() {
    float speed = 4;

    PVector pixlT = level.getTileCenterAt(gridP);//Get target position in pixels
    PVector diff = PVector.sub(pixlT, pixlP);
    //move current pixel position towards target
    pixlP.x += diff.x*.2;
    pixlP.y += diff.y*.2;
    //ensure no movement bugs
    if (abs(diff.x)<1) pixlP.x = pixlT.x;
    if (abs(diff.y)<1) pixlP.y = pixlT.y;

    // IF WE'VE ARRIVED AT LOCATION, TRIGGER NEXT PATH FIND
    if (pixlP.x == pixlT.x && pixlP.y == pixlT.y) findPath = true;
  }


  void goLeft(boolean overridePath) {
    // IF THE TILE TO THE LEFT IS PASSABLE, MOVE LEFT
    if (level.isPassable(gridP.getLeft())) gridP.x--;

    // IF overridePath, SET TARGET POSITION TO NEW POSITION
    if (overridePath) gridT = gridP.get();
  }
  void goUp(boolean overridePath) {
    // IF THE TILE ABOVE IS PASSABLE, MOVE UP
    if (level.isPassable(gridP.getUp())) gridP.y--;
    // IF overridePath, SET TARGET POSITION TO NEW POSITION
    if (overridePath) gridT = gridP.get();
  }
  void goRight(boolean overridePath) {
    // IF THE TILE TO THE RIGHT IS PASSABLE, MOVE RIGHT
    if (level.isPassable(gridP.getRight())) gridP.x++;
    // IF overridePath, SET TARGET POSITION TO NEW POSITION
    if (overridePath) gridT = gridP.get();
  }
  void goDown(boolean overridePath) {
    // IF THE TILE BELOW IS PASSABLE, MOVE DOWN
    if (level.isPassable(gridP.getDown())) gridP.y++;
    // IF overridePath, SET TARGET POSITION TO NEW POSITION
    if (overridePath) gridT = gridP.get();
  }
  void draw() {
    noStroke();
    fill(0);
    ellipse(pixlP.x, pixlP.y, 28, 28);
    drawPath();
    //filter(soundWaveShader);
  }

  //draws path for debug purposes
  void drawPath() {
    // DRAW PATH
    if (path != null && path.size() > 1) {
      stroke(0);
      PVector prevP = pixlP.get();
      for (int i = 1; i < path.size(); i++) {
        PVector nextP = path.get(i).getCenter();
        line(prevP.x, prevP.y, nextP.x, nextP.y);
        prevP = nextP;
      }
      noStroke();
      fill(0);
      ellipse(prevP.x, prevP.y, 8, 8);
    }
  }
}

