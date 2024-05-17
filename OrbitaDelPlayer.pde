//Augusto Velazquez

int numFireballs = 10; // Número de bolas de fuego
float radius = 150; // Radio de la órbita
boolean powerUpCollected = false; // Indica si el PowerUp ha sido recogido

PImage playerImg, powerUpImg, fireballImg, backgroundImage;

class Player {
  float x, y;
  float size = 180;
  
  Player(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  //movimiento del player con las teclas de direccionamiento
  void move() {
    if (keyPressed) {
      if (keyCode == UP) y -= 5;
      if (keyCode == DOWN) y += 5;
      if (keyCode == LEFT) x -= 5;
      if (keyCode == RIGHT) x += 5;
    }
  }
  
  void display() {
    //fill(0, 0, 255);
    //ellipse(x, y, size, size);
    image(playerImg, x - size / 2, y - size / 2, size, size);
  }
}

class Fireball {
  float angle;
  
  Fireball(float angle) {
    this.angle = angle;
  }
  
  void update(float centerX, float centerY) {
    float x = centerX + radius * cos(angle);
    float y = centerY + radius * sin(angle);
    //fill(255, 0, 0);
    //ellipse(x, y, 10, 10);
    image(fireballImg, x - 40 / 2, y - 40 / 2, 40, 40);
    angle += 0.01; // Incremento del ángulo para la rotación
  }
}

class PowerUp {
  float x, y;
  float size = 110; // Tamaño del cuadrado
  boolean isCollected = false;
  
  PowerUp(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  void display() {
    if (!isCollected) {
      //fill(0, 255, 0);
      //rect(x - size / 2, y - size / 2, size, size); // Dibuja un cuadrado centrado en (x, y)
      image(powerUpImg, x - size / 2, y - size / 2, size, size);
    }
  }
  
  boolean comprobarColision(float playerX, float playerY) {
    float mitad = size-10;
    if (playerX > x - mitad && playerX < x + mitad &&
        playerY > y - mitad && playerY < y + mitad) {
      isCollected = true; //colision! y se apaga el display
      return true;
    }
    return false;
  }
}

Player player;
PowerUp powerUp;
Fireball[] fireballs = new Fireball[numFireballs];

void setup() {
  size(700, 600);
  player = new Player(width/2, height/2);
  powerUp = new PowerUp(random(width), random(height));
  
  playerImg = loadImage("frezzer.png");
  powerUpImg = loadImage("radar.png");
  fireballImg = loadImage("ball.png");
  backgroundImage = loadImage("namekusein.jpg");
  
  for (int i = 0; i < numFireballs; i++) {
    fireballs[i] = new Fireball(TWO_PI / numFireballs * i); //TWO_PI es una constante que representa el valor de 2π
  }
}

void draw() {
  //background(#8E4514);
  image(backgroundImage, 0, 0, width, height);
  
  player.move();
  player.display();
  
  if (powerUp.comprobarColision(player.x, player.y)) {
    powerUpCollected = true;
  }
  
  if (powerUpCollected) {
    for (int i = 0; i < numFireballs; i++) {
      fireballs[i].update(player.x, player.y);
    }
  }
  
  powerUp.display();
}
