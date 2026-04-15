class Rocket {

  float positionX, positionY;         // Posição atual
  float speed;                        // Velocidade
  float directionAngle;               // Direção
  float targetX, targetY;             // Posição do alvo
  boolean hasExploded = false;        // Estado da explosão
  ArrayList<Effect> effects;          // Lista de efeitos
  ArrayList<Integer> explosionColors; // Cores da explosão

  Rocket(float targetXValue, float targetYValue, ArrayList<Effect> effectsList, ArrayList<Integer> colorsList) {

    positionX = 0;
    positionY = height;

    speed = 3;

    targetX = targetXValue;
    targetY = targetYValue;

    effects = effectsList;
    explosionColors = colorsList;
  }

  void update() {

    // Se não reealizou a explosão
    if (!hasExploded) {

      float deltaX = targetX - positionX;
      float deltaY = targetY - positionY;

      // Calcula a direção do movimento do foguete
      directionAngle = atan2(deltaY, deltaX);

      float trailOffset = 20;

      // Calcula a posição do rastro do foguete
      float trailX = positionX - cos(directionAngle) * trailOffset;
      float trailY = positionY - sin(directionAngle) * trailOffset;

      // Cria as partícula de rastro de fogo do foguete
      effects.add(new Effect(trailX, trailY));

      float distanceToTarget = dist(positionX, positionY, targetX, targetY);

      // Move o foguete
      positionX += cos(directionAngle) * speed;
      positionY += sin(directionAngle) * speed;

      // Se o foguete chegou no alvo
      if (distanceToTarget < 55) {
        explode();
      }
    }
  }

  void explode() {

    // Indica que foi realizado a explosão
    hasExploded = true;

    // Cria as partículas da explosão
    for (int i = 0; i < 250; i++) {
      color randomColor = (color) explosionColors.get((int) random(explosionColors.size()));
      effects.add(new Effect(targetX, targetY, randomColor));
    }

    // Ativa o tremor de câmera
    shakeIntensity = 20;
  }

  void display() {

    // Se ainda não realizou a explosão
    if (!hasExploded) {

      pushMatrix();
      
      // Move para posição do foguete
      translate(positionX, positionY);
      
      // Rotaciona na direção do movimento
      rotate(directionAngle + HALF_PI);
      rectMode(CENTER);

      // Corpo do foguete
      fill(200);
      rect(0, 0, 10, 30);

      // Ponta do foguete
      fill(255, 0, 0);
      triangle(-5, -15, 5, -15, 0, -25);

      // Fogo do foguete
      fill(255, 150, 0);
      triangle(-5, 15, 5, 15, 0, 25);

      popMatrix();
    }
  }
}
