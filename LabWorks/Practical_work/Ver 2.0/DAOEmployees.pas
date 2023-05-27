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
        listOfGo^.employeeFromList.hasHigherEducation :=
          iniEmployees.ReadBool('Employee' + intToStr(i), 'HigherEducation', False);
        listOfGo^.employeeFromList.preferredPosition :=
          iniEmployees.ReadString('Employee' + intToStr(i), 'Position', 'null');
        listOfGo^.employeeFromList.minSalary :=
          iniEmployees.ReadFloat('Employee' + intToStr(i), 'Salary', 0.0);
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
  
end.
