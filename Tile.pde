static class TileHelper {
  static HW3_Senneker app;
  final static int W = 32;
  final static int H = 32;
  final static int halfW = W/2;
  final static int halfH = H/2;

  //convert grid coordinates to pixel coordinates
  static PVector gridToPixel(Point p) {

    return new PVector((p.x*W), (p.y*H));
  }

  static PVector gridToPixel(int X, int Y) {
    return gridToPixel(app.new Point(X, Y));
  }
  //convert pixel coordinates to grid coordinates
  static Point pixelToGrid(PVector  p) {
    return app.new Point((int)(p.x/W), (int)(p.y/H));
  }
}

class Tile {
  int X;
  int Y;
  int TERRAIN = 0;

  Tile(int X, int Y) {
    this.X = X;
    this.Y = Y;
  }

  void draw() {
  }

  //returns the center of the tile in pixel coordinates
  PVector getCenter() {
    //TODO: implement method
    PVector p = TileHelper.gridToPixel(X, Y);
    p.x += TileHelper.halfW;
    p.y += TileHelper.halfH;

    return p;
  }

  boolean isPassable() {
    return (TERRAIN != 0);
  }

  /////////////PATHFINDING STUFF///////////////////////
  ArrayList<Tile> neighbors = new ArrayList<Tile>();/////list ofneighboring tiles
  Tile parent;//parent of this tile
  float G;//cost of traveling to this node from the start of the path
  float F;//estimated total cost of this node

  void resetParent() {
    parent = null;
    G=0;
    F=0;
  }
  void setParent(Tile tile) {
    parent = tile;
    G = parent.G + getTerrainCost();
  }
  float getTerrainCost() {
    if (TERRAIN == 0) return 99999;
    if (TERRAIN == 1)  return 1;
    return 1;
  }

  //a function that does the heuristic to guess the total cost of moving to this tile
  void doHeuristic(Tile end, boolean useManhattan) {
    float H;
    if (useManhattan)H = distanceManhattan(end);
    else H = distanceEuclidean(end);
    F = G + H;
  }
  //THE MANHATTAN HEURISTIC
  float distanceManhattan(Tile end) {
    float dx = end.X - X;
    float dy = end.Y - Y;
    return abs(dx) + abs(dy);
  }

  //THE EUCLIDEAN HEURISTIC
  float distanceEuclidean(Tile end) {
    float dx = end.X - X;
    float dy = end.Y - Y;
    return sqrt(dx*dx + dy*dy);
  }
  void addNeighbors(Tile[] tiles){
   for(Tile t : tiles){
    if (t != null)neighbors.add(t);
   } 
  }
}

