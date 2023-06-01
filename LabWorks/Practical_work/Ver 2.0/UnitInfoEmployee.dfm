object FormEmployeeInfo: TFormEmployeeInfo
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Information'
  ClientHeight = 433
  ClientWidth = 622
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object PanelMainInfo: TPanel
    Left = 0
    Top = 0
    Width = 622
    Height = 433
    Align = alClient
    TabOrder = 0
    object EditName: TEdit
      Left = 312
      Top = 32
      Width = 121
      Height = 23
      TabOrder = 0
      Text = 'EditName'
    end
    object EditSpeciality: TEdit
      Left = 312
      Top = 72
      Width = 121
      Height = 23
      TabOrder = 1
      Text = 'Edit1'
    end
    object EditPosition: TEdit
      Left = 312
      Top = 117
      Width = 121
      Height = 23
      TabOrder = 2
      Text = 'Edit1'
    end
    object EditAge: TEdit
      Left = 464
      Top = 32
      Width = 121
      Height = 23
      TabOrder = 3
      Text = 'Edit1'
    end
    object EditSalary: TEdit
      Left = 464
      Top = 72
      Width = 121
      Height = 23
      TabOrder = 4
      Text = 'Edit1'
    end
    object EditHigherEdu: TEdit
      Left = 464
      Top = 117
      Width = 121
      Height = 23
      TabOrder = 5
      Text = 'Edit1'
    end
    object PanelListOfSugg: TPanel
      Left = 1
      Top = 224
      Width = 620
      Height = 208
      Align = alBottom
      TabOrder = 6
      object listOfSugg: TListView
        Left = 1
        Top = 1
        Width = 618
        Height = 206
        Align = alClient
        Columns = <
          item
            Caption = 'Name'
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
          end>
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
    object Button1: TButton
      Left = 312
      Top = 168
      Width = 121
      Height = 41
      Action = ActionStrictSearch
      TabOrder = 7
    end
    object Button2: TButton
      Left = 464
      Top = 168
      Width = 121
      Height = 41
      Action = ActionCommonSearch
      TabOrder = 8
    end
  end
  object ActionListSugg: TActionList
    OnUpdate = ActionListSuggUpdate
    Left = 1
    Top = 224
    object ActionStrictSearch: TAction
      Caption = 'ActionStrictSearch'
      OnExecute = ActionStrictSearchExecute
    end
    object ActionCommonSearch: TAction
      Caption = 'ActionCommonSearch'
      OnExecute = ActionCommonSearchExecute
    end
  end
end
