unit Restaraunt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    ListOfDishes: TListBox;
    Panel3: TPanel;
    procedure doShowTheMostPopular(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.doShowTheMostPopular(Sender: TObject);
begin
  ListOfDishes.Items.Add('Hello world!');
end;


end.
