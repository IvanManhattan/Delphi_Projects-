object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'MainFrame'
  ClientHeight = 593
  ClientWidth = 1006
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  PixelsPerInch = 96
  TextHeight = 15
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 1006
    Height = 57
    Align = alTop
    TabOrder = 0
    object Edit1: TEdit
      Left = 296
      Top = 18
      Width = 121
      Height = 23
      TabOrder = 0
      Text = 'Edit1'
    end
    object Button1: TButton
      Left = 632
      Top = 17
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 760
      Top = 17
      Width = 75
      Height = 25
      Caption = 'Button2'
      TabOrder = 2
      OnClick = Button2Click
    end
    object Edit2: TEdit
      Left = 456
      Top = 18
      Width = 121
      Height = 23
      TabOrder = 3
      Text = 'Edit2'
    end
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 536
    Width = 1006
    Height = 57
    Align = alBottom
    TabOrder = 1
  end
  object PanelCentral: TPanel
    Left = 0
    Top = 57
    Width = 1006
    Height = 479
    Align = alClient
    TabOrder = 2
    object ListViewEmployees: TListView
      Left = 504
      Top = 1
      Width = 501
      Height = 477
      Align = alRight
      Columns = <>
      TabOrder = 0
    end
    object ScrollBoxCompanies: TScrollBox
      Left = 1
      Top = 1
      Width = 502
      Height = 477
      Align = alLeft
      TabOrder = 1
    end
  end
end
