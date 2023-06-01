unit UnitCompanyForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, DAOCompanies, CompanyClass, UnitCreateCompany, uSearch;

type
  TFormEmployeesList = class(TForm)
    PanelMain: TPanel;
    PanelControlEmployees: TPanel;
    editCompany: TButton;
    deleteCompany: TButton;
    ActionListCompanies: TActionList;
    ActionAddNewCompany: TAction;
    addCompany: TButton;
    ActionEditCompany: TAction;
    ActionDeleteCompany: TAction;
    listOfCompanies: TListView;
    ButtonDeficitSpecialities: TButton;
    ActionDeficitSpecialities: TAction;
    Button1: TButton;
    ActionNoCandidates: TAction;
    ButtonGetBack: TButton;
    ActionGetBack: TAction;
    procedure ActionAddNewCompanyExecute(Sender: TObject);
    procedure ActionListCompaniesUpdate(Action: TBasicAction;
      var Handled: Boolean);
    procedure UpdateList;
    procedure UpdateDeficitList;
    procedure UpdateNoCandidatesList;
    procedure FormCreate(Sender: TObject);
    procedure ActionDeleteCompanyExecute(Sender: TObject);
    procedure ActionEditCompanyExecute(Sender: TObject);
    procedure ActionDeficitSpecialitiesExecute(Sender: TObject);
    procedure ActionNoCandidatesExecute(Sender: TObject);
    procedure ActionGetBackExecute(Sender: TObject);
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

    DAOCompaniesList_SetCallback(UpdateList);
    DAOCompanies_initList;
    UpdateList;
  end;

  procedure TFormEmployeesList.ActionAddNewCompanyExecute(Sender: TObject);
  var
    Res: TModalResult;
    Company: TCompany;
    listOfComp: PPointerCompanies;
  begin
    listOfCompanies.SetFocus;

    Res := formCreateCompany.ShowForNewCompany(Company);
    if Res = MrCancel then
      Exit;

    DAOCompaniesList_AddCompany(Company);

  end;

  procedure TFormEmployeesList.ActionDeficitSpecialitiesExecute(Sender: TObject);
  var
    Res: TModalResult;
    Company: TCompany;
    listOfComp: PPointerCompanies;
  begin
    listOfCompanies.SetFocus;
    listOfComp := uSearch_deficitSpecialities;
    DAOCompaniesList_SetCallback(UpdateDeficitList);
    UpdateDeficitList;
  end;

  procedure TFormEmployeesList.ActionDeleteCompanyExecute(Sender: TObject);
  var
    company: TCompany;
  begin
    listOfCompanies.SetFocus;
    DAOCompanies_GetItem(listOfCompanies.ItemIndex, Company);
    DAOCompanies_DeleteCompany(Company);
  end;

  procedure TFormEmployeesList.ActionEditCompanyExecute(Sender: TObject);
  var
    Res: TModalResult;
    Company: TCompany;

  begin
    listOfCompanies.SetFocus;

    DAOCompanies_GetItem(listOfCompanies.ItemIndex, Company);
    Res := formCreateCompany.ShowForEditCompany(Company);
    if Res = MrCancel then
      Exit;

    DAOCompanies_SetItem(listOfCompanies.ItemIndex, Company);

  end;

  procedure TFormEmployeesList.ActionGetBackExecute(Sender: TObject);
  begin
    DAOCompaniesList_SetCallback(UpdateList);
    UpdateList;
  end;

procedure TFormEmployeesList.ActionListCompaniesUpdate(Action: TBasicAction; var Handled: Boolean);
  begin
    ActionAddNewCompany.Enabled := True;
    ActionEditCompany.Enabled := listOfCompanies.ItemIndex >= 0;
    ActionDeleteCompany.Enabled := listOfCompanies.ItemIndex >= 0;
  end;


  procedure TFormEmployeesList.ActionNoCandidatesExecute(Sender: TObject);
  var
    Res: TModalResult;
    Company: TCompany;
    listOfComp: PPointerCompanies;
  begin
    listOfCompanies.SetFocus;
    listOfComp := uSearch_noCandidates;
    DAOCompaniesList_SetCallback(UpdateNoCandidatesList);
    UpdateNoCandidatesList;
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

  procedure TFormEmployeesList.UpdateDeficitList;
  var
    i: Integer;
    Companies: PPointerCompanies;
    currCompany: TCompany;
    Item: TListItem;
  begin
    Companies := uSearch_getListOfDeficitSpec;
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

  procedure TFormEmployeesList.UpdateNoCandidatesList;
  var
    i: Integer;
    Companies: PPointerCompanies;
    currCompany: TCompany;
    Item: TListItem;
  begin
    Companies := uSearch_getListOfNoCandidates;
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
