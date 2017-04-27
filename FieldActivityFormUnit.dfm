object FieldActivityForm: TFieldActivityForm
  Left = 193
  Top = 125
  Width = 1418
  Height = 884
  Caption = #1044#1086#1083#1078#1085#1080#1082#1080#1060
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Visible = True
  OnShow = FormShow
  DesignSize = (
    1402
    846)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox3: TGroupBox
    Left = 8
    Top = 747
    Width = 273
    Height = 201
    Anchors = [akLeft, akBottom]
    Caption = #1050#1072#1088#1090#1086#1095#1082#1072
    TabOrder = 0
    Visible = False
    object Label20: TLabel
      Left = 16
      Top = 24
      Width = 72
      Height = 13
      Caption = #1051#1080#1094#1077#1074#1086#1081' '#1089#1095#1077#1090':'
    end
  end
  object MainPanel: TPanel
    Left = 289
    Top = 0
    Width = 1113
    Height = 846
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Panel1: TPanel
      Left = 0
      Top = 40
      Width = 1113
      Height = 806
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object PackPageControl: TPageControl
        Left = 0
        Top = 0
        Width = 1113
        Height = 806
        ActivePage = MainTabSheet
        Align = alClient
        OwnerDraw = True
        Style = tsFlatButtons
        TabHeight = 25
        TabIndex = 0
        TabOrder = 0
        OnDrawTab = PackPageControlDrawTab
        object MainTabSheet: TTabSheet
          Caption = '['#1057#1058#1040#1056#1058']'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ImageIndex = 10
          ParentFont = False
          OnShow = MainTabSheetShow
          object GroupBox2: TGroupBox
            Left = 7
            Top = 7
            Width = 402
            Height = 298
            Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072
            TabOrder = 0
            object Label3: TLabel
              Left = 48
              Top = 32
              Width = 227
              Height = 13
              Caption = #1069#1090#1072' '#1087#1072#1085#1077#1083#1100' '#1085#1072#1093#1086#1076#1080#1090#1089#1103' '#1085#1072' '#1089#1090#1072#1076#1080#1080' '#1088#1072#1079#1088#1072#1073#1086#1090#1082#1080
            end
            object Memo1: TMemo
              Left = 16
              Top = 216
              Width = 281
              Height = 73
              BevelInner = bvNone
              BevelOuter = bvNone
              BorderStyle = bsNone
              Color = clBtnFace
              Enabled = False
              Lines.Strings = (
                #1057' '#1074#1086#1087#1088#1086#1089#1072#1084#1080' '#1087#1086' '#1088#1072#1073#1086#1090#1077' '#1089' '#1087#1088#1086#1075#1088#1072#1084#1084#1086#1081' '
                #1086#1073#1088#1072#1097#1072#1081#1090#1077#1089#1100' '#1082' '#1045'.'#1042'. '#1053#1072#1079#1072#1088#1086#1074#1091' ('#1090#1077#1083'.504)'
                ''
                #1057' '#1074#1086#1087#1088#1086#1089#1072#1084#1080' '#1087#1086' '#1088#1072#1073#1086#1090#1086#1089#1087#1086#1089#1086#1073#1085#1086#1089#1090#1080' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
                #1086#1073#1088#1072#1097#1072#1081#1090#1077#1089#1100' '#1082' '#1042'.'#1057'. '#1054#1074#1095#1080#1085#1085#1080#1082#1086#1074#1091' ('#1090#1077#1083'.113)')
              ReadOnly = True
              TabOrder = 0
            end
          end
        end
        object DebtorsTabSheet: TTabSheet
          Caption = #1044#1086#1083#1078#1085#1080#1082#1080
          OnShow = DebtorsTabSheetShow
          object DBGridAltGeneral: TDBGridAlt
            Left = 0
            Top = 0
            Width = 704
            Height = 828
            Align = alClient
            DataSource = MainDataModule.getDebtorsDataSource
            ReadOnly = True
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
            CheckedFont.Color = clRed
            CheckedFont.Height = -11
            CheckedFont.Name = 'MS Sans Serif'
            CheckedFont.Style = []
            EditableFont.Charset = DEFAULT_CHARSET
            EditableFont.Color = clBlack
            EditableFont.Height = -11
            EditableFont.Name = 'MS Sans Serif'
            EditableFont.Style = []
            OnChangeCheck = DBGridAltGeneralChangeCheck
            OnChangeFilter = DBGridAltGeneralChangeFilter
            Columns = <
              item
                Expanded = False
                FieldName = 'CHECK_DATA'
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'ROWNUM'
                Title.Caption = 'N'
                Width = 50
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ACCT_ID'
                Title.Caption = #1051#1080#1094#1077#1074#1086#1081' '#1089#1095#1077#1090
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'FIO'
                Title.Caption = #1060#1048#1054
                Width = 160
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CITY'
                Title.Caption = #1053#1072#1089'. '#1087#1091#1085#1082#1090
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ADDRESS'
                Title.Caption = #1040#1076#1088#1077#1089
                Width = 200
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PREM_TYPE_DESCR'
                Title.Caption = #1058#1080#1087' '#1054#1054
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'SALDO_UCH'
                Title.Caption = #1057#1072#1083#1100#1076#1086
                Width = 70
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'SALDO_M3'
                Title.Caption = #1057#1072#1083#1100#1076#1086' (- 3 '#1084#1077#1089')'
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'SERVICE_ORG'
                Title.Caption = #1054#1073#1089#1083#1091#1078#1080#1074#1072#1102#1097#1072#1103' '#1086#1088#1075'-'#1103
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'OP_AREA_DESCR'
                Title.Caption = #1050#1086#1085#1090#1088#1086#1083#1077#1088
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CC_DTTM'
                Title.Caption = #1044#1072#1090#1072' '#1082#1086#1085#1090#1072#1082#1090#1072
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'FA_ID'
                Title.Caption = #1059#1074#1077#1076#1086#1084#1083#1077#1085#1080#1077
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'FA_PACK_ID'
                Title.Caption = #1056#1077#1077#1089#1090#1088
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CRE_DTTM'
                Title.Caption = #1044#1072#1090#1072' '#1088#1077#1077#1089#1090#1088#1072
                Width = 100
                Visible = True
              end>
          end
        end
        object PackManualTabSheet: TTabSheet
          Caption = #1056#1077#1077#1089#1090#1088' '#1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1081
          ImageIndex = 1
          OnShow = PackManualTabSheetShow
          object DBGridAltManual: TDBGridAlt
            Left = 0
            Top = 0
            Width = 1105
            Height = 771
            Align = alClient
            DataSource = MainDataModule.getFaPackDataSource
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            OnCellClick = DBGridAltManualCellClick
            DefaultSortFieldName = 'ROWNUM'
            CheckDataFieldName = 'CHECK_DATA'
            OddRowColor = 16448250
            EvenRowColor = clWhite
            SortColumnColor = 13824255
            ColumnAutosize = False
            CheckedFont.Charset = DEFAULT_CHARSET
            CheckedFont.Color = clRed
            CheckedFont.Height = -11
            CheckedFont.Name = 'MS Sans Serif'
            CheckedFont.Style = []
            EditableFont.Charset = DEFAULT_CHARSET
            EditableFont.Color = clBlack
            EditableFont.Height = -11
            EditableFont.Name = 'MS Sans Serif'
            EditableFont.Style = []
            OnChangeCheck = DBGridAltGeneralChangeCheck
            Columns = <
              item
                Expanded = False
                FieldName = 'ROWNUM'
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'CHECK_DATA'
                ReadOnly = True
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'FA_ID'
                ReadOnly = True
                Title.Caption = 'ID '#1076#1086#1082#1091#1084#1077#1085#1090#1072
                Width = 90
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CC_DTTM'
                ReadOnly = True
                Title.Caption = #1044#1072#1090#1072' '#1082#1086#1085#1090#1072#1082#1090#1072
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ACCT_ID'
                ReadOnly = True
                Title.Caption = #1051#1080#1094#1077#1074#1086#1081' '#1089#1095#1077#1090
                Width = 90
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'SALDO_UCH'
                ReadOnly = True
                Title.Caption = #1057#1072#1083#1100#1076#1086
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'END_REG_READING1'
                ReadOnly = True
                Title.Caption = #1055#1086#1082#1072#1079#1072#1085#1080#1103' '#1076#1077#1085#1100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'END_REG_READING2'
                ReadOnly = True
                Title.Caption = #1055#1086#1082#1072#1079#1072#1085#1080#1103' '#1085#1086#1095#1100
                Width = 64
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CITY'
                ReadOnly = True
                Title.Caption = #1043#1086#1088#1086#1076
                Width = 120
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ADDRESS'
                ReadOnly = True
                Title.Caption = #1059#1083#1080#1094#1072', '#1076#1086#1084', '#1082#1074#1072#1088#1090#1080#1088#1072', '#1082#1086#1088#1087#1091#1089
                Width = 200
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'FIO'
                ReadOnly = True
                Title.Caption = #1060#1048#1054
                Width = 200
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'OP_AREA_DESCR'
                Title.Caption = #1050#1086#1085#1090#1088#1086#1083#1077#1088
                Width = 64
                Visible = True
              end>
          end
        end
        object ApprovalListTabSheet: TTabSheet
          Caption = #1057#1087#1080#1089#1086#1082' '#1085#1072' '#1091#1090#1074#1077#1088#1078#1076#1077#1085#1080#1077
          ImageIndex = 4
          OnShow = ApprovalListTabSheetShow
          object ApproveListGrid: TDBGridAlt
            Left = 0
            Top = 0
            Width = 1105
            Height = 771
            Align = alClient
            DataSource = MainDataModule.getApprovalListDataSource
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
            CheckedFont.Color = clRed
            CheckedFont.Height = -11
            CheckedFont.Name = 'MS Sans Serif'
            CheckedFont.Style = []
            EditableFont.Charset = DEFAULT_CHARSET
            EditableFont.Color = clBlack
            EditableFont.Height = -11
            EditableFont.Name = 'MS Sans Serif'
            EditableFont.Style = []
            OnChangeCheck = DBGridAltGeneralChangeCheck
            Columns = <
              item
                Expanded = False
                FieldName = 'ROWNUM'
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'CHECK_DATA'
                ReadOnly = True
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'ACCT_ID'
                Title.Caption = #1051#1080#1094#1077#1074#1086#1081' '#1089#1095#1077#1090
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ADDRESS'
                Title.Caption = #1040#1076#1088#1077#1089
                Width = 200
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'FIO'
                Title.Caption = #1060#1048#1054
                Width = 200
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'SALDO_UCH'
                ReadOnly = True
                Title.Caption = #1057#1072#1083#1100#1076#1086
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CC_DTTM'
                ReadOnly = True
                Title.Caption = #1044#1072#1090#1072' '#1082#1086#1085#1090#1072#1082#1090#1072
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'APPROVAL_DTTM'
                ReadOnly = True
                Title.Caption = #1044#1072#1090#1072' '#1091#1090#1074#1077#1088#1078#1076#1077#1085#1080#1103
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'FA_ID'
                Title.Caption = 'ID '#1076#1086#1082#1091#1084#1077#1085#1090#1072
                Width = 100
                Visible = True
              end>
          end
        end
        object StopListTabSheet: TTabSheet
          Caption = #1042#1074#1077#1076#1077#1085#1080#1077' '#1086#1075#1088#1072#1085#1080#1095#1077#1085#1080#1103
          ImageIndex = 2
          OnShow = StopListTabSheetShow
          object StopListGrid: TDBGridAlt
            Left = 0
            Top = 0
            Width = 1090
            Height = 900
            Align = alClient
            DataSource = MainDataModule.getStopListDataSource
            ReadOnly = True
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
            CheckedFont.Color = clRed
            CheckedFont.Height = -11
            CheckedFont.Name = 'MS Sans Serif'
            CheckedFont.Style = []
            EditableFont.Charset = DEFAULT_CHARSET
            EditableFont.Color = clBlack
            EditableFont.Height = -11
            EditableFont.Name = 'MS Sans Serif'
            EditableFont.Style = []
            OnChangeCheck = DBGridAltGeneralChangeCheck
            Columns = <
              item
                Expanded = False
                FieldName = 'CHECK_DATA'
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'ROWNUM'
                Title.Caption = 'N'
                Width = 50
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ACCT_ID'
                Title.Caption = #1051#1080#1094#1077#1074#1086#1081' '#1089#1095#1077#1090
                Width = 80
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'FA_PACK_ID'
                Title.Caption = #1056#1077#1077#1089#1090#1088
                Width = 80
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'FA_PACK_TYPE_DESCR'
                Title.Caption = #1058#1080#1087' '#1088#1077#1077#1089#1090#1088#1072
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CC_DTTM'
                Title.Caption = #1044#1072#1090#1072' '#1082#1086#1085#1090#1072#1082#1090#1072
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'APPROVAL_DTTM'
                Title.Caption = #1044#1072#1090#1072' '#1091#1090#1074#1077#1088#1078#1076#1077#1085#1080#1103
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'SPR_DESCR'
                Title.Caption = #1054#1073#1089#1083#1091#1078#1080#1074#1072#1102#1097#1072#1103' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
                Width = 300
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'FIO'
                Title.Caption = #1060#1048#1054
                Width = 160
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CITY'
                Title.Caption = #1053#1072#1089'. '#1087#1091#1085#1082#1090
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ADDRESS'
                Title.Caption = #1040#1076#1088#1077#1089
                Width = 200
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'SALDO_UCH'
                Title.Caption = #1057#1072#1083#1100#1076#1086
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PREM_TYPE_DESCR'
                Title.Caption = #1058#1080#1087' '#1054#1054
                Width = 100
                Visible = True
              end>
          end
        end
        object PackStopListTabSheet: TTabSheet
          Caption = #1057#1087#1080#1089#1086#1082' '#1088#1077#1077#1089#1090#1088#1086#1074' '#1085#1072' '#1086#1075#1088#1072#1085#1080#1095#1077#1085#1080#1077
          ImageIndex = 8
          OnShow = PackStopListTabSheetShow
          object PackStopListGrid: TDBGridAlt
            Left = 0
            Top = 0
            Width = 1090
            Height = 900
            Align = alClient
            DataSource = MainDataModule.getPackStopListDataSource
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
            CheckedFont.Color = clRed
            CheckedFont.Height = -11
            CheckedFont.Name = 'MS Sans Serif'
            CheckedFont.Style = []
            EditableFont.Charset = DEFAULT_CHARSET
            EditableFont.Color = clBlack
            EditableFont.Height = -11
            EditableFont.Name = 'MS Sans Serif'
            EditableFont.Style = []
            OnChangeCheck = DBGridAltGeneralChangeCheck
            Columns = <
              item
                Expanded = False
                FieldName = 'ROWNUM'
                Title.Caption = 'N'
                Width = 40
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CHECK_DATA'
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'FA_PACK_ID'
                Title.Caption = #1056#1077#1077#1089#1090#1088
                Width = 90
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CRE_DTTM'
                Title.Caption = #1044#1072#1090#1072' '#1088#1077#1077#1089#1090#1088#1072
                Width = 120
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ACCT_ID_CNT'
                Title.Caption = #1050#1086#1083'-'#1074#1086' '#1072#1073#1086#1085#1077#1085#1090#1086#1074
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ST_P_DT'
                Title.Caption = #1044#1072#1090#1072' '#1086#1090#1082#1083'.'
                Width = 90
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'FA_PACK_STATUS_DESCR'
                Title.Caption = #1057#1090#1072#1090#1091#1089' '#1088#1077#1077#1089#1090#1088#1072
                Width = 90
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'RECIPIENT_SPR_DESCR'
                Title.Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082' '#1091#1089#1083#1091#1075
                Width = 120
                Visible = True
              end>
          end
        end
        object PackStopTabSheet: TTabSheet
          Tag = 1
          Caption = #1056#1077#1077#1089#1090#1088' '#1079#1072#1103#1074#1086#1082' '#1085#1072' '#1086#1075#1088#1072#1085#1080#1095#1077#1085#1080#1077
          ImageIndex = 4
          OnShow = PackStopTabSheetShow
          object StopPackGrid: TDBGridAlt
            Left = 0
            Top = 0
            Width = 1090
            Height = 900
            Align = alClient
            DataSource = MainDataModule.getFaPackStopDataSource
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
            CheckedFont.Color = clRed
            CheckedFont.Height = -11
            CheckedFont.Name = 'MS Sans Serif'
            CheckedFont.Style = []
            EditableFont.Charset = DEFAULT_CHARSET
            EditableFont.Color = clBlack
            EditableFont.Height = -11
            EditableFont.Name = 'MS Sans Serif'
            EditableFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'ROWNUM'
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'CHECK_DATA'
                ReadOnly = True
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'FA_ID'
                ReadOnly = True
                Title.Caption = 'ID '#1076#1086#1082#1091#1084#1077#1085#1090#1072
                Width = 90
                Visible = True
              end
              item
                ButtonStyle = cbsEllipsis
                Expanded = False
                FieldName = 'CC_DTTM'
                Title.Caption = #1044#1072#1090#1072' '#1082#1086#1085#1090#1072#1082#1090#1072
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ST_P_DT'
                Title.Caption = #1044#1072#1090#1072' '#1087#1083#1072#1085'. '#1086#1075#1088'.'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'SA_END_DT'
                Title.Caption = #1044#1072#1090#1072' '#1086#1090#1082#1083'. '#1056#1044#1054
                Width = 64
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ACCT_ID'
                ReadOnly = True
                Title.Caption = #1051#1080#1094#1077#1074#1086#1081' '#1089#1095#1077#1090
                Width = 90
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'SALDO_UCH'
                ReadOnly = True
                Title.Caption = #1057#1072#1083#1100#1076#1086
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'END_REG_READING1'
                ReadOnly = True
                Title.Caption = #1055#1086#1082#1072#1079#1072#1085#1080#1103' '#1076#1077#1085#1100
                Width = 64
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'END_REG_READING2'
                ReadOnly = True
                Title.Caption = #1055#1086#1082#1072#1079#1072#1085#1080#1103' '#1085#1086#1095#1100
                Width = 64
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CITY'
                ReadOnly = True
                Title.Caption = #1043#1086#1088#1086#1076
                Width = 120
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ADDRESS'
                ReadOnly = True
                Title.Caption = #1059#1083#1080#1094#1072', '#1076#1086#1084', '#1082#1074#1072#1088#1090#1080#1088#1072', '#1082#1086#1088#1087#1091#1089
                Width = 200
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'FIO'
                ReadOnly = True
                Title.Caption = #1060#1048#1054
                Width = 200
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'OP_AREA_DESCR'
                Title.Caption = #1050#1086#1085#1090#1088#1086#1083#1077#1088
                Width = 64
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'SPR_DESCR'
                Title.Caption = #1054#1073#1089#1083#1091#1078#1080#1074#1072#1102#1097#1072#1103' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
                Width = 64
                Visible = True
              end
              item
                Expanded = False
                Visible = True
              end>
          end
        end
        object FaCancelListTabSheet: TTabSheet
          Tag = 1
          Caption = #1054#1090#1079#1099#1074' '#1079#1072#1103#1074#1082#1080' '#1085#1072' '#1086#1075#1088#1072#1085#1080#1095#1077#1085#1080#1077
          ImageIndex = 5
          OnShow = FaCancelListTabSheetShow
          object FaCancelListGrid: TDBGridAlt
            Left = 0
            Top = 0
            Width = 1105
            Height = 771
            Align = alClient
            DataSource = MainDataModule.getFaCancelListDataSource
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
            CheckedFont.Color = clRed
            CheckedFont.Height = -11
            CheckedFont.Name = 'MS Sans Serif'
            CheckedFont.Style = []
            EditableFont.Charset = DEFAULT_CHARSET
            EditableFont.Color = clBlack
            EditableFont.Height = -11
            EditableFont.Name = 'MS Sans Serif'
            EditableFont.Style = []
            Columns = <
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
                FieldName = 'CHECK_DATA'
                ReadOnly = True
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'FA_PACK_ID'
                Title.Caption = #1056#1077#1077#1089#1090#1088
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CRE_DTTM'
                Title.Caption = #1044#1072#1090#1072' '#1088#1077#1077#1089#1090#1088#1072
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'FA_PACK_STATUS_FLG'
                Title.Caption = #1057#1090#1072#1090#1091#1089
                Width = 40
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PRNT_FA_ID'
                Title.Caption = #1047#1072#1103#1074#1082#1072
                Width = 90
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'FA_ID'
                Width = 90
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'RT_SPR'
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'RT_ADDR'
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'RT_POST'
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'RT_NAME'
                Width = 100
                Visible = True
              end>
          end
        end
        object PackReloadTabSheet: TTabSheet
          Tag = 1
          Caption = #1047#1072#1103#1074#1082#1080' '#1085#1072' '#1074#1086#1079#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077
          ImageIndex = 7
          object FaResumptionList: TDBGridAlt
            Left = 0
            Top = 0
            Width = 906
            Height = 842
            Align = alClient
            DataSource = MainDataModule.getFaPackStopDataSource
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
            CheckedFont.Color = clRed
            CheckedFont.Height = -11
            CheckedFont.Name = 'MS Sans Serif'
            CheckedFont.Style = []
            EditableFont.Charset = DEFAULT_CHARSET
            EditableFont.Color = clBlack
            EditableFont.Height = -11
            EditableFont.Name = 'MS Sans Serif'
            EditableFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'ROWNUM'
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'CHECK_DATA'
                ReadOnly = True
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'FA_ID'
                ReadOnly = True
                Title.Caption = 'ID '#1076#1086#1082#1091#1084#1077#1085#1090#1072
                Width = 90
                Visible = True
              end
              item
                ButtonStyle = cbsEllipsis
                Expanded = False
                FieldName = 'CC_DTTM'
                Title.Caption = #1044#1072#1090#1072' '#1082#1086#1085#1090#1072#1082#1090#1072
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ST_P_DT'
                Title.Caption = #1044#1072#1090#1072' '#1086#1075#1088'.'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ACCT_ID'
                ReadOnly = True
                Title.Caption = #1051#1080#1094#1077#1074#1086#1081' '#1089#1095#1077#1090
                Width = 90
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'SALDO_UCH'
                ReadOnly = True
                Title.Caption = #1057#1072#1083#1100#1076#1086
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'END_REG_READING1'
                ReadOnly = True
                Title.Caption = #1055#1086#1082#1072#1079#1072#1085#1080#1103' '#1076#1077#1085#1100
                Width = 64
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'END_REG_READING2'
                ReadOnly = True
                Title.Caption = #1055#1086#1082#1072#1079#1072#1085#1080#1103' '#1085#1086#1095#1100
                Width = 64
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CITY'
                ReadOnly = True
                Title.Caption = #1043#1086#1088#1086#1076
                Width = 120
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ADDRESS'
                ReadOnly = True
                Title.Caption = #1059#1083#1080#1094#1072', '#1076#1086#1084', '#1082#1074#1072#1088#1090#1080#1088#1072', '#1082#1086#1088#1087#1091#1089
                Width = 200
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'FIO'
                ReadOnly = True
                Title.Caption = #1060#1048#1054
                Width = 200
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'OP_AREA_DESCR'
                Title.Caption = #1050#1086#1085#1090#1088#1086#1083#1077#1088
                Width = 64
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'SPR_DESCR'
                Title.Caption = #1054#1073#1089#1083#1091#1078#1080#1074#1072#1102#1097#1072#1103' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
                Width = 64
                Visible = True
              end>
          end
        end
        object PostListTabSheet: TTabSheet
          Caption = #1057#1087#1080#1089#1086#1082' '#1085#1072' '#1087#1086#1095#1090#1091
          ImageIndex = 9
          OnShow = PostListTabSheetShow
          object PostListGrid: TDBGridAlt
            Left = 0
            Top = 0
            Width = 906
            Height = 842
            Align = alClient
            DataSource = MainDataModule.getPostListDataSource
            ReadOnly = True
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
            CheckedFont.Color = clRed
            CheckedFont.Height = -11
            CheckedFont.Name = 'MS Sans Serif'
            CheckedFont.Style = []
            EditableFont.Charset = DEFAULT_CHARSET
            EditableFont.Color = clBlack
            EditableFont.Height = -11
            EditableFont.Name = 'MS Sans Serif'
            EditableFont.Style = []
            OnChangeCheck = DBGridAltGeneralChangeCheck
            OnChangeFilter = DBGridAltGeneralChangeFilter
            Columns = <
              item
                Expanded = False
                FieldName = 'ROWNUM'
                Title.Caption = '#'
                Width = 40
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ACCT_ID'
                Title.Caption = #1051#1080#1094#1077#1074#1086#1081' '#1089#1095#1077#1090
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'FA_PACK_ID'
                Title.Caption = #1056#1077#1077#1089#1090#1088
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CRE_DTTM'
                Title.Caption = #1044#1072#1090#1072' '#1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1103
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'SALDO_BT_UCH'
                Width = 64
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'SALDO_ACT_UCH'
                Width = 64
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'FIO'
                Title.Caption = #1060#1048#1054
                Width = 200
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CITY'
                Title.Caption = #1043#1086#1088#1086#1076
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ADDRESS'
                Title.Caption = #1040#1076#1088#1077#1089
                Width = 200
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'SALDO_UCH'
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'SALDO_M3'
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'SERVICE_ORG'
                Title.Caption = #1054#1073#1089#1083#1091#1078#1080#1074#1072#1102#1097#1072#1103' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
                Width = 200
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'OP_AREA_DESCR'
                Title.Caption = #1050#1086#1085#1090#1088#1086#1083#1077#1088
                Width = 200
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CHECK_DATA'
                Visible = False
              end>
          end
        end
        object FullListTabSheet: TTabSheet
          Caption = #1042#1089#1077' '#1072#1073#1086#1085#1077#1085#1090#1099
          ImageIndex = 10
          OnShow = FullListTabSheetShow
          object FullListGrid: TDBGridAlt
            Left = 0
            Top = 0
            Width = 906
            Height = 842
            Align = alClient
            DataSource = MainDataModule.getFullListDataSource
            ReadOnly = True
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
            CheckedFont.Color = clRed
            CheckedFont.Height = -11
            CheckedFont.Name = 'MS Sans Serif'
            CheckedFont.Style = []
            EditableFont.Charset = DEFAULT_CHARSET
            EditableFont.Color = clBlack
            EditableFont.Height = -11
            EditableFont.Name = 'MS Sans Serif'
            EditableFont.Style = []
            OnChangeCheck = DBGridAltGeneralChangeCheck
            OnChangeFilter = DBGridAltGeneralChangeFilter
            Columns = <
              item
                Expanded = False
                FieldName = 'CHECK_DATA'
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'ROWNUM'
                Title.Caption = 'N'
                Width = 50
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ACCT_ID'
                Title.Caption = #1051#1080#1094#1077#1074#1086#1081' '#1089#1095#1077#1090
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'FIO'
                Title.Caption = #1060#1048#1054
                Width = 160
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CITY'
                Title.Caption = #1053#1072#1089'. '#1087#1091#1085#1082#1090
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ADDRESS'
                Title.Caption = #1040#1076#1088#1077#1089
                Width = 200
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PREM_TYPE_DESCR'
                Title.Caption = #1058#1080#1087' '#1054#1054
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'SALDO_UCH'
                Title.Caption = #1057#1072#1083#1100#1076#1086
                Width = 70
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'SALDO_M3'
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'SERVICE_ORG'
                Title.Caption = #1054#1073#1089#1083#1091#1078#1080#1074#1072#1102#1097#1072#1103' '#1086#1088#1075'-'#1103
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'OP_AREA_DESCR'
                Title.Caption = #1050#1086#1085#1090#1088#1086#1083#1077#1088
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CC_DTTM'
                Title.Caption = #1044#1072#1090#1072' '#1082#1086#1085#1090#1072#1082#1090#1072
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'FA_ID'
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'FA_PACK_ID'
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CRE_DTTM'
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DEBTOR_FLG'
                Title.Caption = #1044#1086#1083#1078#1085#1080#1082
                Visible = True
              end>
          end
        end
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 1113
      Height = 40
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object SelectAcctPopupMenuPanel: TPanel
        Left = 0
        Top = 8
        Width = 65
        Height = 25
        TabOrder = 0
        object ShowSelectAcctMenuButton: TBitBtn
          Left = 30
          Top = 0
          Width = 35
          Height = 25
          Caption = '...'
          TabOrder = 0
          OnKeyPress = ShowSelectAcctMenuButtonKeyPress
          OnMouseDown = ShowSelectAcctMenuButtonMouseDown
        end
        object SelectAllCheckBox: TCheckBox
          Left = 9
          Top = 4
          Width = 17
          Height = 17
          AllowGrayed = True
          Caption = 'SelectAllCheckBox'
          Checked = True
          State = cbChecked
          TabOrder = 1
          OnClick = SelectAllCheckBoxClick
        end
      end
      object ShowActionsMenuButton: TBitBtn
        Left = 72
        Top = 8
        Width = 75
        Height = 25
        Caption = #1044#1077#1081#1089#1090#1074#1080#1103
        TabOrder = 1
        OnMouseDown = ShowActionsMenuButtonMouseDown
      end
      object ShowDocumentsMenuButton: TBitBtn
        Left = 152
        Top = 8
        Width = 75
        Height = 25
        Caption = #1044#1086#1082#1091#1084#1077#1085#1090#1099
        TabOrder = 2
        OnMouseDown = ShowDocumentsMenuButtonMouseDown
      end
      object Button6: TButton
        Left = 238
        Top = 7
        Width = 75
        Height = 25
        Caption = 'TestButton'
        TabOrder = 3
        Visible = False
        OnClick = Button6Click
      end
    end
  end
  object LeftPanel: TPanel
    Left = 0
    Top = 0
    Width = 289
    Height = 846
    Align = alLeft
    BevelOuter = bvNone
    BorderWidth = 2
    TabOrder = 2
    object GroupBox7: TGroupBox
      Left = 8
      Top = 40
      Width = 273
      Height = 73
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
      Color = clBtnFace
      ParentColor = False
      TabOrder = 0
      object Label2: TLabel
        Left = 16
        Top = 24
        Width = 42
        Height = 13
        Caption = #1059#1095#1072#1089#1090#1086#1082
      end
      object Label6: TLabel
        Left = 16
        Top = 48
        Width = 56
        Height = 13
        Caption = 'ID '#1056#1077#1077#1089#1090#1088#1072
      end
      object ParamPackIdEdit: TEdit
        Left = 96
        Top = 40
        Width = 129
        Height = 21
        Color = clBtnFace
        TabOrder = 0
        Text = 'ParamPackIdEdit'
        OnDblClick = ParamPackIdEditClick
        OnKeyPress = ParamPackIdEditKeyPress
      end
      object OtdelenComboBox: TDBLookupComboBox
        Left = 96
        Top = 16
        Width = 161
        Height = 21
        DropDownRows = 11
        KeyField = 'ACCT_OTDELEN'
        ListField = 'ACCT_OTDELEN; OTDELEN_DESCR'
        ListFieldIndex = 1
        ListSource = MainDataModule.getOtdelenListDataSource
        ParentColor = True
        TabOrder = 1
        OnClick = OtdelenComboBoxClick
      end
      object BitBtn1: TBitBtn
        Left = 232
        Top = 40
        Width = 25
        Height = 21
        Caption = '...'
        TabOrder = 2
        OnClick = ParamPackIdEditClick
      end
    end
    object SelectModeComboBox: TComboBox
      Left = 8
      Top = 8
      Width = 273
      Height = 28
      Style = csDropDownList
      Color = 4194304
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindow
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ItemHeight = 20
      ParentFont = False
      TabOrder = 1
      OnChange = SelectModeComboBoxChange
    end
    object FilterGroupBox: TGroupBox
      Left = 8
      Top = 120
      Width = 273
      Height = 617
      Caption = #1060#1080#1083#1100#1090#1088
      Color = clBtnFace
      Ctl3D = True
      ParentColor = False
      ParentCtl3D = False
      TabOrder = 2
      object AcctIdFilterPanel: TPanel
        Left = 2
        Top = 15
        Width = 269
        Height = 31
        Align = alTop
        Alignment = taLeftJustify
        BorderWidth = 4
        Caption = #1051#1080#1094#1077#1074#1086#1081
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 0
        Visible = False
        object AcctIdComboBox: TEditAlt
          Left = 96
          Top = 5
          Width = 161
          Height = 21
          TabOrder = 0
          Text = '0'
          OnChange = FilterEditTextChange
          AllowNull = True
        end
      end
      object CityFilterPanel: TPanel
        Left = 2
        Top = 77
        Width = 269
        Height = 31
        Align = alTop
        Alignment = taLeftJustify
        BorderWidth = 4
        Caption = #1053#1072#1089'. '#1087#1091#1085#1082#1090
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 1
        Visible = False
        object CityComboBox: TComboBox
          Left = 96
          Top = 5
          Width = 161
          Height = 21
          ItemHeight = 13
          TabOrder = 0
          OnChange = FilterComboBoxTextChange
        end
      end
      object AddressFilterPanel: TPanel
        Left = 2
        Top = 139
        Width = 269
        Height = 31
        Align = alTop
        Alignment = taLeftJustify
        BorderWidth = 4
        Caption = #1040#1076#1088#1077#1089
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 2
        Visible = False
        object AddressComboBox: TComboBox
          Left = 96
          Top = 5
          Width = 161
          Height = 21
          ItemHeight = 13
          TabOrder = 0
          OnChange = FilterComboBoxTextChange
        end
      end
      object FioFilterPanel: TPanel
        Left = 2
        Top = 46
        Width = 269
        Height = 31
        Align = alTop
        Alignment = taLeftJustify
        BorderWidth = 4
        Caption = #1060#1048#1054
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 3
        Visible = False
        object FioComboBox: TEdit
          Left = 96
          Top = 5
          Width = 161
          Height = 21
          TabOrder = 0
          Text = 'FioComboBox'
          OnChange = FilterEditTextChange
        end
      end
      object SaldoFilterPanel: TPanel
        Left = 2
        Top = 170
        Width = 269
        Height = 31
        Align = alTop
        Alignment = taLeftJustify
        BorderWidth = 4
        Caption = #1057#1072#1083#1100#1076#1086' >'
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 4
        Visible = False
        object SaldoFilterEdit: TEditAlt
          Left = 96
          Top = 5
          Width = 161
          Height = 21
          TabOrder = 0
          Text = '0'
          OnChange = FilterEditTextChange
          AllowNull = True
          AllowDot = True
          AllowSign = True
        end
      end
      object ServiceCompanyFilterPanel: TPanel
        Left = 2
        Top = 232
        Width = 269
        Height = 31
        Align = alTop
        Alignment = taLeftJustify
        BorderWidth = 4
        Caption = #1054#1073#1089#1083#1091#1078'. '#1086#1088#1075'-'#1103
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 5
        Visible = False
        object ServiceCompanyFilterComboBox: TComboBox
          Left = 96
          Top = 5
          Width = 161
          Height = 21
          ItemHeight = 13
          TabOrder = 0
          OnChange = FilterComboBoxTextChange
        end
      end
      object FaPackIdFilterPanel: TPanel
        Left = 2
        Top = 296
        Width = 269
        Height = 33
        Align = alTop
        Alignment = taLeftJustify
        BorderWidth = 4
        Caption = #1056#1077#1077#1089#1090#1088
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 6
        Visible = False
        object FaPackIdFilterEdit: TEditAlt
          Left = 96
          Top = 5
          Width = 161
          Height = 21
          TabOrder = 0
          Text = '0'
          OnChange = FilterEditTextChange
          AllowNull = True
        end
      end
      object FaPackTypeFilterPanel: TPanel
        Left = 2
        Top = 263
        Width = 269
        Height = 33
        Align = alTop
        Alignment = taLeftJustify
        BorderWidth = 4
        Caption = #1058#1080#1087' '#1088#1077#1077#1089#1090#1088#1072
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 12
        Visible = False
        object FaPackTypeFilterComboBox: TComboBox
          Left = 96
          Top = 5
          Width = 161
          Height = 21
          ItemHeight = 13
          TabOrder = 0
          OnChange = FilterComboBoxTextChange
          Items.Strings = (
            #1055#1086' '#1087#1086#1095#1090#1077
            #1044#1083#1103' '#1082#1086#1085#1090#1088#1086#1083#1077#1088#1072)
        end
      end
      object PremTypeFilterPanel: TPanel
        Left = 2
        Top = 108
        Width = 269
        Height = 31
        Align = alTop
        Alignment = taLeftJustify
        BorderWidth = 4
        Caption = #1058#1080#1087' '#1054#1054
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 13
        Visible = False
        object PremTypeComboBox: TComboBox
          Left = 96
          Top = 5
          Width = 161
          Height = 21
          ItemHeight = 13
          TabOrder = 0
          OnChange = FilterComboBoxTextChange
          Items.Strings = (
            #1050#1074#1072#1088#1090#1080#1088#1072
            #1063#1072#1089#1090#1085#1099#1081' '#1078#1080#1083#1086#1081' '#1076#1086#1084
            #1050#1086#1084#1091#1085#1072#1083#1100#1085#1072#1103' '#1082#1074#1072#1088#1090#1080#1088#1072)
        end
      end
      object OpAreaDescrFilterPanel: TPanel
        Left = 2
        Top = 201
        Width = 269
        Height = 31
        Align = alTop
        Alignment = taLeftJustify
        BorderWidth = 4
        Caption = #1050#1086#1085#1090#1088#1086#1083#1077#1088
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 7
        Visible = False
        object OpAreaDescrFilterComboBox: TComboBox
          Left = 96
          Top = 5
          Width = 161
          Height = 21
          ItemHeight = 13
          TabOrder = 0
          OnChange = FilterComboBoxTextChange
        end
      end
      object CcDttmExistsFilterPanel: TPanel
        Left = 2
        Top = 329
        Width = 269
        Height = 56
        Align = alTop
        Alignment = taLeftJustify
        BorderWidth = 4
        TabOrder = 8
        Visible = False
        object Label4: TLabel
          Left = 5
          Top = 9
          Width = 41
          Height = 13
          Caption = #1050#1086#1085#1090#1072#1082#1090
        end
        object CcDttmStatusComboBox: TComboBox
          Left = 96
          Top = 5
          Width = 161
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnChange = CcDttmStatusComboBoxChange
          Items.Strings = (
            #1042#1089#1077
            #1050#1086#1085#1090#1072#1082#1090' '#1077#1089#1090#1100
            #1050#1086#1085#1090#1072#1082#1090' '#1086#1090#1089#1091#1090#1089#1090#1074#1091#1077#1090
            #1042' '#1076#1080#1072#1087#1072#1079#1086#1085#1077)
        end
        object ccDttmPeriodPanel: TPanel
          Left = 16
          Top = 29
          Width = 241
          Height = 25
          BevelOuter = bvNone
          TabOrder = 1
          object Label1: TLabel
            Left = 144
            Top = 8
            Width = 12
            Height = 13
            Caption = #1076#1086
          end
          object Label7: TLabel
            Left = 24
            Top = 8
            Width = 11
            Height = 13
            Caption = #1086#1090
          end
          object DateTimePicker2: TDateTimePicker
            Left = 160
            Top = 0
            Width = 81
            Height = 21
            CalAlignment = dtaLeft
            Date = 42731.6390556019
            Time = 42731.6390556019
            DateFormat = dfShort
            DateMode = dmComboBox
            Kind = dtkDate
            ParseInput = False
            TabOrder = 0
            OnChange = FilterCcDttmChange
          end
          object DateTimePicker1: TDateTimePicker
            Left = 40
            Top = 0
            Width = 81
            Height = 21
            CalAlignment = dtaLeft
            Date = 42731.6390556019
            Time = 42731.6390556019
            DateFormat = dfShort
            DateMode = dmComboBox
            Kind = dtkDate
            ParseInput = False
            TabOrder = 1
            OnChange = FilterCcDttmChange
          end
        end
      end
      object TemporaryUnusedFilterPanel: TPanel
        Left = 2
        Top = 385
        Width = 269
        Height = 32
        Align = alTop
        Alignment = taLeftJustify
        BorderWidth = 4
        Caption = #1053#1077' '#1080#1089#1087#1086#1083#1100#1079#1091#1077#1090#1089#1103
        TabOrder = 9
        Visible = False
      end
      object ccDttmIsApprovedFilterPanel: TPanel
        Left = 2
        Top = 417
        Width = 269
        Height = 33
        Align = alTop
        Alignment = taLeftJustify
        BorderWidth = 4
        Caption = #1057#1090#1072#1090#1091#1089' '#1091#1090#1074'.'
        TabOrder = 10
        Visible = False
        object ApprovedStatusComboBox: TComboBox
          Left = 96
          Top = 5
          Width = 161
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 0
          Text = #1042#1089#1077
          OnChange = FilterComboBoxIndexChange
          Items.Strings = (
            #1042#1089#1077
            #1059#1090#1074#1077#1088#1078#1076#1077#1085#1085#1099#1077
            #1053#1077' '#1091#1090#1074#1077#1088#1078#1076#1077#1085#1085#1099#1077)
        end
      end
      object RstButtonFilterPanel: TPanel
        Left = 2
        Top = 450
        Width = 269
        Height = 59
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 11
        object ResetFiltersButton: TBitBtn
          Left = 104
          Top = 16
          Width = 153
          Height = 33
          Caption = #1057#1073#1088#1086#1089#1080#1090#1100' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
          TabOrder = 0
          OnClick = ResetFiltersButtonClick
        end
        object FilterSplitterPanel: TPanel
          Left = 0
          Top = 0
          Width = 269
          Height = 2
          Align = alTop
          BevelOuter = bvNone
          Color = clDefault
          TabOrder = 1
          Visible = False
        end
      end
    end
    object Panel3: TPanel
      Left = 2
      Top = 735
      Width = 285
      Height = 109
      Align = alBottom
      BevelOuter = bvNone
      BorderWidth = 3
      TabOrder = 3
      object SummaryInfoGroupBox: TGroupBox
        Left = 3
        Top = 3
        Width = 279
        Height = 103
        Align = alClient
        Caption = #1048#1090#1086#1075#1080
        Enabled = False
        TabOrder = 0
        object Label16: TLabel
          Left = 16
          Top = 40
          Width = 80
          Height = 13
          Caption = #1054#1090#1092#1080#1083#1100#1090#1088#1086#1074#1072#1085#1086
        end
        object Label15: TLabel
          Left = 16
          Top = 56
          Width = 30
          Height = 13
          Caption = #1042#1089#1077#1075#1086
        end
        object Label14: TLabel
          Left = 16
          Top = 24
          Width = 81
          Height = 13
          Caption = #1050#1086#1083'-'#1074#1086' '#1074#1099#1073#1088#1072#1085#1086
        end
        object SelectedStatLabel: TLabel
          Left = 152
          Top = 24
          Width = 87
          Height = 13
          Caption = 'SelectedStatLabel'
        end
        object TotalStatLabel: TLabel
          Left = 152
          Top = 56
          Width = 69
          Height = 13
          Caption = 'TotalStatLabel'
        end
        object FilteredStatLabel: TLabel
          Left = 152
          Top = 40
          Width = 79
          Height = 13
          Caption = 'FilteredStatLabel'
        end
      end
    end
  end
  object DocumentsPopupMenu: TPopupMenu
    Left = 360
    Top = 152
    object N4: TMenuItem
      Action = printDocumentFaNoticesAction
    end
    object N5: TMenuItem
      Action = printDocumentFaNoticesListAction
    end
    object N11: TMenuItem
      Action = printFaNoticeEnvelopeAction
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object DocumentStopMenuItem: TMenuItem
      Action = printDocumentStopAction
    end
    object N8: TMenuItem
      Action = printDocumentStopListAction
    end
    object N7: TMenuItem
      Action = printDocumentStopActionRefuseAction
    end
  end
  object ActionList1: TActionList
    Left = 320
    Top = 120
    object createFaPackStopToControlAction: TAction
      Category = 'Actions_stop'
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1088#1077#1077#1089#1090#1088' '#1079#1072#1103#1074#1086#1082' '#1085#1072' '#1086#1075#1088#1072#1085#1080#1095#1077#1085#1080#1077' ('#1082#1086#1085#1090#1088#1086#1083#1077#1088#1091')'
      OnExecute = createFaPackStopActionExecute
      OnUpdate = createFaPackNoticeActionUpdate
    end
    object printFaNoticeEnvelopeAction: TAction
      Category = 'Reports'
      Caption = #1055#1077#1095#1072#1090#1100' '#1082#1086#1085#1074#1077#1088#1090#1086#1074' '#1076#1083#1103' '#1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1081
      Enabled = False
      OnExecute = printFaNoticeEnvelopeActionExecute
      OnUpdate = createFaPackNoticeActionUpdate
    end
    object createFaPackFree_old: TAction
      Category = 'Actions_notice'
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1089#1074#1086#1073#1086#1076#1085#1099#1081' '#1088#1077#1077#1089#1090#1088' '#1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1081' '#1082#1086#1085#1090#1088#1086#1083#1077#1088#1091
      OnExecute = createFaPackFree_oldExecute
    end
    object printDocumentFaNoticesListAction: TAction
      Category = 'Reports'
      Caption = #1055#1077#1095#1072#1090#1100' '#1089#1087#1080#1089#1082#1072' '#1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1081
      Enabled = False
      OnExecute = printDocumentFaNoticesListActionExecute
      OnUpdate = createFaPackNoticeActionUpdate
    end
    object createFaPackPostAction: TAction
      Category = 'Actions_notice'
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1088#1077#1077#1089#1090#1088' '#1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1081' '#1087#1086' '#1087#1086#1095#1090#1077
      OnExecute = createFaPackPostActionExecute
      OnUpdate = createFaPackNoticeActionUpdate
    end
    object printDocumentStopAction: TAction
      Category = 'Reports'
      Caption = #1055#1077#1095#1072#1090#1100' '#1079#1072#1103#1074#1086#1082' '#1085#1072' '#1086#1090#1082#1083#1102#1095#1077#1085#1080#1077
      Enabled = False
      OnExecute = printDocumentStopActionExecute
      OnUpdate = createFaPackNoticeActionUpdate
    end
    object createFaPackStopAction: TAction
      Category = 'Actions_stop'
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1088#1077#1077#1089#1090#1088' '#1079#1072#1103#1074#1086#1082' '#1085#1072' '#1086#1075#1088#1072#1085#1080#1095#1077#1085#1080#1077
      OnExecute = createFaPackStopActionExecute
      OnUpdate = createFaPackNoticeActionUpdate
    end
    object printDocumentFaNoticesAction: TAction
      Category = 'Reports'
      Caption = #1055#1077#1095#1072#1090#1100' '#1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1081' '#1072#1073#1086#1085#1077#1085#1090#1091
      Enabled = False
      OnExecute = printDocumentFaNoticesActionExecute
      OnUpdate = createFaPackNoticeActionUpdate
    end
    object printDocumentStopListAction: TAction
      Category = 'Reports'
      Caption = #1055#1077#1095#1072#1090#1100' '#1089#1087#1080#1089#1082#1072' '#1079#1072#1103#1074#1086#1082' '#1085#1072' '#1086#1090#1082#1083#1102#1095#1077#1085#1080#1077
      Enabled = False
      OnUpdate = createFaPackNoticeActionUpdate
    end
    object printDocumentStopActionRefuseAction: TAction
      Category = 'Reports'
      Caption = #1055#1077#1095#1072#1090#1100' '#1079#1072#1103#1074#1086#1082' '#1085#1072' '#1086#1090#1084#1077#1085#1091' '#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103
      Enabled = False
      OnUpdate = createFaPackNoticeActionUpdate
    end
    object createFaPackAction: TAction
      Category = 'Actions_notice'
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1088#1077#1077#1089#1090#1088' '#1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1081' '#1082#1086#1085#1090#1088#1086#1083#1077#1088#1091
      OnExecute = createFaPackActionExecute
      OnUpdate = createFaPackNoticeActionUpdate
    end
    object approveFaPackCcDttmAction: TAction
      Category = 'Actions_notice'
      Caption = #1059#1090#1074#1077#1088#1076#1080#1090#1100' '#1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1103
      OnExecute = approveFaPackCcDttmActionExecute
      OnUpdate = createFaPackNoticeActionUpdate
    end
    object checkAllAction: TAction
      Tag = 1
      Category = 'Check'
      Caption = #1042#1089#1077
      OnExecute = checkAllActionExecute
      OnUpdate = checkAllActionUpdate
    end
    object checkNoneAction: TAction
      Category = 'Check'
      Caption = #1053#1080' '#1086#1076#1085#1086#1075#1086
      OnExecute = checkNoneActionExecute
      OnUpdate = checkAllActionUpdate
    end
    object checkWithoutCcAction: TAction
      Category = 'Check'
      Caption = #1041#1077#1079' '#1076#1072#1090#1099' '#1082#1086#1085#1090#1072#1082#1090#1072
      OnExecute = checkWithoutCcActionExecute
      OnUpdate = checkAllActionUpdate
    end
    object checkWithCcLess3MonthAction: TAction
      Category = 'Check'
      Caption = #1057' '#1076#1072#1090#1086#1081' '#1082#1086#1085#1090#1072#1082#1090#1072' '#1088#1072#1085#1077#1077' 3'#1093' '#1084#1077#1089#1103#1094#1077#1074
      OnExecute = checkWithCcLess3MonthActionExecute
      OnUpdate = checkAllActionUpdate
    end
    object updateCcAction: TAction
      Category = 'Actions_notice'
      Caption = #1042#1074#1077#1089#1090#1080' '#1076#1072#1090#1091' '#1082#1086#1085#1090#1072#1082#1090#1072' '#1089' '#1072#1073#1086#1085#1077#1085#1090#1086#1084
      OnExecute = updateCcActionExecute
    end
    object createFaCancelPackAction: TAction
      Category = 'Actions_stop'
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1088#1077#1077#1089#1090#1088' '#1085#1072' '#1086#1090#1084#1077#1085#1091' '#1079#1072#1103#1074#1082#1080' '#1085#1072' '#1086#1075#1088#1072#1085#1080#1095#1077#1085#1080#1077
    end
    object deleteFaPackAction: TAction
      Category = 'Actions_stop'
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1088#1077#1077#1089#1090#1088
      OnExecute = deleteFaPackActionExecute
    end
    object setFaPackStatusIncompleteAction: TAction
      Category = 'Actions_stop'
      Caption = #1055#1077#1088#1077#1074#1077#1089#1090#1080' '#1088#1077#1077#1089#1090#1088' '#1074' '#1089#1090#1072#1090#1091#1089' ['#1053#1077' '#1079#1072#1074#1077#1088#1096#1077#1085']'
      OnExecute = setFaPackStatusIncompleteActionExecute
    end
    object setFaPackStatusFrozenAction: TAction
      Category = 'Actions_stop'
      Caption = #1055#1077#1088#1077#1074#1077#1089#1090#1080' '#1088#1077#1077#1089#1090#1088' '#1074' '#1089#1090#1072#1090#1091#1089' ['#1059#1090#1074#1077#1088#1078#1076#1077#1085']'
      OnExecute = setFaPackStatusFrozenActionExecute
    end
  end
  object ActionsPopupMenu: TPopupMenu
    Left = 400
    Top = 152
    object MenuItem1: TMenuItem
      Action = createFaPackAction
    end
    object N16: TMenuItem
      Action = createFaPackStopToControlAction
    end
    object MenuItem2: TMenuItem
      Action = approveFaPackCcDttmAction
    end
    object N9: TMenuItem
      Action = createFaPackStopAction
    end
    object N10: TMenuItem
      Action = createFaPackPostAction
    end
    object N12: TMenuItem
      Action = createFaCancelPackAction
    end
    object N13: TMenuItem
      Action = deleteFaPackAction
    end
    object N14: TMenuItem
      Action = setFaPackStatusIncompleteAction
    end
    object N15: TMenuItem
      Action = setFaPackStatusFrozenAction
    end
  end
  object ActionList2: TActionList
    Left = 368
    Top = 120
    object Action11: TAction
      Tag = 1
      Category = 'Check'
      Caption = #1042#1089#1077
      Enabled = False
      OnExecute = checkAllActionExecute
    end
    object Action12: TAction
      Category = 'Check'
      Caption = #1053#1080' '#1086#1076#1085#1086#1075#1086
      Enabled = False
      OnExecute = checkNoneActionExecute
    end
    object Action13: TAction
      Category = 'Check'
      Caption = #1041#1077#1079' '#1076#1072#1090#1099' '#1082#1086#1085#1090#1072#1082#1090#1072
      Enabled = False
      OnExecute = checkWithoutCcActionExecute
    end
    object Action14: TAction
      Category = 'Check'
      Caption = #1057' '#1076#1072#1090#1086#1081' '#1082#1086#1085#1090#1072#1082#1090#1072' '#1088#1072#1085#1077#1077' 3'#1093' '#1084#1077#1089#1103#1094#1077#1074
      Enabled = False
      OnExecute = checkWithCcLess3MonthActionExecute
    end
  end
  object SelectAcctPopupMenu: TPopupMenu
    Left = 320
    Top = 152
    object N1: TMenuItem
      Action = checkAllAction
    end
    object N2: TMenuItem
      Action = checkNoneAction
    end
    object N3: TMenuItem
      Action = checkWithoutCcAction
    end
    object N31: TMenuItem
      Action = checkWithCcLess3MonthAction
    end
  end
end
