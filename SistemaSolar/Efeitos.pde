class Effect {
  
  float positionX, positionY; // Posição da partícula
  float velocityX, velocityY; // Velocidade da partícula
  float life;                 // Tempo de vida das partículas
  color particleColor;        // Cor da partícula
  boolean isTrail;            // Indica se é o rastro de fogo do foguete

  Effect(float startX, float startY, color colorValue) {
    // Define a posição atual da partícula da explosão
    positionX = startX;
    positionY = startY;

    // Define que a explosão será em formato circular
    float angle = random(TWO_PI);
    float speed = random(1, 4);
    
    // Define a velocidade da explosão
    velocityX = cos(angle) * speed;
    velocityY = sin(angle) * speed;
    
    // Define o tempo de vida das partículas da explosão
    life = 255;
    
    // Define a cor da partícula da explosão
    particleColor = colorValue;
   
    // Indica que não é o rastro de fogo do foguete
    isTrail = false;
  }

  Effect(float startX, float startY) {
    // Define a posição atual da partícula do rastro do foguete
    positionX = startX;
    positionY = startY;

    // Define a velocidade do rastro de fogo do foguete
    velocityX = random(-1, 1);
    velocityY = random(1, 2);

    // Define o tempo de vida das partículas do rastro de fogo do foguete
    life = 120;
    
    // Define a cor da partícula do rastro de fogo do foguete
    particleColor = color(255, random(120, 200), 0);
    
    // Indica que é o rastro de fogo do foguete
    isTrail = true;
  }

  void update() {
    // Atualiza a posição atual
    positionX += velocityX;
    positionY += velocityY;

    // Reduz o tempo de vida da partícula
    life -= isTrail ? 6 : 3;
  }

  void display() {
    // Indica que não deve possuir borda
    noStroke();
    
    // Passa a cor e o tempo de vida da partícula
    fill(particleColor, life);

    // Define o tamanho da partícula
    float size = isTrail ? 6 : 8;
    
    // Desenha a partícula como uma ellipse
    ellipse(positionX, positionY, size, size);
  }

  boolean isDead() {
    // Verifica se a partícula morreu
    return life <= 0;
  }
}
