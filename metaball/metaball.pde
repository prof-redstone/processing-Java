int nbBall = 2;

class Ball{
    float posx;
    float posy;
    float x;
    float y;
    float size;

    float xoff = 153.0;
    float yoff = 846.0;
    float soff = 0;
    float incem = 0.005;

    Ball(float X, float Y,float S){
        posx = X;
        posy = Y;
        size = S;
        x = posx;
        y = posy;

        xoff = random(100.0, 1000.0);
        yoff = random(100.0, 1000.0);
    }

    void update(){
        x = posx + (noise(xoff)-0.5)*height/2;
        y = posy + (noise(yoff)-0.5)*width/2;
        xoff += incem;
        yoff += incem;
    }

    void show(){
        ellipse(x, y, size, size);
    }
}

Ball[] balles;

void setup(){
    size(500,500);

    balles = new Ball[nbBall];

    for (int i = 0; i < nbBall; ++i) {
        balles[i] = new Ball(width/2 + random(-width/3, width/3), height/2 + random(-height/3, height/3), 100);
    }
}

void draw(){
    background(255);
    for (int i = 0; i < balles.length; ++i) {
        balles[i].update();
        //balles[i].show();
    }

    loadPixels();
    for (int i = 0; i < width; ++i) {
        for (int j = 0; j < height; ++j) {
            int index = i + j * width
            pixels[index]
        }
    }
}
