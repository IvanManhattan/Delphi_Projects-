program SortComparison;

{$APPTYPE CONSOLE}

{$R *.res}

// Determining the Console Program Type
uses
  System.SysUtils, Windows;

// Determining the type for record
// TRes - array of records with output results
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

// Declairing values
(*
   i, j, k, l - cycle counters,
   countOfComparisonQuick, countOfComparisonBubble - number of comparisons,
   arrayQuick, arrayBubble - arrays to sort,
   lengthOfArr - inputting length
   Res - table of results
*)
var
  i, j, k, l, countOfComparisonQuick, countOfComparisonBubble: Integer;
  arrayQuick, arrayBubble: TArrayOfElements;
  lengthOfArr: Integer;
  Res: TRes;

// Subprogram for inputting lengths of arrays
(*
  User enters the value which will be used as length
  of arrays. Subprogram check the value. In case of
  incorrect value it shows appropriate message
*)
function initArray: Integer;
// Variable declaration section
var
  Error: Integer;
  Check: String;
(*
  Error - flag
  Check - inputting value
*)

begin

  repeat
    write('Enter the size of the array: ');
    readln(Check);
    val(Check, Result, Error);
    if (Error <> 0) or (Result <= 1) then
      writeln('Incorrect input');
  until (Error = 0) and (Result > 1);

end;


// Subprogram to swap elements
(*
  Take 2 values (A, B), saves the first one in
  temporary value (temp), change the second one
  and set the first one a value of temp
*)
procedure swapElem(var A, B: Integer);
// Variable declaration section
var
  temp: Integer;
(*
  temp - temporary value
*)

begin
  temp := A;
  A := B;
  B := temp;
end;


// Subprogram to fill arrays with random values
(*
  Take an array and fills it using random values
  in the range of lowest and highest indexes of
  array
*)
procedure fillArray(var arr: TArrayOfElements);
// Variable declaration section
var
  i: Integer;
(*
  i - cycle counter
*)
begin
  Randomize;

  // Cycle 1.0
  (*
    fills array using random values
  *)
  for i := Low(arr) to High(arr) do
    arr[i]:= Random(high(TArrayOfElements)) + 1;

end;


// Subprogram to reverse array
(*
  Take the first and the last values of array
  and swap them. Then the second one and
  penultimate one and so on
*)
procedure doReverseArray(var toBeReversedArray: TArrayOfElements);
// Variable declaration section
var
  i, j, temp: Integer;
(*
  i, j - cycle counters
*)
begin
  i := 0;
  j := High(toBeReversedArray);

  // Cycle 1.0
  (*
    swaps elements until i > j
  *)
  while i < j do
  begin
    swapElem(toBeReversedArray[i], toBeReversedArray[j]);
    inc(i);
    dec(j);
  end;

end;

// Subprogram which sort array using algorithm of QuickSort
(*
  Take inputted array, sort it and write down the result of
  comparisons
*)
procedure doQuickSort(var toBeSortedQuick: TArrayOfElements; var counterResult: Integer);
// Variable declaration section
var
  middle: Integer;
  pivotElem: Integer;
  i, j, L, leftElem, rightElem, temp: Integer;
  stackArr: array of array [0..1] of Integer;
begin
(*
  pivotElem - a separator,
  i, j, k, L - cycle counters,
  leftElem, rightElem - temporary values as borders
  stackArr - stack of borders
*)

  // setting default values
  counterResult := 0;
  L := 0;

  setLength(stackArr, high(toBeSortedQuick));
  stackArr[0, 0] := low(toBeSortedQuick);
  stackArr[0, 1] := high(toBeSortedQuick);

  // Cycle 1.0
  (*
    Main cycle. It sorts array using quick sort
    and writes border elements into stack
  *)
  repeat

    // write border elements into stack
    leftElem := stackArr[L, 0];
    rightElem := stackArr[L, 1];

    Dec(L);

    // Cycle 1.1
    (*
      Count the pivot element and separate
      arrays, sets border elements
    *)
    repeat

      // setting border elements and pivot element
      i := leftELem;
      j := rightElem;
      pivotElem := toBeSortedQuick[(leftElem + rightElem) div 2];

      // Cycle 1.1.2
      (*
        find needed elements in array and swaps them
        until i > j
      *)
      repeat

        // Cycle 1.1.2.1
        (*
          find the element that is less than the
          pivot element
        *)
        while toBeSortedQuick[i] < pivotElem do
        begin
          inc(i);
          inc(counterResult);
        end;
        // End of cycle 1.1.2.1

        // Cycle 1.1.2.2
        (*
          find the element that is bigger than the
          pivot element
        *)
        while toBeSortedQuick[j] > pivotElem do
        begin
          dec(j);
          inc(counterResult);
        end;
        // End of cycle 1.1.2.2

        // Cycle 1.1.2.3
        (*
          swap founded elements if i <= j
        *)
        if i <= j then
        begin
          swapElem(toBeSortedQuick[i], toBeSortedQuick[j]);
          inc(i);
          dec(j);
          inc(counterResult);
        end;
        // End of cycle 1.1.2.3

      until i > j;
      // End of cycle 1.1.2

      // write down borders into stack
      if i < rightElem then
      begin
        inc(L);
        StackArr[L, 0] := i;
        StackArr[L, 1] := rightElem;
      end;
      rightElem := j;
    until leftElem >= rightElem;
    // End of cycle 1.1

  until L < 0 ;
  // End of cycle 1.0

end;


// Subprogram which sort array using algorithm of Bubble sort
(*
  Take inputted array, sort it and write down the result of
  comparisons
*)
procedure doBubbleSort(var toBeSortedBubble: TArrayOfElements; var counterResult: Integer);
// Variable declaration section
var
  i, j, temp: Integer;
  isSorted: boolean;
  (*
    i, j - cycle counters
    isSorted - flag
  *)
begin
  // set default values
  counterResult := 0;
  isSorted := false;
  i := 0;

  // Cycle 1.0
  (*
    sort array and count number of comparisons
  *)
  while (i <= High(toBeSortedBubble) - 1) and (not isSorted) do
  begin

    // Cycle 1.1
    (*
      check if array is already sorted. If so, end the
      cycle. In opposite case, sort array
    *)
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
    // End of Cycle 1.1
    inc(i);
  end;
  // End of Cycle 1.0

end;


//---------Start of program---------//

begin

// Cycle 1.0
(*
  Input lengths of arrays, fills arrays and
  write down results in array of records for
  'Unsorted' type of arrays
*)
  for k := 0 to 5 do
  begin
    Res[k].sizeOfArray := initArray;

    setLength(arrayQuick, Res[k].sizeOfArray);
    setLength(arrayBubble, Res[k].sizeOfArray);

    fillArray(arrayQuick);
    fillArray(arrayBubble);

    doQuickSort(arrayQuick, Res[k].quantityPracticalFirst);
    doBubbleSort(arrayBubble, Res[k].quantityPracticalSecond);

    Res[k].typeOfArray := 'Unsorted';

    Res[k].quantityTheoreticalFirst := round(Res[k].sizeOfArray * (ln(Res[k].sizeOfArray) /
                                       ln(2)));
    Res[k].quantityTheoreticalSecond := round((sqr(Res[k].sizeOfArray) - Res[k].sizeOfArray) div 2);

  end;
// End of cycle 1.0

// Cycle 2.0
(*
  Input lengths of arrays, fills arrays and
  write down results in array of records for
  'Sorted' type of arrays
*)
  for k := 6 to 11 do
  begin
    Res[k].sizeOfArray := Res[k - 6].sizeOfArray;

    setLength(arrayQuick, Res[k].sizeOfArray);
    setLength(arrayBubble, Res[k].sizeOfArray);

    fillArray(arrayQuick);
    doQuickSort(arrayQuick, Res[k].quantityPracticalFirst);
    Res[k].quantityPracticalFirst := 0;

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
// End of cycle 2.0

// Cycle 3.0
(*
  Input lengths of arrays, fills arrays and
  write down results in array of records for
  'Inverted' type of arrays
*)
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
// End of cycle 3.0

// Output ressults
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

