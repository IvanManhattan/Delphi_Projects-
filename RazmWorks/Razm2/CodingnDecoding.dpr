program CodingnDecoding;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

type
  TMatrix = array of array of Char;

var
  inputLine: String;

const
  FINAL_MESSAGE = 'Press any button to terminate...';

procedure enterTheString(var S: String);
begin
  Writeln('Enter the string...');
  readln(S);
end;

procedure showInfo();
begin
  writeln('"1" - enter the string');
  writeln('"2" - read a file');
  writeln('"3" - decode a text from file');
  writeln('"4" - exit');
  writeln('------------------------------------');
end;

procedure doChoice();
var
  number: Integer;
  choice: Boolean;
begin
  choice := true;
  repeat

    writeln('Which action you want to execute?');
    showInfo;
    readln(number);
    case number of
      1:
        enterTheString(inputLine);
      2:
        writeln('reading a file...');
      3:
        writeln('Decoding...');
      4:
        choice := false;
    end;

  until choice = false;
end;

procedure codeString(const S: String; var codedMatrix: TMatrix);
var
  i, j: Integer;
  lengthOf: Integer;
begin
  lengthOf := round(sqrt(length(S)));
  setLength(codedMatrix, lengthOf, lengthOf);



end;

begin
  doChoice;


  writeln(FINAL_MESSAGE);
readln;
end.
