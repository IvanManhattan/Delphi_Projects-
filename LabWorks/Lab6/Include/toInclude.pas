type
  TMatrix = array[1..3, 1..3] of integer;

// Declaring the initial matrixes used in the expression
// Tepm1, Temp2, Temp3, Temp4, Temp5 - intemideate results
// resultMatrix - result of expression
var
  A: TMatrix;
  B: TMatrix;
  resultOf: Integer;
  Temp1, Temp2, Temp3, Temp4, Temp5, resultMatrix: TMatrix;
  I, J, L: Integer;

// Subprogram for inputting matrixes
{
  Matrix inputMatrix is being entered by user. Inputted values are
  being checked. In case of the incorrect input it displays an error
  message
}
procedure initArray(var inputMatrix: TMatrix);
var
  i, j: Integer;
  check: String;
  flags: Integer;
begin

  for i := 1 to 3 do
  begin
    for j := 1 to 3 do
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
function doSumOrSubOfMatrix(const firstMatrix, secondMatrix: TMatrix; const flags: boolean): TMatrix;

// Variable declaration section
var
  i, j, m, n: Integer;
{
  i,j, m, n – counter variables;
}

  begin

// set matrix's length
  m := length(firstMatrix);
  n := length(secondMatrix);

  for i := 1 to m do
    for j := 1 to n do
    begin
    if flags then
      result[i, j] := firstMatrix[i, j] + secondMatrix[i, j]
    else
      result[i, j] := firstMatrix[i, j] - secondMatrix[i, j]
    end;

end;


// Subprogram for multiplying the matrixes
{
  Two matrixes (firstMatrix1, secondMatrix1) of the same size are given.
  The subprogram returns the matrix that is equal
  to the result of the multiplication of the matrixes.
}
function doMultiplyMatrix(const firstMatrix1, secondMatrix1: TMatrix): TMatrix;

// Declaring counter variables
var
  i, j, l, s, lengthOfArray: Integer;
begin

// set a length of matrix's
  lengthOfArray := length(firstMatrix1);

  for i := 1 to lengthOfArray do
    for j := 1 to lengthOfArray do
    begin
    s := 0;
      for l := 1 to lengthOfArray do
        s := s + firstMatrix1[i, l] * secondMatrix1[l, j];

    result[i, j] := s;

    end;

end;


// Subprogram for multiplying the matrix by a number
{
  The firstMatrix1 matrix and the multiplier number are given. The
  subprogram returns the value of the matrix multiplied by
  a number.
}
function doMultiplyNum(const firstMatrix1: TMatrix; const number: Integer): TMatrix;

// Declaring counter variables
var
  i, j, l, lengthOfArray: Integer;
begin

// set matrix's length
  lengthOfArray := length(firstMatrix1);

  for i := 1 to lengthOfArray do
    for j := 1 to lengthOfArray do
        result[i, j] := firstMatrix1[i, j] * number

end;

// Subprogram for outputting the matrix
{
  A matrix X1 is given. The procedure outputs the
  formatted values of the matrix elements.
}
procedure doPrintMatrix(const outputMatrix: TMatrix);

// Declaring counter variables
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

