Program PitagorasH;
{ Pitagoras hipotenusa dado catetos}
var
 H{hipotenusa},Co{cateto opuesto},Ca{cateto adyacente}:real;

Begin
 writeln(' hallar hipotenusa por pitagoras');
 writeln;
 write(' CAteto adyancente: ');
 readln(Ca);
 write(' CAteto opuesto: ');
 readln(Co);
 H:= sqrt ((Ca*Ca)+(Co*Co));
 writeln;
 writeln('  hipotenusa: ',H);
 writeln('  hipotenusa redondeada: ',H:2:2);
 Readln;
End.
