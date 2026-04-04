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

    // Usa um array de luas auxiliar para poder deixar o número de luas parametrizável
    Moon[] moons_ = new Moon[number_moons_];
    for (int m = 0; m < number_moons_; m++) {
      // Cria uma lua de distância e tamanho aleatórios
      moons_[m] = new Moon(int(random(10, 50)), int(random(5, 20)));
    }
    // Transcreve o array auxiliar para o array de luas principal
    moons = moons_;
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
    // Before rotation and translation, the state of the matrix is saved with pushMatrix().
    pushMatrix();
    // Rotate orbit
    rotate(theta);
    // translate out distance
    translate(distance, 0);
    stroke(0);
    fill(planet_color);
    ellipse(0, 0, diameter, diameter);
    // The planet is drawn, now draw the moon
    for (int m = 0; m < moons.length; m++ ) {
      moons[m].display();
    }

    // Once the planet is drawn, the matrix is restored with popMatrix() so that the next planet is not affected.
    popMatrix();
  }
}
