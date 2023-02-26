program findingDistance;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

type
  TArrayOfCoordinates = array[0..9, 0..2] of Integer;
  TArrayOfDistances = array[0..9, 0..9] of Real;

var
  arrayOfCoordinates: TArrayOfCoordinates;
  arrayOfDistances: TArrayOfDistances;
  distanceOf: Real;


procedure doFindDistance(xCoord, yCoord: Integer; var arrayOfDistances: TArrayOfDistances);
var
  i, j: Integer;
begin
  for i := 0 to 9 do
  begin
    for j := 0 to 9 do
    begin
      arrayOfDistances[i, j] := sqrt(sqr(xCoord) + sqr(yCoord));
    end;
  end;
end;

procedure doPrintMatrix(const outputMatrix: TArrayOfDistances);
var
  i, j: Integer;
begin
  for i := 1 to length(outputmatrix)  do
  begin
    for j := 1 to length(outputMatrix)  do
      write(outputMatrix[i, j]:6);
    writeln;
  end;
  writeln;
end;

procedure findTheHighest();
begin

end;


begin

end.
