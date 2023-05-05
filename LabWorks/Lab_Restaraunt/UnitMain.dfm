object FormMain: TFormMain
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'FormMain'
  ClientHeight = 553
  ClientWidth = 782
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object PanelShow: TPanel
    Left = 0
    Top = 0
    Width = 782
    Height = 553
    Align = alRight
    TabOrder = 0
    object ScrollBoxMain: TScrollBox
      Left = 1
      Top = 1
      Width = 551
      Height = 551
      Align = alLeft
      TabOrder = 0
      object Panel2: TPanel
        Left = 44
        Top = 159
        Width = 450
        Height = 150
        Caption = 'Panel1'
        TabOrder = 0
      end
      object Panel1: TPanel
        Left = 44
        Top = 3
        Width = 450
        Height = 150
        Caption = 'Panel1'
        TabOrder = 1
        object Image1: TImage
          Left = 16
          Top = 10
          Width = 160
          Height = 120
        end
        object Label1_dishName: TLabel
          Left = 288
          Top = 32
          Width = 93
          Height = 15
          Caption = 'Label1_dishName'
        end
      end
      object Panel3: TPanel
        Left = 44
        Top = 314
        Width = 450
        Height = 150
        Caption = 'Panel1'
        TabOrder = 2
      end
      object Panel4: TPanel
        Left = 44
        Top = 470
        Width = 450
        Height = 150
        Caption = 'Panel1'
        TabOrder = 3
      end
    end
  end
  object PanelAction: TPanel
    Left = 584
    Top = 0
    Width = 200
    Height = 600
    TabOrder = 1
    object ButtonShow: TButton
      Left = 9
      Top = 352
      Width = 161
      Height = 65
      Caption = 'ButtonShow'
      TabOrder = 0
      OnClick = ButtonShowClick
    end
    object PanelEditFields: TPanel
      Left = 0
      Top = 16
      Width = 180
      Height = 313
      TabOrder = 1
      object EditDishName: TEdit
        Left = 8
        Top = 40
        Width = 160
        Height = 23
        TabOrder = 0
      end
      object EditDishCategory: TEdit
        Left = 8
        Top = 110
        Width = 160
        Height = 23
        TabOrder = 1
      end
      object EditDishPrice: TEdit
        Left = 8
        Top = 176
        Width = 160
        Height = 23
        TabOrder = 2
        Text = '0'
      end
      object ButtonAdd: TButton
        Left = 8
        Top = 236
        Width = 161
        Height = 65
        Caption = 'ButtonAdd'
        TabOrder = 3
        OnClick = ButtonAddClick
      end
    end
    object ListBoxAllDishes: TListBox
      Left = -41
      Top = 409
      Width = 233
      Height = 153
      ItemHeight = 15
      TabOrder = 2
    end
    object ButtonAddPanel: TButton
      Left = 40
      Top = 323
      Width = 105
      Height = 25
      Caption = 'ButtonAddPanel'
      TabOrder = 3
      OnClick = ButtonAddPanelClick
    end
  end
end
