unit DAOCompanies;


interface

uses
  CompanyClass, SysUtils, Forms;

type
  TOnModelChanged = procedure of object;
  PPointerCompanies = ^TListOfCompanies;
  TListOfCompanies = record
    companyFromList: TCompany;
    next: PPointerCompanies;
  end;

  function DAOCompanies_initList: PPointerCompanies;
  procedure DAOCompanies_saveList;
  function getListOfCompanies(): PPointerCompanies;
  procedure DAOCompaniesList_SetCallback(ACallBack: TOnModelChanged);
  procedure DAOCompaniesList_AddCompany(company: TCompany);
  procedure DAOCompanies_GetItem(itemIndex: Integer; var company: TCompany);
  procedure DAOCompanies_SetItem(itemIndex: Integer; company: TCompany);
  procedure DAOCompanies_DeleteCompany(company: TCompany);

implementation

uses
  IniFiles, ShellAPI;

var
  typedCompanyFile: File of TListOfCompanies;
  listOfCompanies: PPointerCompanies;
  company: TCompany;
  numberOfCompanies: Integer;
  ViewCallback: TOnModelChanged;

  procedure DAOCompaniesList_SetCallback(ACallBack: TOnModelChanged);
  begin
    ViewCallback := ACallBack;
  end;


  function DAOCompanies_initList: PPointerCompanies;
  var
    fileName: String;
    iniCompanies: TMemIniFile;
    listOfGo, listTemp: PPointerCompanies;
    currCompany: TCompany;
    i: Integer;
  begin
    fileName := ExtractFilePath(Application.ExeName) + 'listOfCompanies.ini';
    iniCompanies := TMemIniFile.Create(fileName);

    numberOfCompanies := iniCompanies.ReadInteger('Number', 'Number', 0);
    new(listOfGo);
    listOfCompanies := listOfGo;

    listTemp := listOfGo;
    

    try
      for i := 1 to numberOfCompanies do
      begin
        new(listOfGo^.next);
        listOfGo := listOfGo^.next;

        listOfGo^.companyFromList	:= TCompany.Create;
        listOfGo^.companyFromList.nameOfCompany	:=
          iniCompanies.ReadString('Company' + intToStr(i), 'CompanyName', 'null');
        listOfGo^.companyFromList.nameOfSpeciality :=
          iniCompanies.ReadString('Company' + intToStr(i), 'SpecialityName', 'null');
        listOfGo^.companyFromList.positionName :=
          iniCompanies.ReadString('Company' + intToStr(i), 'PositionName', 'null');
        listOfGo^.companyFromList.salary :=
          iniCompanies.ReadFloat('Company' + intToStr(i), 'Salary', 0.0);
        listOfGo^.companyFromList.daysOfVacation :=
          iniCompanies.ReadInteger('Company' + intToStr(i), 'DaysOfVacation', 0);
        listOfGo^.companyFromList.minAge :=
          iniCompanies.ReadInteger('Company' + intToStr(i), 'MinAge', 0);
        listOfGo^.companyFromList.maxAge :=
          iniCompanies.ReadInteger('Company' + intToStr(i), 'MaxAge', 0);
        if iniCompanies.ReadString('Company' + intToStr(i), 'Edu', 'null') = 'Yes' then
        begin
          listOfGo^.companyFromList.needsHigherEducation := true;
        end
        else
        begin
          listOfGo^.companyFromList.needsHigherEducation := false;
        end;
        end;
      finally
        iniCompanies.Free;
    end;

    listOfGo^.next := nil;
      
    result := listOfCompanies;
  end;

  procedure DAOCompanies_saveList;
  var
    fileName: String;
    iniCompanies: TMemIniFile;
    listOfGo: PPointerCompanies;
    i: Integer;
  begin
    fileName := ExtractFilePath(Application.ExeName) + 'listOfCompanies.ini';
    iniCompanies := TMemIniFile.Create(FileName);
    
//    numberOfCompanies := iniCompanies.ReadInteger('Companies', 'Number', 0);
    iniCompanies.WriteInteger('Number', 'Number', numberOfCompanies);
    listOfGo := listOfCompanies;
    listOfGo := listOfGo^.next;
    i := 1;

    while listOfGo <> nil do
    begin
      try
        iniCompanies.WriteString('Company' + intToStr(i), 'CompanyName', listOfGo^.companyFromList.nameOfCompany);
        iniCompanies.WriteString('Company' + intToStr(i), 'SpecialityName', listOfGo^.companyFromList.nameOfSpeciality);
        iniCompanies.WriteString('Company' + intToStr(i), 'PositionName', listOfGo^.companyFromList.nameOfSpeciality);
        iniCompanies.WriteFloat('Company' + intToStr(i), 'PositionName', listOfGo^.companyFromList.salary);
        iniCompanies.WriteInteger('Company' + intToStr(i), 'PositionName', listOfGo^.companyFromList.daysOfVacation);
        iniCompanies.WriteInteger('Company' + intToStr(i), 'PositionName', listOfGo^.companyFromList.minAge);
        iniCompanies.WriteInteger('Company' + intToStr(i), 'PositionName', listOfGo^.companyFromList.maxAge);
        listOfGo := listOfGo^.next;
        iniCompanies.UpdateFile;
        inc(i);
      finally
        iniCompanies.Free;
      end;
    end;

  end;

  function getListOfCompanies: PPointerCompanies;
  begin
    result := listOfCompanies;
  end;

  procedure DAOCompaniesList_AddCompany(company: TCompany);
  var
    currCompany: PPointerCompanies;
  begin
    currCompany := listOfCompanies;
//    currCompany := currCompany^.next;

    while currCompany^.next <> nil do
    begin
      currCompany := currCompany^.next;
    end;

     new(currCompany^.next);
     currCompany := currCompany^.next;
     currCompany^.companyFromList := company;
     currCompany^.next	:= nil;


    if Assigned(ViewCallback) then
      ViewCallback;

  end;


  procedure DAOCompanies_GetItem(itemIndex: Integer; var company: TCompany);
  var
    i: Integer;
    currCompany: PPointerCompanies;
  begin

    i := 0;
    currCompany := listOfCompanies;
    currCompany := currCompany^.next;

    while i <> itemIndex do
    begin
      inc(i);
      currCompany := currCompany^.next;
    end;

    company := currCompany.companyFromList;


  end;

  procedure DAOCompanies_SetItem(itemIndex: Integer; company: TCompany);
  var
    i: Integer;
    currCompany: PPointerCompanies;
  begin

    i := 0;
    currCompany := listOfCompanies;
    currCompany := currCompany^.next;

    while i <> itemIndex do
    begin
      inc(i);
      currCompany := currCompany^.next;
    end;

    currCompany.companyFromList	:= company;

    if Assigned(ViewCallback) then
      ViewCallback;

  end;

  procedure DAOCompanies_DeleteCompany(company: TCompany);
  var
    currCompanyX, currCompanyY: PPointerCompanies;
  begin

    currCompanyX := listOfCompanies;
    currCompanyX := currCompanyX^.next;
    currCompanyY := currCompanyX;

    while currCompanyX.companyFromList <> company do
    begin
      currCompanyX := currCompanyX^.next;
    end;

    if currCompanyX <> currCompanyY then
    begin
      while currCompanyY^.next.companyFromList <> company do
      begin
        currCompanyY := currCompanyY^.next;
      end;
      currCompanyX := currCompanyY^.next;
      currCompanyY^.next := currCompanyY^.next.next;
    end
    else
    begin
      listOfCompanies^.next := currCompanyX^.next;
      currCompanyX^.next := nil;
    end;

    FreeAndNil(currCompanyX^.companyFromList);

    if Assigned(ViewCallback) then
      ViewCallback;
  end;

end.
