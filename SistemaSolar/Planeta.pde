class Planet {
  // Cada objeto "Planeta" mantém controle sobre seu próprio ângulo de rotação
  float theta;        // Rotação ao redor do sol
  float diameter;     // Tamanho
  float distance;     // Distância do sol
  float orbitspeed;   // Velocidade orbital
  color planet_color; // Cor

  // Luas do planeta
  Moon[] moons;

  Planet(float distance_, float diameter_, color planet_color_, int number_moons_) {
    distance = distance_;
    diameter = diameter_;
    planet_color = planet_color_;
    theta = 0;
    orbitspeed = random(0.01, 0.03);

    // Usa um array de luas para poder deixar o número de luas parametrizável
    moons = new Moon[number_moons_];
    for (int m = 0; m < number_moons_; m++) {
      // Cria uma lua de distância e tamanho aleatórios
      moons[m] = new Moon(int(random(20, 50)), int(random(5, 20)));
    }
  }

  void update() {
    // Incremeta o ângulo de rotação
    theta += orbitspeed;
    // Atualiza todas as luas do planeta
    for (int m = 0; m < moons.length; m++) {
      moons[m].update();
    }
  }

  void display() {
    // Antes da rotação e translação, o estado da matriz é salvo com pushMatrix()
    pushMatrix();
    
    // Carrega a rotação da órbita do planeta
    rotate(theta);
    // Carrega a distância do planeta em relação ao sol
    translate(distance, 0);
    stroke(0);
    fill(planet_color);
    ellipse(0, 0, diameter, diameter);
    // Desenha todas as luas em volta do planeta
    for (int m = 0; m < moons.length; m++ ) {
      moons[m].display();
    }

    // Uma vez que o planeta é desenhado, a matriz é restaurada com popMatrix() para que o próximo planeta não seja afetado
    popMatrix();
  }
}
