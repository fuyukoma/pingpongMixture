import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

class Ball {
  int x, y, r, dx, dy;
  int i = 0;

  Ball(int x, int y, int r) {
    this.x = x;
    this.y = y;
    this.r = r;
    minim = new Minim(this);
    dx = 1;
    dy = 2;
  }
  
  void move() {
    x = x + dx;
    y = y + dy;
  }
  
  int getX() {
    return x;
  }
  int getY() {
    return y;
  }
//  int getIdx() {
//   return nowImgIdx; 
//  }
  
  void set(int sx, int sy) {
    x = sx;
    y = sy;
  }
  
//  void changeImg() {
//    if(nowImgIdx < colors.length-1) {
//      nowImgIdx++;
//    } else {
//      nowImgIdx = 0;
//    }
//  }
  
  void show() {
    noStroke();
    fill(green);
    ellipse(0, 0, r, r);
  }
}
