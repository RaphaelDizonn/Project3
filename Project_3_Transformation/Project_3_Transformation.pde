// Raphael Dizon #218038464
// Project 3: Transformation
// This project derived from Week 10 Example 06 code. This project transforms from a heart to a cube as it uses fragments from shapes and images using PShape and PImage variables.

PImage img1, img2, img3, heartpixel, cubepixel, heartpixel2, invisible, bgwhite, bgblack, bgwhite2;
ArrayList<Dot> dots;
ArrayList<PVector> targets1, targets2;
int scaler = 2; 
int threshold = 200;
boolean imageToggled = false;
color col1, col2;
PShape square1, square2, square3;


void setup() {

  size(1200, 600, P2D);  
  imageMode(CORNER);
  shapeMode(CORNER);
  bgwhite = loadImage("whiteBG.png");
  bgwhite2 = loadImage("whiteBG.png");
  bgblack = loadImage("blackBG.png");
  img1 = loadImage("heart.png");
  img2 = loadImage("cube.png");

  
  int w, h;
  if (img1.width > img2.width) {
    w = img1.width;
  } else {
    w = img2.width;
  }
  if (img1.height > img2.height) {
    h = img1.height;
  } else {
    h = img2.height;
  }
  surface.setSize(w, h);
  
  img1.loadPixels();
  img2.loadPixels();

  targets1 = new ArrayList<PVector>();
  targets2 = new ArrayList<PVector>();
      noStroke();
      square1 = createShape(RECT, 0, 0, 10, 10); 
            square2 = createShape(ELLIPSE, 0, 0, 0, 0); 
                        square3 = createShape(ELLIPSE, 0, 0, 20, 20);


  col1 = color(255, 127, 0, 63);
  col2 = color(0, 127, 255, 63);
  
  for (int x = 0; x < img2.width; x += scaler) {
    for (int y = 0; y < img2.height; y += scaler) {
      // this translates x and y coordinates into a location in the pixels array
      int loc = x + y * img2.width;

      if (brightness(img2.pixels[loc]) > threshold) {
        targets2.add(new PVector(x, y));
      }
    }
  }

  dots = new ArrayList<Dot>();

  for (int x = 0; x < img1.width; x += scaler) {
    for (int y = 0; y < img1.height; y += scaler) {
      int loc = x + y * img1.width;
      
      if (brightness(img1.pixels[loc]) > threshold) {
        int targetIndex = int(random(0, targets2.size()));
        targets1.add(new PVector(x, y));
        Dot dot = new Dot(x, y, square1, targets2.get(targetIndex));
        dots.add(dot);
      }
    }
  }
}

void draw() { 
 image(bgwhite, 0, 0);
  boolean flipTargets = true;
  for (Dot dot : dots) {
    dot.run();
    if (!dot.ready) flipTargets = false;
  }
  
  if (flipTargets) {
    for (Dot dot : dots) {
      if (!imageToggled) {
        int targetIndex = int(random(0, targets1.size()));
        dot.target = targets1.get(targetIndex);
bgwhite = bgblack;
dot.square = square1; 
heartpixel = invisible;

} else {
       dot.square = square2;
       heartpixel = heartpixel2;
  int targetIndex = int(random(0, targets2.size()));
        dot.target = targets2.get(targetIndex);
        bgwhite = bgwhite2;
}
    }
    imageToggled = !imageToggled;
  }
    surface.setTitle("" + frameRate);
  
}
