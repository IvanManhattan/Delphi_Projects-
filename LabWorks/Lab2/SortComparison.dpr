program SortComparison;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils, Windows;

type
  TArrayOfElements = array of Integer;
  TTable = record
    sizeOfArray: Integer;
    typeOfArray: String;
    quantityTheoreticalFirst: Integer;
    quantityPracticalFirst: Integer;
    quantityTheoreticalSecond: Integer;
    quantityPracticalSecond: Integer;
  end;
  Tres = array[0..17] of TTable;

var
  i, j, k, l, countOfComparisonQuick, countOfComparisonBubble: Integer;
  arrayQuick, arrayBubble: TArrayOfElements;
//  arrayOf100Elem, arrayOf100ElemSorted, arrayOf100ElemReversed: TArrayOfElements;
//  arrayOf250Elem, arrayOf250ElemSorted, arrayOf250ElemReversed: TArrayOfElements;
//  arrayOf500Elem, arrayOf500ElemSorted, arrayOf500ElemReversed: TArrayOfElements;
//  arrayOf1000Elem, arrayOf1000ElemSorted,arrayOf1000ElemReversed: TArrayOfElements;
//  arrayOf2000Elem, arrayOf2000ElemSorted, arrayOf2000ElemReversed: TArrayOfElements;
//  arrayOf3000Elem, arrayOf3000Sorted, arrayOf3000Reversed: TArrayOfElements;

//  startTime, endTime, elapsedTime: Cardinal;
  Res: TRes;

const
  ArrayOfSizes: array[0..5] of Integer = (100, 250, 500, 1000, 2000, 3000);
//  MAX100 = 100;
//  MAX250 = 250;
//  MAX500 = 500;
//  MAX1000 = 1000;
//  MAX2000 = 2000;
//  MAX3000 = 3000;

procedure incrementV(var i, counter: Integer);
begin

    i := i + 1;
    counter := counter + 1;

end;

procedure decrementV(var j, counter: Integer);
begin
    j := j - 1;
    counter := counter + 1;
end;

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
  For i := Low(arr) to High(arr) do
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

function doQuickSort(var toBeSortedQuick: TArrayOfElements; lowElem, highElem: Integer; var counterResult: Integer): TArrayOfElements;
var
  middle: Integer;
  pivotElem: Integer;
  i, j: Integer;
  comparisonCounter: Integer;
  arrayToSortQuick: TArrayOfElements;

begin
  arrayToSortQuick := toBeSortedQuick;
//comparisonCounter := 0;
//counterResult := 0;
  middle := Round((lowElem + highElem) / 2);
  pivotElem := toBeSortedQuick[middle];

  i := lowElem;
  j := highElem;

  while i <= j do
  begin
    while arrayToSortQuick[i] < pivotElem do
    begin
//      i := i + 1;
//      comparisonCounter := comparisonCounter + 1;
        incrementV(i, counterResult)
   end;
//    isMore(arrayToSortQuick[i], pivotElem, comparisonCounter);

    while arrayToSortQuick[j] > pivotElem do
    begin
//      j := j - 1;
//      comparisonCounter := comparisonCounter + 1;
        decrementV(j, counterResult);
    end;
//    isLess(arrayToSortQuick[j], pivotElem, comparisonCounter);

    if i <= j then
    begin
      swapElem(arrayToSortQuick, i, j);
      inc(i);
      dec(j);
    end;

  if lowElem < j then
    doQuickSort(arrayToSortQuick, lowElem, j, counterResult);

  if highElem > i then
    doQuickSort(arrayToSortQuick, i, highElem, counterResult);
  end;

  result := arrayToSortQuick;

end;

function doBubbleSort(var toBeSortedBubble: TArrayOfElements; highElem: Integer; var counterResult2: Integer): TArrayOfElements;
var
  i, j, Temp, counter: Integer;
  arrayToSortBubble: TArrayOfElements;
begin
  arrayToSortBubble := toBeSortedBubble;
  counter := 0;

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
        counterResult2 := counterResult2 + 1;
      end;
    end;
  end;

//  counterResult2 := counter;
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

function initArray: Integer;
var
  Error: Integer;
  Check: String;
begin
//  setLength(toBeInited, lengthOf);
//  fillArray(toBeInited);
  repeat
    write('Enter the size of the array: ');
    readln(Check);
    val(Check,Result,Error);
    if (Error <> 0) or (Result <= 1) then
      writeln('Incorrect input');
  until (Error = 0) and (Result > 1);
end;

//-------------------------------------------

begin

  for k := 0 to 5 do
  begin
    Res[k].sizeOfArray := initArray;

    setLength(arrayQuick, Res[k].sizeOfArray);
    setLength(arrayBubble, Res[k].sizeOfArray);

    fillArray(arrayQuick);
    arrayBubble := arrayQuick;

    doQuickSort(arrayQuick, low(arrayQuick), high(arrayQuick), Res[k].quantityPracticalFirst);
    doBubbleSort(arrayBubble, high(arrayBubble) - 1, Res[k].quantityPracticalSecond);

    Res[k].typeOfArray := 'Unsorted';

    Res[k].quantityTheoreticalFirst := 100;
    Res[k].quantityTheoreticalSecond := 100;

  end;

  for k := 6 to 11 do
  begin
    Res[k].sizeOfArray := Res[k - 6].sizeOfArray;

    setLength(arrayQuick, Res[k].sizeOfArray);
    setLength(arrayBubble, Res[k].sizeOfArray);

    fillArray(arrayQuick);
    doQuickSort(arrayQuick, low(arrayQuick), high(arrayQuick), Res[k].quantityPracticalFirst);
    Res[k].quantityPracticalFirst := 0;
    arrayBubble := arrayQuick;

    doBubbleSort(arrayBubble, high(arrayBubble) - 1, Res[k].quantityPracticalSecond);
    doQuickSort(arrayQuick, low(arrayQuick), high(arrayQuick), Res[k].quantityPracticalFirst);

    Res[k].typeOfArray := 'Sorted';

    Res[k].quantityTheoreticalFirst := 100;
    Res[k].quantityTheoreticalSecond := 100;
  end;

//  for k := 12 to 17 do
//  begin


//  end;

  writeln;
  writeln('Result table:':36);
  writeln;
  writeln('Size |','   Type   |','  Experimental |':27,' Theoretical ':20);
  writeln;
  writeln('|':6,'| Shaker sort |':25,' Quick sort |', ' Shaker sort |',' Quick sort');
  writeln;
  for I:=0 to 17 do
  begin
    writeln(Res[I].sizeOfArray:4,' |',Res[I].typeOfArray:9, ' |',Res[I].quantityPracticalFirst:12,' |',Res[I].quantityTheoreticalFirst:11,' |',Res[I].quantityPracticalSecond:12,' |', Res[I].quantityTheoreticalSecond:11);
    writeln;
  end;




//  setLength(arrayOf250Elem, MAX250);
//  initArray(arrayOf250Elem, Length(arrayOf250Elem));
//
//  arrayOf250ElemSorted := doQuickSort(arrayOf250Elem, 0,  249, countOfComparisonQuick);

//  printArray(arrayOf250ElemSorted);
//  writeln;
//  writeln(countOfComparisonQuick);

//  writeln;
//  writeln;

//  setLength(arrayOf100Elem, MAX100);
//  initArray(arrayOf100Elem, Length(arrayOf100ELEM));
//  arrayOf100ElemSorted := doQuickSort(arrayOf100Elem, 0, MAX100 - 1, countOfComparisonBubble);
//  printArray(arrayOf100ElemSorted);
//  writeln;
//  writeln(countOfComparisonBubble);

readln;
end.

