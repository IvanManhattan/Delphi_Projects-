program Lab11;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

type
  PPointer = ^TText;
  TText = record
    currentString: String;
    numberOf: Integer;
  end;

function doSeparateText(inputText: String; const divider: Integer): TText;
var
  buffString: String;
begin

end;

function doSearch(const Text: TText; var stringNum: Integer; var position: Integer;
                  const requiredChar: Char): Boolean;
var
  i: Integer;
begin

end;

procedure doDelete(var Text: TText; const stringNum: Integer);
begin

end;

procedure doReplaceBy(var Text: TText; const beReplaced: Integer;
                      const toReplace: Integer);
begin

end;

begin



end.
