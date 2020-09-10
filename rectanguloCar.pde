color c = color(0);  //  c es una variable de color que usa el color 0
float x = 0;  // variable x es una decimal que empieza en cero
float y = 100;  // y es una variable que es decimal y vale cien
float speed = 1;   // la velocidad es una variable decimal que empieza en 1

void setup() { // al abrir el void setup seteamos un tamaño del canvas
  size(200,200);  //este valor vale 200x200 px
}

void draw() {   //al abrir el void draw pedimos un background blanco
  background(255);  // y durante cada ciclo pedimos el background blanco
  move();   // pedimos que en cada pasito se ejecute la orden mover
  display();   //pedimos que se ejecute la orden desplegar
}

void move() {   //la funcion move() no entregaria ningun valor
  x = x + speed;  //pedimos que variable x se sume a variable speed (1)
  if (x > width) {  //si 'x' es mayor al ancho de la pantalla
    x = 0;             //que x vuelva a cero.
  }
}

void display() {   //la función display() entrega ningún valor
  fill(c);        // pedimos que fill(c) o sea llenar del color asignado al valor color
  rect(x,y,30,10);  //que el rectángulo sea (x,y,30,10)
}