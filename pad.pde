class Pad {
 int x, y, w, h;
 
 Pad(int x, int y, int w, int h) {
   this.x = x;
   this.y = y;
   this.w = w;
   this.h = h;
 }
 
 int getX() {
   return mouseX-w/2;
 }
 int getY() {
   return mouseY-w/2;
 }

 void show() {
   fill(pink);
   ellipse(mouseX-w/2, mouseY-w/2, w, h);
 }
}
