// Cria um array de 3 objetos "Planeta"
Planet[] planets = new Planet[3];

// Dados para desenhar estrelas no céu (estética)
int numStars = 200;
float[] starsX = new float[numStars];
float[] starsY = new float[numStars];

void setup() {
  size(600, 600);

  // Inicializa os objetos "Planeta"
  for (int p = 0; p < planets.length; p++) {
    planets[p] = new Planet(60 + p*36, 24, color(random(0, 255), random(0, 255), random(0, 255)), 2);
  }

  for (int i = 0; i < numStars; i++) {
    starsX[i] = random(width);
    starsY[i] = random(height);
  }
}

void draw() {
  // Desenha o espaço em azul escuro
  background(10, 15, 30);

  // Estrelas
  stroke(255);
  for (int i = 0; i < numStars; i++) {
    point(starsX[i], starsY[i]);
  }

  // Desenha um sol amarelo no centro do espaço
  pushMatrix();
  translate(width/2, height/2);
  stroke(0);
  fill(255, 220, 0);
  ellipse(0, 0, 64, 64);
  // Desenha todos os planetas em volta do sol
  for (int p = 0; p < planets.length; p++) {
    planets[p].update();
    planets[p].display();
  }
  popMatrix();
}
