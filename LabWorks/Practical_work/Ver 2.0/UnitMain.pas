unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, CompanyClass, EmployeeClass, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.StdCtrls, UnitCompanyForm, System.Actions, Vcl.ActnList, DAOCompanies, DAOEmployees,
  UnitCreateEmployee, UnitInfoEmployee, Vcl.Imaging.jpeg;

type
  PPointerPanelList = ^TPanelList;
  TPanelList = record
    panel: TPanel;
    employee: TEmployee;
    next: PPointerPanelList;
    prev: PPointerPanelList;
    ID: Integer;
  end;

  TFormMain = class(TForm)
    PanelTop: TPanel;
    PanelBottom: TPanel;
    PanelCentral: TPanel;
    ScrollBoxCompanies: TScrollBox;
    PanelControlCompanies: TPanel;
    ButtonAddEmployee: TButton;
    ButtonViewCompanies: TButton;
    ButtonEditEmployee: TButton;
    ButtonDeleteEmployee: TButton;
    ButtonMoreInfo: TButton;
//    procedure Button1Click(Sender: TObject);
//    procedure Button2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonViewCompaniesClick(Sender: TObject);
    procedure ButtonAddEmployeeClick(Sender: TObject);
    procedure RepaintScrollBox(pointerList: PPointerPanelList; var tmpPanel: TPanel);
    procedure RepaintPanel(pointerList: PPointerPanelList);
    procedure ClearScrollBox;
    function GetPanel(id: Integer): PPointerPanelList;
    procedure DeletePanel(panelToDelete: PPointerPanelList);
    procedure ButtonEditEmployeeClick(Sender: TObject);
    procedure ButtonDeleteEmployeeClick(Sender: TObject);
    procedure ButtonMoreInfoClick(Sender: TObject);
//    procedure AddPanel(var tmpPanel: TPanel; employee: TEmployee);
  private

  public

  end;



var
  FormMain: TFormMain;

implementation

uses
  IniFiles, ShellAPI;
{$R *.dfm}

var
  PointerCompanies: PPointerCompanies;
  PointerEmployees: PPointerEmployees;
  listOfPanel: PPointerPanelList;
  ID: Integer;


(*  procedure TFormMain.Button1Click(Sender: TObject);
  var
    myPointer: PPointerCompanies;
  begin
//    pointerOf := pointerOf^.next;
    pointerOf^.companyFromList.nameOfCompany := Edit1.Text;
    UnitDAO_saveList;
  end;

  procedure TFormMain.Button2Click(Sender: TObject);
  var
    myPointer: PPointerCompanies;
  begin
    pointerOf := UnitDAO_initList;
    pointerOf := pointerOf^.next;
//    myPointer := pointerOf;
    Edit2.Text := pointerOf^.companyFromList.nameOfCompany;
  end;
*)



  procedure TFormMain.ButtonAddEmployeeClick(Sender: TObject);
  var
    Res: TModalResult;
    Employee: TEmployee;
    panelPointer: PPointerPanelList;
    panel: TPanel;
  begin
//    FormCreateEmployee.Show;
    Res := formCreateEmployee.ShowForNewEmployee(Employee);

    if Res = mrCancel then
      Exit;

    DAOEmployees_AddEmployee(Employee);
//    panelPointer(panel, Employee);
    panelPointer := listOfPanel;
    
    while panelPointer^.next <> nil do
    begin
      panelPointer := panelPointer^.next;
    end;

    new(panelPointer^.next);
    panelPointer^.next^.prev := panelPointer;
    panelPointer := panelPointer^.next;
    panelPointer^.next := nil;

    panelPointer^.employee := Employee;
    inc(ID);
    panelPointer^.ID := ID;	
    RepaintScrollBox(panelPointer, panel);
    panelPointer^.panel	:= panel;
    


  end;

  procedure TFormMain.ButtonDeleteEmployeeClick(Sender: TObject);
  var
    tmpStrID: String;
    id: Integer;
    panelToDelete, nextPanel: PPointerPanelList;
    tmpTop, tmpHeight: Integer;
  begin
    tmpStrID := TControl(Sender).Parent.Name;
    id := StrToInt(tmpStrID[length(tmpStrID)]);
    panelToDelete := getPanel(id);

    DAOEmployees_DeleteEmployee(panelToDelete^.employee);

    nextPanel := panelToDelete^.next;

    if panelToDelete^.prev <> nil then
    begin
      tmpTop := panelToDelete^.prev.panel.Top;
      tmpHeight := 200;
    end
    else
    begin
      tmpTop := panelToDelete^.panel.Top;
      tmpHeight := 0;
    end;

    DeletePanel(panelToDelete);
    while nextPanel <> nil do
    begin
      nextPanel^.panel.Top := tmpTop + tmpHeight;
      tmpHeight := tmpHeight + 200;
      nextPanel := nextPanel^.next;

    end;



  end;

  procedure TFormMain.ButtonEditEmployeeClick(Sender: TObject);
  var
    tmpStrID: String;
    id: Integer;
    panelToEdit: PPointerPanelList;

  begin
    tmpStrID := TControl(Sender).Parent.Name;
    id := StrToInt(tmpStrID[length(tmpStrID)]);
    panelToEdit := getPanel(id);
    FormCreateEmployee.ShowForEditEmployee(panelToEdit^.employee);

    RepaintPanel(panelToEdit);

//    RepaintScrollBox(panelToEdit, panelToEdit^.panel);

  end;

  procedure TFormMain.ButtonMoreInfoClick(Sender: TObject);
  var
    tmpStrID: String;
    id: Integer;
    panelToShow: PPointerPanelList;
  begin
//    FormEmployeeInfo.Show;
    tmpStrID := TControl(Sender).Parent.Name;
    id := StrToInt(tmpStrID[length(tmpStrID)]);

    panelToShow := getPanel(id);
    FormEmployeeInfo.ShowForEmployee(panelToShow^.employee);
  end;

  procedure TFormMain.ButtonViewCompaniesClick(Sender: TObject);
  begin
    FormEmployeesList.Show;
  end;

  procedure TFormMain.FormCreate(Sender: TObject);
  var
    FileName: String;
    iniSettings: TMemIniFile;
    tmpPanel: TPanel;
    tmpName, tmpDate, tmpSpeciality, tmpEdu, tmpPrPos, tmpSal: TEdit;
    xPanel, yPanel: PPointerPanelList;
    currEmployee: PPointerEmployees;
    topCoordPanel, leftCoordPanel: Integer;


  begin
    Caption := Application.Title;

    FileName := ExtractFilePath(Application.ExeName) + 'settings.ini';
    iniSettings := TMemIniFile.Create(FileName);
    try
      Left := iniSettings.ReadInteger('Window', 'Left', 0);
      Top := iniSettings.ReadInteger('Window', 'Top', 0);
      Width := iniSettings.ReadInteger('Window', 'Width', 0);
      Height := iniSettings.ReadInteger('Window', 'Height', 0);
    finally
      iniSettings.Free;
    end;

    ButtonEditEmployee.Visible := false;
    ButtonDeleteEmployee.Visible := false;
    ButtonMoreInfo.Visible := false;

    DAOEmployees_initList;
    currEmployee := getListOfEmployees;
    currEmployee := currEmployee^.next;

    new(xPanel);
    xPanel^.prev := nil;
    listOfPanel := xPanel;

    while currEmployee <> nil do
    begin
      yPanel := xPanel;
      yPanel^.employee := currEmployee^.employeeFromList;

      inc(ID);
      yPanel^.ID := ID;
      //
      RepaintScrollBox(yPanel, tmpPanel);
      //

      yPanel^.panel := tmpPanel;
      

//      topCoordPanel := topCoordPanel + 200;
      currEmployee := currEmployee^.next;

      if currEmployee <> nil then
      begin
        new(xPanel);
        yPanel^.next := xPanel;
        xPanel^.prev := yPanel;
      end
      else
      begin
        yPanel^.next := nil;
      end;

    end;


  end;

  procedure TFormMain.FormDestroy(Sender: TObject);
  var
    FileName: String;
    iniSettings: TMemIniFile;
  begin
    FileName := ExtractFilePath(Application.ExeName) + 'settings.ini';
  iniSettings := TMemIniFile.Create(FileName);
    try
      iniSettings.WriteInteger('Window', 'Left', Left);
      iniSettings.WriteInteger('Window', 'Top', Top);
      iniSettings.WriteInteger('Window', 'Width', Width);
      iniSettings.WriteInteger('Window', 'Height', Height);
      iniSettings.UpdateFile;
    finally
      iniSettings.Free;
    end;
  end;

  procedure TFormMain.RepaintScrollBox(pointerList: PPointerPanelList; var tmpPanel: TPanel);
  var
    tmpName, tmpDate, tmpSpeciality, tmpEdu, tmpPrPos, tmpSal: TEdit;
    tmpButtonEdit, tmpButtonDelete, tmpButtonInfo: TButton;
    tmpImage: TImage;
    currPanel: PPointerPanelList;
    currEmployee: PPointerEmployees;
    topCoordPanel, leftCoordPanel: Integer;

  begin

    if pointerList^.prev = nil then
    begin
      topCoordPanel := 0;
    end
    else
    begin
      topCoordPanel := pointerList^.prev.panel.Top + 150;
    end;

    leftCoordPanel := 0;


    tmpPanel := TPanel.Create(ScrollBoxCompanies);
    tmpPanel.Parent	:= ScrollBoxCompanies;
    //tmpPanel.Width := ScrollBoxCompanies.Width - 200;
    tmpPanel.Name	:= 'Panel_' + intToStr(pointerList^.ID);
    tmpPanel.Width := 600;
    tmpPanel.Height	:= 150;
    //tmpPanel.Left	:= (ScrollBoxCompanies.Width - tmpPanel.Width) div 3;
    tmpPanel.Left	:= 50;
    tmpPanel.Top := topCoordPanel + 50;


    tmpButtonEdit := TButton.Create(tmpPanel);
    with tmpButtonEdit do
    begin
      Parent := tmpPanel;
      Name := 'ButtonEdit_' + intToStr(pointerList^.ID);
      OnClick := ButtonEditEmployee.OnClick;
      Left := tmpPanel.Width - 425;
      Top := 20;
      Width := 30;
      Height := 30;
      Caption := 'E';
      Visible := True;
    end;	

    tmpButtonDelete := TButton.Create(tmpPanel);
    with tmpButtonDelete do
    begin
      Parent := tmpPanel;
      Name := 'ButtonDelete_' + intToStr(pointerList^.ID);
      OnClick := ButtonDeleteEmployee.OnClick;
      Left := tmpPanel.Width - 425;
      Top := 60;
      Width := 30;
      Height := 30;
      Caption := 'D';
      Visible := True;
    end;

    tmpButtonInfo := TButton.Create(tmpPanel);
    with tmpButtonInfo do
    begin
      Parent := tmpPanel;
      Name := 'ButtonInfo_' + intToStr(pointerList^.ID);
      OnClick := ButtonMoreInfo.OnClick;
      Left := tmpPanel.Width - 425;
      Top := 100;
      Width := 30;
      Height := 30;
      Caption := '...';
      Visible := True;
    end;
    
    tmpName := TEdit.Create(tmpPanel);
    with tmpName do
    begin
      Parent := tmpPanel;
      Name := 'EditNam_' + intToStr(pointerList^.ID);
      Left := tmpPanel.Width - 350;
      Top := tmpPanel.Height - 130;
      Text := pointerList^.employee.fullName;
    end;

    tmpDate := TEdit.Create(tmpPanel);
    with tmpDate do
    begin
      Parent := tmpPanel;
      Name := 'EditDat_'+ intToStr(pointerList^.ID);
      Left := tmpPanel.Width - 350;
      Top := tmpPanel.Height - 90;
      Text := DateToStr(pointerList^.employee.dateOfBirth);
    end;

    tmpSpeciality := TEdit.Create(tmpPanel);
    with tmpSpeciality do
    begin
      Parent := tmpPanel;
      Name := 'EditSpe_'+ intToStr(pointerList^.ID);
      Left := tmpPanel.Width - 350;
      Top := tmpPanel.Height - 50;
      Text := pointerList^.employee.specialityOf;
    end;

    tmpEdu := TEdit.Create(tmpPanel);
    with tmpEdu do
    begin
      Parent := tmpPanel;
      Name := 'EditEdu_'+ intToStr(pointerList^.ID);
      Left := tmpPanel.Width - 175;
      Top := tmpPanel.Height - 130;
      if pointerList^.employee.hasHigherEducation	= true then
      begin
        Text := 'Yes';
      end
      else
      begin
        Text := 'No';
      end;
    end;

    tmpPrPos := TEdit.Create(tmpPanel);
    with tmpPrPos do
    begin
      Parent := tmpPanel;
      Name := 'EditPos_'+ intToStr(pointerList^.ID);
      Left := tmpPanel.Width - 175;
      Top := tmpPanel.Height - 90;
      Text := pointerList^.employee.preferredPosition;
    end;

    tmpSal := TEdit.Create(tmpPanel);
    with tmpSal do
    begin
      Parent := tmpPanel;
      Name := 'EditSal_'+ intToStr(pointerList^.ID);
      Left := tmpPanel.Width - 175;
      Top := tmpPanel.Height - 50;
      Text := FloatToStr(pointerList^.employee.minSalary);
    end;

  end;

  procedure TFormMain.RepaintPanel(pointerList: PPointerPanelList);
  var
    editFound: TComponent;
  begin
    editFound := pointerList^.panel.FindComponent('EditNam_' + intToStr(pointerList^.ID));
    if editFound <> nil then
    begin
      (editFound as TEdit).Text := pointerList^.employee.fullName;
    end;
    editFound := pointerList^.panel.FindComponent('EditDat_' + intToStr(pointerList^.ID));
    if editFound <> nil then
    begin
      (editFound as TEdit).Text := DateToStr(pointerList^.employee.dateOfBirth);
    end;
    editFound := pointerList^.panel.FindComponent('EditSpe_' + intToStr(pointerList^.ID));
    if editFound <> nil then
    begin
      (editFound as TEdit).Text := pointerList^.employee.specialityOf;
    end;
    editFound := pointerList^.panel.FindComponent('EditPos_' + intToStr(pointerList^.ID));
    if editFound <> nil then
    begin
      (editFound as TEdit).Text := pointerList^.employee.preferredPosition;
    end;
    editFound := pointerList^.panel.FindComponent('EditEdu_' + intToStr(pointerList^.ID));
    if editFound <> nil then
    begin
      (editFound as TEdit).Text := BoolToStr(pointerList^.employee.hasHigherEducation);
    end;
    editFound := pointerList^.panel.FindComponent('EditSal_' + intToStr(pointerList^.ID));
    if editFound <> nil then
    begin
      (editFound as TEdit).Text := FloatToStr(pointerList^.employee.minSalary);
    end;
  end;

  procedure TFormMain.ClearScrollBox;
  var
    n : integer;
  begin
    //    ScrollBoxCompanies.visible:=true;
    with ScrollBoxCompanies do
    begin
      repeat
        n := ControlCount - 1;
        Controls[n].Free;
      until ControlCount = 0;
    end;
    //    ScrollBoxCompanies.visible:=true;
  end;

(*  procedure TFormMain.AddPanel(var tmpPanel: TPanel; employee: TEmployee);
  var
    currPanel: PPointerPanelList;
    tmpName, tmpDate, tmpSpeciality, tmpEdu, tmpPrPos, tmpSal: TEdit;

  begin

    currPanel := listOfPanel;
    while currPanel^.next	<> nil do
    begin
      currPanel := currPanel^.next;
    end;

    new(currPanel^.next);
    currPanel^.next^.prev	:= currPanel;
    currPanel := currPanel^.next;
    currPanel^.panel := tmpPanel;
    currPanel^.employee	:= employee;
    currPanel^.next := nil;

  end;
*)

  function TFormMain.GetPanel(id: Integer): PPointerPanelList;
  var
    currPanel: PPointerPanelList;
  begin
    currPanel := listOfPanel;
    while currPanel^.ID <> id do
    begin
      currPanel := currPanel^.next;
    end;

    result := currPanel;

  end;

  procedure TFormMain.DeletePanel(panelToDelete: PPointerPanelList);
  begin

    if (panelToDelete^.next <> nil) and (panelToDelete^.prev <> nil) then
    begin
      panelToDelete^.prev^.next := panelToDelete^.next;
      panelToDelete^.next^.prev := panelToDelete^.prev;
      FreeAndNil(panelToDelete^.panel);
      dispose(panelToDelete);
    end
    else if (panelToDelete^.next = nil) and (panelToDelete^.prev <> nil) then
    begin
      panelToDelete^.prev^.next := nil;
      panelToDelete^.prev := nil;
      FreeAndNil(panelToDelete^.panel);
      dispose(panelToDelete);
    end
    else if (panelToDelete^.prev = nil) and (panelToDelete^.next <> nil) then
    begin
      listOfPanel := panelToDelete^.next;
      panelToDelete^.next^.prev := nil;
      panelToDelete^.next := nil;
      FreeAndNil(panelToDelete^.panel);
      dispose(panelToDelete);
    end
    else
    begin
      panelToDelete^.next := nil;
      panelToDelete^.prev := nil;
      FreeAndNil(panelToDelete^.panel);
    end;


  end;

end.
