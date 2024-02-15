float offx, offy=0;
int tileSize=64;
Level level;
boolean click=false;
PImage [][] img=new PImage[5][8];
int imgamounts [] ={2, 7, 8, 3, 1};
int menuPhase=0;
ArrayList<ArrayList<PVector>> connections =new ArrayList();
boolean drawempty=true;
int w, h;
ArrayList<Textbox>textboxes=new ArrayList<Textbox>();
void setup() {
  size(1000, 1000, P2D);
  w=width;
  h=height;
  frameRate(1000);
  level=new Level(int(width/tileSize)*8, int(height/tileSize)*8);
  offx=-level.cols*tileSize/2-width/2;
  offy=-level.rows*tileSize/2-height/2;
  cutImages();
}
PVector selected_tile=new PVector(0, 0);
PVector hovered_tile;
char pressed;
void draw() {
  background(255);
  if (drawempty) {
    level.showEmpty();
  }
  if (textool) {
    cursor(TEXT);
    if(click){
      click=false;
      if (mouseButton==RIGHT) {
        int closestid=0;
        int closestdst=99999;
        for (int i = 0; i<textboxes.size(); i++) {
          textboxes.get(i).urselected = false;
          if (textboxes.get(i).dst()<closestdst) {
            closestid=i;
            closestdst=textboxes.get(i).dst();
          }
        }
        textboxselected = true;
        textboxes.get(closestid).urselected = true;
      } else if (mouseButton==LEFT) {
        if(!textboxselected){
          textboxselected=true;
          for (int i = 0; i<textboxes.size(); i++) {
            textboxes.get(i).urselected=false;
          }
          textboxes.add(new Textbox(new PVector(mouseX-offx, mouseY-offy)));
        }else{
          for (int i = 0; i<textboxes.size(); i++) {
            textboxes.get(i).urselected = false;
          }
          textboxselected = false;
        }
      }
    }
  } else {
    cursor(ARROW);
  }
  // LINES
  for (int i = 0; i<connections.size(); i++) {
    if (connections.get(i).size()==2) {
      stroke(0);
      strokeWeight(1);
      line(connections.get(i).get(0).x*tileSize+offx+tileSize/2, connections.get(i).get(0).y*tileSize+offy+tileSize/2, connections.get(i).get(1).x*tileSize+offx+tileSize/2, connections.get(i).get(1).y*tileSize+offy+tileSize/2);
    }
  }
  level.update();
  level.show();

  hovered_tile =new PVector(int((mouseX-offx)/tileSize), int( (mouseY-offy)/tileSize));
  if(!textool){
    if (click&&mouseButton==LEFT) {
      if (menuPhase==0) {
        click=false;
        selected_tile=new PVector(int((mouseX-offx)/tileSize), int( (mouseY-offy)/tileSize));
        if (level.tiles[(int)selected_tile.x][(int)selected_tile.y].imgx==-1&&level.tiles[(int)selected_tile.x][(int)selected_tile.y].imgy==-1) {
          menuPhase+=2;
        } else {
          menuPhase++;
        }
      }
    }
    if (click&&mouseButton==RIGHT) {
      connections.add(new ArrayList<PVector>());
      connections.get(connections.size()-1).add(hovered_tile);
    } else if (mousePressed&&mouseButton==RIGHT) {
      if (connections.get(connections.size()-1).size()==1) {
        connections.get(connections.size()-1).add(hovered_tile);
      } else {
        connections.get(connections.size()-1).set(1, hovered_tile);
      }
    }
  }
  if (mousePressed&&mouseButton==CENTER) {
    offx+=mouseX-pmouseX;
    offy+=mouseY-pmouseY;
  }
  if (menuPhase==1) {
    textSize(60);
    fill(0);
    textAlign(LEFT, BOTTOM);
    text("GYVAS", (selected_tile.x+1)*tileSize+offx, selected_tile.y*tileSize+offy);
    textAlign(LEFT, TOP);
    text("NEGYVAS", (selected_tile.x+1)*tileSize+offx, selected_tile.y*tileSize+offy);


    if (click) {
      click=false;
      if (mouseX>(selected_tile.x+1)*tileSize+offx&&mouseX<(selected_tile.x+1)*tileSize+offx+textWidth("GYVAS")) {
        if (mouseY>selected_tile.y*tileSize+offy-60&&mouseY<selected_tile.y*tileSize+offy) {
          level.tiles[(int)selected_tile.x][(int)selected_tile.y].dead=false;
          menuPhase++;
        } else if (mouseY>selected_tile.y*tileSize+offy&&mouseY<selected_tile.y*tileSize+offy+60) {
          level.tiles[(int)selected_tile.x][(int)selected_tile.y].dead=true;
          menuPhase++;
        } else {
          menuPhase=0;
        }
      } else {
        menuPhase=0;
      }
    }
  }
  if (menuPhase==2) {
    fill(125);
    noStroke();
    rect((selected_tile.x+1)*tileSize+offx, selected_tile.y*tileSize+offy, img.length*tileSize, tileSize);
    for (int i = 0; i<img.length; i++) {
      image(img[i][0], (selected_tile.x+i+1)*tileSize+offx, (selected_tile.y)*tileSize+offy, tileSize, tileSize);
    }
    if (click&&mouseButton==LEFT) {
      click=false;
      if (hovered_tile.y==selected_tile.y) {
        if (hovered_tile.x>selected_tile.x&&hovered_tile.x<selected_tile.x+img.length+1) {
          menuPhase++;
          level.tiles[(int)selected_tile.x][(int)selected_tile.y].imgy=-1;
          level.tiles[(int)selected_tile.x][(int)selected_tile.y].imgx=int(hovered_tile.x-selected_tile.x-1);
        } else {
          menuPhase=0;
        }
      } else {
        menuPhase=0;
      }
    }
  }
  if (menuPhase==3) {
    fill(125);
    noStroke();
    rect((selected_tile.x+1)*tileSize+offx, selected_tile.y*tileSize+offy, imgamounts[level.tiles[(int)selected_tile.x][(int)selected_tile.y].imgx]*tileSize, tileSize);
    for (int i = 0; i<imgamounts[level.tiles[(int)selected_tile.x][(int)selected_tile.y].imgx]; i++) {
      image(img[level.tiles[(int)selected_tile.x][(int)selected_tile.y].imgx][i], (selected_tile.x+i+1)*tileSize+offx, (selected_tile.y)*tileSize+offy, tileSize, tileSize);
    }
    if (click&&mouseButton==LEFT) {
      click=false;
      if (hovered_tile.y==selected_tile.y) {
        if (hovered_tile.x>selected_tile.x&&hovered_tile.x<selected_tile.x+1+imgamounts[level.tiles[(int)selected_tile.x][(int)selected_tile.y].imgx]) {
          menuPhase=0;
          level.tiles[(int)selected_tile.x][(int)selected_tile.y].imgy=int(hovered_tile.x-selected_tile.x-1);
        } else {
          menuPhase=0;
        }
      } else {
        menuPhase=0;
      }
    }
  }
  for (int i = 0; i<textboxes.size(); i++) {
    textboxes.get(i).update();
    textboxes.get(i).show();
  }
  click=false;
  pressed='`';
}
void mousePressed() {
  click=true;
}
boolean textool=false;
void keyPressed() {
  pressed=key;
  if (!textboxselected) {
    if (key=='t') {
      textboxselected=false;
      textool=!textool;
      for (int i = 0; i<textboxes.size(); i++) {
        textboxes.get(i).urselected=false;
      }
    }
    println(int(key));

    if (key==' ') {
      drawempty=!drawempty;
    }
    if (int(key)==127) {//delete
      for (int i = 0; i<connections.size(); i++) {
        if (connections.get(i).size()==2) {
          if (connections.get(i).get(0).x==hovered_tile.x&&connections.get(i).get(0).y==hovered_tile.y) {
            connections.remove(i);
            i--;
            continue;
          }
          if (connections.get(i).get(1).x==hovered_tile.x&&connections.get(i).get(1).y==hovered_tile.y) {
            connections.remove(i);
            i--;
            continue;
          }
        }
      }
      level.tiles[(int)hovered_tile.x][(int)hovered_tile.y].imgx=-1;
      level.tiles[(int)hovered_tile.x][(int)hovered_tile.y].imgy=-1;
    }
  }
}
void cutImages() {
  for (int i = 0; i<img.length; i++) {
    for (int j = 0; j<imgamounts[i]; j++) {
      img[i][j]=loadImage((i+1)+"_"+(j+1)+".png");
    }
  }
}
void mouseWheel(MouseEvent event) {
  int e = (int)event.getCount();
  //tileSize-=e;
}
