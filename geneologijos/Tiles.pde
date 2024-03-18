class Tile {
  int gridx;
  int gridy;
  int costume;
  int imgx=-1;
  int imgy=-1;
  boolean dead=false;
  Tile(int gridx, int gridy) {
    this.gridx=gridx;
    this.gridy=gridy;
  }
  void update() {
  }
  void show() {
    strokeWeight(1);
    stroke(140);
    noFill();
    imageMode(CORNER);
    rectMode(CORNER);
    if (imgx!=-1&&imgy!=-1) {
      image(img[imgx][imgy], gridx*tileSize+offx, gridy*tileSize+offy, tileSize, tileSize);
      stroke(0);
      strokeWeight(4);
      if (dead) {
        line(gridx*tileSize+offx+tileSize+tileSize/4, gridy*tileSize+offy-tileSize/4, gridx*tileSize+offx-tileSize/4, gridy*tileSize+offy+tileSize+tileSize/4);
      }
    }
  }
  void showEmpty() {
    //if (imgx==-1||imgy==-1) {
      strokeWeight(1);
      stroke(140);
      noFill();
      imageMode(CORNER);
      rectMode(CORNER);
      rect(gridx*tileSize+offx, gridy*tileSize+offy, tileSize, tileSize);
   // }
  }
}
