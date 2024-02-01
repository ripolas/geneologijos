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
      if (int(pressed)!=65535&&int(pressed)!=9&&pressed!='`') {
        if (int(pressed)!=8) {
          text+=pressed;
        } else {
          if (text.length()>0) {
            text = text.substring(0, text.length()-1);
          }
        }
      }
    }
  }
  int dst(){
    return (int)dist(pos.x,pos.y,mouseX,mouseY);
  }
  void show() {
    textAlign(LEFT,CENTER);
    fill(0);
    text(text,pos.x,pos.y);
  }
}
