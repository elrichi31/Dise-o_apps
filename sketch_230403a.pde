//Declaración de variables
int turno = 1; 
int [][] tablero = new int [3][3]; 
boolean juegoTerminado = false;
int ganador = 0;

//Tamaño del tablero
int anchoTablero = 600; 
int altoTablero = 600;

//Tamaño de los cuadrados del tablero
int tamCuadro = 200;

int marcadorJugador1 = 0;
int marcadorJugador2 = 0;
int partidasJugadas = -1;


//Método para comprobar si hay un ganador
void comprobarGanador() {
  //Comprobamos las líneas horizontales
  for (int i = 0; i < 3; i++) {
    if (tablero[i][0] != 0 && tablero[i][0] == tablero[i][1] && tablero[i][1] == tablero[i][2]) {
      ganador = tablero[i][0];
      juegoTerminado = true;
      return;
    }
  }
  
  //Comprobamos las líneas verticales
  for (int j = 0; j < 3; j++) {
    if (tablero[0][j] != 0 && tablero[0][j] == tablero[1][j] && tablero[1][j] == tablero[2][j]) {
      ganador = tablero[0][j];
      juegoTerminado = true;
      return;
    }
  }
  
  //Comprobamos la diagonal principal
  if (tablero[0][0] != 0 && tablero[0][0] == tablero[1][1] && tablero[1][1] == tablero[2][2]) {
    ganador = tablero[0][0];
    juegoTerminado = true;
    return;
  }
  
  //Comprobamos la diagonal secundaria
  if (tablero[0][2] != 0 && tablero[0][2] == tablero[1][1] && tablero[1][1] == tablero[2][0]) {
    ganador = tablero[0][2];
    juegoTerminado = true;
    return;
  }
  
  //Comprobamos si hay empate
  boolean hayEmpate = true;
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (tablero[i][j] == 0) {
        hayEmpate = false;
        break;
      }
    }
  }
  if (hayEmpate) {
    ganador = 0;
    juegoTerminado = true;
  }
}

//Método para dibujar el mensaje de fin de juego
void dibujarFinJuego() {
  textSize(64);
  textAlign(CENTER);
  fill(51);
  if (ganador == 0) {
    text("¡Empate!", anchoTablero/2, altoTablero/2);
  } else {
    text("¡Jugador " + ganador + " ha ganado!", anchoTablero/2, altoTablero/2);
  }
}

//Método para reiniciar el juego
void reiniciarJuego() {
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      tablero[i][j] = 0;
    }
  }
  if(ganador == 1){
    marcadorJugador1 += 1;
    partidasJugadas += 1;

  } else if (ganador == 2){
    marcadorJugador2 += 1; 
    partidasJugadas += 1;

  } else {
    partidasJugadas += 1;

  }
  turno = 1;
  juegoTerminado = false;
  ganador = 0;
}

//Método para detectar el click del mouse
void mouseClicked() {
  if (juegoTerminado) {
    reiniciarJuego();
    return;
  }
  
  int fila = floor(mouseY/tamCuadro);
  int columna = floor(mouseX/tamCuadro);
  
  if (fila >= 0 && fila < 3 && columna >= 0 && columna < 3) {
    if (tablero[fila][columna] == 0) {
      tablero[fila][columna] = turno;
      turno = turno == 1 ? 2 : 1;
      comprobarGanador();
    }
  }
}

void displayText(){
  textAlign(CENTER);
  textSize(40);
  fill(255);
  text("(Jugador 1)   " + marcadorJugador1 + "  vs  " + marcadorJugador2 + "  (Jugador 2)",(width/2), height -50);
  text("Partidas jugadas: " + partidasJugadas, width/2, height - 100);
}
void setup() {
  size(600, 750);
  tamCuadro = 600/3;
  tablero = new int[3][3];
  reiniciarJuego();
}


void draw() {
  //Dibujamos el tablero
  background(51);
  stroke(255);
  strokeWeight(4);
  displayText();
  for (int i = 1; i < 3; i++) {
    line(i*tamCuadro, 0, i*tamCuadro, altoTablero);
    line(0, i*tamCuadro, anchoTablero, i*tamCuadro);
  }
  
  //Dibujamos las X y O
  strokeWeight(5);
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      float x = j*tamCuadro + tamCuadro/2;
      float y = i*tamCuadro + tamCuadro/2;
      float r = tamCuadro/4;
      if (tablero[i][j] == 1) {
        //line(x-r, y-r, x+r, y+r);
        //line(x+r, y-r, x-r, y+r);
        fill(255, 75, 51);
        rect(j*tamCuadro+10, i*tamCuadro+10, tamCuadro-20, tamCuadro-20);

      } else if (tablero[i][j] == 2) {
        //ellipse(x, y, 2*r, 2*r);
        fill(51, 191, 255);
        rect(j*tamCuadro+10, i*tamCuadro+10, tamCuadro-20, tamCuadro-20);\
      }
    }
  }

  


  //Comprobamos si hay un ganador o empate
  if (juegoTerminado) {
    dibujarFinJuego();
  }

}
