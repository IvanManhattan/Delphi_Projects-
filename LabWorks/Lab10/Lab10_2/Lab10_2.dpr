program Lab10_2;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

type
  TMyString = array of String;
  TMyInteger = array of Integer;

var
  myFile: TextFile;
  arrayOfInteger: TMyInteger;
  arrayOfLength: TMyInteger;
  theLowestLength: Integer;

const
  FINAL_MESSAGE = 'Press any button to terminate...';
  FILE_PATH = 'E:\Delphi2023\DelphiLabs\Labs\Delphi_Projects-\LabWorks\Lab10\Lab10_2\MyTextFile.txt';

procedure findMin(const arrayOf: TMyInteger; var theLowest: Integer);
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

procedure doReadFile(var myFile: TextFile; var arrayOfLength: TMyInteger);
var
  inputString: String;
  myChar: Char;
  currentString: Integer;
  i, k: Integer;
  buffLength: Integer;
  theLowest: Integer;
  arrayOfSigns: TMyInteger;
  signLength: Integer;

begin
  currentString := 0;
  inputString := '';
  assignFile(myFile, FILE_PATH);
  buffLength := 0;
  i := 0;

  writeln('-->File contains the following text<--');
  reset(myFile);
  while not EoF(myFile) do
  begin
    while not EoLn(myFile) do
    begin
      read(myFile, myChar);
      inputString := inputString + myChar;
    end;
    writeln(inputString);
    inputString := '';
    readln(myFile);
    inc(i);

  end;
  closeFile(myFile);

  setLength(arrayOfLength, i);

  reset(myFile);
  while not EoF(myFile) do
  begin
    while not EoLn(myFile) do
    begin
      read(myFile, myChar);
      inc(buffLength);
    end;
    readln(myFile);
    arrayOfLength[currentString] := buffLength;
    buffLength := 0;
    inc(currentString);
  end;
  closeFile(myFile);

  findMin(arrayOfLength, theLowest);
  signLength := 0;
  
  for i := 0 to high(arrayOfLength) do
  begin
    if arrayOfLength[i] = theLowest then
    begin
      inc(signLength);
    end;
  end;

  setLength(arrayOfSigns, signLength);
  
  k := 0;
  for i := 0 to high(arrayOfLength) do
  begin
    if arrayOfLength[i] = theLowest then
    begin
      arrayOfSigns[k] := i;
      inc(k);
    end;
  end;

  writeln;
  reset(myFile);
  
  k := 0;
  i := 0;
  writeln('-->Smallest sentences<--');
  while not EoF(myFile) do
  begin
    while not EoLn(myFile) do
    begin
      read(myFile, myChar);
      inputString := inputString + myChar;
    end;
    if k = arrayOfSigns[i] then
    begin
      writeln(inputString);
      inc(i);   
    end;
    inc(k);
    inputString := '';
    readln(myFile);
  end;

  closeFile(myFile);

end;


begin

  doReadFile(myFile, arrayOfInteger);
  writeln;
  writeln(FINAL_MESSAGE);

readln;
end.
