object Form1: TForm1
  Left = 192
  Top = 124
  Width = 870
  Height = 640
  Caption = 'GroupDoc'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 224
    Top = 24
    object s1: TMenuItem
      Caption = 'CC&&B'
      object N1: TMenuItem
        Action = ActionFieldActivity
      end
    end
  end
  object ActionList1: TActionList
    Left = 80
    Top = 72
    object ActionFieldActivity: TAction
      Caption = 'Деятельность на местах...'
      OnExecute = ActionFieldActivityExecute
    end
  end
end
