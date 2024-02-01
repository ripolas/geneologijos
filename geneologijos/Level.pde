class Level {
  int cols, rows;
  Tile [] [] tiles;
  String save[];
  Level(int cols, int rows) {
    this.cols=cols;
    this.rows=rows;
    tiles=new Tile[cols][rows];
    save=new String[cols*rows];
    int id=1;
    for (int i = 0; i<cols; i++) {
      for (int j = 0; j<rows; j++) {
        tiles[i][j]=new Tile(id%2==0?1:0, i, j);
        id++;
      }
      id++;
    }
  }
  void update() {
    for (int i = 0; i<cols; i++) {
      for (int j = 0; j<rows; j++) {
        tiles[i][j].update();
      }
    }
  }
  void showEmpty(){
    for (int i = 0; i<cols; i++) {
      for (int j = 0; j<rows; j++) {
        tiles[i][j].showEmpty();
      }
    }
  }
  void show() {
    for (int i = 0; i<cols; i++) {
      for (int j = 0; j<rows; j++) {
        tiles[i][j].show();
      }
    }
  }
}
