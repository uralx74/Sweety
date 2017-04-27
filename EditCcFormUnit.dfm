object EditCcForm: TEditCcForm
  Left = 211
  Top = 124
  BorderStyle = bsDialog
  Caption = #1050#1086#1085#1090#1072#1082#1090' '#1089' '#1072#1073#1086#1085#1077#1085#1090#1086#1084
  ClientHeight = 392
  ClientWidth = 443
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  OnCreate = FormCreate
  DesignSize = (
    443
    392)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 425
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
    Left = 360
    Top = 360
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 1
  end
  object Button3: TButton
    Left = 280
    Top = 360
    Width = 73
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    ModalResult = 1
    TabOrder = 2
    OnClick = Button3Click
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 96
    Width = 425
    Height = 259
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = #1050#1086#1085#1090#1072#1082#1090
    TabOrder = 3
    DesignSize = (
      425
      259)
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
      Top = 168
      Width = 70
      Height = 13
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
    end
    object Label27: TLabel
      Left = 16
      Top = 80
      Width = 143
      Height = 13
      Caption = #1057#1090#1072#1090#1091#1089' '#1082#1086#1085#1090#1072#1082#1090#1072' ('#1088#1077#1079#1091#1083#1100#1090#1072#1090')'
    end
    object Label28: TLabel
      Left = 16
      Top = 128
      Width = 130
      Height = 13
      Caption = #1048#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100' ('#1050#1086#1085#1090#1088#1086#1083#1077#1088')'
      Visible = False
    end
    object LockCcDttmButton: TSpeedButton
      Left = 386
      Top = 24
      Width = 23
      Height = 22
      AllowAllUp = True
      Anchors = [akTop, akRight]
      GroupIndex = 101
    end
    object LockCcTypeCdButton: TSpeedButton
      Left = 386
      Top = 48
      Width = 23
      Height = 22
      AllowAllUp = True
      Anchors = [akTop, akRight]
      GroupIndex = 102
    end
    object LockCcStatusFlgButton: TSpeedButton
      Left = 386
      Top = 72
      Width = 23
      Height = 22
      AllowAllUp = True
      Anchors = [akTop, akRight]
      GroupIndex = 103
    end
    object LockCallerButton: TSpeedButton
      Left = 386
      Top = 96
      Width = 23
      Height = 22
      AllowAllUp = True
      Anchors = [akTop, akRight]
      GroupIndex = 104
    end
    object LockDescrButton: TSpeedButton
      Left = 386
      Top = 160
      Width = 23
      Height = 22
      AllowAllUp = True
      Anchors = [akTop, akRight]
      GroupIndex = 105
    end
    object DescrEdit: TRichEdit
      Left = 16
      Top = 184
      Width = 393
      Height = 41
      Anchors = [akLeft, akTop, akRight]
      PlainText = True
      TabOrder = 0
    end
    object CcDttmDateTimePicker: TDateTimePicker
      Left = 192
      Top = 24
      Width = 193
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
    object CallerEdit: TEdit
      Left = 192
      Top = 96
      Width = 193
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
    end
    object CcTypeCdComboBox: TDBLookupComboBox
      Left = 192
      Top = 48
      Width = 193
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DropDownRows = 8
      KeyField = 'FIELD_VALUE'
      ListField = 'DESCR;FIELD_VALUE'
      ListSource = MainDataModule.getCcTypeCdDataSource
      TabOrder = 3
    end
    object CcStatusFlgComboBox: TDBLookupComboBox
      Left = 192
      Top = 72
      Width = 193
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DropDownRows = 10
      KeyField = 'FIELD_VALUE'
      ListField = 'DESCR;FIELD_VALUE'
      ListSource = MainDataModule.getCcStatusFlgListDataSource
      TabOrder = 4
    end
    object DBLookupComboBox1: TDBLookupComboBox
      Left = 192
      Top = 120
      Width = 193
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DropDownRows = 10
      KeyField = 'OP_AREA_CD'
      ListField = 'OP_AREA_CD;OP_AREA_DESCR'
      ListFieldIndex = 1
      ListSource = MainDataModule.OraDataSourceTEST
      TabOrder = 5
      Visible = False
    end
  end
  object DeleteCcButton: TButton
    Left = 8
    Top = 360
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1059#1076#1072#1083#1080#1090#1100
    TabOrder = 4
    OnClick = DeleteCcButtonClick
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
