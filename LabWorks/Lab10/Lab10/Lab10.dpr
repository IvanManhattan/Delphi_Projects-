Program Lab10;

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
  arrayOfString: TMyString;
  arrayOfLength: TMyInteger;
  theLowestLength: Integer;

// Declairing const values
const
  FINAL_MESSAGE = 'Press any button to terminate...';
  FILE_PATH = 'E:\Delphi2023\DelphiLabs\Labs\Delphi_Projects-\LabWorks\Lab10\Lab10\MyTextFile.txt';


// Subprogram for printing strings
(*
  requires - var of TMyString type
  prints all strings from var
*)
procedure doPrintString(const arrayOfString: TMyString);

// Variable declaration section
var
  i: Integer;
(*
  i - cycle counter
*)

begin
  for i := 0 to high(arrayOfString) do
    writeln(arrayOfString[i]);
end;

// Subprogram for finding length
(*
  requires - var of TMyString type, var of TMyInteger
  finds length of each element from var of TMyString in var of TMyInteger
*)
procedure doFindLength(const arrayOfString: TMyString; var arrayOfLength: TMyInteger);

// Variable declaration section
var
  i: Integer;
(*
  i - cycle counter
*)

begin

  setLength(arrayOfLength, length(arrayOfString));

  for i := 0 to high(arrayOfString) do
  begin
    arrayOfLength[i] := length(arrayOfString[i]);
  end;

end;

// Subprogram for reading file
(*
  requires - var of TextFile, var of TMyString
  reads var of TextFile and puts all strings in var of TMyString
*)
procedure doReadFile(var myFile: TextFile; var arrayOfString: TMyString);

// Variable declaration section
var
  inputString: String;
  myChar: Char;
  currentString: Integer;
  i: Integer;
(*
  inputString - temp string to write down a data from file
  myChar - current char
  currentString - cycle counter
  i - cycle counter
*)

begin
  currentString := 0;
  assignFile(myFile, FILE_PATH);
  reset(myFile);
  setLength(arrayOfString, 35);

  //check the file procedure where find length for array
  while not EoF(myFile) do
  begin
    while not EoLn(myFile) do
    begin
      read(myFile, myChar);
      inputString := inputString + myChar;
    end;
    arrayOfString[currentString] := inputString;
    inc(currentString);
    inputString := '';
    readln(myFile);
  end;

  doPrintString(arrayOfString);
//  writeln('Done!');

  closeFile(myFile);

end;

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
(*
  temp - temporary var for comparison
  i - cycle counter
*)

begin
  theLowest := arrayOf[0];

  for i := 0 to high(arrayof) do
  begin
    if arrayOf[i] < theLowest then
      theLowest := arrayOf[i];
  end;
end;

// Subprogram for printing strings
(*
  requires - var of arrayOfString, var of Integer
  compares length of each element with the var of Integer
  and prints it if the are equal
*)
procedure printLowest(const arrayOfString: TMyString; const theLowestLength: Integer);

// Variable declaration section
var
  i: Integer;
(*
  i - cycle counter
*)
begin
  for i := 0 to high(arrayOfString) do
  begin
    if length(arrayOfString[i]) = theLowestLength then
      writeln(arrayOfString[i]);
  end;
end;

// Start of program
begin
  writeln('-->File contains the following text<--');
  doReadFile(myFile, arrayOfString);
  doFindLength(arrayOfString, arrayOfLength);
  findMin(arrayOfLength, theLowestLength);
  writeln;
  writeln('-->Smallest sentences<--');
  printLowest(arrayOfString, theLowestLength);

  writeln;
  writeln(FINAL_MESSAGE);

readln;
end.
