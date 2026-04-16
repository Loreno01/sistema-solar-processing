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
    // Incremeta o ângulo de rotação
    theta += orbitspeed;
  }

  void display() {
    // Antes da rotação e translação, o estado da matriz é salvo com pushMatrix()
    pushMatrix();

    // Carrega a rotação da órbita da lua
    rotate(theta);
    
    // Carrega a distância da lua em relação ao planeta
    translate(distance, 0);
    
    // Define aparência da lua
    stroke(0);
    fill(175);
    ellipse(0, 0, diameter, diameter);

    // Uma vez que a lua é desenhada, a matriz é restaurada com popMatrix() para que a próxima lua não seja afetada
    popMatrix();
  }
}
