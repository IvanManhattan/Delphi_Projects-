program UseAbsolute;

{
  Create a program that calculates matrix expressions. Find
  the value of a given matrix expression using subprograms
  that do not use global parameters.
}

// Determining the Console Program Type
{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

// Determining the type for matrixes
type
  TNew = array of array of Integer;
  TMatrix = array[1..3, 1..3] of Integer;

// Declaring the initial matrixes used in the expression
// Tepm1, Temp2, Temp3, Temp4, Temp5 - intemideate results
// resultMatrix - result of expression
var
  A: TNew;
  B: TNew;
  C: TNew;
  resultOf, allLength: Integer;
  Temp1, Temp2, Temp3, Temp4, Temp5, resultMatrix: TNew;
  I, J, L: Integer;

procedure doSetLength();
begin
  setLength(A, allLength, allLength);
  setLength(B, allLength, allLength);
  setLength(Temp1, allLength, allLength);
  setLength(Temp2, allLength, allLength);
  setLength(Temp3, allLength, allLength);
  setLength(Temp4, allLength, allLength);
  setLength(Temp5, allLength, allLength);
  setLength(resultMatrix, allLength, allLength);
end;

procedure lengthOfArray(var allLength: Integer);
var
  lengthOf: String;
  flags: Integer;

begin

    repeat
      writeln('Enter the length of array...');
      readln(lengthOf);
      val(lengthOf, resultOf, flags);
      if (flags <> 0) or (resultOf <= 1) then
        writeln('Incorect input')
      else
        allLength := strToInt(lengthOf);
    until (flags = 0) or (resultOf > 1);

end;
// Subprogram for inputting matrixes
{
  Matrix inputMatrix is being entered by user. Inputted values are
  being checked. In case of the incorrect input it displays an error
  message
}
procedure initArray(var inputMatrix: TNew);
var
  i, j: Integer;
  check: String;
  flags: Integer;
begin

  for i := 0 to high(inputMatrix) do
  begin
    for j := 0 to high(inputMatrix) do
    begin
       repeat
        Write('Enter the [' + intToStr(i) + ', ' + intToStr(j) + '] element]: ');
        readln(check);
        val(check, resultOf, flags);
        if (flags <> 0) then
          writeln('Incorrect input')
        else
          inputMatrix[i, j] := strToInt(check);
      until (flags = 0) and (resultOf > -10);
    end;
  end;

end;
// Subprogram for calculating the sum or sub of matrixes
{
  Two matrixes (firstMatrix, secondMatrix) of the same size are given.
  The subprogram returns the matrix that is equal
  to the result of summation or subtraction of
  the given matrixes.
}
procedure doSumOrSubOfMatrix(const firstMatrix, secondMatrix: TNew; const flags: boolean; var resultOf);

// Variable declaration section
var
  i, j, m, n: Integer;
  resA: TMatrix absolute resultOf;
{
  i,j, m, n � counter variables;
}

begin

// set matrix's length
  m := high(firstMatrix);
  n := high(secondMatrix);

  for i := 1 to m + 1 do
    for j := 1 to n + 1 do
    begin
    if flags then
      resA[i, j] := firstMatrix[i, j] + secondMatrix[i, j]
    else
      resA[i, j] := firstMatrix[i, j] - secondMatrix[i, j]
    end;

end;

// Subprogram for multiplying the matrixes
{
  Two matrixes (firstMatrix1, secondMatrix1) of the same size are given.
  The subprogram returns the matrix that is equal
  to the result of the multiplication of the matrixes.
}
procedure doMultiplyMatrix(const firstMatrix1, secondMatrix1: TNew; var resultOf: TNew);

// Declaring counter variables
var
  i, j, l, s, lengthOfArray: Integer;
begin

// set a length of matrix's
  lengthOfArray := high(firstMatrix1);

  for i := 0 to lengthOfArray do
    for j := 0 to lengthOfArray do
    begin
    s := 0;
      for l := 1 to lengthOfArray do
        s := s + firstMatrix1[i, l] * secondMatrix1[l, j];
    resultOf[i, j] := s;

    end;
end;

// Subprogram for multiplying the matrix by a number
{
  The firstMatrix1 matrix and the multiplier number are given. The
  subprogram returns the value of the matrix multiplied by
  a number.
}
procedure doMultiplyNum(const firstMatrix1: TNew; const number: Integer; var resultOf: TNew);

// Declaring counter variables
var
  i, j, l, lengthOfArray: Integer;
begin

// set matrix's length
  lengthOfArray := high(firstMatrix1);

  for i := 0 to lengthOfArray do
    for j := 0 to lengthOfArray do
        resultOf[i, j] := firstMatrix1[i, j] * number

end;

// Subprogram for outputting the matrix
{
  A matrix outputMatrix is given. The procedure outputs the
  formatted values of the matrix elements.
}
procedure doPrintMatrix(const outputMatrix: TNew);

// Declaring counter variables
var
  i, j: Integer;
begin

  for i := 0 to high(outputMatrix) do
  begin
    for j := 0 to high(outputMatrix) do
      write(outputMatrix[i, j]:6);
    writeln;
  end;
  writeln;
end;


begin


  lengthOfArray(allLength);

  doSetLength;

// Inputting matrixes
  writeln('Enter the matrix A: ');
  initArray(A);
  writeln('Enter the matrix B: ');
  initArray(B);

// Outputting the initial matrixes
  writeln('Matrix A: ');
  doPrintMatrix(A);

  writeln('Matrix B: ');
  doPrintMatrix(B);

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

// Calculating the value of the expression
  writeln('The end result is  -  2 * A * B - (A + B) * (A - B): ');
  doSumOrSubOfMatrix(Temp5, Temp3, false, resultMatrix);
  doPrintMatrix(resultMatrix);

  writeln('Press any key to end...');
readln;
end.
