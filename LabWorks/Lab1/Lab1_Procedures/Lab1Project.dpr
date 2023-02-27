program Lab1Project;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

type
  TMatrix = array[1..3, 1..3] of integer;

procedure doSumOrSubOfMatrix(const firstMatrix, secondMatrix: TMatrix; const flags: boolean; var resultOf: TMatrix);
var
  i, j, m, n: Integer;
begin
  m := length(firstMatrix);
  n := length(secondMatrix);

  for i := 1 to m do
    for j := 1 to n do
    begin
    if flags then
      resultOf[i, j] := firstMatrix[i, j] + secondMatrix[i, j]
    else
      resultOf[i, j] := firstMatrix[i, j] - secondMatrix[i, j]
    end;

end;

procedure doMultiplyMatrix(const firstMatrix1, secondMatrix1: TMatrix; var resultOf: TMatrix);
var
  i, j, l, s, lengthOfArray: Integer;
begin
  lengthOfArray := length(firstMatrix1);

  for i := 1 to lengthOfArray do
    for j := 1 to lengthOfArray do
    begin
    s := 0;
      for l := 1 to lengthOfArray do
        s := s + firstMatrix1[i, l] * secondMatrix1[l, j];
    resultOf[i, j] := s;

    end;
end;

procedure doMultiplyNum(const firstMatrix1: TMatrix; const number: Integer; var resultOf: TMatrix);
var
  i, j, l, lengthOfArray: Integer;
begin
  lengthOfArray := length(firstMatrix1);

  for i := 1 to lengthOfArray do
    for j := 1 to lengthOfArray do
        resultOf[i, j] := firstMatrix1[i, j] * number

end;

procedure doPrintMatrix(const outputMatrix: TMatrix);
var
  i, j: Integer;
begin
  for I := 1 to length(outputmatrix)  do
  begin
    for j := 1 to length(outputMatrix)  do
      write(outputMatrix[i, j]:6);
    writeln;
  end;
  writeln;
end;

var
  A: TMatrix = ((4, -2, 0), (1, 1, 2), (3, -2, 0));
  B: TMatrix = ((0, -2, 6), (2, 4, 3), (0, -3, 4));
  Temp1, Temp2, Temp3, Temp4, Temp5, resultMatrix: TMatrix;
  I, J, L: Integer;

begin

  writeln('Sum of matrix A and B -  (A + B): ');
  doSumOrSubOfMatrix(A, B, true, Temp1);
  doPrintMatrix(Temp1);

  writeln('Difference of matrix A and B -  (A - B): ');
  doSumOrSubOfMatrix(A, B, false, Temp2);
  doPrintMatrix(Temp2);

  writeln('Multiply of matrix Temp1 and Temp2 -  (A + B) * (A - B): ');
  doMultiplyMatrix(Temp1, Temp2, Temp3);
  doPrintMatrix(Temp3);

  writeln('Multiply of matrix A and number - 2 * A');
  doMultiplyNum(A, 2, Temp4);
  doPrintMatrix(Temp4);

  writeln('Multiply of matrix Temp4 and B -  Temp4 * B: ');
  doMultiplyMatrix(Temp4, B, Temp5);
  doPrintMatrix(Temp5);


  writeln('The end result is  -  2 * A * B - (A + B) * (A - B): ');
  doSumOrSubOfMatrix(Temp5, Temp3, false, resultMatrix);
  doPrintMatrix(Temp5);

  writeln('Press any key to end...');
readln;
end.
