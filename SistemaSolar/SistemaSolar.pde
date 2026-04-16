Planet[] planets = new Planet[3];                              // Array de 3 objetos "Planeta"

float shakeIntensity = 0;                                      // Intensidade do tremor da câmera na explosão

int numberOfStars = 200;                                       // Quantidade de estrelas
float[] starsPositionX = new float[numberOfStars];             // Posição X da estrela
float[] starsPositionY = new float[numberOfStars];             // Posição Y da estrela

int countdownDuration = 10;                                    // Tempo do contador do lançamento em segundos
int countdownStartTime = 0;                                    // Início do contador

boolean isCountingDown = false;                                // Estado do contador do lançamento
boolean simulationFinished = false;                            // Estado da simulação
boolean rocketLaunched = false;                                // Estado do foguete

Rocket rocket;                                                 // Foguete
ArrayList<Effects> effects = new ArrayList<Effects>();         // Partículas
ArrayList<Integer> explosionColors = new ArrayList<Integer>(); // Cores da explosão

void setup() {
  size(600, 600);

  // Inicializa dados para textos/mensagens
  PFont font = createFont("Georgia", 18);
  textFont(font);
  textAlign(CENTER);

  // Define o índice do planeta com 2 luas aleatoriamente
  int specialPlanetIndex = int(random(planets.length));

  // Inicializa os objetos "Planeta"
  for (int i = 0; i < planets.length; i++) {
    // Gera uma cor aleatória para o planeta
    color planetColor = color(random(255), random(255), random(255));
    // Verifica se o planeta deverá ser criado com uma ou duas luas
    int numberOfMoons = (i == specialPlanetIndex) ? 2 : 1;

    // Adiciona o planeta na lista
    planets[i] = new Planet(100 + i * 36, 24, planetColor, numberOfMoons);

    // Adiciona a cor do planeta nas cores da explosão
    explosionColors.add(planetColor);
  }

  // Adiciona a cor do sol nas cores da explosão
  explosionColors.add(color(255, 220, 0));

  // Gera uma posição XY aleatória para todas as estrelas
  for (int i = 0; i < numberOfStars; i++) {
    starsPositionX[i] = random(width);
    starsPositionY[i] = random(height);
  }
}

void draw() {
  // Define o tremor da câmera na explosão
  float shakeOffsetX = random(-shakeIntensity, shakeIntensity);
  float shakeOffsetY = random(-shakeIntensity, shakeIntensity);
  translate(shakeOffsetX, shakeOffsetY);
  shakeIntensity *= 0.97;

  // Desenha o espaço em azul escuro
  background(10, 15, 30);

  // Desenha as estrelas no espaço
  stroke(255);
  for (int i = 0; i < numberOfStars; i++) {
    point(starsPositionX[i], starsPositionY[i]);
  }

  pushMatrix();

  // Se a simulação não terminou
  if (!simulationFinished) {

    // Se o foguete não realizou a explosão
    if (rocket == null || !rocket.hasExploded) {

      pushMatrix();
      translate(width / 2, height / 2);

      // Desenha um sol amarelo no centro do espaço
      noStroke();
      fill(255, 220, 0);
      ellipse(0, 0, 64, 64);

      // Desenha todos os planetas em volta do sol
      for (Planet planet : planets) {
        planet.update();
        planet.display();
      }

      popMatrix();
    }

    // Se está em contagem regressiva para o lançamento do foguete
    if (isCountingDown) {

      int elapsedTime = (millis() - countdownStartTime) / 1000;
      int remainingTime = countdownDuration - elapsedTime;

      // Se terminou a contagem do lançamento do fogueete
      if (remainingTime <= 0) {
        rocket = new Rocket(width/2, height/2, effects, explosionColors);
        rocketLaunched = true;
        isCountingDown = false;
      }
    }

    // Se o foguete existe
    if (rocket != null) {
      rocket.update();
      rocket.display();
    }

    // Atualiza partículas
    for (int i = effects.size() - 1; i >= 0; i--) {

      Effects effect = effects.get(i);

      effect.update();
      effect.display();

      // Se a partícula morreu
      if (effect.isDead()) {
        effects.remove(i);
      }
    }

    // Se a explosão terminou
    if (rocket != null && rocket.hasExploded && effects.size() == 0) {
      simulationFinished = true;
    }
  }

  popMatrix();

  // Exibe mensagem informando o estado do lançamento do foguete
  showMessage();
}

void showMessage() {
  // Se o foguete não realizou a explosão
  if (rocket == null || !rocket.hasExploded) {
    // Se ainda não iniciou a contagem regressiva para o lançamento do foguete e ainda não lançou o foguete
    if (!isCountingDown && !rocketLaunched) {
      fill(255);
      text("Clique para lançar o foguete", width/2, height - 20);
    }
    // Se está em contagem regressiva para o lançamento do foguete
    else if (isCountingDown) {
      int elapsedTime = (millis() - countdownStartTime) / 1000;
      int remainingTime = max(0, countdownDuration - elapsedTime);

      fill(255);
      text("Lançamento em: " + remainingTime + "s", width/2, height - 20);
    }
  }
}

void mousePressed() {
  // Se ainda não lançou o foguete e não está em contagem regressiva para o lançamento do foguete
  if (!rocketLaunched && !isCountingDown) {
    isCountingDown = true;
    countdownStartTime = millis();
  }
}
