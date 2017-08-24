object MainDataModule: TMainDataModule
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 349
  Top = 159
  Height = 873
  Width = 1777
  object EsaleSession: TOraSession
    Tag = 1
    Options.Charset = 'CL8MSWIN1251'
    Options.DateFormat = 'DD-MON-RR'
    Options.DateLanguage = 'AMERICAN'
    Options.Direct = True
    Username = 'admin'
    Server = '10.7.0.10:1521:esale'
    AutoCommit = False
    Connected = True
    LoginPrompt = False
    AfterDisconnect = EsaleSessionAfterDisconnect
    Left = 24
    Top = 16
    EncryptedPassword = '94FF8AFF85FF92FF9AFF93FF'
  end
  object getPreDebtorListDataSource: TOraDataSource
    DataSet = getPreDebtorListProc
    Left = 456
    Top = 8
  end
  object CreateFaProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.CREATE_FA'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      
        '  :RESULT := PK_NASEL_SWEETY.CREATE_FA(:P_ACCT_ID, :P_FA_PACK_ID' +
        ');'
      'end;')
    Left = 1120
    Top = 776
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'RESULT'
        ParamType = ptResult
        Size = 10
        IsResult = True
      end
      item
        DataType = ftFixedChar
        Name = 'P_ACCT_ID'
        ParamType = ptInput
      end
      item
        DataType = ftFixedChar
        Name = 'P_FA_PACK_ID'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.CREATE_FA'
  end
  object CreateFaPackProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.CREATE_FP'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      
        '  :RESULT := PK_NASEL_SWEETY.CREATE_FP(:P_FA_PACK_TYPE_CD, :P_PR' +
        'NT_FA_PACK_ID, :P_ACCT_OTDELEN);'
      'end;')
    Left = 1024
    Top = 600
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'RESULT'
        ParamType = ptResult
        Size = 10
        IsResult = True
      end
      item
        DataType = ftFixedChar
        Name = 'P_FA_PACK_TYPE_CD'
        ParamType = ptInput
      end
      item
        DataType = ftFixedChar
        Name = 'P_PRNT_FA_PACK_ID'
        ParamType = ptInput
        HasDefault = True
      end
      item
        DataType = ftFixedChar
        Name = 'P_ACCT_OTDELEN'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.CREATE_FP'
  end
  object getFpNoticesContentDataSource: TOraDataSource
    DataSet = getFpNoticesContentProc
    Left = 576
    Top = 8
  end
  object addCcProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.ADD_FA_CC'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      
        '  :RESULT := PK_NASEL_SWEETY.ADD_FA_CC(:P_CC_DTTM, :P_CC_TYPE_CD' +
        ', :P_ACCT_ID, :P_DESCR, :P_SRC_ID, :P_SRC_TYPE_CD, :P_CALLER);'
      'end;')
    Left = 1168
    Top = 600
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'RESULT'
        Size = 10
        IsResult = True
      end
      item
        DataType = ftDateTime
        Name = 'P_CC_DTTM'
        ParamType = ptInputOutput
      end
      item
        DataType = ftFixedChar
        Name = 'P_CC_TYPE_CD'
        ParamType = ptInput
      end
      item
        DataType = ftFixedChar
        Name = 'P_ACCT_ID'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'P_DESCR'
        ParamType = ptInput
      end
      item
        DataType = ftFixedChar
        Name = 'P_SRC_ID'
        ParamType = ptInput
      end
      item
        DataType = ftFixedChar
        Name = 'P_SRC_TYPE_CD'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'P_CALLER'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.ADD_FA_CC'
  end
  object setCcStatusFlgProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.SET_CC_STATUS_FLG'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.SET_CC_STATUS_FLG(:P_CC_ID, :P_CC_STATUS_FLG);'
      'end;')
    Left = 1168
    Top = 648
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_CC_ID'
        ParamType = ptInput
      end
      item
        DataType = ftFixedChar
        Name = 'P_CC_STATUS_FLG'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.SET_CC_STATUS_FLG'
  end
  object getApprovalListDataSource: TOraDataSource
    DataSet = getApprovalListProc
    Left = 704
    Top = 8
  end
  object setCcApprovalProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.SET_CC_APPROVAL'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.SET_CC_APPROVAL(:P_CC_ID);'
      'end;')
    Left = 1280
    Top = 592
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_CC_ID'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.SET_CC_APPROVAL'
  end
  object getFpNoticesContentFilter: TDataSetFilter
    OnChange = OnFilterChange
    Glue = ' AND '
    DataSet = getFpNoticesContentRam
    Left = 576
    Top = 112
  end
  object getApprovalListFilter: TDataSetFilter
    OnChange = OnFilterChange
    Glue = ' AND '
    DataSet = getApprovalListRam
    Left = 704
    Top = 112
  end
  object getPreDebtorListFilter: TDataSetFilter
    OnChange = OnFilterChange
    Glue = ' AND '
    DataSet = getPreDebtorListRam
    Left = 456
    Top = 112
  end
  object getCheckedFilter: TDataSetFilter
    Glue = ' AND '
    Left = 888
    Top = 608
  end
  object getCcStatusFlgListQuery: TOraQuery
    Session = EsaleSession
    SQL.Strings = (
      'select descr'
      '  , field_value'
      'from nasel_lookup_val '
      'where field_name = '#39'CC_STATUS_FLG'#39' and eff_status = '#39'A'#39)
    FetchAll = True
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 64
    Top = 152
    object getCcStatusFlgListQueryDESCR: TStringField
      FieldName = 'DESCR'
      Size = 60
    end
    object getCcStatusFlgListQueryFIELD_VALUE: TStringField
      FieldName = 'FIELD_VALUE'
      Required = True
      FixedChar = True
      Size = 4
    end
  end
  object getCcStatusFlgListDataSource: TOraDataSource
    DataSet = getCcStatusFlgListQuery
    Left = 64
    Top = 104
  end
  object getCcTypeCdQuery: TOraQuery
    Session = EsaleSession
    SQL.Strings = (
      'select descr'
      '  , field_value'
      'from nasel_lookup_val '
      'where field_name = '#39'CC_TYPE_CD'#39' and eff_status = '#39'A'#39)
    FetchAll = True
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 200
    Top = 152
    object getCcTypeCdQueryDESCR: TStringField
      FieldName = 'DESCR'
      Size = 60
    end
    object getCcTypeCdQueryFIELD_VALUE: TStringField
      FieldName = 'FIELD_VALUE'
      Required = True
      FixedChar = True
      Size = 4
    end
  end
  object getCcTypeCdDataSource: TOraDataSource
    DataSet = getCcTypeCdQuery
    Left = 200
    Top = 104
  end
  object getPreStopListDataSource: TOraDataSource
    DataSet = getPreStopListProc
    Left = 360
    Top = 288
  end
  object getPreStopListFilter: TDataSetFilter
    OnChange = OnFilterChange
    Glue = ' AND '
    DataSet = getPreStopListRam
    Left = 360
    Top = 392
  end
  object getOtdelenListDataSource: TOraDataSource
    DataSet = getOtdelenListProc
    Left = 128
    Top = 224
  end
  object getConfigQuery: TOraQuery
    KeyFields = 'ACCT_OTDELEN'
    Session = EsaleSession
    SQL.Strings = (
      '-- '#1054#1073#1097#1072#1103' '#1082#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1086#1085#1085#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103
      'select sysdate'
      '  , :app_path app_path'
      '  , :app_path || '#39'report\'#39' report_path'
      '  , :app_path || '#39'report\visa\'#39' visa_path'
      '  --, :app_path || '#39'report\template_document_notice.dotx'#39
      '  , :username username'
      ''
      'from dual'
      ''
      '/*select'
      '  rownum'
      '  , sysdate'
      '  , t.acct_otdelen'
      '  , t.acct_otdelen_descr'
      '  , t.address'
      '  , t.post'
      '  , t.phone'
      '  , t.nachalnik  '
      '  , t.visa'
      'from ('
      '  select'
      '    nasel_uch.fname'
      '    , nasel_uch.acct_otdelen'
      '    , raion.fname acct_otdelen_descr'
      '    , raion.address'
      '    , raion.nachalnik'
      '    , raion.phone'
      '    , raion.ccb_acct_char_val       '
      
        '    , :app_path || '#39'report\visa\'#39'|| raion.nachalnik || '#39'.png'#39' vi' +
        'sa'
      
        '    , substr(trim(raion.FNAME),1,length(trim(raion.FNAME))-2) ||' +
        ' '#39#1086#1075#1086' '#1091#1095#1072#1089#1090#1082#1072#39'  post'
      '  from nasel_uch '
      '  left join raion on raion.id = nasel_uch.id_rn'
      ' '
      '  where nasel_uch.acct_otdelen = :acct_otdelen'
      '  --order by nasel_uch.poryadok '
      ') t'
      '*/')
    FetchAll = True
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 1240
    Top = 416
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'app_path'
      end
      item
        DataType = ftUnknown
        Name = 'username'
      end>
    object getConfigQuerySYSDATE: TDateTimeField
      FieldName = 'SYSDATE'
    end
    object getConfigQueryAPP_PATH: TStringField
      FieldName = 'APP_PATH'
      Size = 2000
    end
    object getConfigQueryVISA_PATH: TStringField
      FieldName = 'VISA_PATH'
      Size = 2012
    end
    object getConfigQueryREPORT_PATH: TStringField
      FieldName = 'REPORT_PATH'
      Size = 2007
    end
    object getConfigQueryUSERNAME: TStringField
      FieldName = 'USERNAME'
      Size = 2000
    end
  end
  object getFpStopContentDataSource: TOraDataSource
    DataSet = getFpStopContentProc
    Left = 488
    Top = 288
  end
  object getFpStopContentFilter: TDataSetFilter
    OnChange = OnFilterChange
    Glue = ' AND '
    DataSet = getFpStopContentRam
    Left = 480
    Top = 400
  end
  object getFaPackStopInfoQuery: TOraQuery
    Session = EsaleSession
    SQL.Strings = (
      'select'
      '  rownum'
      '  , sysdate'
      '  , t.cre_dttm'
      '  , t.acct_otdelen'
      '  , t.fa_pack_id'
      ''
      'from ('
      '  select'
      '    nasel_fa_pack.* '
      '  from nasel_fa_pack'
      ''
      '  where nasel_fa_pack.fa_pack_id = :fa_pack_id --'#39'0000000416'#39
      '  order by nasel_fa_pack.cre_dttm desc '
      ') t')
    FetchAll = True
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 480
    Top = 520
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'fa_pack_id'
      end>
    object getFaPackStopInfoQueryROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
    object getFaPackStopInfoQuerySYSDATE: TDateTimeField
      FieldName = 'SYSDATE'
    end
    object getFaPackStopInfoQueryCRE_DTTM: TDateTimeField
      FieldName = 'CRE_DTTM'
    end
    object getFaPackStopInfoQueryACCT_OTDELEN: TStringField
      FieldName = 'ACCT_OTDELEN'
      Size = 6
    end
    object getFaPackStopInfoQueryFA_PACK_ID: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
  end
  object getFpStopListDataSource: TOraDataSource
    DataSet = getFpStopListProc
    Left = 624
    Top = 288
  end
  object getFpStopListFilter: TDataSetFilter
    OnChange = OnFilterChange
    Glue = ' AND '
    DataSet = getFpStopListRam
    Left = 608
    Top = 392
  end
  object getPreDebtorListRam: TVirtualTable
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 456
    Top = 176
    Data = {03000000000000000000}
  end
  object getPrePostListFilter: TDataSetFilter
    OnChange = OnFilterChange
    Glue = ' AND '
    DataSet = getPrePostListRam
    Left = 808
    Top = 112
  end
  object updateCcProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.UPDATE_CC'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      
        '  PK_NASEL_SWEETY.UPDATE_CC(:P_CC_ID, :P_CC_DTTM, :P_CC_TYPE_CD,' +
        ' :P_DESCR, :P_CALLER);'
      'end;')
    Left = 1280
    Top = 656
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_CC_ID'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'P_CC_DTTM'
        ParamType = ptInputOutput
      end
      item
        DataType = ftFixedChar
        Name = 'P_CC_TYPE_CD'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'P_DESCR'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'P_CALLER'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.UPDATE_CC'
  end
  object deleteCcProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.DELETE_CC'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.DELETE_CC(:P_CC_ID);'
      'end;')
    Left = 1384
    Top = 656
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_CC_ID'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.DELETE_CC'
  end
  object setFaPackStatusFlgFrozenProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.SET_FP_STATUS_FLG_FROZEN'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.SET_FP_STATUS_FLG_FROZEN(:P_FA_PACK_ID);'
      'end;')
    Left = 1360
    Top = 752
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_FA_PACK_ID'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.SET_FP_STATUS_FLG_FROZEN'
  end
  object getAcctFullListFilter: TDataSetFilter
    OnChange = OnFilterChange
    Glue = ' AND '
    DataSet = getAcctFullListRam
    Left = 352
    Top = 112
  end
  object getAcctFullListRam: TVirtualTable
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 352
    Top = 176
    Data = {03000000000000000000}
  end
  object getPreStopListRam: TVirtualTable
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 360
    Top = 456
    Data = {03000000000000000000}
  end
  object getApprovalListRam: TVirtualTable
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 704
    Top = 176
    Data = {03000000000000000000}
  end
  object getFpNoticesContentRam: TVirtualTable
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 576
    Top = 176
    Data = {03000000000000000000}
  end
  object getFpStopContentRam: TVirtualTable
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 480
    Top = 464
    Data = {03000000000000000000}
  end
  object getFpStopListRam: TVirtualTable
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 608
    Top = 456
    Data = {03000000000000000000}
  end
  object getFpCancelListDataSource: TOraDataSource
    DataSet = getFpCancelListProc
    Left = 784
    Top = 288
  end
  object getFpCancelListFilter: TDataSetFilter
    OnChange = OnFilterChange
    Glue = ' AND '
    DataSet = getFpCancelStopRam
    Left = 784
    Top = 392
  end
  object getFpCancelStopRam: TVirtualTable
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 784
    Top = 456
    Data = {03000000000000000000}
  end
  object deleteFaPackProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.DELETE_FP'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.DELETE_FP(:P_FA_PACK_ID);'
      'end;')
    Left = 1496
    Top = 592
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_FA_PACK_ID'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.DELETE_FP'
  end
  object setFpStatusFlgCancelProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.SET_FP_STATUS_FLG_CANCEL'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.SET_FP_STATUS_FLG_CANCEL(:P_FA_PACK_ID);'
      'end;')
    Left = 1240
    Top = 736
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_FA_PACK_ID'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.SET_FP_STATUS_FLG_CANCEL'
  end
  object getOtdelenListFilter: TDataSetFilter
    OnChange = OnFilterChange
    Glue = ' AND '
    DataSet = getOtdelenListProc
    Left = 120
    Top = 360
  end
  object getFaPackInfoFilter: TDataSetFilter
    OnChange = OnFilterChange
    Glue = ' AND '
    DataSet = getFaPackInfProc
    Left = 144
    Top = 608
  end
  object getPreDebtorListProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_PRE_NOTICES_LIST'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.GET_PRE_NOTICES_LIST(:P_ACCT_OTDELEN, :RC);'
      'end;')
    Left = 456
    Top = 64
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_ACCT_OTDELEN'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'RC'
        ParamType = ptOutput
        Value = 'Object'
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.GET_PRE_NOTICES_LIST'
    object getPreDebtorListProcROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
    object getPreDebtorListProcCHECK_DATA: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object getPreDebtorListProcACCT_ID: TStringField
      FieldName = 'ACCT_ID'
      FixedChar = True
      Size = 10
    end
    object getPreDebtorListProcFIO: TStringField
      FieldName = 'FIO'
      Size = 254
    end
    object getPreDebtorListProcCITY: TStringField
      FieldName = 'CITY'
      Size = 60
    end
    object getPreDebtorListProcADDRESS: TStringField
      FieldName = 'ADDRESS'
      Size = 315
    end
    object getPreDebtorListProcPREM_TYPE_DESCR: TStringField
      FieldName = 'PREM_TYPE_DESCR'
      Size = 60
    end
    object getPreDebtorListProcSALDO_UCH: TFloatField
      FieldName = 'SALDO_UCH'
    end
    object getPreDebtorListProcSALDO_M3: TFloatField
      FieldName = 'SALDO_M3'
    end
    object getPreDebtorListProcCC_DTTM: TDateTimeField
      FieldName = 'CC_DTTM'
    end
    object getPreDebtorListProcFA_ID: TStringField
      FieldName = 'FA_ID'
      FixedChar = True
      Size = 10
    end
    object getPreDebtorListProcFA_PACK_ID: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object getPreDebtorListProcCRE_DTTM: TDateTimeField
      FieldName = 'CRE_DTTM'
    end
    object getPreDebtorListProcACCT_OTDELEN: TStringField
      FieldName = 'ACCT_OTDELEN'
      FixedChar = True
      Size = 7
    end
    object getPreDebtorListProcSERVICE_ORG: TStringField
      FieldName = 'SERVICE_ORG'
      Size = 50
    end
    object getPreDebtorListProcOP_AREA_DESCR: TStringField
      FieldName = 'OP_AREA_DESCR'
      Size = 60
    end
    object getPreDebtorListProcMR_RTE_CD: TStringField
      FieldName = 'MR_RTE_CD'
      FixedChar = True
      Size = 8
    end
  end
  object getPrePostListDataSource: TOraDataSource
    DataSet = getPrePostListProc
    Left = 816
    Top = 8
  end
  object getPrePostListRam: TVirtualTable
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 808
    Top = 176
    Data = {03000000000000000000}
  end
  object getPrePostListProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_PRE_POST_LIST'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.GET_PRE_POST_LIST(:P_ACCT_OTDELEN, :RC);'
      'end;')
    Left = 816
    Top = 64
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_ACCT_OTDELEN'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'RC'
        ParamType = ptOutput
        Value = 'Object'
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.GET_PRE_POST_LIST'
  end
  object getFpNoticesContentProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_FP_NOTICES_CONTENT'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.GET_FP_NOTICES_CONTENT(:P_FA_PACK_ID, :RC);'
      'end;')
    Left = 576
    Top = 64
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_FA_PACK_ID'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'RC'
        ParamType = ptOutput
        Value = 'Object'
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.GET_FP_NOTICES_CONTENT'
    object getFpNoticesContentProcROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
    object getFpNoticesContentProcCHECK_DATA: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object getFpNoticesContentProcFA_ID: TStringField
      FieldName = 'FA_ID'
      FixedChar = True
      Size = 10
    end
    object getFpNoticesContentProcACCT_ID: TStringField
      FieldName = 'ACCT_ID'
      FixedChar = True
      Size = 10
    end
    object getFpNoticesContentProcADDRESS: TStringField
      FieldName = 'ADDRESS'
      Size = 315
    end
    object getFpNoticesContentProcCITY: TStringField
      FieldName = 'CITY'
      Size = 60
    end
    object getFpNoticesContentProcFIO: TStringField
      FieldName = 'FIO'
      Size = 254
    end
    object getFpNoticesContentProcPOSTAL: TStringField
      FieldName = 'POSTAL'
      Size = 10
    end
    object getFpNoticesContentProcCC_DTTM: TDateTimeField
      FieldName = 'CC_DTTM'
    end
    object getFpNoticesContentProcSRC_TYPE_CD: TStringField
      FieldName = 'SRC_TYPE_CD'
      FixedChar = True
      Size = 10
    end
    object getFpNoticesContentProcSERVICE_ORG: TStringField
      FieldName = 'SERVICE_ORG'
      Size = 50
    end
    object getFpNoticesContentProcPHONES: TStringField
      FieldName = 'PHONES'
      Size = 254
    end
    object getFpNoticesContentProcPHONE: TStringField
      FieldName = 'PHONE'
      Size = 254
    end
    object getFpNoticesContentProcEND_REG_READING_SZ1: TFloatField
      FieldName = 'END_REG_READING_SZ1'
    end
    object getFpNoticesContentProcEND_REG_READING1: TFloatField
      FieldName = 'END_REG_READING1'
    end
    object getFpNoticesContentProcEND_REG_READING2: TFloatField
      FieldName = 'END_REG_READING2'
    end
    object getFpNoticesContentProcSALDO_UCH: TFloatField
      FieldName = 'SALDO_UCH'
    end
    object getFpNoticesContentProcMTR_SERIAL_NBR: TStringField
      FieldName = 'MTR_SERIAL_NBR'
      Size = 16
    end
    object getFpNoticesContentProcFA_PACK_ID: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object getFpNoticesContentProcACCT_OTDELEN: TStringField
      FieldName = 'ACCT_OTDELEN'
      FixedChar = True
      Size = 7
    end
    object getFpNoticesContentProcCRE_DTTM: TDateTimeField
      FieldName = 'CRE_DTTM'
    end
    object getFpNoticesContentProcOP_AREA_DESCR: TStringField
      FieldName = 'OP_AREA_DESCR'
      Size = 60
    end
    object getFpNoticesContentProcFA_PACK_TYPE_CD: TStringField
      FieldName = 'FA_PACK_TYPE_CD'
      FixedChar = True
      Size = 8
    end
    object getFpNoticesContentProcCONT_QTY_SZ: TFloatField
      FieldName = 'CONT_QTY_SZ'
    end
    object getFpNoticesContentProcCC_ID: TStringField
      FieldName = 'CC_ID'
      FixedChar = True
      Size = 10
    end
    object getFpNoticesContentProcCC_STATUS_FLG: TStringField
      FieldName = 'CC_STATUS_FLG'
      FixedChar = True
      Size = 2
    end
    object getFpNoticesContentProcCC_TYPE_CD: TStringField
      FieldName = 'CC_TYPE_CD'
      FixedChar = True
      Size = 10
    end
    object getFpNoticesContentProcOWNER: TStringField
      FieldName = 'OWNER'
      Size = 22
    end
    object getFpNoticesContentProcAPPROVAL_DTTM: TDateTimeField
      FieldName = 'APPROVAL_DTTM'
    end
    object getFpNoticesContentProcMR_RTE_CD: TStringField
      FieldName = 'MR_RTE_CD'
      FixedChar = True
      Size = 8
    end
  end
  object getApprovalListProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_APPROVAL_LIST'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.GET_APPROVAL_LIST(:P_ACCT_OTDELEN, :RC);'
      'end;')
    Left = 704
    Top = 64
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_ACCT_OTDELEN'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'RC'
        ParamType = ptOutput
        Value = 'Object'
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.GET_APPROVAL_LIST'
    object getApprovalListProcROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
    object getApprovalListProcCHECK_DATA: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object getApprovalListProcACCT_ID: TStringField
      FieldName = 'ACCT_ID'
      FixedChar = True
      Size = 10
    end
    object getApprovalListProcFA_ID: TStringField
      FieldName = 'FA_ID'
      FixedChar = True
      Size = 10
    end
    object getApprovalListProcSALDO_UCH: TFloatField
      FieldName = 'SALDO_UCH'
    end
    object getApprovalListProcADDRESS: TStringField
      FieldName = 'ADDRESS'
      Size = 315
    end
    object getApprovalListProcCITY: TStringField
      FieldName = 'CITY'
      Size = 60
    end
    object getApprovalListProcFIO: TStringField
      FieldName = 'FIO'
      Size = 254
    end
    object getApprovalListProcSERVICE_ORG: TStringField
      FieldName = 'SERVICE_ORG'
      Size = 50
    end
    object getApprovalListProcCC_ID: TStringField
      FieldName = 'CC_ID'
      FixedChar = True
      Size = 10
    end
    object getApprovalListProcCC_DTTM: TDateTimeField
      FieldName = 'CC_DTTM'
    end
    object getApprovalListProcSRC_TYPE_CD: TStringField
      FieldName = 'SRC_TYPE_CD'
      FixedChar = True
      Size = 10
    end
    object getApprovalListProcAPPROVAL_DTTM: TDateTimeField
      FieldName = 'APPROVAL_DTTM'
    end
    object getApprovalListProcN: TFloatField
      FieldName = 'N'
    end
    object getApprovalListProcCC_STATUS_FLG: TStringField
      FieldName = 'CC_STATUS_FLG'
      FixedChar = True
      Size = 2
    end
    object getApprovalListProcCC_STATUS_DESCR: TStringField
      FieldName = 'CC_STATUS_DESCR'
      Size = 60
    end
    object getApprovalListProcAPPROVAL_USER: TStringField
      FieldName = 'APPROVAL_USER'
      Size = 22
    end
    object getApprovalListProcCC_TYPE_CD: TStringField
      FieldName = 'CC_TYPE_CD'
      FixedChar = True
      Size = 10
    end
    object getApprovalListProcCC_TYPE_DESCR: TStringField
      FieldName = 'CC_TYPE_DESCR'
      Size = 60
    end
  end
  object getPreStopListProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_PRE_STOP_LIST'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.GET_PRE_STOP_LIST(:P_ACCT_OTDELEN, :RC);'
      'end;')
    Left = 352
    Top = 344
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_ACCT_OTDELEN'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'RC'
        ParamType = ptOutput
        Value = 'Object'
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.GET_PRE_STOP_LIST'
    object getPreStopListProcROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
    object getPreStopListProcCHECK_DATA: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object getPreStopListProcACCT_ID: TStringField
      FieldName = 'ACCT_ID'
      FixedChar = True
      Size = 10
    end
    object getPreStopListProcAPPROVAL_DTTM: TDateTimeField
      FieldName = 'APPROVAL_DTTM'
    end
    object getPreStopListProcCC_DTTM: TDateTimeField
      FieldName = 'CC_DTTM'
    end
    object getPreStopListProcFIO: TStringField
      FieldName = 'FIO'
      Size = 254
    end
    object getPreStopListProcPOSTAL: TStringField
      FieldName = 'POSTAL'
      Size = 10
    end
    object getPreStopListProcCITY: TStringField
      FieldName = 'CITY'
      Size = 60
    end
    object getPreStopListProcADDRESS: TStringField
      FieldName = 'ADDRESS'
      Size = 315
    end
    object getPreStopListProcPREM_TYPE_DESCR: TStringField
      FieldName = 'PREM_TYPE_DESCR'
      Size = 60
    end
    object getPreStopListProcSALDO_UCH: TFloatField
      FieldName = 'SALDO_UCH'
    end
    object getPreStopListProcSPR_DESCR: TStringField
      FieldName = 'SPR_DESCR'
      Size = 50
    end
    object getPreStopListProcFA_PACK_ID: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object getPreStopListProcFA_PACK_TYPE_DESCR: TStringField
      FieldName = 'FA_PACK_TYPE_DESCR'
      Size = 60
    end
    object getPreStopListProcCTR_DESCR: TStringField
      FieldName = 'CTR_DESCR'
      Size = 254
    end
  end
  object getFpStopContentProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_FP_STOP_CONTENT'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.GET_FP_STOP_CONTENT(:P_FA_PACK_ID, :RC);'
      'end;')
    Left = 480
    Top = 352
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_FA_PACK_ID'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'RC'
        ParamType = ptOutput
        Value = 'Object'
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.GET_FP_STOP_CONTENT'
    object getFpStopContentProcROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
    object getFpStopContentProcCHECK_DATA: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object getFpStopContentProcFA_ID: TStringField
      FieldName = 'FA_ID'
      FixedChar = True
      Size = 10
    end
    object getFpStopContentProcACCT_ID: TStringField
      FieldName = 'ACCT_ID'
      FixedChar = True
      Size = 10
    end
    object getFpStopContentProcADDRESS: TStringField
      FieldName = 'ADDRESS'
      Size = 315
    end
    object getFpStopContentProcCITY: TStringField
      FieldName = 'CITY'
      Size = 60
    end
    object getFpStopContentProcFIO: TStringField
      FieldName = 'FIO'
      Size = 254
    end
    object getFpStopContentProcPOSTAL: TStringField
      FieldName = 'POSTAL'
      Size = 10
    end
    object getFpStopContentProcCC_DTTM: TDateTimeField
      FieldName = 'CC_DTTM'
    end
    object getFpStopContentProcSRC_TYPE_CD: TStringField
      FieldName = 'SRC_TYPE_CD'
      FixedChar = True
      Size = 10
    end
    object getFpStopContentProcSPR_DESCR: TStringField
      FieldName = 'SPR_DESCR'
      Size = 50
    end
    object getFpStopContentProcPHONES: TStringField
      FieldName = 'PHONES'
      Size = 254
    end
    object getFpStopContentProcPHONE: TStringField
      FieldName = 'PHONE'
      Size = 254
    end
    object getFpStopContentProcEND_REG_READING1: TFloatField
      FieldName = 'END_REG_READING1'
    end
    object getFpStopContentProcEND_REG_READING2: TFloatField
      FieldName = 'END_REG_READING2'
    end
    object getFpStopContentProcSALDO_UCH: TFloatField
      FieldName = 'SALDO_UCH'
    end
    object getFpStopContentProcMTR_SERIAL_NBR: TStringField
      FieldName = 'MTR_SERIAL_NBR'
      Size = 16
    end
    object getFpStopContentProcFA_PACK_ID: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object getFpStopContentProcACCT_OTDELEN: TStringField
      FieldName = 'ACCT_OTDELEN'
      FixedChar = True
      Size = 7
    end
    object getFpStopContentProcCRE_DTTM: TDateTimeField
      FieldName = 'CRE_DTTM'
    end
    object getFpStopContentProcOP_AREA_DESCR: TStringField
      FieldName = 'OP_AREA_DESCR'
      Size = 60
    end
    object getFpStopContentProcFA_PACK_TYPE_CD: TStringField
      FieldName = 'FA_PACK_TYPE_CD'
      FixedChar = True
      Size = 8
    end
    object getFpStopContentProcGRP: TFloatField
      FieldName = 'GRP'
    end
    object getFpStopContentProcPREM_TYPE_DESCR: TStringField
      FieldName = 'PREM_TYPE_DESCR'
      Size = 60
    end
    object getFpStopContentProcST_P_DT: TDateTimeField
      FieldName = 'ST_P_DT'
    end
    object getFpStopContentProcSA_END_DT: TDateTimeField
      FieldName = 'SA_END_DT'
    end
    object getFpStopContentProcNOTICE_FA_ID: TStringField
      FieldName = 'NOTICE_FA_ID'
      FixedChar = True
      Size = 10
    end
    object getFpStopContentProcNOTICE_CRE_DTTM: TDateTimeField
      FieldName = 'NOTICE_CRE_DTTM'
    end
    object getFpStopContentProcST_P_DT_END: TDateTimeField
      FieldName = 'ST_P_DT_END'
    end
    object getFpStopContentProcCANCEL_FA_PACK_CRE_DTTM: TDateTimeField
      FieldName = 'CANCEL_FA_PACK_CRE_DTTM'
    end
    object getFpStopContentProcCANCEL_FA_PACK_ID: TStringField
      FieldName = 'CANCEL_FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object getFpStopContentProcSA_E_DT: TDateTimeField
      FieldName = 'SA_E_DT'
    end
    object getFpStopContentProcNOTICE_SALDO_UCH: TFloatField
      FieldName = 'NOTICE_SALDO_UCH'
    end
    object getFpStopContentProcNOTICE_END_REG_READING1: TFloatField
      FieldName = 'NOTICE_END_REG_READING1'
    end
    object getFpStopContentProcNOTICE_END_REG_READING2: TFloatField
      FieldName = 'NOTICE_END_REG_READING2'
    end
  end
  object getFpStopListProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_FP_STOP_LIST'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      
        '  PK_NASEL_SWEETY.GET_FP_STOP_LIST(:P_ACCT_OTDELEN, :P_FA_ID, :P' +
        '_ACCT_ID, :RC);'
      'end;')
    Left = 608
    Top = 344
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_ACCT_OTDELEN'
        ParamType = ptInput
      end
      item
        DataType = ftFixedChar
        Name = 'P_FA_ID'
        ParamType = ptInput
      end
      item
        DataType = ftFixedChar
        Name = 'P_ACCT_ID'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'RC'
        ParamType = ptOutput
        Value = 'Object'
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.GET_FP_STOP_LIST'
    object getFpStopListProcROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
    object getFpStopListProcCHECK_DATA: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object getFpStopListProcFA_PACK_ID: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object getFpStopListProcCRE_DTTM: TDateTimeField
      FieldName = 'CRE_DTTM'
    end
    object getFpStopListProcST_P_DT: TDateTimeField
      FieldName = 'ST_P_DT'
    end
    object getFpStopListProcOWNER: TStringField
      FieldName = 'OWNER'
      Size = 22
    end
    object getFpStopListProcFA_PACK_STATUS_DESCR: TStringField
      FieldName = 'FA_PACK_STATUS_DESCR'
      Size = 60
    end
    object getFpStopListProcFA_CNT: TFloatField
      FieldName = 'FA_CNT'
    end
    object getFpStopListProcFA_PACK_STATUS_FLG: TStringField
      FieldName = 'FA_PACK_STATUS_FLG'
      FixedChar = True
      Size = 2
    end
    object getFpStopListProcFA_PACK_TYPE_DESCR: TStringField
      FieldName = 'FA_PACK_TYPE_DESCR'
      Size = 60
    end
    object getFpStopListProcRT_TYPE: TStringField
      FieldName = 'RT_TYPE'
      Size = 255
    end
    object getFpStopListProcSIGNER_NAME: TStringField
      FieldName = 'SIGNER_NAME'
      Size = 25
    end
    object getFpStopListProcSIGNER_POST: TStringField
      FieldName = 'SIGNER_POST'
      Size = 100
    end
    object getFpStopListProcRT_CD: TStringField
      FieldName = 'RT_CD'
      Size = 255
    end
    object getFpStopListProcRT_DESCR: TStringField
      FieldName = 'RT_DESCR'
      Size = 255
    end
    object getFpStopListProcRT_ADDR: TStringField
      FieldName = 'RT_ADDR'
      Size = 255
    end
    object getFpStopListProcRT_POST: TStringField
      FieldName = 'RT_POST'
      Size = 255
    end
    object getFpStopListProcRT_NAME: TStringField
      FieldName = 'RT_NAME'
      Size = 255
    end
    object getFpStopListProcSGNR_NAME: TStringField
      FieldName = 'SGNR_NAME'
      Size = 25
    end
    object getFpStopListProcSGNR_POST: TStringField
      FieldName = 'SGNR_POST'
      Size = 100
    end
  end
  object getFpCancelListProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_FP_CANCEL_LIST'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.GET_FP_CANCEL_LIST(:P_ACCT_OTDELEN, :RC);'
      'end;')
    Left = 784
    Top = 344
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_ACCT_OTDELEN'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'RC'
        ParamType = ptOutput
        Value = 'Object'
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.GET_FP_CANCEL_LIST'
    object getFpCancelListProcROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
    object getFpCancelListProcCHECK_DATA: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object getFpCancelListProcFA_PACK_ID: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object getFpCancelListProcCRE_DTTM: TDateTimeField
      FieldName = 'CRE_DTTM'
    end
    object getFpCancelListProcFA_PACK_STATUS_DESCR: TStringField
      FieldName = 'FA_PACK_STATUS_DESCR'
      Size = 60
    end
    object getFpCancelListProcFA_PACK_STATUS_FLG: TStringField
      FieldName = 'FA_PACK_STATUS_FLG'
      FixedChar = True
      Size = 2
    end
    object getFpCancelListProcPRNT_FA_ID: TStringField
      FieldName = 'PRNT_FA_ID'
      Size = 10
    end
    object getFpCancelListProcFA_ID: TStringField
      FieldName = 'FA_ID'
      FixedChar = True
      Size = 10
    end
    object getFpCancelListProcRT_ADDR: TStringField
      FieldName = 'RT_ADDR'
      Size = 255
    end
    object getFpCancelListProcRT_POST: TStringField
      FieldName = 'RT_POST'
      Size = 255
    end
    object getFpCancelListProcRT_NAME: TStringField
      FieldName = 'RT_NAME'
      Size = 255
    end
    object getFpCancelListProcRT_DESCR: TStringField
      FieldName = 'RT_DESCR'
      Size = 255
    end
    object getFpCancelListProcACCT_ID_CNT: TFloatField
      FieldName = 'ACCT_ID_CNT'
    end
    object getFpCancelListProcOWNER: TStringField
      FieldName = 'OWNER'
      Size = 22
    end
    object getFpCancelListProcSIGNER_NAME: TStringField
      FieldName = 'SIGNER_NAME'
      Size = 25
    end
    object getFpCancelListProcSIGNER_POST: TStringField
      FieldName = 'SIGNER_POST'
      Size = 100
    end
    object getFpCancelListProcSGNR_NAME: TStringField
      FieldName = 'SGNR_NAME'
      Size = 25
    end
    object getFpCancelListProcSGNR_POST: TStringField
      FieldName = 'SGNR_POST'
      Size = 100
    end
  end
  object getAcctFullListDataSource: TOraDataSource
    Left = 352
    Top = 8
  end
  object MainDataSource: TOraDataSource
    Left = 112
    Top = 16
  end
  object findFaPackListNoticesDS: TOraDataSource
    DataSet = findFaPackListNoticesProc
    Left = 1312
    Top = 24
  end
  object findFaPackListNoticesFilter: TDataSetFilter
    Glue = ' AND '
    DataSet = findFaPackListNoticesRam
    Left = 1312
    Top = 128
  end
  object findFaPackListNoticesProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_FP_NOTICES_LIST'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      
        '  PK_NASEL_SWEETY.GET_FP_NOTICES_LIST(:P_ACCT_OTDELEN, :P_FA_ID,' +
        ' :P_ACCT_ID, :RC);'
      'end;')
    Left = 1312
    Top = 80
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_ACCT_OTDELEN'
        ParamType = ptInput
      end
      item
        DataType = ftFixedChar
        Name = 'P_FA_ID'
        ParamType = ptInput
      end
      item
        DataType = ftFixedChar
        Name = 'P_ACCT_ID'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'RC'
        ParamType = ptOutput
        Value = 'Object'
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.GET_FP_NOTICES_LIST'
    object findFaPackListNoticesProcROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
    object findFaPackListNoticesProcCHECK_DATA: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object findFaPackListNoticesProcFA_PACK_ID: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object findFaPackListNoticesProcFA_PACK_TYPE_CD: TStringField
      FieldName = 'FA_PACK_TYPE_CD'
      FixedChar = True
      Size = 8
    end
    object findFaPackListNoticesProcCRE_DTTM: TDateTimeField
      FieldName = 'CRE_DTTM'
    end
    object findFaPackListNoticesProcPRNT_FA_PACK_ID: TStringField
      FieldName = 'PRNT_FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object findFaPackListNoticesProcACCT_OTDELEN: TStringField
      FieldName = 'ACCT_OTDELEN'
      FixedChar = True
      Size = 7
    end
    object findFaPackListNoticesProcFA_PACK_STATUS_FLG: TStringField
      FieldName = 'FA_PACK_STATUS_FLG'
      FixedChar = True
      Size = 2
    end
    object findFaPackListNoticesProcUSER_ID: TStringField
      FieldName = 'USER_ID'
      FixedChar = True
      Size = 8
    end
    object findFaPackListNoticesProcFA_PACK_STATUS_DESCR: TStringField
      FieldName = 'FA_PACK_STATUS_DESCR'
      Size = 60
    end
    object findFaPackListNoticesProcFA_PACK_TYPE_DESCR: TStringField
      FieldName = 'FA_PACK_TYPE_DESCR'
      Size = 60
    end
    object findFaPackListNoticesProcOWNER: TStringField
      FieldName = 'OWNER'
      Size = 22
    end
    object findFaPackListNoticesProcFA_CNT: TFloatField
      FieldName = 'FA_CNT'
    end
    object findFaPackListNoticesProcCNT: TFloatField
      FieldName = 'CNT'
    end
  end
  object findFaPackListNoticesRam: TVirtualTable
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 1312
    Top = 192
    Data = {03000000000000000000}
  end
  object findFaPackListStopDS: TOraDataSource
    DataSet = findFpStopListProc
    Left = 1440
    Top = 24
  end
  object findFpStopListFilter: TDataSetFilter
    Glue = ' AND '
    DataSet = findFpStopListRam
    Left = 1440
    Top = 128
  end
  object findFpStopListProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.FIND_FP_STOP_LIST'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      
        '  PK_NASEL_SWEETY.FIND_FP_STOP_LIST(:P_ACCT_OTDELEN, :P_FA_ID, :' +
        'P_ACCT_ID, :RC);'
      'end;')
    Left = 1440
    Top = 80
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_ACCT_OTDELEN'
        ParamType = ptInput
      end
      item
        DataType = ftFixedChar
        Name = 'P_FA_ID'
        ParamType = ptInput
      end
      item
        DataType = ftFixedChar
        Name = 'P_ACCT_ID'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'RC'
        ParamType = ptOutput
        Value = 'Object'
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.FIND_FP_STOP_LIST'
    object findFpStopListProcROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
    object findFpStopListProcCHECK_DATA: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object findFpStopListProcFA_PACK_ID: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object findFpStopListProcCRE_DTTM: TDateTimeField
      FieldName = 'CRE_DTTM'
    end
    object findFpStopListProcFA_PACK_STATUS_FLG: TStringField
      FieldName = 'FA_PACK_STATUS_FLG'
      FixedChar = True
      Size = 2
    end
    object findFpStopListProcOWNER: TStringField
      FieldName = 'OWNER'
      Size = 22
    end
    object findFpStopListProcFA_PACK_STATUS_DESCR: TStringField
      FieldName = 'FA_PACK_STATUS_DESCR'
      Size = 60
    end
    object findFpStopListProcFA_CNT: TFloatField
      FieldName = 'FA_CNT'
    end
    object findFpStopListProcFA_PACK_TYPE_DESCR: TStringField
      FieldName = 'FA_PACK_TYPE_DESCR'
      Size = 60
    end
    object findFpStopListProcRT_TYPE: TStringField
      FieldName = 'RT_TYPE'
      Size = 255
    end
    object findFpStopListProcFA_PACK_TYPE_CD: TStringField
      FieldName = 'FA_PACK_TYPE_CD'
      FixedChar = True
      Size = 8
    end
    object findFpStopListProcRT_CD: TStringField
      FieldName = 'RT_CD'
      Size = 255
    end
    object findFpStopListProcRT_DESCR: TStringField
      FieldName = 'RT_DESCR'
      Size = 255
    end
    object findFpStopListProcRT_ADDR: TStringField
      FieldName = 'RT_ADDR'
      Size = 255
    end
    object findFpStopListProcRT_POST: TStringField
      FieldName = 'RT_POST'
      Size = 255
    end
    object findFpStopListProcRT_NAME: TStringField
      FieldName = 'RT_NAME'
      Size = 255
    end
  end
  object findFpStopListRam: TVirtualTable
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 1440
    Top = 192
    Data = {03000000000000000000}
  end
  object getFpCancelContentTmpProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_FP_CANCEL_CONTENT'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.GET_FP_CANCEL_CONTENT(:P_FA_PACK_ID, :RC);'
      'end;')
    Left = 936
    Top = 344
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_FA_PACK_ID'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'RC'
        ParamType = ptOutput
        Value = 'Object'
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.GET_FP_CANCEL_CONTENT'
    object getFpCancelContentTmpProcACCT_ID: TStringField
      FieldName = 'ACCT_ID'
      FixedChar = True
      Size = 10
    end
    object getFpCancelContentTmpProcFIO: TStringField
      FieldName = 'FIO'
      Size = 254
    end
    object getFpCancelContentTmpProcSTOP_FA_ID: TStringField
      FieldName = 'STOP_FA_ID'
      FixedChar = True
      Size = 10
    end
    object getFpCancelContentTmpProcSTOP_FA_PACK_ID: TStringField
      FieldName = 'STOP_FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object getFpCancelContentTmpProcSTOP_CRE_DTTM: TDateTimeField
      FieldName = 'STOP_CRE_DTTM'
    end
    object getFpCancelContentTmpProcNOTICE_FA_ID: TStringField
      FieldName = 'NOTICE_FA_ID'
      FixedChar = True
      Size = 10
    end
    object getFpCancelContentTmpProcNOTICE_FA_PACK_ID: TStringField
      FieldName = 'NOTICE_FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object getFpCancelContentTmpProcNOTICE_CRE_DTTM: TDateTimeField
      FieldName = 'NOTICE_CRE_DTTM'
    end
    object getFpCancelContentTmpProcST_P_DT: TDateTimeField
      FieldName = 'ST_P_DT'
    end
    object getFpCancelContentTmpProcCITY: TStringField
      FieldName = 'CITY'
      Size = 60
    end
    object getFpCancelContentTmpProcADDRESS: TStringField
      FieldName = 'ADDRESS'
      Size = 315
    end
    object getFpCancelContentTmpProcPREM_TYPE_DESCR: TStringField
      FieldName = 'PREM_TYPE_DESCR'
      Size = 60
    end
    object getFpCancelContentTmpProcSTOP_SALDO_UCH: TFloatField
      FieldName = 'STOP_SALDO_UCH'
    end
    object getFpCancelContentTmpProcROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
    object getFpCancelContentTmpProcCHECK_DATA: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object getFpCancelContentTmpProcCC_DTTM: TDateTimeField
      FieldName = 'CC_DTTM'
    end
    object getFpCancelContentTmpProcFA_ID: TStringField
      FieldName = 'FA_ID'
      FixedChar = True
      Size = 10
    end
    object getFpCancelContentTmpProcST_P_DT_END: TDateTimeField
      FieldName = 'ST_P_DT_END'
    end
  end
  object getOtdelenListProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_ACCT_OTDELEN_LIST'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.GET_ACCT_OTDELEN_LIST(:RC);'
      'end;')
    Left = 120
    Top = 312
    ParamData = <
      item
        DataType = ftCursor
        Name = 'RC'
        ParamType = ptOutput
        Value = 'Object'
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.GET_ACCT_OTDELEN_LIST'
    object getOtdelenListProcACCT_OTDELEN: TStringField
      FieldName = 'ACCT_OTDELEN'
      FixedChar = True
      Size = 7
    end
    object getOtdelenListProcDESCR: TStringField
      FieldName = 'DESCR'
      Size = 25
    end
    object getOtdelenListProcMAILING_ADDRESS: TStringField
      FieldName = 'MAILING_ADDRESS'
      Size = 62
    end
    object getOtdelenListProcACTING_NAME: TStringField
      FieldName = 'ACTING_NAME'
      Size = 60
    end
    object getOtdelenListProcACTING_POST: TStringField
      FieldName = 'ACTING_POST'
      Size = 22
    end
    object getOtdelenListProcDESCR_L_GENITIVE: TStringField
      FieldName = 'DESCR_L_GENITIVE'
      Size = 25
    end
    object getOtdelenListProcPHONE: TStringField
      FieldName = 'PHONE'
      Size = 50
    end
    object getOtdelenListProcDESCR_L: TStringField
      FieldName = 'DESCR_L'
      Size = 25
    end
    object getOtdelenListProcADDRESS: TStringField
      FieldName = 'ADDRESS'
      Size = 62
    end
  end
  object getOpAreaCdProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_OP_AREA_CD_LIST'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.GET_OP_AREA_CD_LIST(:P_ACCT_OTDELEN, :RC);'
      'end;')
    Left = 224
    Top = 312
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_ACCT_OTDELEN'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'RC'
        ParamType = ptOutput
        Value = 'Object'
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.GET_OP_AREA_CD_LIST'
    object getOpAreaCdProcOP_AREA_CD: TStringField
      FieldName = 'OP_AREA_CD'
      Size = 8
    end
    object getOpAreaCdProcOP_AREA_DESCR: TStringField
      FieldName = 'OP_AREA_DESCR'
      Size = 60
    end
    object getOpAreaCdProcACCT_OTDELEN: TStringField
      FieldName = 'ACCT_OTDELEN'
      FixedChar = True
      Size = 7
    end
  end
  object getConfigProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_APP_CONFIG'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.GET_APP_CONFIG(:P_APP_PATH, :P_APP_VER, :RC);'
      'end;')
    Left = 32
    Top = 312
    ParamData = <
      item
        DataType = ftString
        Name = 'P_APP_PATH'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'P_APP_VER'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'RC'
        ParamType = ptOutput
        Value = 'Object'
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.GET_APP_CONFIG'
    object getConfigProcSYSDATE: TDateTimeField
      FieldName = 'SYSDATE'
    end
    object getConfigProcAPP_PATH: TStringField
      FieldName = 'APP_PATH'
      Size = 32
    end
    object getConfigProcREPORT_PATH: TStringField
      FieldName = 'REPORT_PATH'
      Size = 39
    end
    object getConfigProcVISA_PATH: TStringField
      FieldName = 'VISA_PATH'
      Size = 44
    end
    object getConfigProcUSERNAME: TStringField
      FieldName = 'USERNAME'
      Size = 256
    end
    object getConfigProcMIN_APP_VER: TFloatField
      FieldName = 'MIN_APP_VER'
    end
    object getConfigProcMAX_APP_VER: TFloatField
      FieldName = 'MAX_APP_VER'
    end
    object getConfigProcALLOWED: TFloatField
      FieldName = 'ALLOWED'
    end
    object getConfigProcTODAY: TDateTimeField
      FieldName = 'TODAY'
    end
    object getConfigProcSTOP_ALLERT: TStringField
      FieldName = 'STOP_ALLERT'
      FixedChar = True
      Size = 34
    end
    object getConfigProcAPP_VER: TStringField
      FieldName = 'APP_VER'
      Size = 32
    end
    object getConfigProcSERVICE_STOP_ALLERT: TStringField
      FieldName = 'SERVICE_STOP_ALLERT'
      FixedChar = True
      Size = 1
    end
    object getConfigProcNEEDS_APP_UPDATE: TStringField
      FieldName = 'NEEDS_APP_UPDATE'
      FixedChar = True
      Size = 2
    end
    object getConfigProcUPDATE_FAILURE: TStringField
      FieldName = 'UPDATE_FAILURE'
      FixedChar = True
      Size = 2
    end
    object getConfigProcOTHER_STOP_REASON: TStringField
      FieldName = 'OTHER_STOP_REASON'
      FixedChar = True
      Size = 2
    end
  end
  object getFaPackTypeListProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_FP_TYPE_LIST'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.GET_FP_TYPE_LIST(:RC);'
      'end;')
    Left = 40
    Top = 544
    ParamData = <
      item
        DataType = ftCursor
        Name = 'RC'
        ParamType = ptOutput
        Value = 'Object'
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.GET_FP_TYPE_LIST'
    object getFaPackTypeListProcFA_PACK_TYPE_CD: TStringField
      FieldName = 'FA_PACK_TYPE_CD'
      FixedChar = True
      Size = 8
    end
    object getFaPackTypeListProcDESCR: TStringField
      FieldName = 'DESCR'
      Size = 60
    end
  end
  object getFaPackInfProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_FP_INF'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.GET_FP_INF(:P_FA_PACK_ID, :RC);'
      'end;')
    Left = 40
    Top = 608
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_FA_PACK_ID'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'RC'
        ParamType = ptOutput
        Value = 'Object'
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.GET_FP_INF'
    object getFaPackInfProcCRE_DTTM: TDateTimeField
      FieldName = 'CRE_DTTM'
    end
    object getFaPackInfProcACCT_OTDELEN: TStringField
      FieldName = 'ACCT_OTDELEN'
      FixedChar = True
      Size = 7
    end
    object getFaPackInfProcFA_PACK_ID: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object getFaPackInfProcFA_COUNT: TFloatField
      FieldName = 'FA_COUNT'
    end
  end
  object getCcInfProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_FA_CC_INF'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.GET_FA_CC_INF(:P_CC_ID, :RC);'
      'end;')
    Left = 40
    Top = 664
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_CC_ID'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'RC'
        ParamType = ptOutput
        Value = 'Object'
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.GET_FA_CC_INF'
  end
  object setFaPackStatSentPerformerProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.SET_FP_STAT_SENT_PERF'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.SET_FP_STAT_SENT_PERF(:P_FA_PACK_ID);'
      'end;')
    Left = 1496
    Top = 736
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_FA_PACK_ID'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.SET_FP_STAT_SENT_PERF'
  end
  object getFaPackStatsProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_FP_STATS'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      
        '  PK_NASEL_SWEETY.GET_FP_STATS(:P_ACCT_OTDELEN, :P_START_DT, :P_' +
        'END_DT, :RC);'
      'end;')
    Left = 40
    Top = 728
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_ACCT_OTDELEN'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'P_START_DT'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'P_END_DT'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'RC'
        ParamType = ptOutput
        Value = 'Object'
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.GET_FP_STATS'
    object getFaPackStatsProcACCT_OTDELEN: TStringField
      FieldName = 'ACCT_OTDELEN'
      Size = 7
    end
    object getFaPackStatsProcACCT_OTDELEN_DESCR: TStringField
      FieldName = 'ACCT_OTDELEN_DESCR'
      Size = 25
    end
    object getFaPackStatsProcFA_NOTICES_SELF: TFloatField
      FieldName = 'FA_NOTICES_SELF'
    end
    object getFaPackStatsProcFA_NOTICES_POST: TFloatField
      FieldName = 'FA_NOTICES_POST'
    end
    object getFaPackStatsProcFA_PACK_STOP: TFloatField
      FieldName = 'FA_PACK_STOP'
    end
    object getFaPackStatsProcFA_PACK_CANCEL: TFloatField
      FieldName = 'FA_PACK_CANCEL'
    end
    object getFaPackStatsProcFA_PACK_RECONNECT: TFloatField
      FieldName = 'FA_PACK_RECONNECT'
    end
  end
  object getFpReconnectListDataSource: TOraDataSource
    DataSet = getFpReconnectListProc
    Left = 1088
    Top = 296
  end
  object getFpReconnectListFilter: TDataSetFilter
    OnChange = OnFilterChange
    Glue = ' AND '
    DataSet = getFpReconnectListRam
    Left = 1088
    Top = 400
  end
  object getFpReconnectListRam: TVirtualTable
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 1088
    Top = 464
    Data = {03000000000000000000}
  end
  object getFpReconnectListProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_FP_RECONNECT_LIST'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.GET_FP_RECONNECT_LIST(:P_ACCT_OTDELEN, :RC);'
      'end;')
    Left = 1088
    Top = 352
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_ACCT_OTDELEN'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'RC'
        ParamType = ptOutput
        Value = 'Object'
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.GET_FP_RECONNECT_LIST'
    object getFpReconnectListProcROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
    object getFpReconnectListProcCHECK_DATA: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object getFpReconnectListProcFA_PACK_ID: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object getFpReconnectListProcCRE_DTTM: TDateTimeField
      FieldName = 'CRE_DTTM'
    end
    object getFpReconnectListProcFA_PACK_STATUS_FLG: TStringField
      FieldName = 'FA_PACK_STATUS_FLG'
      FixedChar = True
      Size = 2
    end
    object getFpReconnectListProcPRNT_FA_ID: TStringField
      FieldName = 'PRNT_FA_ID'
      Size = 10
    end
    object getFpReconnectListProcRT_ADDR: TStringField
      FieldName = 'RT_ADDR'
      Size = 255
    end
    object getFpReconnectListProcRT_POST: TStringField
      FieldName = 'RT_POST'
      Size = 255
    end
    object getFpReconnectListProcRT_NAME: TStringField
      FieldName = 'RT_NAME'
      Size = 255
    end
    object getFpReconnectListProcFA_PACK_STATUS_DESCR: TStringField
      FieldName = 'FA_PACK_STATUS_DESCR'
      Size = 60
    end
    object getFpReconnectListProcACCT_ID_CNT: TFloatField
      FieldName = 'ACCT_ID_CNT'
    end
    object getFpReconnectListProcOWNER: TStringField
      FieldName = 'OWNER'
      Size = 22
    end
    object getFpReconnectListProcSGNR_NAME: TStringField
      FieldName = 'SGNR_NAME'
      Size = 25
    end
    object getFpReconnectListProcSGNR_POST: TStringField
      FieldName = 'SGNR_POST'
      Size = 100
    end
    object getFpReconnectListProcRT_DESCR: TStringField
      FieldName = 'RT_DESCR'
      Size = 255
    end
  end
  object getFpReconnectContentTmpProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_FP_RECONNECT_CONTENT'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.GET_FP_RECONNECT_CONTENT(:P_FA_PACK_ID, :RC);'
      'end;')
    Left = 1240
    Top = 352
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_FA_PACK_ID'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'RC'
        ParamType = ptOutput
        Value = 'Object'
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.GET_FP_RECONNECT_CONTENT'
    object StringField1: TStringField
      FieldName = 'ACCT_ID'
      FixedChar = True
      Size = 10
    end
    object StringField2: TStringField
      FieldName = 'FIO'
      Size = 254
    end
    object StringField3: TStringField
      FieldName = 'STOP_FA_ID'
      FixedChar = True
      Size = 10
    end
    object StringField4: TStringField
      FieldName = 'STOP_FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object DateTimeField1: TDateTimeField
      FieldName = 'STOP_CRE_DTTM'
    end
    object StringField21: TStringField
      FieldName = 'NOTICE_FA_ID'
      FixedChar = True
      Size = 10
    end
    object StringField22: TStringField
      FieldName = 'NOTICE_FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object DateTimeField8: TDateTimeField
      FieldName = 'NOTICE_CRE_DTTM'
    end
    object DateTimeField9: TDateTimeField
      FieldName = 'ST_P_DT'
    end
    object StringField23: TStringField
      FieldName = 'CITY'
      Size = 60
    end
    object StringField24: TStringField
      FieldName = 'ADDRESS'
      Size = 315
    end
    object StringField25: TStringField
      FieldName = 'PREM_TYPE_DESCR'
      Size = 60
    end
    object getFpReconnectContentTmpProcPHONES: TStringField
      FieldName = 'PHONES'
      Size = 254
    end
    object getFpReconnectContentTmpProcROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
    object getFpReconnectContentTmpProcCHECK_DATA: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object getFpReconnectContentTmpProcFA_ID: TStringField
      FieldName = 'FA_ID'
      FixedChar = True
      Size = 10
    end
  end
  object getAcctFullListProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_PRE_NOTICES_LIST'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.GET_PRE_NOTICES_LIST(:P_ACCT_OTDELEN, :RC);'
      'end;')
    Left = 352
    Top = 64
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_ACCT_OTDELEN'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'RC'
        ParamType = ptOutput
        Value = 'Object'
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.GET_PRE_NOTICES_LIST'
    object getAcctFullListProcROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
    object getAcctFullListProcCHECK_DATA: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object getAcctFullListProcACCT_ID: TStringField
      FieldName = 'ACCT_ID'
      FixedChar = True
      Size = 10
    end
    object getAcctFullListProcFIO: TStringField
      FieldName = 'FIO'
      Size = 254
    end
    object getAcctFullListProcCITY: TStringField
      FieldName = 'CITY'
      Size = 60
    end
    object getAcctFullListProcADDRESS: TStringField
      FieldName = 'ADDRESS'
      Size = 315
    end
    object getAcctFullListProcPREM_TYPE_DESCR: TStringField
      FieldName = 'PREM_TYPE_DESCR'
      Size = 60
    end
    object getAcctFullListProcSALDO_UCH: TFloatField
      FieldName = 'SALDO_UCH'
    end
    object getAcctFullListProcSALDO_M3: TFloatField
      FieldName = 'SALDO_M3'
    end
    object getAcctFullListProcCC_DTTM: TDateTimeField
      FieldName = 'CC_DTTM'
    end
    object getAcctFullListProcFA_ID: TStringField
      FieldName = 'FA_ID'
      FixedChar = True
      Size = 10
    end
    object getAcctFullListProcFA_PACK_ID: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object getAcctFullListProcCRE_DTTM: TDateTimeField
      FieldName = 'CRE_DTTM'
    end
    object getAcctFullListProcACCT_OTDELEN: TStringField
      FieldName = 'ACCT_OTDELEN'
      FixedChar = True
      Size = 7
    end
    object getAcctFullListProcSERVICE_ORG: TStringField
      FieldName = 'SERVICE_ORG'
      Size = 50
    end
    object getAcctFullListProcOP_AREA_DESCR: TStringField
      FieldName = 'OP_AREA_DESCR'
      Size = 60
    end
    object getAcctFullListProcMR_RTE_CD: TStringField
      FieldName = 'MR_RTE_CD'
      FixedChar = True
      Size = 8
    end
  end
  object createFpCancelForceProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.CREATE_FP_CANCEL_FORCE'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.CREATE_FP_CANCEL_FORCE(:P_FA_ID_LIST);'
      'end;')
    Left = 968
    Top = 760
    ParamData = <
      item
        DataType = ftString
        Name = 'P_FA_ID_LIST'
        ParamType = ptInput
        Size = 10
        Table = True
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.CREATE_FP_CANCEL_FORCE'
  end
  object createFpStopProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.CREATE_FP_STOP'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      
        '  PK_NASEL_SWEETY.CREATE_FP_STOP(:P_ACCT_ID_LIST, :P_FORCE_SELF)' +
        ';'
      'end;')
    Left = 968
    Top = 696
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_ACCT_ID_LIST'
        ParamType = ptInput
        Size = 10
        Table = True
      end
      item
        DataType = ftFloat
        Name = 'P_FORCE_SELF'
        ParamType = ptInput
        HasDefault = True
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.CREATE_FP_STOP'
  end
  object createFpNoticeProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.CREATE_FP_NOTICE'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      
        '  :RESULT := PK_NASEL_SWEETY.CREATE_FP_NOTICE(:P_ACCT_ID_LIST, :' +
        'P_FP_TYPE);'
      'end;')
    Left = 848
    Top = 752
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'RESULT'
        ParamType = ptResult
        Size = 10
        IsResult = True
      end
      item
        DataType = ftString
        Name = 'P_ACCT_ID_LIST'
        ParamType = ptInput
        Size = 10
        Table = True
      end
      item
        DataType = ftFixedChar
        Name = 'P_FP_TYPE'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.CREATE_FP_NOTICE'
  end
  object setFaSaEndDtProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.SET_FA_SA_E_DT'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.SET_FA_SA_E_DT(:P_FA_ID, :P_SA_E_DT);'
      'end;')
    Left = 1280
    Top = 544
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_FA_ID'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'P_SA_E_DT'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.SET_FA_SA_E_DT'
  end
  object getFpCancelContentRam: TVirtualTable
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 1400
    Top = 488
    Data = {03000000000000000000}
  end
  object getFpCancelContentFilter: TDataSetFilter
    OnChange = OnFilterChange
    Glue = ' AND '
    DataSet = getFpCancelContentRam
    Left = 1400
    Top = 424
  end
  object getFpCancelContentProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_FP_CANCEL_CONTENT'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.GET_FP_CANCEL_CONTENT(:P_FA_PACK_ID, :RC);'
      'end;')
    Left = 1400
    Top = 376
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_FA_PACK_ID'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'RC'
        ParamType = ptOutput
        Value = 'Object'
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.GET_FP_CANCEL_CONTENT'
    object FloatField1: TFloatField
      FieldName = 'ROWNUM'
    end
    object FloatField2: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object StringField5: TStringField
      FieldName = 'FA_ID'
      FixedChar = True
      Size = 10
    end
    object StringField6: TStringField
      FieldName = 'ACCT_ID'
      FixedChar = True
      Size = 10
    end
    object StringField7: TStringField
      FieldName = 'ADDRESS'
      Size = 315
    end
    object StringField8: TStringField
      FieldName = 'CITY'
      Size = 60
    end
    object StringField9: TStringField
      FieldName = 'FIO'
      Size = 254
    end
    object StringField10: TStringField
      FieldName = 'POSTAL'
      Size = 10
    end
    object DateTimeField2: TDateTimeField
      FieldName = 'CC_DTTM'
    end
    object StringField11: TStringField
      FieldName = 'SRC_TYPE_CD'
      FixedChar = True
      Size = 10
    end
    object StringField12: TStringField
      FieldName = 'SPR_DESCR'
      Size = 50
    end
    object StringField13: TStringField
      FieldName = 'PHONES'
      Size = 254
    end
    object StringField14: TStringField
      FieldName = 'PHONE'
      Size = 254
    end
    object FloatField3: TFloatField
      FieldName = 'END_REG_READING1'
    end
    object FloatField4: TFloatField
      FieldName = 'END_REG_READING2'
    end
    object FloatField5: TFloatField
      FieldName = 'SALDO_UCH'
    end
    object StringField15: TStringField
      FieldName = 'MTR_SERIAL_NBR'
      Size = 16
    end
    object StringField16: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object StringField17: TStringField
      FieldName = 'ACCT_OTDELEN'
      FixedChar = True
      Size = 7
    end
    object DateTimeField3: TDateTimeField
      FieldName = 'CRE_DTTM'
    end
    object StringField18: TStringField
      FieldName = 'OP_AREA_DESCR'
      Size = 60
    end
    object StringField19: TStringField
      FieldName = 'FA_PACK_TYPE_CD'
      FixedChar = True
      Size = 8
    end
    object FloatField6: TFloatField
      FieldName = 'GRP'
    end
    object StringField20: TStringField
      FieldName = 'PREM_TYPE_DESCR'
      Size = 60
    end
    object DateTimeField4: TDateTimeField
      FieldName = 'ST_P_DT'
    end
    object DateTimeField5: TDateTimeField
      FieldName = 'SA_END_DT'
    end
    object StringField26: TStringField
      FieldName = 'NOTICE_FA_ID'
      FixedChar = True
      Size = 10
    end
    object DateTimeField6: TDateTimeField
      FieldName = 'NOTICE_CRE_DTTM'
    end
    object DateTimeField7: TDateTimeField
      FieldName = 'ST_P_DT_END'
    end
    object DateTimeField10: TDateTimeField
      FieldName = 'CANCEL_FA_PACK_CRE_DTTM'
    end
    object StringField27: TStringField
      FieldName = 'CANCEL_FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object DateTimeField11: TDateTimeField
      FieldName = 'SA_E_DT'
    end
    object getFpCancelContentProcSTOP_FA_ID: TStringField
      FieldName = 'STOP_FA_ID'
      FixedChar = True
      Size = 10
    end
    object getFpCancelContentProcSTOP_FA_PACK_ID: TStringField
      FieldName = 'STOP_FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object getFpCancelContentProcSTOP_SALDO_UCH: TFloatField
      FieldName = 'STOP_SALDO_UCH'
    end
    object getFpCancelContentProcSTOP_CRE_DTTM: TDateTimeField
      FieldName = 'STOP_CRE_DTTM'
    end
    object getFpCancelContentProcNOTICE_FA_PACK_ID: TStringField
      FieldName = 'NOTICE_FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
  end
  object getFpCancelContentDataSource: TOraDataSource
    DataSet = getFpCancelContentProc
    Left = 1400
    Top = 312
  end
  object getFpReconnectContentRam: TVirtualTable
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 1576
    Top = 488
    Data = {03000000000000000000}
  end
  object getFpReconnectContentFilter: TDataSetFilter
    OnChange = OnFilterChange
    Glue = ' AND '
    DataSet = getFpReconnectContentRam
    Left = 1576
    Top = 424
  end
  object getFpReconnectContentProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_FP_RECONNECT_CONTENT'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.GET_FP_RECONNECT_CONTENT(:P_FA_PACK_ID, :RC);'
      'end;')
    Left = 1576
    Top = 376
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_FA_PACK_ID'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'RC'
        ParamType = ptOutput
        Value = 'Object'
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.GET_FP_RECONNECT_CONTENT'
    object getFpReconnectContentProcROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
    object getFpReconnectContentProcCHECK_DATA: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object getFpReconnectContentProcFA_ID: TStringField
      FieldName = 'FA_ID'
      FixedChar = True
      Size = 10
    end
    object getFpReconnectContentProcACCT_ID: TStringField
      FieldName = 'ACCT_ID'
      FixedChar = True
      Size = 10
    end
    object getFpReconnectContentProcFIO: TStringField
      FieldName = 'FIO'
      Size = 254
    end
    object getFpReconnectContentProcSTOP_FA_ID: TStringField
      FieldName = 'STOP_FA_ID'
      FixedChar = True
      Size = 10
    end
    object getFpReconnectContentProcSTOP_FA_PACK_ID: TStringField
      FieldName = 'STOP_FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object getFpReconnectContentProcSTOP_CRE_DTTM: TDateTimeField
      FieldName = 'STOP_CRE_DTTM'
    end
    object getFpReconnectContentProcNOTICE_FA_ID: TStringField
      FieldName = 'NOTICE_FA_ID'
      FixedChar = True
      Size = 10
    end
    object getFpReconnectContentProcNOTICE_FA_PACK_ID: TStringField
      FieldName = 'NOTICE_FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object getFpReconnectContentProcNOTICE_CRE_DTTM: TDateTimeField
      FieldName = 'NOTICE_CRE_DTTM'
    end
    object getFpReconnectContentProcST_P_DT: TDateTimeField
      FieldName = 'ST_P_DT'
    end
    object getFpReconnectContentProcPHONES: TStringField
      FieldName = 'PHONES'
      Size = 254
    end
    object getFpReconnectContentProcCITY: TStringField
      FieldName = 'CITY'
      Size = 60
    end
    object getFpReconnectContentProcADDRESS: TStringField
      FieldName = 'ADDRESS'
      Size = 315
    end
    object getFpReconnectContentProcPREM_TYPE_DESCR: TStringField
      FieldName = 'PREM_TYPE_DESCR'
      Size = 60
    end
  end
  object getFpReconnectContentDataSource: TOraDataSource
    DataSet = getFpReconnectContentProc
    Left = 1576
    Top = 320
  end
  object setCcStatusRefuseProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.SET_CC_STATUS_REFUSE'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.SET_CC_STATUS_REFUSE(:P_CC_ID_LIST);'
      'end;')
    Left = 1384
    Top = 592
    ParamData = <
      item
        DataType = ftString
        Name = 'P_CC_ID_LIST'
        ParamType = ptInput
        Size = 10
        Table = True
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.SET_CC_STATUS_REFUSE'
  end
  object getPreOverdueListDataSource: TOraDataSource
    DataSet = getPreOverdueListProc
    Left = 344
    Top = 592
  end
  object getPreOverdueListFilter: TDataSetFilter
    OnChange = OnFilterChange
    Glue = ' AND '
    DataSet = getPreOverdueListRam
    Left = 344
    Top = 696
  end
  object getPreOverdueListRam: TVirtualTable
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 344
    Top = 760
    Data = {03000000000000000000}
  end
  object getPreOverdueListProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_PRE_OVERDUE_LIST'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.GET_PRE_OVERDUE_LIST(:P_ACCT_OTDELEN, :RC);'
      'end;')
    Left = 336
    Top = 648
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_ACCT_OTDELEN'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'RC'
        ParamType = ptOutput
        Value = 'Object'
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.GET_PRE_OVERDUE_LIST'
    object getPreOverdueListProcROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
    object getPreOverdueListProcCHECK_DATA: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object getPreOverdueListProcFA_ID: TStringField
      FieldName = 'FA_ID'
      FixedChar = True
      Size = 10
    end
    object getPreOverdueListProcACCT_ID: TStringField
      FieldName = 'ACCT_ID'
      FixedChar = True
      Size = 10
    end
    object getPreOverdueListProcST_P_DT: TDateTimeField
      FieldName = 'ST_P_DT'
    end
    object getPreOverdueListProcSA_E_DT: TDateTimeField
      FieldName = 'SA_E_DT'
    end
    object getPreOverdueListProcRT_TYPE: TStringField
      FieldName = 'RT_TYPE'
      Size = 255
    end
    object getPreOverdueListProcFA_PACK_ID: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object getPreOverdueListProcRT_CD: TStringField
      FieldName = 'RT_CD'
      Size = 255
    end
    object getPreOverdueListProcRT_DESCR: TStringField
      FieldName = 'RT_DESCR'
      Size = 254
    end
    object getPreOverdueListProcACCT_OTDELEN: TStringField
      FieldName = 'ACCT_OTDELEN'
      FixedChar = True
      Size = 7
    end
    object getPreOverdueListProcRT_ADDR: TStringField
      FieldName = 'RT_ADDR'
      Size = 254
    end
    object getPreOverdueListProcRT_NAME: TStringField
      FieldName = 'RT_NAME'
      Size = 4000
    end
    object getPreOverdueListProcRT_POST: TStringField
      FieldName = 'RT_POST'
      Size = 4000
    end
    object getPreOverdueListProcCITY: TStringField
      FieldName = 'CITY'
      Size = 60
    end
    object getPreOverdueListProcADDRESS: TStringField
      FieldName = 'ADDRESS'
      Size = 254
    end
    object getPreOverdueListProcFIO: TStringField
      FieldName = 'FIO'
      Size = 254
    end
    object getPreOverdueListProcPREM_TYPE_CD: TStringField
      FieldName = 'PREM_TYPE_CD'
      FixedChar = True
      Size = 8
    end
    object getPreOverdueListProcPREM_TYPE_DESCR: TStringField
      FieldName = 'PREM_TYPE_DESCR'
      Size = 60
    end
  end
  object createFpOverdueProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.CREATE_FP_OVERDUE'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.CREATE_FP_OVERDUE(:P_FA_ID_LIST);'
      'end;')
    Left = 1088
    Top = 696
    ParamData = <
      item
        DataType = ftString
        Name = 'P_FA_ID_LIST'
        ParamType = ptInput
        Size = 10
        Table = True
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.CREATE_FP_OVERDUE'
  end
  object getFpOverdueContentDataSource: TOraDataSource
    DataSet = getFpOverdueContentProc
    Left = 656
    Top = 592
  end
  object getFpOverdueContentFilter: TDataSetFilter
    OnChange = OnFilterChange
    Glue = ' AND '
    DataSet = getFpOverdueContentRam
    Left = 656
    Top = 696
  end
  object getFpOverdueContentRam: TVirtualTable
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 656
    Top = 760
    Data = {03000000000000000000}
  end
  object getFpOverdueContentProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_FP_OVERDUE_CONTENT'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.GET_FP_OVERDUE_CONTENT(:P_FA_PACK_ID, :RC);'
      'end;')
    Left = 656
    Top = 648
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_FA_PACK_ID'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'RC'
        ParamType = ptOutput
        Value = 'Object'
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.GET_FP_OVERDUE_CONTENT'
    object getFpOverdueContentProcROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
    object getFpOverdueContentProcCHECK_DATA: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object getFpOverdueContentProcFA_ID: TStringField
      FieldName = 'FA_ID'
      FixedChar = True
      Size = 10
    end
    object getFpOverdueContentProcACCT_ID: TStringField
      FieldName = 'ACCT_ID'
      FixedChar = True
      Size = 10
    end
    object getFpOverdueContentProcFIO: TStringField
      FieldName = 'FIO'
      Size = 254
    end
    object getFpOverdueContentProcSTOP_FA_ID: TStringField
      FieldName = 'STOP_FA_ID'
      FixedChar = True
      Size = 10
    end
    object getFpOverdueContentProcSTOP_FA_PACK_ID: TStringField
      FieldName = 'STOP_FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object getFpOverdueContentProcSTOP_CRE_DTTM: TDateTimeField
      FieldName = 'STOP_CRE_DTTM'
    end
    object getFpOverdueContentProcNOTICE_FA_ID: TStringField
      FieldName = 'NOTICE_FA_ID'
      FixedChar = True
      Size = 10
    end
    object getFpOverdueContentProcNOTICE_FA_PACK_ID: TStringField
      FieldName = 'NOTICE_FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object getFpOverdueContentProcNOTICE_CRE_DTTM: TDateTimeField
      FieldName = 'NOTICE_CRE_DTTM'
    end
    object getFpOverdueContentProcST_P_DT: TDateTimeField
      FieldName = 'ST_P_DT'
    end
    object getFpOverdueContentProcPHONES: TStringField
      FieldName = 'PHONES'
      Size = 254
    end
    object getFpOverdueContentProcCITY: TStringField
      FieldName = 'CITY'
      Size = 60
    end
    object getFpOverdueContentProcADDRESS: TStringField
      FieldName = 'ADDRESS'
      Size = 315
    end
    object getFpOverdueContentProcPREM_TYPE_DESCR: TStringField
      FieldName = 'PREM_TYPE_DESCR'
      Size = 60
    end
    object getFpOverdueContentProcCC_DTTM: TDateTimeField
      FieldName = 'CC_DTTM'
    end
  end
  object getFpOverdueListDataSource: TOraDataSource
    DataSet = getFpOverdueListProc
    Left = 496
    Top = 592
  end
  object getFpOverdueListFilter: TDataSetFilter
    OnChange = OnFilterChange
    Glue = ' AND '
    DataSet = getFpOverdueListRam
    Left = 496
    Top = 696
  end
  object getFpOverdueListRam: TVirtualTable
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 496
    Top = 760
    Data = {03000000000000000000}
  end
  object getFpOverdueListProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_FP_OVERDUE_LIST'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      
        '  PK_NASEL_SWEETY.GET_FP_OVERDUE_LIST(:P_ACCT_OTDELEN, :P_FA_ID,' +
        ' :P_ACCT_ID, :RC);'
      'end;')
    Left = 496
    Top = 648
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_ACCT_OTDELEN'
        ParamType = ptInput
      end
      item
        DataType = ftFixedChar
        Name = 'P_FA_ID'
        ParamType = ptInput
      end
      item
        DataType = ftFixedChar
        Name = 'P_ACCT_ID'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'RC'
        ParamType = ptOutput
        Value = 'Object'
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.GET_FP_OVERDUE_LIST'
    object FloatField7: TFloatField
      FieldName = 'ROWNUM'
    end
    object FloatField8: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object StringField28: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object DateTimeField12: TDateTimeField
      FieldName = 'CRE_DTTM'
    end
    object DateTimeField13: TDateTimeField
      FieldName = 'ST_P_DT'
    end
    object StringField29: TStringField
      FieldName = 'OWNER'
      Size = 22
    end
    object StringField30: TStringField
      FieldName = 'FA_PACK_STATUS_DESCR'
      Size = 60
    end
    object FloatField9: TFloatField
      FieldName = 'FA_CNT'
    end
    object StringField31: TStringField
      FieldName = 'FA_PACK_STATUS_FLG'
      FixedChar = True
      Size = 2
    end
    object StringField32: TStringField
      FieldName = 'FA_PACK_TYPE_DESCR'
      Size = 60
    end
    object StringField33: TStringField
      FieldName = 'RT_TYPE'
      Size = 255
    end
    object StringField34: TStringField
      FieldName = 'SIGNER_NAME'
      Size = 25
    end
    object StringField35: TStringField
      FieldName = 'SIGNER_POST'
      Size = 100
    end
    object StringField36: TStringField
      FieldName = 'RT_CD'
      Size = 255
    end
    object StringField37: TStringField
      FieldName = 'RT_DESCR'
      Size = 255
    end
    object StringField38: TStringField
      FieldName = 'RT_ADDR'
      Size = 255
    end
    object StringField39: TStringField
      FieldName = 'RT_POST'
      Size = 255
    end
    object StringField40: TStringField
      FieldName = 'RT_NAME'
      Size = 255
    end
    object StringField41: TStringField
      FieldName = 'SGNR_NAME'
      Size = 25
    end
    object StringField42: TStringField
      FieldName = 'SGNR_POST'
      Size = 100
    end
  end
  object findFpOverdueListDataSource: TOraDataSource
    DataSet = findFpOverdueListProc
    Left = 1568
    Top = 24
  end
  object findFpOverdueListFilter: TDataSetFilter
    Glue = ' AND '
    DataSet = findFpOverdueListRam
    Left = 1568
    Top = 128
  end
  object findFpOverdueListProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_FP_OVERDUE_LIST'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      
        '  PK_NASEL_SWEETY.GET_FP_OVERDUE_LIST(:P_ACCT_OTDELEN, :P_FA_ID,' +
        ' :P_ACCT_ID, :RC);'
      'end;')
    Left = 1568
    Top = 80
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_ACCT_OTDELEN'
        ParamType = ptInput
      end
      item
        DataType = ftFixedChar
        Name = 'P_FA_ID'
        ParamType = ptInput
      end
      item
        DataType = ftFixedChar
        Name = 'P_ACCT_ID'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'RC'
        ParamType = ptOutput
        Value = 'Object'
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.GET_FP_OVERDUE_LIST'
    object findFpOverdueListProcROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
    object findFpOverdueListProcCHECK_DATA: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object findFpOverdueListProcFA_PACK_ID: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object findFpOverdueListProcRT_CD: TStringField
      FieldName = 'RT_CD'
      Size = 255
    end
    object findFpOverdueListProcRT_TYPE: TStringField
      FieldName = 'RT_TYPE'
      Size = 255
    end
    object findFpOverdueListProcRT_DESCR: TStringField
      FieldName = 'RT_DESCR'
      Size = 255
    end
    object findFpOverdueListProcRT_ADDR: TStringField
      FieldName = 'RT_ADDR'
      Size = 255
    end
    object findFpOverdueListProcRT_POST: TStringField
      FieldName = 'RT_POST'
      Size = 255
    end
    object findFpOverdueListProcRT_NAME: TStringField
      FieldName = 'RT_NAME'
      Size = 255
    end
    object findFpOverdueListProcSIGNER_NAME: TStringField
      FieldName = 'SIGNER_NAME'
      Size = 25
    end
    object findFpOverdueListProcSIGNER_POST: TStringField
      FieldName = 'SIGNER_POST'
      Size = 100
    end
    object findFpOverdueListProcCRE_DTTM: TDateTimeField
      FieldName = 'CRE_DTTM'
    end
    object findFpOverdueListProcFA_PACK_STATUS_FLG: TStringField
      FieldName = 'FA_PACK_STATUS_FLG'
      FixedChar = True
      Size = 2
    end
    object findFpOverdueListProcSGNR_NAME: TStringField
      FieldName = 'SGNR_NAME'
      Size = 25
    end
    object findFpOverdueListProcSGNR_POST: TStringField
      FieldName = 'SGNR_POST'
      Size = 100
    end
    object findFpOverdueListProcOWNER: TStringField
      FieldName = 'OWNER'
      Size = 22
    end
    object findFpOverdueListProcFA_PACK_STATUS_DESCR: TStringField
      FieldName = 'FA_PACK_STATUS_DESCR'
      Size = 60
    end
    object findFpOverdueListProcFA_PACK_TYPE_DESCR: TStringField
      FieldName = 'FA_PACK_TYPE_DESCR'
      Size = 60
    end
    object findFpOverdueListProcFA_CNT: TFloatField
      FieldName = 'FA_CNT'
    end
    object findFpOverdueListProcFA_PACK_TYPE_CD: TStringField
      FieldName = 'FA_PACK_TYPE_CD'
      FixedChar = True
      Size = 8
    end
  end
  object findFpOverdueListRam: TVirtualTable
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 1568
    Top = 192
    Data = {03000000000000000000}
  end
end
