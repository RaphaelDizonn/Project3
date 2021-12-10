class Dot {

  PVector position, target;
  color col;
  PShape square;
  float speed;
  float dotSize;
  boolean ready;
  
  
  
  Dot(float x, float y, PShape _square, PVector _target) {
  heartpixel = loadImage("heartpixel.png");
  cubepixel = loadImage("cubepixel.png"); 
    heartpixel2 = loadImage("heartpixel2.png"); 
    invisible = loadImage("invisible.png");

    position = new PVector(x, y);
    square = _square;
    target = _target;
    speed = 0.10;
    ready = false;
  }
  
  void update() {
    position.lerp(target, speed);
    ready = position.dist(target) < 2;
  }
  
  void draw() {
    shape(square, position.x, position.y);
image(heartpixel, position.x, position.y);
}
  
  void run() {
    update();
    draw();
  }

}
