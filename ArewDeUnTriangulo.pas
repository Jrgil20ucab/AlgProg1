program AreaDeTriangulo; 
 { Programa para calcular el area de un triangulo }
var
  Area, Base, Altura: real;
begin
  write('Indica Base: ');
  readln(base);
  write('Indica Altura: ');
  readln(altura);
  Area := Base * Altura / 2;
  writeln(' El Area del triangulo es:', Area: 2: 2);
  readln;
end.