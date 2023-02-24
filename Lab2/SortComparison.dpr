program SortComparison;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils, Windows;

type
  TArrayOfElements = array of Integer;

  TPList = ^TList;
  TList = record
    sizeOfArray: array[1..20] of String;
    typeOfArray: array[1..20] of String;
    quantityTheoreticalFirst: Integer;
    quantityPracticalFirst: Integer;
    quantityTheoreticalSecond: Integer;
    quantityPracticalSecond: Integer;
    next: TPList;
  end;

var
  i, j: Integer;
  arrayOf100Elem, arrayOf100ElemSorted, arrayOf100ElemReversed: TArrayOfElements;
  startTime, endTime, elapsedTime: Cardinal;
  head: TPList;

const
  MAX100 = 100;
  MAX250 = 250;
  MAX500 = 500;
  MAX1000 = 1000;
  MAX2000 = 2000;
  MAX3000 = 3000;

procedure swapElem(arr: TArrayOfElements; i, j: Integer);
var
  temp: Integer;
begin
  temp := arr[i];
  arr[i] := arr[j];
  arr[j] := temp;
end;

procedure fillArray(var arr: TArrayOfElements);

var
  i: Integer;
begin
  Randomize;
  For i:=Low(arr) to High(arr) do
    arr[i]:= Random(100) + 1;

end;

function doReverseArray(var toBeReversedArray: TArrayOfElements): TArrayOfElements;
var
  i, j, temp: Integer;
  arrayToReverse: TArrayOfElements;

begin
  arrayToReverse := toBeReversedArray;
  i := 0;
  j := Length(arrayToReverse) - 1;

  while i < j do
  begin
    temp := arrayToReverse[i];
    arrayToReverse[i] := arrayToReverse[j];
    arrayToReverse[j] := temp;
    inc(i);
    dec(j);
  end;

  result := arrayToReverse;

end;

function doQuickSort(var toBeSortedQuick: TArrayOfElements; lowElem, highElem: Integer): TArrayOfElements;
var
  middle: Integer;
  pivotElem: Integer;
  i, j: Integer;
  comparisonCounter: Integer;
  arrayToSortQuick: TArrayOfElements;

begin
  arrayToSortQuick := toBeSortedQuick;
  comparisonCounter := 0;
  middle := Round((lowElem + highElem) / 2);
  pivotElem := toBeSortedQuick[middle];

  i := lowElem;
  j := highElem;

  while i <= j do
  begin
    while arrayToSortQuick[i] < pivotElem do
    begin
      i := i + 1;
      comparisonCounter := comparisonCounter + 1;
    end;


    while arrayToSortQuick[j] > pivotElem do
    begin
      j := j - 1;
      comparisonCounter := comparisonCounter + 1;
    end;

    if i <= j then
    begin
      swapElem(arrayToSortQuick, i, j);
      inc(i);
      dec(j);
    end;

  if lowElem < j then
    doQuickSort(arrayToSortQuick, lowElem, j);

  if highElem > i then
    doQuickSort(arrayToSortQuick, i, highElem);
  end;

  result := arrayToSortQuick;

end;

function doBubbleSort(var toBeSortedBubble: TArrayOfElements; highElem: Integer): TArrayOfElements;
var
  i, j, Temp: Integer;
  arrayToSortBubble: TArrayOfElements;
begin
  arrayToSortBubble := toBeSortedBubble;

  for i := 0 to High(arrayToSortBubble) - 1 do
  begin
    for j := 0 to High(arrayToSortBubble) - i - 1 do
    begin
      if arrayToSortBubble[j] > toBeSortedBubble[j + 1] then
      begin
        //Temp := arrayToSortBubble[j];
        //arrayToSortBubble[j] := arrayToSortBubble[j + 1];
        //arrayToSortBubble[j + 1] := Temp;
        swapElem(arrayToSortBubble, j, j + 1);
      end;
    end;
  end;

  result := arrayToSortBubble;
end;

procedure printArray(var inputArray: TArrayOfElements);
var
  i: Integer;
begin
  for i := 0 to Length(inputArray) - 1 do
  begin
    write(IntToStr(inputArray[i]) + ' ');
  end;
end;

procedure initArray(var toBeInited: TArrayOfElements; lengthOf: Integer);
begin
  setLength(toBeInited, lengthOf);
  fillArray(toBeInited);
end;


//-------------------------------------------

begin
  writeln('Start');
  elapsedTime := 0;

  initArray(arrayOf100Elem, MAX100);
  printArray(arrayOf100Elem);

  writeln;
  writeln;

  setLength(arrayOf100ElemSorted, MAX100);
  arrayOf100ElemSorted := doBubbleSort(arrayOf100Elem, Length(arrayOf100ElemSorted));
  printArray(arrayOf100ElemSorted);

  writeln;
  writeln;

  setLength(arrayOf100ElemReversed, MAX100);
  arrayOf100ElemReversed := doReverseArray(arrayOf100ElemSorted);
  printArray(arrayOf100ElemReversed);

  writeln;
  writeln;

  startTime := getTickCount;
  arrayOf100ElemSorted := doBubbleSort(arrayOf100ElemReversed, Length(arrayOf100ElemReversed) - 1);
  endTime := getTickCount;
//  elapsedTime := (endTime - startTime);
//  writeln(Format('Elapsed time %d ms', [endTime - startTime]));

  printArray(arrayOf100ElemSorted);


readln;
end.