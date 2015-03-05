class Pathfinder {
  boolean useManhattan = false;
  boolean useDiagonals = false;
  ArrayList<Tile> open = new ArrayList<Tile>();//collection of tiles we can use to solve the algorithm
  ArrayList<Tile> closed = new ArrayList<Tile>();//collection of tiles that have already been checked

  Pathfinder() {
  }

  ArrayList<Tile> findPath(Tile start, Tile end) {

    //empty arrays
    open.clear();
    closed.clear();

    //make sure the starting tile's parent property is set to null
    start.resetParent();

    //Connect start to end
    connectStartToEnd(start, end);

    //build path back to beginning
    ArrayList<Tile> path = connectEndToStart(start, end);

    //Reverse the path (for convenience)
    ArrayList<Tile> rev = new ArrayList<Tile>();
    for (int i = path.size ()-1; i >=0; i--) rev.add(path.get(i));
    return rev;
  }

  //connect start to end
  void connectStartToEnd(Tile start, Tile end) {
    open.add(start);//add start tile to open array

    //While we still have tiles in the open array
    while (open.size () > 0) {
      //find the open tile with the lowest F value
      float F = 999999999;
      int index = -1;
      for (int i = 0; i < open.size (); i++) {
        if (open.get(i).F < F) {
          F = open.get(i).F; 
          index = i;
        }
      } 

      Tile current = open.remove(index); //remove the tile from the open array
      closed.add(current); //add the tile to the closed array

      if (current == end) break; //if the current tile is the end break out of while, return out of function

      for (int i = 0; i< current.neighbors.size (); i++) {//loop through all of current's neighbors
        Tile neighbor = current.neighbors.get(i); 
        if (!tileInArray(closed, neighbor)) {
          if (!tileInArray(open, neighbor)) {
            open.add(neighbor); 
            neighbor.setParent(current); 
            neighbor.doHeuristic(end, useManhattan);
          }
        } else {
          if (neighbor.G > current.G + neighbor.getTerrainCost()) {
            neighbor.setParent(current); 
            neighbor.doHeuristic(end, useManhattan);
          }
        }

        //else
        //if it would be cheaper to move to that tile from current
        //set it's parent to current
        //recalculate it's H value
      }
    }
  }//end method

  //starting at the end, get each tiles parent
  ArrayList<Tile> connectEndToStart(Tile start, Tile end) {
    ArrayList<Tile> path = new ArrayList<Tile>(); 
    Tile pathNode = end; 

    while (pathNode!= null) {
      path.add(pathNode); 
      pathNode = pathNode.parent;
    }

    return path;
  }

  //returns if specified tile is in the specified ArrayList
  boolean tileInArray(ArrayList<Tile> a, Tile t) {
    for (Tile tile : a) if (tile == t) return true; 
    return false;
  }
}

