unit UnitCreateEmployee;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, EmployeeClass;

type
  TFormCreateEmployee = class(TForm)
    PanelMainCreateCompany: TPanel;
    LabelLogo: TLabel;
    EditName: TEdit;
    EditSpeciality: TEdit;
    EditPosition: TEdit;
    EditSalary: TEdit;
    EditDate: TEdit;
    EditHasHigherEducation: TEdit;
    ButtonCreate: TButton;
    ButtonCancel: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function ShowForNewEmployee(var employee: TEmployee): TModalResult;
    function ShowForEditEmployee(var employee: TEmployee): TModalResult;
  end;

var
  FormCreateEmployee: TFormCreateEmployee;

implementation

uses
  IniFiles, ShellAPI;
{$R *.dfm}


  function TFormCreateEmployee.ShowForNewEmployee(var employee: TEmployee): TModalResult;
  begin
    LabelLogo.Caption	:= 'Create Employee';

    EditName.Text := 'Name';
    EditSpeciality.Text	:= 'Speciality';
    EditPosition.Text	:= 'Position';
    EditSalary.Text	:= 'Salary';
    EditDate.Text	:= 'Date of birth';
    EditHasHigherEducation.Text	:= 'Education';

    Result := ShowModal;

    if Result = MrOk then
    begin
      Employee := TEmployee.Create;
      with Employee do
      begin
        fullName := EditName.Text;
        dateOfBirth := StrToDate(EditDate.Text);
        specialityOf := EditSpeciality.Text;
        preferredPosition := EditPosition.Text;
        minSalary := StrToFloat(EditSalary.Text);
        if length(EditHasHigherEducation.Text) > 0 then
        begin
          hasHigherEducation := True;
        end
        else
        begin
          hasHigherEducation := False;
        end;
      end;
    end;
  end;

  function TFormCreateEmployee.ShowForEditEmployee(var employee: TEmployee): TModalResult;
  begin
    LabelLogo.Caption	:= 'Edit Employee';

    EditName.Text := employee.fullName;
    EditSpeciality.Text	:= employee.specialityOf;
    EditPosition.Text	:= employee.preferredPosition;
    EditSalary.Text	:= FloatToStr(employee.minSalary);
    EditDate.Text	:= DateToStr(employee.dateOfBirth);
    if employee.hasHigherEducation = true then
    begin
      EditHasHigherEducation.Text := 'Yes';
    end
    else
    begin
      EditHasHigherEducation.Text := 'No';
    end;

    Result := ShowModal;
    if Result = mrOk then
    begin
      employee.fullName	:= EditName.Text;
      employee.specialityOf := EditSpeciality.Text;
      employee.preferredPosition := EditPosition.Text;
      employee.minSalary := StrToFloat(EditSalary.Text);
      employee.dateOfBirth := StrToDate(EditDate.Text);
      if length(EditHasHigherEducation.Text) > 0 then
      begin
        employee.hasHigherEducation := True;
      end
      else
      begin
        employee.hasHigherEducation := False;
      end;

    end;
  end;

  procedure TFormCreateEmployee.FormCreate(Sender: TObject);
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

end.
