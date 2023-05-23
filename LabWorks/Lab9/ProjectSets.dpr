program ProjectSets;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils, Windows;

type
  TArr = Array[1..11] Of String;
  TSet = set of Char;

const
  ENTER_MESSAGE = 'Enter the string';
  ERROR_MESSAGE = 'Wrong input. Try again';
  FINAL_MESSAGE = 'Enter any button to terminate...';

var
  setOfMuteCons: TSet = ['к', 'п', 'с', 'т', 'ф', 'х', 'ц', 'ч', 'ш', 'щ'];
  setOfLetts: TSet;
  inputString: AnsiString;


procedure findLetters(var inputString: AnsiString);
var
  i, k: Integer;
  s: Char;
  arr: TArr;
  buffSet: TSet;
  resultSet: TSet;
begin
  i := 1;
  k := 1;
  buffSet := [];

(*
  while i < length(inputString) do
  begin
    while inputString[i] <> ',' do
    begin
      if inputString[i] <> '.' then
      begin
        include(buffSet, inputString[i]);
        inc(i);
      end;
    end;
    inc(i);
  end;
*)
  while i < length(inputString) do
  begin
    include(buffSet, inputString[i]);
    inc(i);

    if (inputString[i] = ',') or (inputString[i] = '.') then
    begin
      resultSet := setOfMuteCons - buffSet;
      buffSet := [];
      if inputString[i] <> '.' then
        inc(i);
    end;

  end;


  for s := 'а' to 'я' do
  begin
    if s in resultSet then
    begin
      arr[k] := s;
      inc(k);
    end;
  end;

end;

begin
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);

  readln(inputString);
  findLetters(inputString);

  writeln(FINAL_MESSAGE);
readln;
end.
