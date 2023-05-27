unit CompanyClass;

interface

type
  TCompany = class
    private
      FNameOfCompany: String;
      FNameOfSpeciality: String;
      FPositionName: String;
      FSalary: Double;
      FDaysOfVacation: Integer;
      FNeedsHigherEducation: Boolean;
      FMinAge: Integer;
      FMaxAge: Integer;
      procedure setNameOfCompany(const nameOfCompany: String);
      function getNameOfCompany(): String;
      procedure setNameOfSpeciality(const nameOfSpeciality: String);
      function getNameOfSpeciality(): String;
      procedure setPositionName(const positionName: String);
      function getPositionName(): String;
      procedure setSalary(const salary: Double);
      function getSalary(): Double;
      procedure setDaysOfVacation(const daysOfVacation: Integer);
      function getDaysOfVacation(): Integer;
      procedure setMinAge(const minAge: Integer);
      function getMinAge(): Integer;
      procedure setMaxAge(const maxAge: Integer);
      function getMaxAge(): Integer;
      procedure setNeedsHigherEducation(const needsHigherEducation: Boolean);
      function getNeedsHigherEducation(): Boolean;
    public
      property nameOfCompany: String read getNameOfCompany write setNameOfCompany;
      property nameOfSpeciality: String read getNameOfSpeciality write setNameOfSpeciality;
      property positionName: String read getPositionName write setPositionName;
      property salary: Double read getSalary write setSalary;
      property daysOfVacation: Integer read getDaysOfVacation write setDaysOfVacation;
      property minAge: Integer read getMinAge write setMinAge;
      property maxAge: Integer read getMaxAge write setMaxAge;
      property needsHigherEducation: Boolean read getNeedsHigherEducation write setNeedsHigherEducation;
  end;

implementation

  procedure TCompany.setNameOfCompany(const nameOfCompany: String);
  begin
    FNameOfCompany := nameOfCompany;
  end;

  function TCompany.getNameOfCompany: String;
  begin
    result := FNameOfCompany;
  end;

  procedure TCompany.setNameOfSpeciality(const nameOfSpeciality: String);
  begin
    FNameOfSpeciality := nameOfSpeciality;
  end;

  function TCompany.getNameOfSpeciality: string;
  begin
    result := FNameOfSpeciality;
  end;

  procedure TCompany.setPositionName(const positionName: String);
  begin
    FPositionName := positionName;
  end;

  function TCompany.getPositionName: String;
  begin
    result := FPositionName;
  end;

  procedure TCompany.setSalary(const salary: Double);
  begin
    FSalary := salary;
  end;

  function TCompany.getSalary: Double;
  begin
    result := FSalary;
  end;

  procedure TCompany.setDaysOfVacation(const daysOfVacation: Integer);
  begin
    FDaysOfVacation := daysOfVacation;
  end;

  function TCompany.getDaysOfVacation: Integer;
  begin
    result := FDaysOfVacation;
  end;

  procedure TCompany.setMinAge(const minAge: Integer);
  begin
    FMinAge := minAge;
  end;

  function TCompany.getMinAge(): Integer;
  begin
    result := FMinAge;
  end;

  procedure TCompany.setMaxAge(const maxAge: Integer);
  begin
    FMaxAge := maxAge;
  end;

  function TCompany.getMaxAge(): Integer;
  begin
    result := FMaxAge;
  end;

  procedure TCompany.setNeedsHigherEducation(const needsHigherEducation: Boolean);
  begin
    FNeedsHigherEducation := needsHigherEducation;
  end;

  function TCompany.getNeedsHigherEducation(): Boolean;
  begin
    result := FNeedsHigherEducation;
  end;

end.

