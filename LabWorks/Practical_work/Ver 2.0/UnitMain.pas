unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitCompanyClass, Vcl.ComCtrls,
  Vcl.ExtCtrls, UnitDAO, Vcl.StdCtrls;

type
  TFormMain = class(TForm)
    PanelTop: TPanel;
    PanelBottom: TPanel;
    PanelCentral: TPanel;
    ListViewEmployees: TListView;
    ScrollBoxCompanies: TScrollBox;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Edit2: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation
uses
  IniFiles, ShellAPI;
{$R *.dfm}

var
  pointerOf: PPointerCompanies;

  procedure TFormMain.Button1Click(Sender: TObject);
  var
    myPointer: PPointerCompanies;
  begin
//    pointerOf := pointerOf^.next;
    pointerOf^.companyFromList.nameOfCompany := Edit1.Text;
    UnitDAO_saveList;
  end;

  procedure TFormMain.Button2Click(Sender: TObject);
  var
    myPointer: PPointerCompanies;
  begin
    pointerOf := UnitDAO_initList;
    pointerOf := pointerOf^.next;
//    myPointer := pointerOf;
    Edit2.Text := pointerOf^.companyFromList.nameOfCompany;
  end;

  end.
