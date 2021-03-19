Program sudoku;
Uses crt;
Type
  matriz = Array [1..9, 1..9] Of Integer;
Var
  i, j, x, op,v: Integer;
  y: Char;

Const
  blue = 1;
  green = 2;
  red = 4;
  brown = 6;
  white = 7;
  yellow = 14;
  black = 0;
  //Esta matriz_f es el sudoky completo y terminado.
  matriz_f : matriz =
                      ((9,6,3,1,7,4,2,5,8),
                      (1,7,8,3,2,5,6,4,9),
                      (2,5,4,6,8,9,7,3,1),
                      (8,2,1,4,3,7,5,9,6),
                      (4,9,6,8,5,2,3,1,7),
                      (7,3,5,9,6,1,8,2,4),
                      (5,8,9,7,1,3,4,6,2),
                      (3,1,7,2,4,6,9,8,5),
                      (6,4,2,5,9,8,1,7,3));
  // esta matriz_i es el sudoku incompleto, como es presentado al ususario al inicio.
  matriz_i : matriz =
                      ((0,6,0,1,0,4,0,5,0),
                      (0,0,8,3,0,5,6,0,0),
                      (2,0,0,0,0,0,0,0,1),
                      (8,0,0,4,0,7,0,0,6),
                      (0,0,6,0,0,0,3,0,0),
                      (7,0,0,9,0,1,0,0,4),
                      (5,0,0,0,0,0,0,0,2),
                      (0,0,7,2,0,6,9,0,0),
                      (0,4,0,5,0,8,0,7,0));
  //Esta matriz es el sudoku que le es presentado al usuario,

//que no puede ser modficado. Para ser tomando como referencia para los recuadros que no pueden ser modificados
  matriz_org : matriz =
                        ((0,6,0,1,0,4,0,5,0),
                        (0,0,8,3,0,5,6,0,0),
                        (2,0,0,0,0,0,0,0,1),
                        (8,0,0,4,0,7,0,0,6),
                        (0,0,6,0,0,0,3,0,0),
                        (7,0,0,9,0,1,0,0,4),
                        (5,0,0,0,0,0,0,0,2),
                        (0,0,7,2,0,6,9,0,0),
                        (0,4,0,5,0,8,0,7,0));
  //Este arreglo vectorial tiene la enumeración de las filas
  filas: Array [1..9] Of Integer = (1,2,3,4,5,6,7,8,9);
  //Y este tiene la identificación de las columnas
  columnas: Array [1..9] Of Char = ('A','B','C','D','E','F','G','H','I');

//Esta funcion se encargar de interrupir el proceso del programa cuando el jugador completa correctamente el sudoku.
Function winner(matriz:matriz): Boolean;
Begin
  i := 1;
  j := 1;
  Repeat
    i := 1;
    Repeat
      If matriz_i[j,i]<>matriz_f[j,i] Then
        Begin
          winner := False;
          Exit;
        End;
      i := i+1;
    Until (i>9);
    j := j+1;
  Until (j>9);
  winner := True;
End;

// El procedimiento MOSTRAR se encarga exclusivamente de imprimir los valores organizados del Sudoku para ser visualizados comodamente por el usuario
Procedure mostrar(x:matriz);
Var
  i,j: Integer;
Begin
  If (winner(matriz_i)=False)Then
    i := 1;
  j := 1;
  Write('Estado del sudoku: ');
  Textcolor(red);
  textbackground(white);
  Write('Incompleto.');
  Textcolor(white);
  textbackground(black);
  Writeln(' ');
  Writeln('-----------------------------------------');
  Textcolor(blue);
  textbackground(white);
  Write('    | ');
  Repeat
    Textcolor(blue);
    textbackground(white);
    Write(columnas[i],' | ');
    Textcolor(white);
    textbackground(black);
    i := i+1;
  Until (i=10);
  Writeln('');
  Writeln('-----------------------------------------');
  Repeat
    i := 1;
    Write('|');
    textbackground(white);
    Textcolor(blue);
    Write(' ',filas[j],' ');
    textbackground(black);
    Textcolor(white);
    Write('| ');
    Repeat
			If ((matriz_i[j,i]<>matriz_f[j,i])and(matriz_i[j,i]<>0)) Then
        Begin
					Textcolor(red);
					Write(x[j,i]);
					Textcolor(white);
					Write(' | ');
        End
				Else
				begin
					If matriz_i[j,i]=matriz_f[j,i] Then
	        Begin
						Textcolor(green);
						Write(x[j,i]);
						Textcolor(white);
						Write(' | ');
	        End
					Else
	        Begin
						Textcolor(white);
						Write(x[j,i]);
						Textcolor(white);
						Write(' | ');
	        End;
				 end;
			i := i+1;
		Until (i=10);
    Writeln(' ');
    Writeln('-----------------------------------------');
    j := j+1;
  Until (j=10);
  If (winner(matriz_i)=True)Then
    Begin
      textcolor(yellow);
      Writeln('GANADOR!');
      textcolor(white);
      Write('Has completado el sudoku');
      textcolor(yellow);
      Writeln(' existosamente!');
      textcolor(white);
      Writeln('Gracias por jugar.');
      Write('Selecciona la');
      textcolor(yellow);
      Write(' opción 4 ');
      textcolor(white);
      Writeln('para salir y terminar el juego.');
    End;
End;

// El procedimiento MOSTRARPISTA se encarga exclusivamente de imprimir los valores organizados del Sudoku para ser visualizados comodamente por el usuario
// Resaltando la pista que se añadio
Procedure mostrarpista(x:matriz; a:Integer; b:Integer);
Var
  i,j: Integer;
Begin
  i := 1;
  j := 1;
  Writeln('Estado del sudoku:');
  Writeln('-----------------------------------------');
  Textcolor(blue);
  textbackground(white);
  Write('    | ');
  Repeat
    Textcolor(blue);
    textbackground(white);
    Write(columnas[i],' | ');
    Textcolor(white);
    textbackground(black);
    i := i+1;
  Until (i=10);
  Writeln('');
  Writeln('-----------------------------------------');
  Repeat
    i := 1;
    Write('|');
    textbackground(white);
    Textcolor(blue);
    Write(' ',filas[j],' ');
    textbackground(black);
    Textcolor(white);
    Write('| ');
    Repeat
			If ((matriz_i[j,i]<>matriz_f[j,i])and(matriz_i[j,i]<>0)) Then
        Begin
					Textcolor(red);
					Write(x[j,i]);
					Textcolor(white);
					Write(' | ');
        End
				Else
				begin
					If ((a=j)and(b=i)) Then
	        Begin
						Textcolor(yellow);
						Write(x[j,i]);
						Textcolor(white);
						Write(' | ');
	        End
					Else
	        Begin
						Textcolor(white);
						Write(x[j,i]);
						Textcolor(white);
						Write(' | ');
	        End;
				 end;
			i := i+1;
		Until (i=10);
    Writeln(' ');
    Writeln('-----------------------------------------');
    j := j+1;
  Until (j=10);
  If (winner(matriz_i)=True)Then
    Begin
      textcolor(yellow);
      Writeln('GANADOR!');
      textcolor(white);
      Write('Has completado el sudoku');
      textcolor(yellow);
      Writeln(' existosamente!');
      textcolor(white);
      Writeln('Gracias por jugar.');
      Write('Selecciona la');
      textcolor(yellow);
      Write(' opción 4 ');
      textcolor(white);
      Writeln('para salir y terminar el juego.');
    End;
End;

//Esta funcion convierte los valores de caracter que representan las columnas en numeros integrales compatibles con la matriz

Function letter2num(x:Char): Integer;
Begin
  i := 0;
  Repeat
    i := i+1;
    If x=columnas[i] Then letter2num := i;
  Until (x=columnas[i]);
End;

// Esta funcion verifica que la posicion que el usuario va a modificar no sea un valor original del sudoku.
//Si resulta FALSE, el valor no debe ser cambiado y si resulta TRUE, si puede ser modificado

Function verifpos(x:Integer;q:Char): Boolean;
Var
  bool: Boolean;
  y: Integer;
Begin
  y := (letter2num(q));
  If matriz_org[x,y] <> 0 Then bool := False;
  If matriz_org[x,y] = 0 Then bool := True;
  verifpos := bool;
End;
//Este procedimiento esta encardo de asignar el valor a algun espacio vacio de la matriz.

Procedure asignar(m:matriz);
Var
  x,v,a: Integer;
  y: Char;
	valid:Boolean;
Begin
  Writeln('Introduzca la columna del cuadro a modificar:');
	valid:=false;
	Repeat
		Readln(y);
		case y of
			'A','B','C','D','E','F','G','H','I': valid:=true;
		else;
			Begin
				WriteLn('Valor inválido, las letras deben ser mayúscula');
				WriteLn('Intente denuevo.');
			End;
		end;
	Until(valid=true);
	a := letter2num(y);
  Writeln('Introduzca la fila del cuadro a modificar:');
  Readln(x);
  Repeat
    Writeln('Introduzca el valor que desea colocar en el cuadro');
    Readln(v);
    If ((v<0) Or (v>9)) Then Writeln('Valor inválido. Debe estar entre 1 y 9.');
  Until ((v>0) And (v<10));
  Case verifpos(x,y) Of
    True:
          Begin
            matriz_i[x,a] := v;
          End;
    False: Writeln(

               'Posición inválida. Valores demasiado grandes o cuadro que no puede ser modificado'
           );
  End;
End;

//Esta funcion añade una pista al tablero de sudoku. Es decir, coloca un número correcto en el tablero.
Function pista(m_i:matriz): matriz;
Var
  i,j: Integer;
Begin
  i := 1;
  j := 1;
  Repeat
    i := 1;
    Repeat
      If matriz_i[j,i]<>matriz_f[j,i] Then
        Begin
          matriz_i[j,i] := matriz_f[j,i];
          pista := matriz_i;
          mostrarpista(matriz_i,j,i);
          Writeln('La pista se ubica en la columna ', columnas[i],' y en la fila ', j, '.');
          Exit;
        End;
      i := i+1;
    Until (i>9);
    j := j+1;
  Until (j>10);
End;

Procedure rendirse(x:Integer);
Begin
  If (winner(matriz_i)=True)Then
    Begin
      textcolor(yellow);
      Writeln('Gracias por jugar!');
      Writeln('Hasta luego!');
      textcolor(white);
      Exit;
    End;
  If (winner(matriz_i)=False)Then
    Begin
      Writeln('Mejor suerte la próxima!');
			Writeln('Así se resuelve el sudoku:');
			mostrar(matriz_f);
      Exit;
    End;
End;
//Este procedimiento es el menu que maneja todos los otros procedimientos, los maneja y selecciona
Procedure menu(op:Integer);
Begin
  Repeat
    Writeln('Opciones:');
    Writeln('1- Mostrar el estado del sudoku.');
    Writeln('2- Asignar un valor a alguna caja válida del sudoku.');
    Writeln('3- Ver una pista del sudoku.');
    Writeln('4- Rendirse y ver la solución del sudoku.');
    Readln(op);
    Case op Of
      1: mostrar(matriz_i);
      2: asignar(matriz_i);
      3: pista(matriz_i);
      4:
         Begin
           rendirse(j);
         End;
      Else
        Writeln('Valor inválido. Introduzca un valor entre 1 y 4.');
    End;
  Until (op=4);
End;
//Este es el cuerpo principal donde se usan todas las funciones y procedimientos
Begin
  textbackground(black);
  Writeln('Bienvenido al Sudoku.');
  Writeln('Este es el rompecabezas de hoy:');
  mostrar(matriz_org);
  menu(op);
  Exit;
End.