object FormEmployeesList: TFormEmployeesList
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'FormEmployeesList'
  ClientHeight = 513
  ClientWidth = 942
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object PanelMain: TPanel
    Left = 0
    Top = 0
    Width = 942
    Height = 513
    Align = alClient
    TabOrder = 0
    object PanelControlEmployees: TPanel
      Left = 701
      Top = 1
      Width = 240
      Height = 511
      Align = alRight
      TabOrder = 0
      object editCompany: TButton
        Left = 56
        Top = 146
        Width = 140
        Height = 50
        Action = ActionEditCompany
        TabOrder = 0
      end
      object deleteCompany: TButton
        Left = 56
        Top = 236
        Width = 140
        Height = 50
        Action = ActionDeleteCompany
        TabOrder = 1
      end
      object addCompany: TButton
        Left = 56
        Top = 50
        Width = 140
        Height = 50
        Action = ActionAddNewCompany
        TabOrder = 2
      end
      object ButtonDeficitSpecialities: TButton
        Left = 56
        Top = 328
        Width = 140
        Height = 50
        Action = ActionDeficitSpecialities
        TabOrder = 3
      end
      object Button1: TButton
        Left = 56
        Top = 416
        Width = 140
        Height = 50
        Action = ActionNoCandidates
        TabOrder = 4
      end
      object ButtonGetBack: TButton
        Left = 17
        Top = 11
        Width = 33
        Height = 33
        Action = ActionGetBack
        TabOrder = 5
      end
    end
    object listOfCompanies: TListView
      Left = 1
      Top = 1
      Width = 700
      Height = 511
      Align = alClient
      Columns = <
        item
          Caption = 'Name'
          Width = 100
        end
        item
          Caption = 'Speciality Name'
          Width = 100
        end
        item
          Caption = 'Position'
          Width = 70
        end
        item
          Caption = 'Salary'
        end
        item
          Caption = 'Days of vacation'
          Width = 100
        end
        item
          Caption = 'Higher Education'
          Width = 110
        end
        item
          Caption = 'Min Age'
          Width = 70
        end
        item
          Caption = 'Max Age'
          Width = 70
        end>
      ReadOnly = True
      RowSelect = True
      TabOrder = 1
      ViewStyle = vsReport
    end
  end
  object ActionListCompanies: TActionList
    OnUpdate = ActionListCompaniesUpdate
    object ActionAddNewCompany: TAction
      Caption = 'ActionAddNewCompany'
      OnExecute = ActionAddNewCompanyExecute
    end
    object ActionEditCompany: TAction
      Caption = 'ActionEditCompany'
      OnExecute = ActionEditCompanyExecute
    end
    object ActionDeleteCompany: TAction
      Caption = 'ActionDeleteCompany'
      OnExecute = ActionDeleteCompanyExecute
    end
    object ActionDeficitSpecialities: TAction
      Caption = 'ActionDeficitSpecialities'
      OnExecute = ActionDeficitSpecialitiesExecute
    end
    object ActionNoCandidates: TAction
      Caption = 'ActionNoCandidates'
      OnExecute = ActionNoCandidatesExecute
    end
    object ActionGetBack: TAction
      Caption = 'ActionGetBack'
      OnExecute = ActionGetBackExecute
    end
  end
end
