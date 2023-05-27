unit EmployeeClass;

interface

type

  TEmployee = class
    private
      FFullName: String;
      FDateOfBirth: TDateTime;
      FSpeciality: String;
      FHasHigherEducation: Boolean;
      FPreferredPosition: String;
      FMinSalary: Double;
//     FID: Integer;
      procedure setFullName(const name: String);
      function getFullName(): String;
      procedure setDateOfBirth(const date: TDateTime);
      function getDateOfBirth(): TDateTime ;
      procedure setSpeciality(const speciality: String);
      function getSpeciality(): String;
      procedure settHasHigherEducation(const higherEdu: Boolean);
      function getHasHigherEducation(): Boolean;
      procedure setPreferredPostion(const position: String);
      function getPreferredPosition(): String;
      procedure setMinSalary(const salary: Double);
      function getMinSalary(): Double;
//      procedure setID(const ID: Integer);
//      function getID(): Integer;
    public
      property fullName: String read getFullName write setFullName;
      property dateOfBirth: TDateTime read getDateOfBirth write setDateOfBirth;
      property specialityOf: String read getSpeciality write setSpeciality;
      property hasHigherEducation: Boolean read getHasHigherEducation write settHasHigherEducation;
      property preferredPosition: String read getPreferredPosition write setPreferredPostion;
      property minSalary: Double read getMinSalary write setMinSalary;
//      property ID: Integer read getID write setID;
  end;


implementation

  procedure TEmployee.setFullName(const name: string);
  begin
    FFullName := name;
  end;

  function TEmployee.getFullName: string;
  begin
    result := FFullName;
  end;

  procedure TEmployee.setDateOfBirth(const date: TDateTime);
  begin
    FDateOfBirth := date;
  end;

  function TEmployee.getDateOfBirth: TDateTime;
  begin
    result := FDateOfBirth;
  end;

  procedure TEmployee.setSpeciality(const speciality: string);
  begin
    FSpeciality := speciality;
  end;

  function TEmployee.getSpeciality: string;
  begin
    result := FSpeciality;
  end;

  procedure TEmployee.settHasHigherEducation(const higherEdu: Boolean);
  begin
    FHasHigherEducation := higherEdu;
  end;

  function TEmployee.getHasHigherEducation: Boolean;
  begin
    result := FHasHigherEducation;
  end;

  procedure TEmployee.setPreferredPostion(const position: string);
  begin
    FPreferredPosition := position;
  end;

  function TEmployee.getPreferredPosition: string;
  begin
    result := FPreferredPosition;
  end;

  procedure TEmployee.setMinSalary(const salary: Double);
  begin
    FMinSalary := salary;
  end;

  function TEmployee.getMinSalary: Double;
  begin
    result := FMinSalary;
  end;

(*  procedure TEmployee.setID(const ID: Integer);
  begin
    FID := ID;
  end;

  function TEmployee.getID: Integer;
  begin
    result := FID;
  end;
*)
end.
