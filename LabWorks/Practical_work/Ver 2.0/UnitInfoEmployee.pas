unit UnitInfoEmployee;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls,
  System.Actions, Vcl.ActnList, EmployeeClass, uSearch, DAOEmployees;

type
  TOnModelChanged = procedure of object;
  TFormEmployeeInfo = class(TForm)
    PanelMainInfo: TPanel;
    EditName: TEdit;
    EditSpeciality: TEdit;
    EditPosition: TEdit;
    EditAge: TEdit;
    EditSalary: TEdit;
    EditHigherEdu: TEdit;
    PanelListOfSugg: TPanel;
    listOfSugg: TListView;
    ActionListSugg: TActionList;
    ActionStrictSearch: TAction;
    Button1: TButton;
    Button2: TButton;
    ActionCommonSearch: TAction;
    procedure FormCreate(Sender: TObject);
    function ShowForEmployee(var currEmployee: TEmployee): TModalResult;
    procedure ActionStrictSearchExecute(Sender: TObject);
    procedure UpdateListOfSuggestions;
    procedure ActionListSuggUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure ActionCommonSearchExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormEmployeeInfo: TFormEmployeeInfo;

implementation

uses
  IniFiles, ShellAPI;
{$R *.dfm}

var
  employee: TEmployee;

  procedure TFormEmployeeInfo.ActionCommonSearchExecute(Sender: TObject);
  begin
    listOfSugg.SetFocus;
    uSearch_SetCallback(UpdateListOfSuggestions);
    uSearch_findSuggCompanies(employee);
    UpdateListOfSuggestions;
  end;

  procedure TFormEmployeeInfo.ActionListSuggUpdate(Action: TBasicAction;
  var Handled: Boolean);
  begin
    ActionStrictSearch.Enabled := true;
  end;

  procedure TFormEmployeeInfo.ActionStrictSearchExecute(Sender: TObject);
  var
    pointerOfSugg: PPointerSuggCompanies;
  begin
    listOfSugg.SetFocus;
    uSearch_SetCallback(UpdateListOfSuggestions);
    uSearch_findSuggCompaniesStrict(employee);
    UpdateListOfSuggestions;

  end;

  procedure TFormEmployeeInfo.FormCreate(Sender: TObject);
  var
    FileName: String;
    iniSettings: TMemIniFile;
  begin
    FileName := ExtractFilePath(Application.ExeName) + 'settings.ini';
    iniSettings := TMemIniFile.Create(FileName);
    try
      Left := iniSettings.ReadInteger('Window', 'Left', 0) + 30;
      Top := iniSettings.ReadInteger('Window', 'Top', 0) + 30;
    finally
      iniSettings.Free;
    end;
  end;

  function TFormEmployeeInfo.ShowForEmployee(var currEmployee: TEmployee): TModalResult;
  var
    currDate: TDate;

  begin
    employee := currEmployee;
    currDate := Date;
    EditName.Text	:= currEmployee.fullName;
    EditSpeciality.Text	:= currEmployee.specialityOf;
    EditPosition.Text	:= currEmployee.preferredPosition;
    EditAge.Text := intToStr(getEmployeeAge(currEmployee));

    if currEmployee.hasHigherEducation = true then
    begin
      EditHigherEdu.Text := 'Yes';
    end
    else
    begin
      EditHigherEdu.Text := 'No';
    end;

    Result := ShowModal;
  end;

  procedure TFormEmployeeInfo.UpdateListOfSuggestions;
  var
    currSugg: PPointerSuggCompanies;
    Item: TListItem;
  begin
    currSugg := uSearch_getListOfSuggestions;
    currSugg := currSugg^.next;

    listOfSugg.Items.Clear;

    while currSugg <> nil do
    begin
      Item := listOfSugg.Items.Add;
      Item.Caption := currSugg.suggCompany.nameOfCompany;
      Item.SubItems.Add(currSugg.suggCompany.positionName);
      Item.SubItems.Add(floatToStr(currSugg.suggCompany.salary));
      Item.SubItems.Add(intToStr(currSugg.suggCompany.daysOfVacation));
      if currSugg.suggCompany.needsHigherEducation = true then
      begin
        Item.SubItems.Add('Yes');
      end
      else begin
        Item.SubItems.Add('No');
      end;
      currSugg := currSugg^.next;
    end;

  end;


end.
