unit DAOEmployees;

interface

uses
  EmployeeClass, SysUtils, Forms;

type
  TOnModelChanged = procedure of object;
  PPointerEmployees = ^TListOfEmployees;
  TListOfEmployees = record
    employeeFromList: TEmployee;
    next: PPointerEmployees;
  end;

  function DAOEmployees_initList: PPointerEmployees;
  function getListOfEmployees: PPointerEmployees;
  procedure DAOEmploees_saveList;
  procedure DAOEmployees_AddEmployee(Employee: TEmployee);
  procedure DAOEmployees_DeleteEmployee(Employee: TEmployee);
  function getEmployeeAge(employee: TEmployee): Word;

implementation

uses
  IniFiles, ShellAPI;

var
  typedEmployeeFile: File of TListOfEmployees;
  listOfEmployees: PPointerEmployees;
  employee: TEmployee;
  numberOfEmployees: Integer;


  function DAOEmployees_initList: PPointerEmployees;
  var
    fileName: String;
    iniEmployees: TMemIniFile;
    listOfGo, listTemp: PPointerEmployees;
    currCompany: TEmployee;
    i: Integer;
  begin

    fileName := ExtractFilePath(Application.ExeName) + 'listOfEmployees.ini';
    iniEmployees := TMemIniFile.Create(fileName);

    numberOfEmployees := iniEmployees.ReadInteger('Number', 'Number', 0);
    new(listOfGo);
    listOfEmployees := listOfGo;


    try
      for i := 1 to numberOfEmployees do
      begin
        new(listOfGo^.next);
        listOfGo := listOfGo^.next;

        listOfGo^.employeeFromList := TEmployee.Create;
        listOfGo^.employeeFromList.fullName :=
          iniEmployees.ReadString('Employee' + intToStr(i), 'FullName', 'null');
        listOfGo^.employeeFromList.dateOfBirth :=
          iniEmployees.ReadDate('Employee' + intToStr(i), 'DateOfBirth', 0);
        listOfGo^.employeeFromList.specialityOf :=
          iniEmployees.ReadString('Employee' + intToStr(i), 'Speciality', 'null');
        listOfGo^.employeeFromList.preferredPosition :=
          iniEmployees.ReadString('Employee' + intToStr(i), 'Position', 'null');
        listOfGo^.employeeFromList.minSalary :=
          iniEmployees.ReadFloat('Employee' + intToStr(i), 'Salary', 0.0);
        if iniEmployees.ReadString('Employee' + intToStr(i), 'HigherEducation', 'null') = 'Yes' then
        begin
          listOfGo^.employeeFromList.hasHigherEducation := true;
        end
        else
        begin
          listOfGo^.employeeFromList.hasHigherEducation := false;
        end;
      end;
      finally
        iniEmployees.Free;
    end;

    listOfGo^.next := nil;

    result := listOfEmployees;

  end;

  procedure DAOEmploees_saveList;
  var
    fileName: String;
    iniEmployees: TMemIniFile;
    listOfGo, listTemp: PPointerEmployees;
    currCompany: TEmployee;
    i: Integer;
  begin

    fileName := ExtractFilePath(Application.ExeName) + 'listOfEmployees.ini';
    iniEmployees := TMemIniFile.Create(fileName);

    iniEmployees.WriteInteger('Companies', 'Number', numberOfEmployees);
    listOfGo := listOfEmployees;
    listOfGo := listOfGo^.next;
    i := 1;

    while listOfGo <> nil do
    begin
      try
        iniEmployees.WriteString('Employee' + intToStr(i), 'FullName', listOfGo^.employeeFromList.fullName);
        iniEmployees.WriteDate('Employee' + intToStr(i), 'FullName', listOfGo^.employeeFromList.dateOfBirth);
        iniEmployees.WriteString('Employee' + intToStr(i), 'FullName', listOfGo^.employeeFromList.specialityOf);
        iniEmployees.WriteBool('Employee' + intToStr(i), 'FullName', listOfGo^.employeeFromList.hasHigherEducation);
        iniEmployees.WriteString('Employee' + intToStr(i), 'FullName', listOfGo^.employeeFromList.preferredPosition);
        iniEmployees.WriteFloat('Employee' + intToStr(i), 'FullName', listOfGO^.employeeFromList.minSalary);
        listOfGo := listOfGo^.next;
        iniEmployees.UpdateFile;
        inc(i);
      finally
        iniEmployees.Free;
      end;

    end;



  end;

  function getListOfEmployees: PPointerEmployees;
  begin
    result := listOfEmployees;
  end;

  procedure DAOEmployees_AddEmployee(Employee: TEmployee);
  var
    currEmployee: PPointerEmployees;
  begin
    currEmployee := listOfEmployees;

    while currEmployee^.next <> nil do
    begin
      currEmployee := currEmployee^.next;
    end;

    new(currEmployee^.next);
    currEmployee := currEmployee^.next;
    currEmployee^.employeeFromList := Employee;
    currEmployee^.next	:= nil;


  end;

  procedure DAOEmployees_DeleteEmployee(Employee: TEmployee);
  var
    currEmployeeX, currEmployeeY: PPointerEmployees;
  begin
    currEmployeeX := listOfEmployees;
    currEmployeeX := currEmployeeX^.next;
    currEmployeeY := currEmployeeX;

    while currEmployeeX.employeeFromList <> Employee do
    begin
      currEmployeeX := currEmployeeX^.next;
    end;

    if currEmployeeX <> currEmployeeY then
    begin
      while currEmployeeY^.next.employeeFromList <> Employee do
      begin
        currEmployeeY := currEmployeeY^.next;
      end;
      currEmployeeX := currEmployeeY^.next;
      currEmployeeY^.next := currEmployeeY^.next.next;
    end
    else
    begin
      listOfEmployees^.next := currEmployeeX^.next;
      currEmployeeX^.next := nil;
    end;

    FreeAndNil(currEmployeeX^.employeeFromList);

  end;

  function getEmployeeAge(employee: TEmployee): Word;
  var
    birthYear, birthMonth, birthDay, currYear, currMonth, currDay, res: Word;
  begin
    decodeDate(Date, currYear, currMonth, currDay);
    decodeDate(employee.dateOfBirth, birthYear, birthMonth, birthDay);

    if (currYear = birthYear) and (currMonth = birthMonth) and (currDay = birthDay) then
    begin
      result := 0;
    end
    else
    begin
      result := currYear - birthYear;
      if birthMonth > currMonth then
      begin
        dec(result);
      end
      else
      begin
        if currMonth = birthMonth then
        begin
          if birthDay > currDay then
          begin
            dec(result);
          end;
        end;
      end;
    end;
  end;

end.
