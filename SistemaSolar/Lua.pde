class Moon {
  // Cada objeto "Lua" mantém controle sobre seu próprio ângulo de rotação
  float theta;      // Rotação ao redor do planeta
  float diameter;   // Tamanho
  float distance;   // Distância do planeta
  float orbitspeed; // Velocidade orbital

  Moon(float distance_, float diameter_) {
    distance = distance_;
    diameter = diameter_;
    theta = 0;
    orbitspeed = random(-0.1, 0.1);
  }

  void update() {
    // Increment the angle to rotate
    theta += orbitspeed;
  }

  void display() {
    // Before rotation and translation, the state of the matrix is saved with pushMatrix().
    pushMatrix();
    // Rotate orbit
    rotate(theta);
    // translate out distance
    translate(distance, 0);
    stroke(0);
    fill(175);
    ellipse(0, 0, diameter, diameter);
    // Once the planet is drawn, the matrix is restored with popMatrix() so that the next planet is not affected.
    popMatrix();
  }
}
