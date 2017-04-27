object SelectFaPackForm: TSelectFaPackForm
  Left = 205
  Top = 190
  Width = 1013
  Height = 558
  Caption = #1042#1099#1073#1086#1088' '#1088#1077#1077#1089#1090#1088#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  DesignSize = (
    997
    520)
  PixelsPerInch = 96
  TextHeight = 13
  object faListGrid: TDBGridAlt
    Left = 296
    Top = 24
    Width = 686
    Height = 439
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = MainDataModule.selectFaPackDataSource
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    DefaultSortFieldName = 'ROWNUM'
    CheckDataFieldName = 'CHECK_DATA'
    OddRowColor = 16448250
    EvenRowColor = clWhite
    SortColumnColor = 13824255
    ColumnAutosize = False
    CheckedFont.Charset = DEFAULT_CHARSET
    CheckedFont.Color = clWindowText
    CheckedFont.Height = -11
    CheckedFont.Name = 'MS Sans Serif'
    CheckedFont.Style = []
    EditableFont.Charset = DEFAULT_CHARSET
    EditableFont.Color = clBlue
    EditableFont.Height = -11
    EditableFont.Name = 'MS Sans Serif'
    EditableFont.Style = []
    OnChangeCheck = faListGridChangeCheck
    Columns = <
      item
        Expanded = False
        FieldName = 'CHECK_DATA'
        ReadOnly = True
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'ROWNUM'
        ReadOnly = True
        Title.Caption = 'N'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FA_PACK_ID'
        ReadOnly = True
        Title.Caption = 'ID '#1088#1077#1077#1089#1090#1088#1072
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FA_PACK_TYPE_CD'
        ReadOnly = True
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'CRE_DTTM'
        ReadOnly = True
        Title.Caption = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103
        Width = 140
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FA_CNT'
        ReadOnly = True
        Title.Caption = #1050#1086#1083'-'#1074#1086' '#1072#1073#1086#1085#1077#1085#1090#1086#1074
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FA_PACK_TYPE_DESCR'
        ReadOnly = True
        Title.Caption = #1058#1080#1087' '#1088#1077#1077#1089#1090#1088#1072
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FA_PACK_STATUS_DESCR'
        ReadOnly = True
        Title.Caption = #1057#1090#1072#1090#1091#1089
        Width = 100
        Visible = True
      end>
  end
  object Button1: TButton
    Left = 822
    Top = 486
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1050
    ModalResult = 1
    TabOrder = 1
    OnClick = faListGridChangeCheck
  end
  object Button2: TButton
    Left = 910
    Top = 486
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 2
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 88
    Width = 265
    Height = 129
    Caption = #1060#1080#1083#1100#1090#1088
    TabOrder = 3
    object Label13: TLabel
      Left = 16
      Top = 56
      Width = 56
      Height = 13
      Caption = 'ID '#1056#1077#1077#1089#1090#1088#1072
    end
    object Label1: TLabel
      Left = 16
      Top = 32
      Width = 63
      Height = 13
      Caption = #1058#1080#1087' '#1088#1077#1077#1089#1090#1088#1072
    end
    object FaPackIdComboBox: TComboBox
      Left = 88
      Top = 48
      Width = 161
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      OnChange = FilterComboBoxChange
    end
    object Button3: TButton
      Left = 88
      Top = 88
      Width = 75
      Height = 25
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      TabOrder = 1
    end
    object FaPackTypeCdComboBox: TComboBox
      Left = 88
      Top = 24
      Width = 161
      Height = 21
      ItemHeight = 13
      TabOrder = 2
      OnChange = FilterComboBoxChange
    end
  end
  object GroupBox2: TGroupBox
    Left = 16
    Top = 224
    Width = 265
    Height = 105
    Caption = #1055#1086#1080#1089#1082
    TabOrder = 4
    object Label4: TLabel
      Left = 16
      Top = 32
      Width = 84
      Height = 13
      Caption = 'ID '#1059#1074#1077#1076#1086#1084#1083#1077#1085#1080#1103
    end
    object Button4: TButton
      Left = 88
      Top = 64
      Width = 75
      Height = 25
      Caption = #1053#1072#1081#1090#1080
      TabOrder = 0
    end
    object Edit1: TEdit
      Left = 112
      Top = 24
      Width = 137
      Height = 21
      TabOrder = 1
    end
  end
  object GroupBox3: TGroupBox
    Left = 16
    Top = 16
    Width = 265
    Height = 65
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
    TabOrder = 5
    object Label5: TLabel
      Left = 16
      Top = 32
      Width = 42
      Height = 13
      Caption = #1059#1095#1072#1089#1090#1086#1082
    end
    object OtdelenComboBox: TDBLookupComboBox
      Left = 88
      Top = 24
      Width = 161
      Height = 21
      DataField = 'ACCT_OTDELEN'
      DropDownRows = 11
      KeyField = 'ACCT_OTDELEN'
      ListField = 'OTDELEN_DESCR'
      ListSource = MainDataModule.getOtdelenListDataSource
      ParentColor = True
      TabOrder = 0
      OnClick = OtdelenComboBoxClick
    end
  end
  object Button6: TButton
    Left = 96
    Top = 368
    Width = 75
    Height = 25
    Caption = 'Action1'
    TabOrder = 6
    Visible = False
    OnClick = CloseWindowActionExecute
  end
  object ActionList1: TActionList
    Left = 80
    Top = 400
    object CloseWindowAction: TAction
      Caption = 'CloseWindowAction'
      ShortCut = 27
      OnExecute = CloseWindowActionExecute
    end
  end
end