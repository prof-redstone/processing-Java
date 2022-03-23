
Chose[] chose = new Chose[5000];

void setup() {
 size(400,400); 
 noStroke();
 smooth();
 
  for(int i=0; i < chose.length; i++) {
   chose[i] = new Chose();
 }
}


void draw() {
 // fond blanc à chaque instant
 background(255);
 // allez! au travail!
 for(int i=0; i < chose.length; i++) {
   chose[i].action();
 }
}


class Chose {

 // avant de dessiner, définir la position x,y de la chose (au milieu)
 float x = 200, y = 200;

 void action() {
   bouger();
   dessiner();
 }

 void dessiner() {
   fill(0,0,0,255); // couleur noir, opacité maximum
   ellipse(x, y, 5, 5);
 }

 void bouger() {
   // ajouter -1, 0, ou +1 à la position x de la chose
   x += random(-2,2);
   // ajouter -1, 0, ou +1 à la position y de la chose
   y += random(-2,2); 
   // vérifier les bords. si trop loin, boucler
   if (x > width ) x = 0;
   if (x < 0) x = width ;
   if (y > height ) y = 0;
   if (y < 0) y = height ;

 }

}
