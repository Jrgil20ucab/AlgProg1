Program Untitled;
{Dado el valor de x e y calcule el valor de la siguiente fórmula. Puedes utilizar la función
sqrt(z) para calcular la raíz cuadrada y para elevar un número al cuadrado utiliza:
variable ** 2 o multiplícala por sí misma.}

var
X, Y, Formula: real;
//en pro a ahorrar espacio se puede rescribir X o Y

Begin
 writeln(' Dado el valor de x e y, se calculara la formula algebraica  ');
 writeln('');
  write('  ingrese el valor de x:');
  Readln(X);
  write('  ingrese el valor de y:');
  Readln(Y);
  Formula:= (3*(X*X)*Y*sqrt((2*X)+Y))/sqrt(4*(X*X)+4*X*Y+(Y*Y));
  // se puede usar sqr en las potencias o desglosarlas
  writeln('');
  writeln(' El resultado de la operacion agebraica es: ',Formula:2:2);
 Readln();
End.
