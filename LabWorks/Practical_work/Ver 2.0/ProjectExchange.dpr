program ProjectExchange;

uses
  Vcl.Forms,
  UnitMain in 'UnitMain.pas' {FormMain},
  CompanyClass in 'CompanyClass.pas',
  DAOCompanies in 'DAOCompanies.pas',
  UnitCompanyForm in 'UnitCompanyForm.pas' {FormEmployeesList},
  EmployeeClass in 'EmployeeClass.pas',
  DAOEmployees in 'DAOEmployees.pas',
  UnitCreateCompany in 'UnitCreateCompany.pas' {FormCreateCompany},
  UnitCreateEmployee in 'UnitCreateEmployee.pas' {FormCreateEmployee},
  UnitInfoEmployee in 'UnitInfoEmployee.pas' {FormEmployeeInfo},
  uSearch in 'uSearch.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormEmployeesList, FormEmployeesList);
  Application.CreateForm(TFormCreateCompany, FormCreateCompany);
  Application.CreateForm(TFormCreateEmployee, FormCreateEmployee);
  Application.CreateForm(TFormEmployeeInfo, FormEmployeeInfo);
  Application.Run;
end.
