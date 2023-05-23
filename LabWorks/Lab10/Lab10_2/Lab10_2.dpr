Program Lab10_2;

{$APPTYPE CONSOLE}

{$R *.res}

// Determining the Console Program Type
uses
  System.SysUtils;

// Determining types
(*
 TMyString - array of String
 TMyInteger - array of Integer
*)
type
  TMyString = array of String;
  TMyInteger = array of Integer;

// Declairing values
(*
  myFile - users file (TextFile type)
  arrayOfString - array where strings from file will be put
  arrayOfLength - array of length of input strings
  theLowestLength - the lowest value from array of lengths
*)
var
  myFile: TextFile;
  arrayOfInteger: TMyInteger;
  arrayOfLength: TMyInteger;
  theLowestLength: Integer;

// Declairing const values
const
  FINAL_MESSAGE = 'Press any button to terminate...';
  FILE_PATH = '';

// Subprogram for finding the lowest value
(*
  requires - var of TMyInteger, var of Integer
  searches for the lowest value in var of TMyInteger and puts it in
  var of Integer
*)
procedure findMin(const arrayOf: TMyInteger; var theLowest: Integer);

// Variable declaration section
var
  temp: Integer;
  i: Integer;
begin
  theLowest := arrayOf[0];

  for i := 0 to high(arrayof) do
  begin
    if arrayOf[i] < theLowest then
      theLowest := arrayOf[i];
  end;
end;

// Subprogram for reading file
(*
  requires - var of TextFile, var of TMyString
  reads var of TextFile and puts all strings in var of TMyString
*)
procedure doReadFile(var myFile: TextFile; var arrayOfLength: TMyInteger);

// Variable declaration section
var
  inputString: String;
  myChar: Char;
  currentString: Integer;
  i, k: Integer;
  buffLength: Integer;
  theLowest: Integer;
  arrayOfSigns: TMyInteger;
  signLength: Integer;
(*
  inputString - temp string to write down a data from file
  myChar - current char
  currentString - current string index
  i, k - cycle counters
  buffLength - length of current string
  theLowest - the lowest length of string
  arrayOfSigns - array of indexes of strings with the lowest length
  signLength - length of array of signs
*)

begin

//  initializing vars
  currentString := 0;
  inputString := '';
  assignFile(myFile, FILE_PATH);
  buffLength := 0;
  i := 0;

  writeln('-->File contains the following text<--');
  reset(myFile);

  // Cycle 1.0
  (*
    prints all strings from file
  *)
  while not EoF(myFile) do
  begin

    // Cycle 1.1
    (*
      filling string with chars from file
    *)
    while not EoLn(myFile) do
    begin
      read(myFile, myChar);
      inputString := inputString + myChar;
    end;
    // End of Cycle 1.1

    writeln(inputString);
    inputString := '';
    readln(myFile);
    inc(i);

  end;
  // End of cycle 1.0
  closeFile(myFile);

  setLength(arrayOfLength, i);

  reset(myFile);

  // Cycle 2.0
  (*
    counts lengths of strings and put it in
    array of length
  *)
  while not EoF(myFile) do
  begin

    // Cycle 2.1
    (*
      counting buffLength
    *)
    while not EoLn(myFile) do
    begin
      read(myFile, myChar);
      inc(buffLength);
    end;
    // End of Cycle 2.1

    readln(myFile);
    arrayOfLength[currentString] := buffLength;
    buffLength := 0;
    inc(currentString);
  end;
  // End of Cycle 2.0

  closeFile(myFile);

  // finding the lowest length of string
  findMin(arrayOfLength, theLowest);

  // Cycle 3.0
  (*
    finding all length which are equal to the lowest
    and counting the length of array of signs
  *)
  signLength := 0;
  for i := 0 to high(arrayOfLength) do
  begin
    if arrayOfLength[i] = theLowest then
    begin
      inc(signLength);
    end;
  end;
  // End of Cycle 3.0

  setLength(arrayOfSigns, signLength);

  // Cycle 4.0
  (*
    finding indexes of strings with the lowest
    length and putting them in the array of signs
  *)
  k := 0;
  for i := 0 to high(arrayOfLength) do
  begin
    if arrayOfLength[i] = theLowest then
    begin
      arrayOfSigns[k] := i;
      inc(k);
    end;
  end;
  // End of Cycle 4.0

  writeln;
  reset(myFile);

  // Cycle 5.0
  (*
    printing all strings according to array of indexes
  *)
  k := 0;
  i := 0;
  writeln('-->Smallest sentences<--');
  while not EoF(myFile) do
  begin

    // Cycle 5.1
    (*
      filling string with chars from file
    *)
    while not EoLn(myFile) do
    begin
      read(myFile, myChar);
      inputString := inputString + myChar;
    end;
    // End of Cycle 5.1

    if k = arrayOfSigns[i] then
    begin
      writeln(inputString);
      inc(i);
    end;
    inc(k);
    inputString := '';
    readln(myFile);
  end;
  // End of Cycle 5.0

  closeFile(myFile);

end;


begin

  doReadFile(myFile, arrayOfInteger);
  writeln;
  writeln(FINAL_MESSAGE);

readln;
end.
