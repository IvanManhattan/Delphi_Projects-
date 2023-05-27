unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, CompanyClass, EmployeeClass, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.StdCtrls, UnitCompanyForm, System.Actions, Vcl.ActnList, DAOCompanies, DAOEmployees;

type
  TFormMain = class(TForm)
    PanelTop: TPanel;
    PanelBottom: TPanel;
    PanelCentral: TPanel;
    ScrollBoxCompanies: TScrollBox;
    PanelControlCompanies: TPanel;
    ButtonAddEmployee: TButton;
    Edit1: TEdit;
    Button1: TButton;
    ButtonViewCompanies: TButton;
//    procedure Button1Click(Sender: TObject);
//    procedure Button2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ButtonViewCompaniesClick(Sender: TObject);
  private

  public

  end;

var
  FormMain: TFormMain;

implementation

uses
  IniFiles, ShellAPI;
{$R *.dfm}

var
  pointerOf: PPointerCompanies;
  MyPointer: PPointerEmployees;



(*  procedure TFormMain.Button1Click(Sender: TObject);
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
*)

  procedure TFormMain.Button1Click(Sender: TObject);
  begin
    MyPointer := DAOEmployees_InitList;
    MyPointer := MyPointer^.next;
    Edit1.Text := floatToStr(MyPointer^.employeeFromList.minSalary);
  end;

  procedure TFormMain.ButtonViewCompaniesClick(Sender: TObject);
  begin
    FormEmployeesList.Show;
  end;

  procedure TFormMain.FormCreate(Sender: TObject);
  var
    FileName: String;
    iniSettings: TMemIniFile;
    tmpPanel: TPanel;
    currEmployee: PPointerEmployees;
    topCoord: Integer;

  begin
    Caption := Application.Title;

    FileName := ExtractFilePath(Application.ExeName) + 'settings.ini';
    iniSettings := TMemIniFile.Create(FileName);
    try
      Left := iniSettings.ReadInteger('Window', 'Left', 0);
      Top := iniSettings.ReadInteger('Window', 'Top', 0);
      Width := iniSettings.ReadInteger('Window', 'Width', 0);
      Height := iniSettings.ReadInteger('Window', 'Height', 0);
    finally
      iniSettings.Free;
    end;

    DAOEmployees_initList;
    currEmployee := getListOfEmployees;
    currEmployee := currEmployee^.next;
    topCoord := 0;

    while currEmployee <> nil do
    begin
      tmpPanel := TPanel.Create(ScrollBoxCompanies);
      tmpPanel.Parent	:= ScrollBoxCompanies;
      tmpPanel.Caption := 'Hello there';
      tmpPanel.Width := ScrollBoxCompanies.Width - 200;
      tmpPanel.Height	:= 150;
      tmpPanel.Left	:= (ScrollBoxCompanies.Width - tmpPanel.Width) div 3;
      tmpPanel.Top := topCoord + 50;
      topCoord := topCoord + 50;
      currEmployee := currEmployee^.next;
    end;


  end;

  procedure TFormMain.FormDestroy(Sender: TObject);
  var
    FileName: String;
    iniSettings: TMemIniFile;
  begin
    FileName := ExtractFilePath(Application.ExeName) + 'settings.ini';
  iniSettings := TMemIniFile.Create(FileName);
    try
      iniSettings.WriteInteger('Window', 'Left', Left);
      iniSettings.WriteInteger('Window', 'Top', Top);
      iniSettings.WriteInteger('Window', 'Width', Width);
      iniSettings.WriteInteger('Window', 'Height', Height);
      iniSettings.UpdateFile;
    finally
      iniSettings.Free;
    end;
  end;



end.
