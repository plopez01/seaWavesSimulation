int cols,rows;
int res = 10;
int dist = 0;

PImage texture;

float rotation = 0;

float[][] terrain;

float offset = 0;

float increaseoff = 0;

float textureoffset = 0;

float waveSize = 5;

float frequency = 0.05;

boolean rotate = false;

void setup(){
  size(600, 600, P3D);
  cols = height/res;
  rows = width/res;
  terrain = new float[cols][rows];
  texture = loadImage("texture.jpg");
}

void draw(){
  background(0);
  text("FPS: " + frameRate, 2, 12);
  noFill();
  strokeWeight(0.5);
  stroke(255, 255, 255, 100);
  
  noStroke();
  
  ambientLight(128, 128, 128);
 
  lightSpecular(255*2,255*2,255*2);
  directionalLight(200,200,200, 1, 1, -1);
  
  translate(width/2, height/2, dist);
  rotateX(PI/2.5);
  if(rotate) rotateZ(radians(rotation));
  translate(-width/2, -height/2);

  offset=increaseoff;
  for(int y = 0; y < rows; y++){
    for(int x = 0; x < cols; x++){
      offset+=0.2;
      terrain[x][y] = sin(offset)*waveSize;
    }

  }  
  textureWrap(REPEAT);
  for(int y = 0; y < rows-1; y++){
    
    beginShape(TRIANGLE_STRIP);
    specular(255,255,255);
    shininess(255.0);
    ambient(109,156,232);
    texture(texture);
    for(int x = 0; x < cols; x++){
       vertex(x*res, y*res, terrain[x][y], x*res+textureoffset, y*res);
       vertex(x*res, (y+1)*res, terrain[x][y+1], x*res+textureoffset, (y+1)*res);
    }
    
    endShape();
  }
  rotation+=0.1;
  increaseoff+=frequency;
  textureoffset+=0.5;
}
