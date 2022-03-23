float inc = 0.07;
int scale = 8;
int cols, rows;
float zoff = 0;
int nbParticle = 10000;

Particle[] particles;
PVector[] flowfield;


class Particle {
  PVector pos, vel, acc;
  float maxspeed;

    Particle(){
        pos = new PVector((random(0, width)), (random(0, height)));
        vel = new PVector(0, 0);
        acc = new PVector(0, 0);
        maxspeed = 1;
    }

    void update(){
        vel.add(acc);
        vel.limit(maxspeed);
        pos.add(vel);
        acc.mult(0);
    }

    void follow (PVector[] vectors){
        int x = int(pos.x / scale);
        int y = int(pos.y / scale);
        int index = x + y * cols;
        if(index >= rows*cols){index=rows*cols - 1;}
        PVector force = vectors[index];
        applyForce(force);
    }

    void applyForce(PVector force){
        acc.add(force);
    }

    void show() {
        strokeWeight(1);
        stroke(#fecee9, 8);
        point(pos.x, pos.y);
    }

    void edges() {
        if (pos.x > width) pos.x = 0;
        if (pos.x < 0) pos.x = width;
        if (pos.y > height) pos.y = 0;
        if (pos.y < 0) pos.y = height;

    }

}




void setup(){
    size(1000,1000);
    cols = int(width / scale);
    rows = int(height / scale);
    
    flowfield = new PVector[(cols) * (rows)];

    particles = new Particle[nbParticle];

    for (int i = 0; i < nbParticle; i++) {
        particles[i] = new Particle();
    }

    background(#114b5f);
}

void draw(){
    println(frameRate);
    float yoff = 0;
    for (int y = 0; y < rows; y++) {
        float xoff = 0;
        for (int x = 0; x < cols; x++) {
            int index = x + y * cols;
            float angle = noise(xoff, yoff, zoff) * TWO_PI * 2;
            PVector v = new PVector(cos(angle), sin(angle));
            v.setMag(0.05);
            flowfield[index] = v;
            xoff += inc;
            /*stroke(0);
            push();
            translate(x * scl, y * scl);
            rotate(v.heading());
            //line(0, 0, scl, 0);
            pop();*/
        }
        yoff += inc;
    }

    for (int i = 0; i < particles.length; i++) {
        particles[i].update();
        particles[i].follow(flowfield);
        particles[i].show();
        particles[i].edges();
        
    }


    zoff += 0.007;
}
