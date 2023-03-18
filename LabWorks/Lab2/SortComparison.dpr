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
  lengthOfArr: Integer;
  Res: TRes;

function initArray: Integer;
var
  Error: Integer;
  Check: String;
begin

  repeat
    write('Enter the size of the array: ');
    readln(Check);
    val(Check, Result, Error);
    if (Error <> 0) or (Result <= 1) then
      writeln('Incorrect input');
  until (Error = 0) and (Result > 1);

end;

procedure swapElem(var A, B: Integer);
var
  temp: Integer;
begin
  temp := A;
  A := B;
  B := temp;
end;

procedure fillArray(var arr: TArrayOfElements);

var
  i: Integer;
begin
  Randomize;
  for i := Low(arr) to High(arr) do
    arr[i]:= Random(high(TArrayOfElements)) + 1;

end;

procedure doReverseArray(var toBeReversedArray: TArrayOfElements);
var
  i, j, temp: Integer;

begin
  i := 0;
  j := High(toBeReversedArray);

  while i < j do
  begin
    swapElem(toBeReversedArray[i], toBeReversedArray[j]);
    //temp := toBeReversedArray[i];
    //toBeReversedArray[i] := toBeReversedArray[j];
    //toBeReversedArray[j] := temp;
    inc(i);
    dec(j);
  end;

end;

procedure doQuickSort(var toBeSortedQuick: TArrayOfElements; var counterResult: Integer);
var
  middle: Integer;
  pivotElem: Integer;
  i, j, L, leftElem, rightElem, temp: Integer;
  stackArr: array of array [0..1] of Integer;

begin
  counterResult := 0;
  L := 0;

  setLength(stackArr, high(toBeSortedQuick));
  stackArr[0, 0] := low(toBeSortedQuick);
  stackArr[0, 1] := high(toBeSortedQuick);

  repeat

    leftElem := stackArr[L, 0];
    rightElem := stackArr[L, 1];

    Dec(L);

    repeat
      i := leftELem;
      j := rightElem;

      pivotElem := toBeSortedQuick[(leftElem + rightElem) div 2];

      repeat
        while toBeSortedQuick[i] < pivotElem do
        begin
          inc(i);
          inc(counterResult);
        end;

        while toBeSortedQuick[j] > pivotElem do
        begin
          dec(j);
          inc(counterResult);
        end;

        if i <= j then
        begin
          //temp := toBeSortedQuick[i];
          //toBeSortedQuick[i] := toBeSortedQuick[j];
          //toBeSortedQuick[j] := temp;
          swapElem(toBeSortedQuick[i], toBeSortedQuick[j]);
          inc(i);
          dec(j);
          inc(counterResult);
        end;
      until i > j;

      if i < rightElem then
      begin
        inc(L);
        StackArr[L, 0] := i;
        StackArr[L, 1] := rightElem;
      end;
      rightElem := j;
    until leftElem >= rightElem;


  until L < 0 ;

end;

procedure doBubbleSort(var toBeSortedBubble: TArrayOfElements; var counterResult: Integer);
var
  i, j, temp: Integer;
  isSorted: boolean;
begin
  counterResult := 0;
  isSorted := false;
  i := 0;

  while (i <= High(toBeSortedBubble) - 1) and (not isSorted) do
  begin
    for j := 0 to High(toBeSortedBubble) - i - 1 do
    begin
      isSorted := true;
      if toBeSortedBubble[j] > toBeSortedBubble[j + 1] then
      begin
        isSorted := false;
        swapElem(toBeSortedBubble[j], toBeSortedBubble[j + 1]);
      end;
      inc(counterResult);
    end;
    //counterResult := counterResult + High(toBeSortedBubble);
    inc(i);

  end;

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


//-------------------------------------------


begin

for k := 0 to 5 do
  begin
    Res[k].sizeOfArray := initArray;

    setLength(arrayQuick, Res[k].sizeOfArray);
    setLength(arrayBubble, Res[k].sizeOfArray);

    fillArray(arrayQuick);
//   arrayBubble := arrayQuick;
    fillArray(arrayBubble);

    doQuickSort(arrayQuick, Res[k].quantityPracticalFirst);
    doBubbleSort(arrayBubble, Res[k].quantityPracticalSecond);

    Res[k].typeOfArray := 'Unsorted';

    Res[k].quantityTheoreticalFirst := round(Res[k].sizeOfArray * (ln(Res[k].sizeOfArray) /
                                       ln(2)));
    Res[k].quantityTheoreticalSecond := round((sqr(Res[k].sizeOfArray) - Res[k].sizeOfArray) div 2);

  end;

  for k := 6 to 11 do
  begin
    Res[k].sizeOfArray := Res[k - 6].sizeOfArray;

    setLength(arrayQuick, Res[k].sizeOfArray);
    setLength(arrayBubble, Res[k].sizeOfArray);

    fillArray(arrayQuick);
    doQuickSort(arrayQuick, Res[k].quantityPracticalFirst);
    Res[k].quantityPracticalFirst := 0;

//    arrayBubble := arrayQuick;
    fillArray(arrayBubble);
    doBubbleSort(arrayBubble, Res[k].quantityPracticalSecond);
    Res[k].quantityPracticalSecond := 0;

    doQuickSort(arrayQuick, Res[k].quantityPracticalFirst);
    doBubbleSort(arrayBubble, Res[k].quantityPracticalSecond);

//    Res[k].quantityPracticalSecond := Res[k].sizeOfArray - 1;

    Res[k].typeOfArray := 'Sorted';

    Res[k].quantityTheoreticalFirst := round(Res[k].sizeOfArray * (ln(Res[k].sizeOfArray) /
                                       ln(2)));
    Res[k].quantityTheoreticalSecond := Res[k].sizeOfArray - 1;
  end;



  for k := 12 to 17 do
  begin
    Res[k].sizeOfArray := Res[k - 6].sizeOfArray;

    setLength(arrayQuick, Res[k].sizeOfArray);
    setLength(arrayBubble, Res[k].sizeOfArray);

    fillArray(arrayQuick);
    fillArray(arrayBubble);

    doQuickSort(arrayQuick, Res[k].quantityPracticalFirst);
    Res[k].quantityPracticalFirst := 0;
    doBubbleSort(arrayBubble, Res[k].quantityPracticalSecond);
    Res[k].quantityPracticalSecond := 0;

    doReverseArray(arrayQuick);
    doReverseArray(arrayBubble);

    doQuickSort(arrayQuick, Res[k].quantityPracticalFirst);
    doBubbleSort(arrayBubble, Res[k].quantityPracticalSecond);

    Res[k].typeOfArray := 'Inverted';

    Res[k].quantityTheoreticalFirst := round(Res[k].sizeOfArray * (ln(Res[k].sizeOfArray) /
                                       ln(2)));
    Res[k].quantityTheoreticalSecond := round((sqr(Res[k].sizeOfArray) - Res[k].sizeOfArray) div 2);

  end;

  writeln;
  writeln('Result table:':36);
  writeln;
  writeln('Size |','   Type   |','  Experimental |':27,' Theoretical ':20);
  writeln;
  writeln('|':5,'| Quick sort |':25,' Bubble sort |', ' Quick sort |',' Bubble sort');
  writeln;
  for i := 0 to 17 do
  begin
    writeln(Res[i].sizeOfArray:4,' |',Res[i].typeOfArray:9, ' |',Res[i].quantityPracticalFirst:12,' |',Res[i].quantityPracticalSecond:11,' |',Res[i].quantityTheoreticalFirst:12,' |', Res[i].quantityTheoreticalSecond:11);
    writeln;
  end;

readln;
end.

