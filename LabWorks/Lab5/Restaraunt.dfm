object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'MainFrame'
  ClientHeight = 600
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  PixelsPerInch = 96
  TextHeight = 15
  object Panel1: TPanel
    Left = 8
    Top = 0
    Width = 400
    Height = 500
    Caption = 'PanelOfDishes'
    TabOrder = 0
    object Button1: TButton
      Left = 144
      Top = 312
      Width = 100
      Height = 50
      Caption = 'ButtonShowPopular'
      TabOrder = 0
      OnClick = doShowTheMostPopular
    end
    object ListOfDishes: TListBox
      Left = 48
      Top = 80
      Width = 300
      Height = 200
      ItemHeight = 15
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 400
    Top = 0
    Width = 400
    Height = 500
    Caption = 'PanelOfOrders'
    TabOrder = 1
  end
  object Panel3: TPanel
    Left = 0
    Top = 496
    Width = 800
    Height = 100
    Caption = 'PanelAction'
    TabOrder = 2
  end
end
