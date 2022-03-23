int Iwidth = 300;
int Iheight = 300;
float[][][] grid = new float[Iwidth][Iheight][2];
float[][][] next = new float[Iwidth][Iheight][2];

float Da = 1.0;
float Db = .5;
float f = 0.014;
float k = 0.045;
float delta = 1.0;

//for laplace 
float neighborh = 0.2;
float diagonal = 0.05;

int updatePerLoop = 4;
int scaleFactor = 3;

//for debuging
int time = 0;


void setup() {
    size(900, 900);

    for (int i = 0; i < Iwidth; i++) {
        for (int j = 0; j < Iheight; j++) {
            grid[i][j][0] = 1.;
            grid[i][j][1] = 0.;
            next[i][j][0] = 1.;
            next[i][j][1] = 0.;
        }
    }


    /*for (int x = 0; x < Iwidth; x++) {
        for (int y = 0; y < Iheight; y++) {
            if (sqrt((100 - x) * (100 - x) + (100 - y) * (100 - y)) < 10) {
                grid[x][y][1] = 1.;
            }
        }
    }*/
}

void draw() {


    loadPixels();

    for (int l = 0; l < updatePerLoop; l++) {
        for (int i = 0; i < Iwidth; i++) {
            for (int j = 0; j < Iheight; j++) {
                //updating part
                float a = grid[i][j][0];
                float b = grid[i][j][1];
                next[i][j][0] = a + ((Da * laplaceA(i, j)) - (a * b * b) + (f * (1 - a))) * delta;
                next[i][j][1] = b + ((Db * laplaceB(i, j)) + (a * b * b) - ((k + f) * b)) * delta;

                next[i][j][0] = constrain(next[i][j][0], 0, 1);
                next[i][j][1] = constrain(next[i][j][1], 0, 1);
                
                

                //drawing part
                if (l == updatePerLoop - 1) {
                    int c = constrain(floor((next[i][j][0] - next[i][j][1]) * 255), 0, 255);
                    for (int p = 0; p < scaleFactor; ++p) {
                        for (int q = 0; q < scaleFactor; ++q) {
                            int pix = ((i*scaleFactor +p) + (j*scaleFactor +q) * width) ;
                            pixels[pix] = color(c, c, c);
                        }
                    }
                    
                }
            }
        }

        Swap();
    }

    updatePixels();
    //rect(time,10,10,10);

    time++;
} //<>//

void mousePressed() {
    for (int x = 0; x < Iwidth; x++) {
        for (int y = 0; y < Iheight; y++) { //<>//
            if (sqrt((mouseX/scaleFactor - x) * (mouseX/scaleFactor - x) + (mouseY/scaleFactor - y) * (mouseY/scaleFactor - y)) < 10) {
                grid[x][y][1] = 1;
            }
        }
    }
} 


float laplaceA(int x, int y) {
    float sumA = 0;

    sumA += V(x, y)[0] * -1;
    sumA += V(x - 1, y)[0] * neighborh;
    sumA += V(x + 1, y)[0] * neighborh;
    sumA += V(x, y - 1)[0] * neighborh;
    sumA += V(x, y + 1)[0] * neighborh;
    sumA += V(x + 1, y + 1)[0] * diagonal;
    sumA += V(x + 1, y - 1)[0] * diagonal;
    sumA += V(x - 1, y + 1)[0] * diagonal;
    sumA += V(x - 1, y - 1)[0] * diagonal;

    return sumA;
}

float laplaceB(int x, int y) {
    float sumB = 0;

    sumB += V(x, y)[1] * -1;
    sumB += V(x - 1, y)[1] * neighborh;
    sumB += V(x + 1, y)[1] * neighborh;
    sumB += V(x, y - 1)[1] * neighborh;
    sumB += V(x, y + 1)[1] * neighborh;
    sumB += V(x + 1, y + 1)[1] * diagonal;
    sumB += V(x + 1, y - 1)[1] * diagonal;
    sumB += V(x - 1, y + 1)[1] * diagonal;
    sumB += V(x - 1, y - 1)[1] * diagonal;

    return sumB;
}


void Swap() {
    float[][][] temp = grid;
    grid = next;
    next = temp;
}

float[] V(int x, int y) {
    if (x >= 0 && x < Iwidth && y >= 0 && y < Iwidth) {
        return grid[x][y];
    } else {
        float[] e = new float[]{0,0};
        return e;
    }
}
