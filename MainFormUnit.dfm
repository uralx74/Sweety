object MainForm: TMainForm
  Left = 232
  Top = 192
  Width = 870
  Height = 647
  Caption = #1040#1085#1090#1080#1076#1086#1083#1078#1085#1080#1082
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 112
    Top = 16
    object s1: TMenuItem
      Caption = 'CC&&B'
      object N1: TMenuItem
        Action = ActionFieldActivity
      end
    end
  end
  object ActionList1: TActionList
    Left = 80
    Top = 16
    object ActionFieldActivity: TAction
      Caption = #1044#1077#1103#1090#1077#1083#1100#1085#1086#1089#1090#1100' '#1085#1072' '#1084#1077#1089#1090#1072#1093'...'
      OnExecute = ActionFieldActivityExecute
    end
  end
end
