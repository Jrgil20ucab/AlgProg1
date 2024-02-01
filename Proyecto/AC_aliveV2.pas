program AUtomataCelular_Alive;
uses
    crt;
type
   Matriz= array [1..50,1..50] of integer;
var
   //Variables para el menu y opciones graficas  (op?opciones) (M?Menu) (SM?SubMenu )
   OpM,OpSM,OpISM,OpISM1{Opciones Internas del SubMenu 1}: integer;
   //Variables de comprobacion:
   Archivos,Retornarsalida,Local,RutaModificada,Personalizacion,
    PorCreacion,PorPoblacion,ModificacionDeColores,ModificacionDeBordes:boolean;
   // variables principales
   CelulasVecinas,CaldoDeCultivo:matriz;
   Entrada,Salida:text;
   //Variables secundarias
   x_Filas,y_columnas:integer;
   SiNo,Rutae,RutaS,Carpeta,NombreDelArchivoE,NombreDelArchivoS:string;
   //Contadores
   Generacion,Poblacion,Minpoblacion,N:integer;
   //Enumerados
   ajustes:
    (xArchivo,Devolver,NombreDeEntrada,nombreDeSalida,RutaC,RutaEntrada,RutaSalida,
      Xlocal,xcreacion,xpoblacion,Personalizado,colores,bordes);

  ///////////////////////////////
 // 1.Procedimientos graficos //
///////////////////////////////
Procedure EspacioX(N:integer);
(* 1.1 Procedimiento para crear espacios en blanco *)
var i:integer;
begin
  if N>0 then
     for i := 1 to N do
         write(' ');
end;

procedure Centrar (objeto:string;Centrado:integer);
(* 1.2 Procedimiento para centrar un objeto *)
begin
  EspacioX(Centrado);write(objeto);espacioX(Centrado);writeln();
end;

procedure barra;
(* 1.3 Procedimiento para crear una barra de color *)
begin
  textcolor(cyan);Writeln('////////////////////////////////////////////////////////////////////////////////');NormVideo;
end;

procedure EntradaDeDatos;
(* 1.4 Procedimiento para que emuestre el simbolo para que entre un dato *)
begin
  textcolor(cyan);write(Chr(175));NormVideo;
end;

Procedure Presentacion;
(* 1.5 Procedimiento para La presentacion *)
Begin
 //Linea 0
 writeln('');
 //Linea 1
 write('  ');textbackground(cyan);write('  ');NormVideo;write(' ');
 write('  ');textbackground(cyan);write('   ');NormVideo;write(' ');
 write(' ');textbackground(cyan);write('  ');NormVideo;writeln(' ');
 //Linea 2
 write(' ');textbackground(cyan);write(' ');NormVideo;;write('  ');textbackground(cyan);write(' ');NormVideo;
 write(' ');textbackground(cyan);write(' ');NormVideo;write('   ');
 write(' ');textbackground(cyan);write(' ');NormVideo;write('  ');textbackground(cyan);writeln(' ');NormVideo;
 //Linea 3
 write(' ');textbackground(cyan);write('    ');NormVideo;
 write(' ');textbackground(cyan);write(' ');NormVideo;write('   ');
 write(' ');textbackground(cyan);writeln('    ');NormVideo;
 //Linea4
 write(' ');textbackground(cyan);write(' ');NormVideo;write('  ');textbackground(cyan);write(' ');NormVideo;
 write(' ');textbackground(cyan);write(' ');NormVideo;write('   ');
  write(' ');textbackground(cyan);write(' ');NormVideo;write('  ');textbackground(cyan);writeln(' ');NormVideo;
 //Linea 5
 write(' ');textbackground(cyan);write(' ');NormVideo;write('  ');textbackground(cyan);write(' ');NormVideo;
 write('  ');textbackground(cyan);write('   ');NormVideo;write(' ');
 textbackground(cyan);write(' ');NormVideo;write('  ');textbackground(cyan);write(' ');NormVideo;write(' ');
 //Continuacion de la linea 5
 textbackground(white);textcolor(cyan+blink);writeln(' Automata Celular alive');NormVideo;
 //linea de descipcion
 writeln();barra;
 write('La evolucion de la vida tiene una variedad de patrones reconocidos que provienen');
 Write('de determinadas posiciones iniciales. La vida es un ejemplo de emergencia y auto-organizacion.');
 Write(' Los automatas celulares son automatas simples que producen una   salida a partir de varias ');
 Write('entradas, modificando en el proceso su estado segun   una funcion de transicin. ');
 Write('Por lo general, en un automata celular, al igual que  en la evolucion, el estado de ');
 Write('una celula en una generacion determinada depende  unica y exclusivamente de los estados ');
 writeln('de las celulas vecinas y de su propio     estado en la generacion anterior.');
 writeln();barra;
 // creditos
 write(' ');textbackground(Lightcyan);textcolor(black);writeln(' Emily-Jesus ');NormVideo;
 writeln();EntradaDeDatos;
 Readln;
End;

Procedure Menu(NtabT,NTabOp:integer;subtitulo,op1,op2,op3:string;Ct,COp1,COp2,COp3:integer);
(* 1.6 Procedimiento para el menu reutilzable *)
var
 Colour:integer;
Begin
 clrscr;writeln();writeln();writeln();writeln();writeln();{5 saltos de linea para intentar centrarlo }
 Colour:=3;
 if ModificacionDeColores then
    Colour:=1+random(7);
 EspacioX(25);
 Textbackground(7);textcolor(Colour+blink);Writeln(' Automata Celular Alive ');normvideo;
 EspacioX(25);
 EspacioX(10-NtabT);Textbackground(7);textcolor(0);centrar(subtitulo,Ct);normvideo;
 Writeln();
 Writeln();
 EspacioX(30-NtabOp);write(1);
 Textbackground(7);textcolor(Colour);Centrar(op1,COp1);normvideo;Writeln();
 EspacioX(30-NtabOp);write(2);
 Textbackground(7);textcolor(Colour);Centrar(op2,COp2);normvideo;Writeln();
 EspacioX(30-NtabOp);write(Colour);
 Textbackground(7);textcolor(Colour);Centrar(op3,COp3);normvideo;Writeln();
 writeln();EspacioX(30);EntradaDeDatos;
End;

procedure Saliendo(name:string;tiempo:integer);
(* 1.7 Procedimiento para indicar la salida *)
begin
     textcolor(red);
     writeln(' Esta saliendo ',name);
     delay(tiempo);NormVideo;
end;

  ///////////////////////////////////////////////////////////////
 // 2. procedimientos de inicalzacion, validacion y impresion //
///////////////////////////////////////////////////////////////
function Esvalido(Valor,sup,inf:integer):boolean;
begin
 Esvalido:= ( (Valor<=Sup) and (valor>=Inf) );
end;

procedure validar(var Dato:integer;leer,escribir:boolean;name:string;LimSup,Liminf:integer);
(* 2.1 Procedimiento para validar dato *)
var
 valido:boolean;
begin
     repeat
            if escribir then
                Write('Ingrese ',name,' ( max ',LimSup,' - min ',LimInf,' ) ');
            if leer then
                readln(Dato);
            if  (Dato>=LimSup) then
                Writeln(name,'supera el limite ',LimSup);
            if  (Dato<=LimInF) then
                Writeln(name,'es inferior a el limite ',LimInf);
            valido:=EsValido(Dato,LimSup,liminf);
     until valido;
end;

procedure Llenar_Matriz(var MatrizALlenar:matriz;Dato:integer;Aleatorio:boolean);
(* 2.1 Procedimiento para llenar una matriz *)
var i,j:integer;
begin
  For i:=1 to 50 do
    for j := 1 to 50 do
      begin
        if Aleatorio then
           dato := Random(2);
        MatrizALlenar[i,j] := dato;
      end;
end;

function FileExists(ruta: String): boolean;
var
    f: text;
begin
    assign(f,ruta);
    {$I-}
    reset(f);
    {$I+}
    if (IOResult = 0) then
    begin
        close(f);
        FileExists:=true;
    end
    else
        FileExists:=false;
end;

Procedure inicializarDatosDeFormaPredeterminada;
//Nota: como solo se inicializan los datos, estos se pueden llamar de forma global sin pasarlos como parametros
begin
  Llenar_Matriz(CaldoDeCultivo,0,false);
  Llenar_Matriz(CelulasVecinas,0,false);
  Archivos:=True;
  Local:= not (archivos);
  PorCreacion:=false;
  PorPoblacion:=false;
  Personalizacion:=false;
  ModificacionDeColores:=false;
  ModificacionDeBordes:=true;
  x_filas:= 10 + random(41) ;
  Minpoblacion:=X_Filas;
  y_Columnas:= 10 + random(41);  (* Se recomienda meter un dato menor a 40*)
  poblacion:=0;
  Generacion:=0;
  NombreDelArchivoE:='entrada';
  NombreDelArchivoS:='Salida';
  Carpeta:='C:\Datos\';
  RutaE:=Carpeta+NombreDelArchivoE+'.txt';
  RutaS:=Carpeta+NombreDelArchivoS+'.txt';
  RutaModificada:=false;

end;

procedure imprimir_Matriz(NombreDeLaMatriz:string;MatrizAimprimir:matriz;ImprimirCaldo:boolean;filas,columnas:integer);
var
 x,y:integer;
begin
  writeln('');
  EspacioX(3);Writeln(NombreDeLaMatriz);
  writeln('');
  if Columnas > 39 then
     begin
          EspacioX(3);Writeln('Dada la cantidad de columnas,');
          EspacioX(5);Writeln('la matriz podria no verse unforme,');
          EspacioX(7);Writeln('para evitar esto ingrese menos de 40 columnas');
     end;
  for x := 1 to Filas do
    begin
    EspacioX(40-columnas);
      for y := 1 to columnas do
        begin
          if  ModificacionDeBordes then
            write('|');
          if ImprimirCaldo then
             begin
                  textbackground(MatrizAimprimir[x,y]);
                  write(' ');normvideo;
             end
          else
              write(MatrizAimprimir[x,y]);
        end;
      if  ModificacionDeBordes then
        writeln('|')
      else
        writeln();
    end;
end;

function ValorEntero(texto: string;min,Max:integer): integer;
var
  valor, codigoDeError: integer;
begin
  valor := 0;
  val(texto, valor, codigoDeError);
  if  ( (valor<min) or (valor>Max) ) then
    Begin
     textcolor(Red);   
     writeln(' El Parametro:', valor,', esta fuera del rango ');
     normvideo;
     Writeln('  Se evitara esta linea para salvar las demas');
    end;
  if codigoDeError <> 0 then
    begin
     writeln('hubo un error en la conversion de el parametro:', texto);
     Writeln(' por favor revise que sea un digito');
    end;
  ValorEntero := valor;
end;

procedure separar(palabra:string;linea0:boolean);
var
   Fila,Columna:string;
   posicion, i, limite:integer;
Begin
   posicion:=pos(',',palabra);
   limite:=posicion-1;
   Fila:=' ';
    for i:=1 to limite do
        Begin
            Fila:= Fila+copy(palabra,i,1);
        end;
   delete(palabra,1,posicion);
   Columna:=palabra;
   if Linea0 then
      begin
           X_filas:= ValorEntero(Fila,1,50);
           y_Columnas:=ValorEntero(Columna,1,50);
      end
   else
       CaldoDeCultivo[ValorEntero(Fila,1,50),ValorEntero(Columna,1,50)]:=1;
end;

procedure RevisarArchivo(var A:text;nombre:string;imprimir:boolean);
var
  palabraA:string;
  ContadorDePoblacion:integer;
begin
 if imprimir then
    begin
         writeln;
         EspacioX(5);writeln('Archivo de  ',nombre,' :');
         Writeln('');
    end;
 reset(A);
 ContadorDePoblacion:=-1;
 if eof(A) then
   begin
        EspacioX(4);
        writeln('Archivo vacio');
   end
 else
   begin
     while not(eof(A)) do
       begin
         readln(A,palabraA);
         if imprimir then
            begin
                 EspacioX(6);
                 writeln(palabraA);
            end;
         ContadorDePoblacion:=ContadorDePoblacion+1;
         separar(palabraA,ContadorDePoblacion=0);
         Writeln('');
       end;
     poblacion:=ContadorDePoblacion;
   end;
 close(A);
end;
  //////////////////////////////////////////////
 // 2. procedimientos inspecion y transicion //
//////////////////////////////////////////////

function Vecinas_de_una_celda_en(Px,Py:integer):integer;
 var
  AuxX,AuxY,Temp:integer;
  Rango:boolean;
 begin
  temp:=0;
  for AuxX:=-1 to 1 do
      for AuxY:=-1 to 1 do
          if ( (AuxX<>0) or (AuxY<>0) ) then
             begin
                  Rango:= Esvalido(Px+AuxX,X_Filas,1);
                  Rango:= Esvalido(PY+AuxY,Y_columnas,1);
                  If  Rango then
                     Temp:=temp+CaldoDeCultivo[Px+AuxX,Py+AuxY];
             end;
  Vecinas_de_una_celda_en:=temp;
 end;

procedure Llenar_Celdas_de( var Numero_de_Vecinas:matriz);
var
 PosicionX,PosicionY:integer;
Begin
   For PosicionX := 1 to x_Filas do
     for PosicionY := 1 to y_Columnas do
     Numero_de_Vecinas[PosicionX,PosicionY]:=Vecinas_de_una_celda_en(PosicionX,PosicionY);
end;

procedure Reglas;
var
 x,y:integer;
begin
  For x := 1 to X_Filas do
     for y := 1 to Y_Columnas do
         if ((CaldoDeCultivo[x,y]=1) and (CelulasVecinas[x,y]=2)) then
            write(){ la celula sobrevive}
         else // caldo x,y= 0 o no hay 2 vecinas
             if CelulasVecinas[x,y]=3 then
                CaldoDeCultivo[x,y]:=1  { nace una celula}
             else {no sobrevive ni nace, es decir, muere o permanece en 0 }
                CaldoDecultivo[x,y]:=0;
end;

Procedure Transicion_En_generacion(nAux:integer;imprimir:boolean);
var
   numero:integer;
Begin
 for Numero:=1 to nAux do
     begin
          Llenar_Celdas_de(CelulasVecinas);
          Reglas;
          if imprimir then
             begin
             Writeln('');
             Writeln(' Generacion',Numero);
             Imprimir_Matriz('Caldo de cultivo: ',CaldoDeCultivo,true,x_filas,y_columnas);
             if Personalizacion then
                begin 
                    Delay(1500-n);
                     clrscr;
                 end;
             end;
     end;
end;
Procedure LLenarPorPoblacion(Npoblacion:integer);
var
     x,y,z:integer;
begin
 z:=0;
 while z<> Npoblacion do
		Begin
			x:=1+random(10);
			y:=1+random(10);
			If CaldoDeCultivo[x,y]<>1 then
				begin
					CaldoDecultivo[x,y]:=1;
					z:=z+1;
				end;
		End;
end;

procedure Retornar(var Archivo:text);
var
  n,m:integer;
begin
 rewrite(Archivo);
   for n:=1 to x_Filas do
       for M:=1 to Y_columnas do
           if CaldoDecultivo[n,m]=1 then
              begin
                  write(Archivo,N);write(archivo,',');writeln(archivo,M);
              end;
 close(Archivo);
end;

  ////////////////////////////////////////////////////
 // 3. Procedimientos de ajustes y modificaciones  //
////////////////////////////////////////////////////
Procedure Cambiar_En_posicion_XY(Celula:integer;estado,Proceso:string);
var
 x,y:integer;
Begin
     writeln(proceso,' Celula en la posicion');
     validar(x,true,true,'fila ',X_filas,1);
     validar(y,true,true,'Columna',Y_columnas,1);
     if CaldoDeCultivo[x,y]= celula then
        Writeln(' En la posicion (',x,',',y,') ya existe una celula',estado)
     else
         begin
              Writeln(' En la posicion (',x,',',y,') no existe una celula',estado,' se procede a ',Proceso);
              CaldoDeCultivo[x,y]:=celula;
         end;
     readln();
end;

Function CambiarAjuste(de:string):boolean;
Begin
     repeat
           writeln(' Desea Cambiar la configuracion de ',de,' Si/No');
           EspacioX(25);Readln(SiNo);
           SiNo:=Upcase(SiNo);
     until ( (Sino[1]='S') or (Sino[1]='N'));
     CambiarAjuste:= Sino[1]='S';
end;
  ///////////////////////////
 // 0. Programa Principal //
///////////////////////////
begin
 randomize;
 presentacion;
 InicializarDatosDeFormaPredeterminada;
 repeat
    menu(1,-1,'MENU','Play','Sentings','Exit',1,3,1,3);
    validar(OpM,true,false,' el dato',3,0);barra;
    retornarSalida:=FileExists(rutaS);
    case OpM of
    1:
      Begin
           repeat
                 menu(1,2,'play','Info del Caldo','Editar Caldo',' Salir',1,1,2,5);
                 validar(OpSM,true,false,' el dato',3,0);barra;
                 if not FileExists(rutaE) then
                    begin
                         Writeln('La ruta no es valida, por favor cambiela');
                         Archivos:=false;
                 local:=not Archivos;
                    end;
                 if archivos then
                    begin
                         assign(entrada,rutaE);
                         RevisarArchivo(Entrada,NombreDelArchivoE,false);
                    end;
                 Llenar_Celdas_de(CelulasVecinas);
                 case OpSM of
                 1:
                  begin
                    EspacioX(10);writeln('Informacion Sobre El caldo de cultivo:');
                    Writeln('');
                    if Archivos then
                       RevisarArchivo(Entrada,NombreDelArchivoE,true);
                    EspacioX(5);Writeln('Dimensiones: ',x_filas,'x',y_Columnas);
                    EspacioX(5);Writeln('Poblacion: ',Poblacion);
                    EspacioX(5);Writeln('Generacion: ',Generacion);
                    imprimir_Matriz('Caldo de cultivo: ',CaldoDeCultivo,true,x_filas,y_columnas);
                    imprimir_Matriz('Celulas vecinas de cada celda: ',CelulasVecinas,false,x_filas,y_columnas);
                    EspacioX(4);EntradaDeDatos;readln();
                  end;
                 2:
                   Begin
                    if Local then 
                        if PorCreacion then
                            begin
                                if CambiarAjuste(' Filas y columnas?') then
                                    begin
                                        validar(X_Filas,true,True,' Filas',50,10);
                                        validar(Y_Columnas,true,True,' Columnas',50,10);
                                    end;
                                if CambiarAjuste(' Llenado?') then
                                Llenar_Matriz(CaldoDeCultivo,0,true);
                            end;
                        if Porpoblacion then
                            if CambiarAjuste(' Poblacion') then
                                begin
                                    validar(Poblacion,true,True,'la  Poblacion',X_Filas*Y_columnas,Minpoblacion);barra;
                                    LLenarPorPoblacion(poblacion);
                                end;
                    repeat  
                        menu(4,3,'Editar Caldo','Avanzar Generacion',' Modificar Caldo',' Salir',1,1,2,7);
                        validar(OpISM,true,false,' el dato',3,0);barra;
                        Case OpISM of
                         1:
                          repeat
                            menu(8,12,'Avanzar Generacion','Mostrar Generacion por Generacion',' Mostrar Generacion N','Salir',1,1,7,15);
                            validar(opISM1,true,false,' el dato',3,0);barra;
                            Case opISM1 of
                             1:
                               begin
                                    writeln(' Avanza e imprime hasta N');
                                    validar(N,true,True,' N',500,1);
                                    Transicion_En_generacion(N,true);
                                    readln();
                               end;
                             2:
                               begin
                                    writeln(' Se Imprime la generacion avanzada en N ');
                                    validar(N,true,True,' N',500,1);
                                    Transicion_En_generacion(N,false);
                                    Write('Caldo de cultivo en Generacion',N);
                                    imprimir_Matriz(': ',CaldoDeCultivo,true,x_filas,y_columnas);
                                    readln();
                               end;
                             3:
                                saliendo(' de Avanzar Generacion',500);
                             end;
                          Until opISM1=3;
                        2:
                         repeat
                            menu(6,2,'Modificar Caldo','Eliminar Celula',' Agregar celula','Salir',1,1,1,6);
                            validar(opISM1,true,false,' el dato',3,0);barra;
                            Case opISM1 of
                             1:
                                Cambiar_En_Posicion_XY(0,'muerta','Eliminar');
                             2:
                                Cambiar_En_Posicion_XY(1,'Viva','Agregar');
                             3:
                                saliendo(' de Modificar Caldo',500);
                             end;
                          Until opISM1=3;
                        3:
                          saliendo(' de editar Caldo',500);
                        end;
                    Until OpISM=3;
                   end;
                 3:
                   saliendo(' de la opcion Play',500);
                 end;
           until OpSM=3;
      end;
    2:
      Begin
           repeat
                 menu(2,5,'Sentings','Ver Congifuracion','Cambiar Configuracion','Salir',1,3,1,9);
                 validar(OpSM,true,false,' el dato',3,0);barra;
                 if Not(RutaModificada) then
                    RutaE:=Carpeta+NombreDelArchivoE+'.txt';
                 case OpSM of
                 1:
                   Begin
                        writeln('  La configuracion actual es:');
                        Writeln('');
                        Write(' *Archivos: ');writeln(Archivos);
                        Write(' -retornar salida:');Writeln(Retornarsalida);
                        Write(' -Nombre del archivo de Entrada: ');writeln(NombreDelArchivoE);
                        Write(' -Nombre del archivo de Salida: ');writeln(NombreDelArchivoS);
                        Write(' -Carpeta: ');Writeln(Carpeta);
                        Write(' -Ruta de Entrada: ');writeln(RutaE);
                        Write(' -Ruta de Salida: ');writeln(RutaS);
                        Writeln('');
                        Write(' *Local: ');writeln(Local);
                        Write(' -Por Creacion ');writeln(PorCreacion);
                        Write(' -Por Poblacion: ');writeln(PorPoblacion);
                        Writeln('');
                        Write(' *Personalizacion: ');writeln(Personalizacion);
                        Write(' -De colores ');writeln(ModificacionDeColores);
                        Write(' -De Bordes ');writeln(ModificacionDeBordes);
                        readln();
                   end;
                 2:
                   Begin
                        barra;
                        writeln(' Cambiar Configuracion');
                        for Ajustes:=xArchivo to bordes do
                          begin
                            writeln();
                            Case Ajustes of 
                             xArchivo:
                              begin
                                if CambiarAjuste('Archivo') then
                                Begin
                                     Archivos:=not Archivos;
                                     writeln(' Archivos : ',Archivos);
                                end;
                              end;
                             Devolver:
                              begin
                                if CambiarAjuste('DevolverSalida') then
                                Begin
                                     retornarSalida:=not retornarSalida;
                                     writeln(' Retorno de salida : ',retornarSalida);
                                end;
                              end;
                             NombreDeEntrada:
                              begin
                                if CambiarAjuste('archivo de entrada entrada')then
                                Begin
                                     write(' Ingrese el nombre del Archivo de Entrada: ');
                                     Readln(NombreDelArchivoE);
                                end;
                              end;
                             nombreDeSalida:
                              begin
                               if CambiarAjuste(' Archivo de salida')then
                                Begin
                                     write(' Ingrese el nombre del Archivo de Salida: ');
                                     Readln(NombreDelArchivoS);
                                end;
                              end;
                             RutaC:
                              begin
                               if CambiarAjuste(' La carpeta')then
                                Begin
                                   write(' Ingrese el nombre de la Carpeta: ');
                                   Readln(Carpeta);
                                end;
                              end;
                             RutaEntrada:
                              begin
                                if CambiarAjuste(' Ruta de entrada')then
                                 Begin
                                    write(' Ingrese La nueva Ruta de Entrada: ');
                                    Readln(RutaE);
                                 end;
                              end;
                             RutaSalida:
                              begin
                               if CambiarAjuste(' Ruta de salida')then
                                Begin
                                    write(' Ingrese La nueva Ruta de Salida: ');
                                     Readln(RutaS);
                                end;
                              end;
                             Xlocal:
                              begin
                                if CambiarAjuste('Local') then
                                Begin
                                     local:=not local;
                                     writeln(' Modo local: ',local);
                                end;
                              end;
                             xcreacion:
                              begin
                                if CambiarAjuste(' por Creacion') then
                                Begin
                                     Porcreacion:=not Porcreacion;
                                     writeln(' por creacion: ',Porcreacion);
                                end;
                              end;
                             xpoblacion:
                              begin
                                if CambiarAjuste(' por poblacion')then
                                Begin
                                     PorPoblacion:=not PorPoblacion;
                                     writeln(' Por poblacion: ',PorPoblacion);
                                end;
                              end;
                             Personalizado:
                              begin
                                if CambiarAjuste(' Personalizado')then
                                Begin
                                     Personalizacion:=not Personalizacion;
                                     writeln(' Personalizado: ',Personalizacion);
                                end;
                              end;
                             colores:
                              begin
                                if CambiarAjuste(' colores')then
                                Begin
                                     ModificacionDeColores:=not ModificacionDeColores;
                                     writeln(' Colores: ',ModificacionDeColores);
                                end;
                              end;
                             Bordes:
                              begin
                                if CambiarAjuste(' bordes')then
                                Begin
                                     ModificacionDeBordes:=not ModificacionDeBordes;
                                     writeln(' Bordes: ',ModificacionDeBordes);
                                end;
                              end;
                            else 
                                write('meh esto no deberia salir');
                            end; 
                          end; 

                        readln();
                   end;
                 3:
                   saliendo(' de la opcion Sentings',500);
                 end;
           until OpSM=3;
      end;
    3:
      saliendo('del programa principal',1000);

    end;
    if RetornarSalida then
       begin
              assign(salida,rutaS);
              Retornar(Salida);
       end;
 until OpM=3;
end.
