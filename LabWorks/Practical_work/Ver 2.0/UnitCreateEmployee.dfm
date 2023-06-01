object FormCreateEmployee: TFormCreateEmployee
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'FormCreateEmployee'
  ClientHeight = 600
  ClientWidth = 682
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object PanelMainCreateCompany: TPanel
    Left = 0
    Top = 0
    Width = 682
    Height = 600
    Align = alClient
    TabOrder = 0
    object LabelLogo: TLabel
      Left = 218
      Top = 40
      Width = 243
      Height = 45
      Caption = 'Create Employee'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -33
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object EditName: TEdit
      Left = 88
      Top = 128
      Width = 200
      Height = 33
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -18
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'EditName'
    end
    object EditSpeciality: TEdit
      Left = 88
      Top = 200
      Width = 200
      Height = 33
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -18
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = 'Edit1'
    end
    object EditPosition: TEdit
      Left = 88
      Top = 273
      Width = 200
      Height = 33
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -18
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = 'Position'
    end
    object EditSalary: TEdit
      Left = 88
      Top = 345
      Width = 200
      Height = 33
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -18
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = '180000'
    end
    object EditDate: TEdit
      Left = 384
      Top = 200
      Width = 200
      Height = 33
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -18
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Text = '100'
    end
    object EditHasHigherEducation: TEdit
      Left = 384
      Top = 273
      Width = 200
      Height = 33
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -18
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      Text = 'True'
    end
    object ButtonCreate: TButton
      Left = 208
      Top = 424
      Width = 250
      Height = 70
      Caption = 'ButtonCreate'
      ModalResult = 1
      TabOrder = 6
    end
    object ButtonCancel: TButton
      Left = 272
      Top = 544
      Width = 125
      Height = 35
      Cancel = True
      Caption = 'ButtonCancel'
      ModalResult = 2
      TabOrder = 7
    end
  end
end
