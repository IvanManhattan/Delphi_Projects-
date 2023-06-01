program ProjectExchange;

uses
  Vcl.Forms,
  UnitMain in 'UnitMain.pas' {FormMain},
  CompanyClass in 'CompanyClass.pas',
  DAOCompanies in 'DAOCompanies.pas',
  UnitCompanyForm in 'UnitCompanyForm.pas' {FormEmployeesList},
  EmployeeClass in 'EmployeeClass.pas',
  DAOEmployees in 'DAOEmployees.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormEmployeesList, FormEmployeesList);
  Application.Run;
end.
