program Project1;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Objects;

var
  str: String;
  strNew: String;

procedure MyProcedure(var s1: String);
var
  p1, p2: Person;
  s: String;
begin
  p1 := Person.createPerson('Oleg', 32);
  s := p1.getName;
  writeln(s);
  p1.setName('Pasha');
  s := p1.getName;
  writeln(s);

end;


begin

  MyProcedure(str);


readln;

end.
