boolean textboxselected=false;
class Textbox {
  PVector pos;
  String text ="";
  boolean urselected=true;
  Textbox(PVector pos) {
    this.pos=pos;
  }
  void update() {
    if (urselected) {
      if(int(pressed)==23131){//up
        pos.add(0,-1);
        return;
      }
      if(int(pressed)==23132){//down
        pos.add(0,1);
        return;
      }
      if(int(pressed)==23133){//left
        pos.add(-1,0);
        return;
      }
      if(int(pressed)==23134){//right
        pos.add(1,0);
        return;
      }
      if (int(pressed)!=65535&&int(pressed)!=9&&pressed!='`') {
        if (int(pressed)!=8) {
          text+=pressed;
        } else {
          if (text.length()>0) {
            text = text.substring(0, text.length()-1);
          }
        }
      }
    }else{
      if(text.length()==0){
        removeTextBox(pos);
      }
    }
  }
  int dst(){
    return (int)dist(pos.x,pos.y,mouseX-offx,mouseY-offy);
  }
  void show() {
    
    textSize(30);
    textAlign(LEFT,TOP);
    if(urselected){
      noFill();
      stroke(255,0,0);
      rectMode(CORNER);
      rect(pos.x+offx,pos.y+offy,textWidth(text),30);
    }
    fill(0);
    text(text,pos.x+offx,pos.y+offy);
  }
}
void removeTextBox(PVector pos){
  for(int i = 0;i<textboxes.size();i++){
    if(textboxes.get(i).pos == pos){
      textboxes.remove(i);
      return;
    }
  }
}
