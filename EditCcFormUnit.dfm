object EditCcForm: TEditCcForm
  Left = 429
  Top = 306
  BorderStyle = bsDialog
  Caption = #1050#1086#1085#1090#1072#1082#1090' '#1089' '#1072#1073#1086#1085#1077#1085#1090#1086#1084
  ClientHeight = 357
  ClientWidth = 435
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    435
    357)
  PixelsPerInch = 96
  TextHeight = 13
  object Label27: TLabel
    Left = 32
    Top = 16
    Width = 143
    Height = 13
    Caption = #1057#1090#1072#1090#1091#1089' '#1082#1086#1085#1090#1072#1082#1090#1072' ('#1088#1077#1079#1091#1083#1100#1090#1072#1090')'
    Visible = False
  end
  object LockCcStatusFlgButton: TSpeedButton
    Left = 394
    Top = 8
    Width = 23
    Height = 22
    AllowAllUp = True
    Anchors = [akTop, akRight]
    GroupIndex = 103
    Visible = False
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 417
    Height = 81
    Anchors = [akLeft, akTop, akRight]
    Caption = #1040#1073#1086#1085#1077#1085#1090
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 27
      Height = 13
      Caption = #1060#1048#1054
    end
    object AcctIdLabel: TLabel
      Left = 112
      Top = 48
      Width = 15
      Height = 13
      Caption = #1051#1057
    end
    object Label3: TLabel
      Left = 16
      Top = 48
      Width = 69
      Height = 13
      Caption = #1051#1080#1094#1077#1074#1086#1081' '#1089#1095#1077#1090
    end
    object FioLabel: TLabel
      Left = 112
      Top = 24
      Width = 20
      Height = 13
      Caption = #1092#1080#1086
    end
  end
  object Button2: TButton
    Left = 353
    Top = 326
    Width = 75
    Height = 25
    Anchors = [akRight]
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 1
  end
  object Button3: TButton
    Left = 273
    Top = 326
    Width = 73
    Height = 25
    Anchors = [akRight]
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    ModalResult = 1
    TabOrder = 2
    OnClick = Button3Click
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 96
    Width = 417
    Height = 217
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = #1050#1086#1085#1090#1072#1082#1090
    TabOrder = 3
    DesignSize = (
      417
      217)
    object Label24: TLabel
      Left = 16
      Top = 32
      Width = 75
      Height = 13
      Caption = #1044#1072#1090#1072' '#1082#1086#1085#1090#1072#1082#1090#1072
    end
    object Label25: TLabel
      Left = 16
      Top = 56
      Width = 68
      Height = 13
      Caption = #1058#1080#1087' '#1082#1086#1085#1090#1072#1082#1090#1072
    end
    object Label26: TLabel
      Left = 16
      Top = 104
      Width = 70
      Height = 13
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
    end
    object LockCcDttmButton: TSpeedButton
      Left = 266
      Top = 24
      Width = 23
      Height = 22
      AllowAllUp = True
      Anchors = [akTop, akRight]
      GroupIndex = 101
    end
    object LockCcTypeCdButton: TSpeedButton
      Left = 378
      Top = 48
      Width = 23
      Height = 22
      AllowAllUp = True
      Anchors = [akTop, akRight]
      GroupIndex = 102
    end
    object LockDescrButton: TSpeedButton
      Left = 378
      Top = 96
      Width = 23
      Height = 22
      AllowAllUp = True
      Anchors = [akTop, akRight]
      GroupIndex = 105
    end
    object DescrEdit: TRichEdit
      Left = 16
      Top = 120
      Width = 385
      Height = 81
      Anchors = [akLeft, akTop, akRight]
      PlainText = True
      TabOrder = 0
    end
    object CcDttmDateTimePicker: TDateTimePicker
      Left = 160
      Top = 24
      Width = 106
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      CalAlignment = dtaLeft
      Date = 42747
      Time = 42747
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 1
    end
    object CcTypeCdComboBox: TDBLookupComboBox
      Left = 160
      Top = 48
      Width = 209
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DropDownRows = 8
      KeyField = 'FIELD_VALUE'
      ListField = 'DESCR;FIELD_VALUE'
      ListSource = MainDataModule.getCcTypeCdDataSource
      TabOrder = 2
      OnClick = CcTypeCdComboBoxClick
    end
    object OpAreaCdPanel: TPanel
      Left = 16
      Top = 72
      Width = 385
      Height = 25
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = #1050#1086#1085#1090#1088#1086#1083#1077#1088
      TabOrder = 3
      DesignSize = (
        385
        25)
      object LockCallerButton: TSpeedButton
        Left = 362
        Top = 0
        Width = 23
        Height = 22
        AllowAllUp = True
        Anchors = [akTop, akRight]
        GroupIndex = 104
      end
      object CcOpAreaCdComboBox: TComboBoxAlt
        Left = 144
        Top = 0
        Width = 209
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
      end
    end
  end
  object DeleteCcButton: TButton
    Left = 9
    Top = 326
    Width = 75
    Height = 25
    Anchors = [akRight]
    Caption = #1059#1076#1072#1083#1080#1090#1100
    TabOrder = 4
    OnClick = DeleteCcButtonClick
  end
  object CcStatusFlgComboBox: TDBLookupComboBox
    Left = 208
    Top = 8
    Width = 185
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    DropDownRows = 10
    KeyField = 'FIELD_VALUE'
    ListField = 'DESCR;FIELD_VALUE'
    ListSource = MainDataModule.getCcStatusFlgListDataSource
    TabOrder = 5
    Visible = False
  end
  object ActionList1: TActionList
    Left = 64
    object CloseWindowAction: TAction
      Caption = 'CloseWindowAction'
      ShortCut = 27
      OnExecute = CloseWindowActionExecute
    end
  end
end
