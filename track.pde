class Track {
 int x1, y1, x2, y2, mx, my, dx, dy;

 Track(int x1, int y1, int x2, int y2) {
   this.x1 = x1;
   this.y1 = y1;
   this.x2 = x2;
   this.y2 = y2;
   dx = ball.dx;
   dy = ball.dy;
   mx = x1;
   my = y1;
 }
 
  void move() {
    mx += dx;
    my += dy;
  }
 
 void setEndPt(int sx, int sy) {
   x2 = sx;
   y2 = sy;
 }
 
 void show() {
   stroke(gray3);
   line(x1, y1, x2, y2);
 }
}
