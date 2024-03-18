class Level {
  int cols, rows;
  Tile [] [] tiles;
  String save[];
  Level(int cols, int rows) {
    this.cols=cols;
    this.rows=rows;
    tiles=new Tile[cols][rows];
    save=new String[cols*rows];
    for (int i = 0; i<cols; i++) {
      for (int j = 0; j<rows; j++) {
        tiles[i][j]=new Tile(i, j);
      }
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
  void numerate(){
    textAlign(RIGHT,TOP);
    fill(0);
    textSize(20);
    for(int j = 0;j<rows;j++){
      int which = 1;
      for(int i = 0;i<cols;i++){
        if(tiles[i][j].imgx!=-1&&tiles[i][j].imgx!=4){
          text(which,(tiles[i][j].gridx+1)*tileSize+offx,(tiles[i][j].gridy+1)*tileSize+offy+tileSize/10);
          which++;
        }
      }
    }
    textAlign(RIGHT,CENTER);
    int leftest = 100000;
    ArrayList<PVector> texts = new ArrayList<>();
    int which = 1;
    for(int j = 0;j<rows;j++){
      for(int i = 0;i<cols;i++){
        if(tiles[i][j].imgx!=-1&&tiles[i][j].imgx!=4){
          texts.add(new PVector(which,j));
          //text(romeniskai(which),tiles[i][j].gridx*tileSize+offx-tileSize/10,tiles[i][j].gridy*tileSize+offy+tileSize/2);
          leftest = min(leftest,i);
          which++;
          break;
        }
      }
    }
    for(int i = 0;i<texts.size();i++){
      text(romeniskai((int)texts.get(i).x),leftest*tileSize+offx-tileSize/10,texts.get(i).y*tileSize+offy+tileSize/2); 
    }
  }
  void save_level(String path){
    save_array = new JSONArray();
    for(int i = 0;i<cols;i++){
      for(int j = 0;j<rows;j++){
        if(tiles[i][j].imgx!=-1&&tiles[i][j].imgy!=-1){
          JSONObject current = new JSONObject();
          current.setInt("type",0);
          current.setInt("imgx", tiles[i][j].imgx);
          current.setInt("imgy", tiles[i][j].imgy);
          current.setInt("x", tiles[i][j].gridx);
          current.setInt("y", tiles[i][j].gridy);
          save_array.setJSONObject(save_array.size(), current);
        }
      }
    }
    for (int i = 0; i<connections.size(); i++) {
      if (connections.get(i).size()==2) {
        JSONObject current = new JSONObject();
        current.setInt("type",1);
        current.setInt("first_x",(int)connections.get(i).get(0).x);
        current.setInt("first_y",(int)connections.get(i).get(0).y);
        current.setInt("second_x",(int)connections.get(i).get(1).x);
        current.setInt("second_y",(int)connections.get(i).get(1).y);
        save_array.setJSONObject(save_array.size(), current);
      }
    }
    for (int i = 0; i<textboxes.size(); i++) {
      JSONObject current = new JSONObject();
      current.setInt("type",2);
      current.setInt("posx",(int)textboxes.get(i).pos.x);
      current.setInt("posy",(int)textboxes.get(i).pos.y);
      current.setString("text",textboxes.get(i).text);
      save_array.setJSONObject(save_array.size(), current);
    }
    saveJSONArray(save_array, path);
  }
}
String romeniskai(int sk){
  if(sk==1)return "I";
  if(sk==2)return "II";
  if(sk==3)return "III";
  if(sk==4)return "IV";
  if(sk==5)return "V";
  if(sk==6)return "VI";
  if(sk==7)return "VII";
  if(sk==8)return "VIII";
  if(sk==9)return "IX";
  if(sk==10)return "X";
  return "NEMOKU :(";
}
