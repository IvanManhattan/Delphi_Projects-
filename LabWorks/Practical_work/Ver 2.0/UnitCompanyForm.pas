unit UnitCompanyForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, DAOCompanies, CompanyClass;

type
  TFormEmployeesList = class(TForm)
    PanelMain: TPanel;
    PanelControlEmployees: TPanel;
    editEmployee: TButton;
    deleteEmployee: TButton;
    ActionListCompanies: TActionList;
    ActionAddNewCompany: TAction;
    addEmployee: TButton;
    ActionEditCompany: TAction;
    ActionDeleteCompany: TAction;
    listOfCompanies: TListView;
    procedure ActionAddNewCompanyExecute(Sender: TObject);
    procedure ActionListCompaniesUpdate(Action: TBasicAction;
      var Handled: Boolean);
    procedure UpdateList;
    procedure FormCreate(Sender: TObject);
    procedure ActionDeleteCompanyExecute(Sender: TObject);
    procedure ActionEditCompanyExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormEmployeesList: TFormEmployeesList;

implementation

uses
  IniFiles, ShellAPI;
{$R *.dfm}

  procedure TFormEmployeesList.FormCreate(Sender: TObject);
  var
    FileName: String;
    iniSettings: TMemIniFile;
  begin
    FileName := ExtractFilePath(Application.ExeName) + 'settingsCompany.ini';
    iniSettings := TMemIniFile.Create(FileName);
    try
      Left := iniSettings.ReadInteger('Form', 'Left', 0);
      Top := iniSettings.ReadInteger('Form', 'Top', 0);
//      Width := iniSettings.ReadInteger('Window', 'Width', 0);
//      Height := iniSettings.ReadInteger('Window', 'Height', 0);
    finally
      iniSettings.Free;
    end;

    TaskList_SetCallback(UpdateList);
    DAOCompanies_initList;
    UpdateList;
  end;

  procedure TFormEmployeesList.ActionAddNewCompanyExecute(Sender: TObject);
  var
    Res: TModalResult;
  begin
    listOfCompanies.SetFocus;

  end;

  procedure TFormEmployeesList.ActionDeleteCompanyExecute(Sender: TObject);
  begin
    listOfCompanies.SetFocus;
  end;

  procedure TFormEmployeesList.ActionEditCompanyExecute(Sender: TObject);
  begin
    listOfCompanies.SetFocus;
  end;

  procedure TFormEmployeesList.ActionListCompaniesUpdate(Action: TBasicAction; var Handled: Boolean);
  begin
    ActionAddNewCompany.Enabled := True;
    ActionEditCompany.Enabled := listOfCompanies.ItemIndex >= 0;
    ActionDeleteCompany.Enabled := listOfCompanies.ItemIndex >= 0;
  end;


  procedure TFormEmployeesList.UpdateList;
  var
    i: Integer;
    Companies: PPointerCompanies;
    currCompany: TCompany;
    Item: TListItem;
  begin
    Companies := getListOfCompanies;
    Companies := Companies^.next;
    listOfCompanies.Items.Clear;

    while Companies <> nil do
    begin
      currCompany := Companies^.companyFromList;
      Item := listOfCompanies.Items.Add;
      Item.Caption := currCompany.nameOfCompany;
      Item.SubItems.Add(currCompany.nameOfSpeciality);
      Item.SubItems.Add(currCompany.positionName);
      Item.SubItems.Add(FloatToStr(currCompany.salary));
      Item.SubItems.Add(intToStr(currCompany.daysOfVacation));
      if currCompany.needsHigherEducation = true then
      begin
        Item.SubItems.Add('Yes');
      end
      else begin
        Item.SubItems.Add('No');
      end;

      Item.SubItems.Add(intToStr(currCompany.minAge));
      Item.SubItems.Add(intToStr(currCompany.maxAge));

      Companies := Companies^.next;

    end;

  end;

end.
