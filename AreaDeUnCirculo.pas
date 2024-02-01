Program AreaDeUnCirculo;
 {Area de un circulo dado su radio}
const
 Pi=3.14159265359;// se crea la constante necesaria
var
 r{radio},Area: real;
 Salida:string;
Begin //Programa principal
 repeat
    writeln('Area del circulo dado su radio');
    writeln();
    write(' radio: ');
    readln(r);
    Area:= Pi*(r*r); // Area de un circulo es pi por su radio al cuadrado
    writeln(' El area del circulo es:',area,' El area del circulo redondeada es:',area:2:2);
    writeln(' Desea salir?');
    Read(Salida);
    salida:= upcase(salida);
 until Salida= S;
End.