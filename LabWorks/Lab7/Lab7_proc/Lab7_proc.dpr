program Lab7_proc;
(*
  Calculate the definite integral of the following functions
*)

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

(*
  Declairing const fields
*)
const
  NUMBER_OF_EXPRESSIONS = 4;
  NUMBER_OF_METHODS = 4;
  arrayOfBorders: array[1..NUMBER_OF_EXPRESSIONS] of array[1..2] of Double =
                    ((1.4, 0.6), (1.6, 0.8), (0.8, 0.2), (2.0, 1.2));
  EPS_ONE = 0.00001;
  EPS_TWO = 0.000001;
  FORMAT = '0.0000000000';

// Determining the type for record
// TResult - array of records with output results
// TExpression - type-function
// TTable - type-record
// TListOfExpressions - type-array of functions
type
  TExpression = procedure(x: Double; var res: Double);
  TTable = record

    resultByLeft: Double;
    resultByRight: Double;
    resultByCentral: Double;
    resultByTrapes: Double;
  end;

  TResult = array[1..NUMBER_OF_METHODS] of TTable;
  TListOfExpressions = array[1..NUMBER_OF_EXPRESSIONS] of TExpression;

// Declairing values
(*
  exp - function
  myResult - result of function
  left, right - borders of integrating
  i, k - cycle counters
  resultTable - table of results
  listOfExpressions - array of expressions
*)
var
  exp: TExpression;
  myResult: Double;
  left, right: Double;
  i, k: Integer;
  resultTable: TResult;
  listOfExpressions: TListOfExpressions;


// Subprogram calculating by left integral method
(*
  Uses left and right borders to calculate integral by
  left recktangle method with input eps. Returns double type
*)
function byLeftRecktangle(rightBorder, leftBorder: Double; const eps: Double;
                          inputFunction: TExpression): Double;
var
  square: Double;
  step: Double;
  border: Double;
  n: Integer;
  res: Double;
(*
  square - current result
  step - current step
  border - floating border
  n - use to change a step
*)
begin

  step := rightBorder - leftBorder;
  inputFunction(leftBorder, res);
  result := res * step;
  n := 1;

  // Cycle 1.0
  (*
    calculates integral until eps
  *)
  repeat
    square := result;
    n := n * 2;
    step := (rightBorder - leftBorder) / n;
    border := leftBorder;
    result := 0;

    // Cycle 1.1
    (*
      calculates integral until border
    *)
    while border < rightBorder do
    begin
      inputFunction(border, res);
      result := result + res * step;
      border := border + step;
    end;

  until abs(square - result) <= eps;

end;

// Subprogram calculating by left integral method
(*
  Uses left and right borders to calculate integral by
  right recktangle method with input eps. Returns double type
*)
function byRightRecktangle(rightBorder, leftBorder: Double; const eps: Double;
                          const inputFunction: TExpression): Double;
var
  square: Double;
  step: Double;
  border: Double;
  n: Integer;
  res: Double;
(*
  square - current result
  step - current step
  border - floating border
  n - use to change a step
*)

begin
  step := rightBorder - leftBorder;
  inputFunction(rightBorder, res);
  result := res * step;
  n := 1;

  // Cycle 1.0
  (*
    calculates integral until eps
  *)
  repeat
    square := result;
    n := n * 2;
    step := (rightBorder - leftBorder) / n;
    border := rightBorder;
    result := 0;

    // Cycle 1.1
    (*
      calculates integral until border
    *)
    while leftBorder < border do
    begin
      inputFunction(border, res);
      result := result + res * step;
      border := border - step;
    end;

  until abs(square - result) <= eps;

end;

// Subprogram calculating by left integral method
(*
  Uses left and right borders to calculate integral by
  central recktangle method with input eps. Returns double type
*)
function byCentralRecktangle(rightBorder, leftBorder: Double; const eps: Double;
                          const inputFunction: TExpression): Double;
var
  square: Double;
  step: Double;
  border: Double;
  n: Integer;
  central: Double;
  res: Double;
(*
  square - current result
  step - current step
  border - floating border
  n - use to change a step
*)

begin

  step := rightBorder - leftBorder;
  central := leftBorder + step / 2;
  inputFunction(central, res);
  result := res * step;
  n := 1;

  // Cycle 1.0
  (*
    calculates integral until eps
  *)
  repeat
    square := result;
    n := n * 2;
    step := (rightBorder - leftBorder) / n;
    border := leftBorder + step / 2;
    result := 0;

    // Cycle 1.1
    (*
      calculates integral until border
    *)
    while border < rightBorder do
    begin
      inputFunction(border, res);
      result := result + res * step;
      border := border + step;
    end;

  until abs(square - result) <= eps;

end;

// Subprogram calculating by left integral method
(*
  Uses left and right borders to calculate integral by
  trape method with input eps. Returns double type
*)
function byTrapes(rightBorder, leftBorder: Double; const eps: Double;
                          const inputFunction: TExpression): Double;
var
  square: Double;
  step: Double;
  borderA, borderB: Double;
  n: Integer;
  res1, res2: Double;
(*
  square - current result
  step - current step
  border - floating border
  n - use to change a step
*)

begin

  step := rightBorder - leftBorder;
  inputFunction(rightBorder, res1);
  inputFunction(leftBorder, res2);
  result := ((res1 + res2) / 2) * step;
  n := 1;

  // Cycle 1.0
  (*
    calculates integral until eps
  *)
  repeat
    square := result;
    n := n * 2;
    step := (rightBorder - leftBorder) / n;
    borderA := leftBorder;
    borderB := leftBorder + step;
    result := 0;

    // Cycle 1.1
    (*
      calculates integral until border
    *)
    while borderA < rightBorder do
    begin
      inputFunction(borderB, res1);
      inputFunction(borderA, res2);
      result := result + ((res1 + res2) / 2) * step;
      borderA := borderA + step;
      borderB := borderB + step;
    end;

  until abs(square - result) <= eps;

end;

// Expressions
procedure expressionOne(x: Double; var res: Double);
begin
  res := (sqrt(sqr(x) + 5)) / (2 * x + sqrt(sqr(x) + 0.5));
end;

procedure expressionTwo(x: Double; var res: Double);
begin
  res := 1 / (sqrt(2 * sqr(x) + 1));
end;

procedure expressionThree(x: Double; var res: Double);
begin
  res := (sin(2 * x + 0.5)) / (2 + cos(sqr(x) + 1));
end;

procedure expressionFour(x: Double; var res: Double);
begin
  res := (ln(x + 2) / ln(10)) / x;
end;

begin

  listOfExpressions[1] := expressionOne;
  listOfExpressions[2] := expressionTwo;
  listOfExpressions[3] := expressionThree;
  listOfExpressions[4] := expressionFour;

// Calculating integrals and recording results in result table
  for k := 1 to 4 do
  begin
    exp := listOfExpressions[k];
    left := arrayOfBorders[k, 1];
    right := arrayOfBorders[k, 2];

    resultTable[k].resultByLeft := byLeftRecktangle(
                                left, right, EPS_ONE, exp);
    resultTable[k].resultByRight := byRightRecktangle(
                                left, right, EPS_ONE, exp);
    resultTable[k].resultByCentral := byCentralRecktangle(
                                left, right, EPS_ONE, exp);
    resultTable[k].resultByTrapes := byTrapes(
                                left, right, EPS_ONE, exp);
  end;

// Output results in table
  writeln;
  writeln('Result table:':40);
  writeln(' ________________________________________________________________________');
  writeln('|', '|':13,' Eps = 10^-5 |':60);
  writeln(' ________________________________________________________________________');
  writeln('|',' Expression |','Left |':15,' right |':15, ' central |':15,' trapes |':15);
  writeln(' ________________________________________________________________________');
  for k := 1 to 4 do
  begin
    writeln('|', k:12, '|',formatFloat(FORMAT, resultTable[k].resultByLeft) + '  |', formatFloat(FORMAT, resultTable[k].resultByRight) + '  |',
            formatFloat(FORMAT, resultTable[k].resultByCentral) + '  |', formatFloat(FORMAT, resultTable[k].resultByTrapes) + '  |');
    writeln(' ________________________________________________________________________');
  end;

// Calculating integrals and recording results in result table
  for k := 1 to 4 do
  begin
    exp := listOfExpressions[k];
    left := arrayOfBorders[k, 1];
    right := arrayOfBorders[k, 2];

    resultTable[k].resultByLeft := byLeftRecktangle(
                                left, right, EPS_TWO, exp);
    resultTable[k].resultByRight := byRightRecktangle(
                                left, right, EPS_TWO, exp);
    resultTable[k].resultByCentral := byCentralRecktangle(
                                left, right, EPS_TWO, exp);
    resultTable[k].resultByTrapes := byTrapes(
                                left, right, EPS_TWO, exp);
  end;

// Output results in table
  writeln;
  writeln('Result table:':40);
  writeln(' ________________________________________________________________________');
  writeln('|', '|':13,' Eps = 10^-6 |':60);
  writeln(' ________________________________________________________________________');
  writeln('|',' Expression |','Left |':15,' right |':15, ' central |':15,' trapes |':15);
  writeln(' ________________________________________________________________________');
  for k := 1 to 4 do
  begin
    writeln('|', k:12, '|',formatFloat(FORMAT, resultTable[k].resultByLeft) + '  |', formatFloat(FORMAT, resultTable[k].resultByRight) + '  |',
            formatFloat(FORMAT, resultTable[k].resultByCentral) + '  |', formatFloat(FORMAT, resultTable[k].resultByTrapes) + '  |');
    writeln(' ________________________________________________________________________');
  end;

readln;
end.
