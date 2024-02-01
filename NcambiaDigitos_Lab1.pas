Program N_cambia_digitos;
 { Dado un entero positivo N con 3 dígitos, empleando DIV y/o MOD intercambia el
 primer valor con el último genera un nuevo número y muéstralo al usuario. Realiza las
 operaciones matemáticas que sean necesarias.
 Condiciones:
 -Uso de Div y Mod
 }
var
N: integer;

Begin
 writeln('Dado un entero positivo N de 3 diogitos se intercambiaran el primer y ultimo digito');
 writeln(' ');
 write('Ingrese el valor de N: ');
 readln(N);
 // si el valor de N es superior o inferior a 3 digitos el programa no funcionara correctamente
 N:= N+(N div 100)-(N div 100*100)-(N mod 10)+(N mod 10*100);
 write(' el nuevo numero N con digitos alterados es: ',N);

 readln();
End.
