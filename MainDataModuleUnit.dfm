object MainDataModule: TMainDataModule
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 414
  Top = 227
  Height = 908
  Width = 1549
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
    Left = 792
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
    Left = 800
    Top = 712
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
  object getFaPackListNoticesDataSource: TOraDataSource
    DataSet = getFaPackListNoticesProc
    Left = 984
    Top = 8
  end
  object getFaPackDataSource: TOraDataSource
    DataSet = getFaPackNoticesProc
    Left = 576
    Top = 8
  end
  object addCcProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.ADD_FA_CC'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      
        '  :RESULT := PK_NASEL_SWEETY.ADD_FA_CC(:P_CC_DTTM, :P_CC_TYPE_CD' +
        ', :P_CC_STATUS_FLG, :P_ACCT_ID, :P_DESCR, :P_SRC_ID, :P_SRC_TYPE' +
        '_CD, :P_CALLER);'
      'end;')
    Left = 840
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
        Name = 'P_CC_STATUS_FLG'
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
    Left = 840
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
    Left = 952
    Top = 592
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_CC_ID'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.SET_CC_APPROVAL'
  end
  object getFaPackNoticesFilter: TDataSetFilter
    OnChange = OnFilterChange
    Glue = ' AND '
    DataSet = getFaPackRam
    Left = 576
    Top = 112
  end
  object getFaPackListNoticesFilter: TDataSetFilter
    Glue = ' AND '
    DataSet = getFaPackListNoticesRam
    Left = 984
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
    Left = 560
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
  object getStopListDataSource: TOraDataSource
    DataSet = getStopListProc
    Left = 360
    Top = 288
  end
  object getStopListFilter: TDataSetFilter
    OnChange = OnFilterChange
    Glue = ' AND '
    DataSet = getStopListRam
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
    Left = 1312
    Top = 424
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
  object getFaPackStopDataSource: TOraDataSource
    DataSet = getFaPackStopProc
    Left = 488
    Top = 288
  end
  object getFaPackStopFilter: TDataSetFilter
    OnChange = OnFilterChange
    Glue = ' AND '
    DataSet = getFaPackStopRam
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
  object getPackListStopDataSource: TOraDataSource
    DataSet = getFaPackListStopProc
    Left = 608
    Top = 288
  end
  object getPackListStopFilter: TDataSetFilter
    OnChange = OnFilterChange
    Glue = ' AND '
    DataSet = getPackListStopRam
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
        ' :P_CC_STATUS_FLG, :P_DESCR, :P_CALLER);'
      'end;')
    Left = 952
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
        DataType = ftFixedChar
        Name = 'P_CC_STATUS_FLG'
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
    Left = 1032
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
    Left = 1032
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
  object getStopListRam: TVirtualTable
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
  object getFaPackRam: TVirtualTable
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 576
    Top = 176
    Data = {03000000000000000000}
  end
  object getFaPackStopRam: TVirtualTable
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 480
    Top = 464
    Data = {03000000000000000000}
  end
  object getPackListStopRam: TVirtualTable
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 600
    Top = 456
    Data = {03000000000000000000}
  end
  object getCancelStopListDataSource: TOraDataSource
    DataSet = getFaPackListCancelStopProc
    Left = 784
    Top = 288
  end
  object getFaPackListCancelStopFilter: TDataSetFilter
    OnChange = OnFilterChange
    Glue = ' AND '
    DataSet = getCancelStopListRam
    Left = 784
    Top = 392
  end
  object getCancelStopListRam: TVirtualTable
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
    Left = 1080
    Top = 600
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_FA_PACK_ID'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.DELETE_FP'
  end
  object setFaPackStatusFlgCancelProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.SET_FP_STATUS_FLG_CANCEL'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.SET_FP_STATUS_FLG_CANCEL(:P_FA_PACK_ID);'
      'end;')
    Left = 912
    Top = 736
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_FA_PACK_ID'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.SET_FP_STATUS_FLG_CANCEL'
  end
  object updateFaPackCharRecipientProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.ADD_FP_CHAR_RECIPIENT'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      
        '  PK_NASEL_SWEETY.ADD_FP_CHAR_RECIPIENT(:P_FA_PACK_ID, :P_FORCE_' +
        'SELF);'
      'end;')
    Left = 632
    Top = 530
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_FA_PACK_ID'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'P_FORCE_SELF'
        ParamType = ptInput
        HasDefault = True
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.ADD_FP_CHAR_RECIPIENT'
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
    Left = 808
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
  object getFaPackNoticesProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_FP_NOTICES_CONTENT'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.GET_FP_NOTICES_CONTENT(:P_FA_PACK_ID, :RC);'
      'end;')
    Left = 568
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
    object getFaPackNoticesProcROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
    object getFaPackNoticesProcCHECK_DATA: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object getFaPackNoticesProcFA_ID: TStringField
      FieldName = 'FA_ID'
      FixedChar = True
      Size = 10
    end
    object getFaPackNoticesProcACCT_ID: TStringField
      FieldName = 'ACCT_ID'
      FixedChar = True
      Size = 10
    end
    object getFaPackNoticesProcADDRESS: TStringField
      FieldName = 'ADDRESS'
      Size = 315
    end
    object getFaPackNoticesProcCITY: TStringField
      FieldName = 'CITY'
      Size = 60
    end
    object getFaPackNoticesProcFIO: TStringField
      FieldName = 'FIO'
      Size = 254
    end
    object getFaPackNoticesProcPOSTAL: TStringField
      FieldName = 'POSTAL'
      Size = 10
    end
    object getFaPackNoticesProcCC_DTTM: TDateTimeField
      FieldName = 'CC_DTTM'
    end
    object getFaPackNoticesProcSRC_TYPE_CD: TStringField
      FieldName = 'SRC_TYPE_CD'
      FixedChar = True
      Size = 10
    end
    object getFaPackNoticesProcSERVICE_ORG: TStringField
      FieldName = 'SERVICE_ORG'
      Size = 50
    end
    object getFaPackNoticesProcPHONES: TStringField
      FieldName = 'PHONES'
      Size = 254
    end
    object getFaPackNoticesProcPHONE: TStringField
      FieldName = 'PHONE'
      Size = 254
    end
    object getFaPackNoticesProcEND_REG_READING_SZ1: TFloatField
      FieldName = 'END_REG_READING_SZ1'
    end
    object getFaPackNoticesProcEND_REG_READING1: TFloatField
      FieldName = 'END_REG_READING1'
    end
    object getFaPackNoticesProcEND_REG_READING2: TFloatField
      FieldName = 'END_REG_READING2'
    end
    object getFaPackNoticesProcSALDO_UCH: TFloatField
      FieldName = 'SALDO_UCH'
    end
    object getFaPackNoticesProcMTR_SERIAL_NBR: TStringField
      FieldName = 'MTR_SERIAL_NBR'
      Size = 16
    end
    object getFaPackNoticesProcFA_PACK_ID: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object getFaPackNoticesProcACCT_OTDELEN: TStringField
      FieldName = 'ACCT_OTDELEN'
      FixedChar = True
      Size = 7
    end
    object getFaPackNoticesProcCRE_DTTM: TDateTimeField
      FieldName = 'CRE_DTTM'
    end
    object getFaPackNoticesProcOP_AREA_DESCR: TStringField
      FieldName = 'OP_AREA_DESCR'
      Size = 60
    end
    object getFaPackNoticesProcFA_PACK_TYPE_CD: TStringField
      FieldName = 'FA_PACK_TYPE_CD'
      FixedChar = True
      Size = 8
    end
    object getFaPackNoticesProcCONT_QTY_SZ: TFloatField
      FieldName = 'CONT_QTY_SZ'
    end
    object getFaPackNoticesProcCC_ID: TStringField
      FieldName = 'CC_ID'
      FixedChar = True
      Size = 10
    end
    object getFaPackNoticesProcCC_STATUS_FLG: TStringField
      FieldName = 'CC_STATUS_FLG'
      FixedChar = True
      Size = 2
    end
    object getFaPackNoticesProcCC_TYPE_CD: TStringField
      FieldName = 'CC_TYPE_CD'
      FixedChar = True
      Size = 10
    end
    object getFaPackNoticesProcOWNER: TStringField
      FieldName = 'OWNER'
      Size = 22
    end
    object getFaPackNoticesProcAPPROVAL_DTTM: TDateTimeField
      FieldName = 'APPROVAL_DTTM'
    end
    object getFaPackNoticesProcMR_RTE_CD: TStringField
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
  end
  object getStopListProc: TOraStoredProc
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
    object getStopListProcROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
    object getStopListProcCHECK_DATA: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object getStopListProcGRP_DATA: TFloatField
      FieldName = 'GRP_DATA'
    end
    object getStopListProcACCT_ID: TStringField
      FieldName = 'ACCT_ID'
      FixedChar = True
      Size = 10
    end
    object getStopListProcAPPROVAL_DTTM: TDateTimeField
      FieldName = 'APPROVAL_DTTM'
    end
    object getStopListProcCC_DTTM: TDateTimeField
      FieldName = 'CC_DTTM'
    end
    object getStopListProcFIO: TStringField
      FieldName = 'FIO'
      Size = 254
    end
    object getStopListProcPOSTAL: TStringField
      FieldName = 'POSTAL'
      Size = 10
    end
    object getStopListProcCITY: TStringField
      FieldName = 'CITY'
      Size = 60
    end
    object getStopListProcADDRESS: TStringField
      FieldName = 'ADDRESS'
      Size = 315
    end
    object getStopListProcPREM_TYPE_DESCR: TStringField
      FieldName = 'PREM_TYPE_DESCR'
      Size = 60
    end
    object getStopListProcSALDO_UCH: TFloatField
      FieldName = 'SALDO_UCH'
    end
    object getStopListProcSPR_DESCR: TStringField
      FieldName = 'SPR_DESCR'
      Size = 50
    end
    object getStopListProcFA_PACK_ID: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object getStopListProcFA_PACK_TYPE_DESCR: TStringField
      FieldName = 'FA_PACK_TYPE_DESCR'
      Size = 60
    end
    object getStopListProcGRP_DATA_MAX: TFloatField
      FieldName = 'GRP_DATA_MAX'
    end
  end
  object getFaPackStopProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_FP_STOP_CONTENT'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.GET_FP_STOP_CONTENT(:P_FA_PACK_ID, :RC);'
      'end;')
    Left = 480
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
    CommandStoredProcName = 'PK_NASEL_SWEETY.GET_FP_STOP_CONTENT'
    object getFaPackStopProcROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
    object getFaPackStopProcCHECK_DATA: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object getFaPackStopProcFA_ID: TStringField
      FieldName = 'FA_ID'
      FixedChar = True
      Size = 10
    end
    object getFaPackStopProcACCT_ID: TStringField
      FieldName = 'ACCT_ID'
      FixedChar = True
      Size = 10
    end
    object getFaPackStopProcADDRESS: TStringField
      FieldName = 'ADDRESS'
      Size = 315
    end
    object getFaPackStopProcCITY: TStringField
      FieldName = 'CITY'
      Size = 60
    end
    object getFaPackStopProcFIO: TStringField
      FieldName = 'FIO'
      Size = 254
    end
    object getFaPackStopProcPOSTAL: TStringField
      FieldName = 'POSTAL'
      Size = 10
    end
    object getFaPackStopProcCC_DTTM: TDateTimeField
      FieldName = 'CC_DTTM'
    end
    object getFaPackStopProcSRC_TYPE_CD: TStringField
      FieldName = 'SRC_TYPE_CD'
      FixedChar = True
      Size = 10
    end
    object getFaPackStopProcSPR_DESCR: TStringField
      FieldName = 'SPR_DESCR'
      Size = 50
    end
    object getFaPackStopProcPHONES: TStringField
      FieldName = 'PHONES'
      Size = 254
    end
    object getFaPackStopProcPHONE: TStringField
      FieldName = 'PHONE'
      Size = 254
    end
    object getFaPackStopProcEND_REG_READING1: TFloatField
      FieldName = 'END_REG_READING1'
    end
    object getFaPackStopProcEND_REG_READING2: TFloatField
      FieldName = 'END_REG_READING2'
    end
    object getFaPackStopProcSALDO_UCH: TFloatField
      FieldName = 'SALDO_UCH'
    end
    object getFaPackStopProcMTR_SERIAL_NBR: TStringField
      FieldName = 'MTR_SERIAL_NBR'
      Size = 16
    end
    object getFaPackStopProcFA_PACK_ID: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object getFaPackStopProcACCT_OTDELEN: TStringField
      FieldName = 'ACCT_OTDELEN'
      FixedChar = True
      Size = 7
    end
    object getFaPackStopProcCRE_DTTM: TDateTimeField
      FieldName = 'CRE_DTTM'
    end
    object getFaPackStopProcOP_AREA_DESCR: TStringField
      FieldName = 'OP_AREA_DESCR'
      Size = 60
    end
    object getFaPackStopProcFA_PACK_TYPE_CD: TStringField
      FieldName = 'FA_PACK_TYPE_CD'
      FixedChar = True
      Size = 8
    end
    object getFaPackStopProcGRP: TFloatField
      FieldName = 'GRP'
    end
    object getFaPackStopProcPREM_TYPE_DESCR: TStringField
      FieldName = 'PREM_TYPE_DESCR'
      Size = 60
    end
    object getFaPackStopProcST_P_DT: TDateTimeField
      FieldName = 'ST_P_DT'
    end
    object getFaPackStopProcSA_END_DT: TDateTimeField
      FieldName = 'SA_END_DT'
    end
    object getFaPackStopProcNOTICE_FA_ID: TStringField
      FieldName = 'NOTICE_FA_ID'
      FixedChar = True
      Size = 10
    end
    object getFaPackStopProcNOTICE_CRE_DTTM: TDateTimeField
      FieldName = 'NOTICE_CRE_DTTM'
    end
  end
  object getFaPackListStopProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_FP_STOP_LIST'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      
        '  PK_NASEL_SWEETY.GET_FP_STOP_LIST(:P_ACCT_OTDELEN, :P_FA_ID, :P' +
        '_ACCT_ID, :RC);'
      'end;')
    Left = 600
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
    object getFaPackListStopProcROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
    object getFaPackListStopProcCHECK_DATA: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object getFaPackListStopProcFA_PACK_ID: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object getFaPackListStopProcRECIPIENT_SPR_DESCR: TStringField
      FieldName = 'RECIPIENT_SPR_DESCR'
      Size = 255
    end
    object getFaPackListStopProcRECIPIENT_ADDRESS: TStringField
      FieldName = 'RECIPIENT_ADDRESS'
      Size = 255
    end
    object getFaPackListStopProcRECIPIENT_OFFICIAL_POST: TStringField
      FieldName = 'RECIPIENT_OFFICIAL_POST'
      Size = 255
    end
    object getFaPackListStopProcRECIPIENT_OFFICIAL_NAME: TStringField
      FieldName = 'RECIPIENT_OFFICIAL_NAME'
      Size = 255
    end
    object getFaPackListStopProcCRE_DTTM: TDateTimeField
      FieldName = 'CRE_DTTM'
    end
    object getFaPackListStopProcST_P_DT: TDateTimeField
      FieldName = 'ST_P_DT'
    end
    object getFaPackListStopProcOWNER: TStringField
      FieldName = 'OWNER'
      Size = 22
    end
    object getFaPackListStopProcFA_PACK_STATUS_DESCR: TStringField
      FieldName = 'FA_PACK_STATUS_DESCR'
      Size = 60
    end
    object getFaPackListStopProcFA_CNT: TFloatField
      FieldName = 'FA_CNT'
    end
    object getFaPackListStopProcFA_PACK_STATUS_FLG: TStringField
      FieldName = 'FA_PACK_STATUS_FLG'
      FixedChar = True
      Size = 2
    end
    object getFaPackListStopProcFA_PACK_TYPE_DESCR: TStringField
      FieldName = 'FA_PACK_TYPE_DESCR'
      Size = 60
    end
    object getFaPackListStopProcRT_SPR_CD: TStringField
      FieldName = 'RT_SPR_CD'
      Size = 255
    end
    object getFaPackListStopProcRT_TYPE: TStringField
      FieldName = 'RT_TYPE'
      Size = 255
    end
  end
  object getFaPackListCancelStopProc: TOraStoredProc
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
    object getFaPackListCancelStopProcROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
    object getFaPackListCancelStopProcCHECK_DATA: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object getFaPackListCancelStopProcFA_PACK_ID: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object getFaPackListCancelStopProcCRE_DTTM: TDateTimeField
      FieldName = 'CRE_DTTM'
    end
    object getFaPackListCancelStopProcFA_PACK_STATUS_DESCR: TStringField
      FieldName = 'FA_PACK_STATUS_DESCR'
      Size = 60
    end
    object getFaPackListCancelStopProcFA_PACK_STATUS_FLG: TStringField
      FieldName = 'FA_PACK_STATUS_FLG'
      FixedChar = True
      Size = 2
    end
    object getFaPackListCancelStopProcPRNT_FA_ID: TStringField
      FieldName = 'PRNT_FA_ID'
      Size = 10
    end
    object getFaPackListCancelStopProcFA_ID: TStringField
      FieldName = 'FA_ID'
      FixedChar = True
      Size = 10
    end
    object getFaPackListCancelStopProcRT_SPR: TStringField
      FieldName = 'RT_SPR'
      Size = 255
    end
    object getFaPackListCancelStopProcRT_ADDR: TStringField
      FieldName = 'RT_ADDR'
      Size = 255
    end
    object getFaPackListCancelStopProcRT_POST: TStringField
      FieldName = 'RT_POST'
      Size = 255
    end
    object getFaPackListCancelStopProcRT_NAME: TStringField
      FieldName = 'RT_NAME'
      Size = 255
    end
    object getFaPackListCancelStopProcACCT_ID_CNT: TFloatField
      FieldName = 'ACCT_ID_CNT'
    end
    object getFaPackListCancelStopProcOWNER: TStringField
      FieldName = 'OWNER'
      Size = 22
    end
  end
  object getFaPackListNoticesProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_FP_NOTICES_CONTENT'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.GET_FP_NOTICES_CONTENT(:P_FA_PACK_ID, :RC);'
      'end;')
    Left = 984
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
    object getFaPackListNoticesProcROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
    object getFaPackListNoticesProcCHECK_DATA: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object getFaPackListNoticesProcCRE_DTTM: TDateTimeField
      FieldName = 'CRE_DTTM'
    end
    object getFaPackListNoticesProcACCT_OTDELEN: TStringField
      FieldName = 'ACCT_OTDELEN'
      FixedChar = True
      Size = 7
    end
    object getFaPackListNoticesProcFA_PACK_ID: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object getFaPackListNoticesProcFA_PACK_TYPE_CD: TStringField
      FieldName = 'FA_PACK_TYPE_CD'
      FixedChar = True
      Size = 8
    end
    object getFaPackListNoticesProcFA_CNT: TFloatField
      FieldName = 'FA_CNT'
    end
    object getFaPackListNoticesProcFA_PACK_TYPE_DESCR: TStringField
      FieldName = 'FA_PACK_TYPE_DESCR'
      Size = 60
    end
    object getFaPackListNoticesProcFA_PACK_STATUS_DESCR: TStringField
      FieldName = 'FA_PACK_STATUS_DESCR'
      Size = 60
    end
  end
  object getFaPackListNoticesRam: TVirtualTable
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 984
    Top = 176
    Data = {03000000000000000000}
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
  end
  object findFaPackListNoticesRam: TVirtualTable
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 1312
    Top = 192
    Data = {03000000000000000000}
  end
  object findFaPackListStopDS: TOraDataSource
    DataSet = findFaPackListStopProc
    Left = 1440
    Top = 24
  end
  object findFaPackListStopFilter: TDataSetFilter
    Glue = ' AND '
    DataSet = findFaPackListStopRam
    Left = 1440
    Top = 128
  end
  object findFaPackListStopProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_FP_STOP_LIST'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      
        '  PK_NASEL_SWEETY.GET_FP_STOP_LIST(:P_ACCT_OTDELEN, :P_FA_ID, :P' +
        '_ACCT_ID, :RC);'
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
    CommandStoredProcName = 'PK_NASEL_SWEETY.GET_FP_STOP_LIST'
    object findFaPackListStopProcROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
    object findFaPackListStopProcCHECK_DATA: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object findFaPackListStopProcFA_PACK_ID: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object findFaPackListStopProcRECIPIENT_SPR_DESCR: TStringField
      FieldName = 'RECIPIENT_SPR_DESCR'
      Size = 255
    end
    object findFaPackListStopProcRECIPIENT_ADDRESS: TStringField
      FieldName = 'RECIPIENT_ADDRESS'
      Size = 255
    end
    object findFaPackListStopProcRECIPIENT_OFFICIAL_POST: TStringField
      FieldName = 'RECIPIENT_OFFICIAL_POST'
      Size = 255
    end
    object findFaPackListStopProcRECIPIENT_OFFICIAL_NAME: TStringField
      FieldName = 'RECIPIENT_OFFICIAL_NAME'
      Size = 255
    end
    object findFaPackListStopProcCRE_DTTM: TDateTimeField
      FieldName = 'CRE_DTTM'
    end
    object findFaPackListStopProcFA_PACK_STATUS_FLG: TStringField
      FieldName = 'FA_PACK_STATUS_FLG'
      FixedChar = True
      Size = 2
    end
    object findFaPackListStopProcST_P_DT: TDateTimeField
      FieldName = 'ST_P_DT'
    end
    object findFaPackListStopProcOWNER: TStringField
      FieldName = 'OWNER'
      Size = 22
    end
    object findFaPackListStopProcFA_PACK_STATUS_DESCR: TStringField
      FieldName = 'FA_PACK_STATUS_DESCR'
      Size = 60
    end
    object findFaPackListStopProcFA_CNT: TFloatField
      FieldName = 'FA_CNT'
    end
    object findFaPackListStopProcFA_PACK_TYPE_DESCR: TStringField
      FieldName = 'FA_PACK_TYPE_DESCR'
      Size = 60
    end
  end
  object findFaPackListStopRam: TVirtualTable
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 1440
    Top = 192
    Data = {03000000000000000000}
  end
  object getFpCancelStopContentProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_FP_CANCEL_STOP_CONTENT'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      
        '  PK_NASEL_SWEETY.GET_FP_CANCEL_STOP_CONTENT(:P_FA_PACK_ID, :RC)' +
        ';'
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
    CommandStoredProcName = 'PK_NASEL_SWEETY.GET_FP_CANCEL_STOP_CONTENT'
    object getFpCancelStopContentProcACCT_ID: TStringField
      FieldName = 'ACCT_ID'
      FixedChar = True
      Size = 10
    end
    object getFpCancelStopContentProcFIO: TStringField
      FieldName = 'FIO'
      Size = 254
    end
    object getFpCancelStopContentProcSTOP_FA_ID: TStringField
      FieldName = 'STOP_FA_ID'
      FixedChar = True
      Size = 10
    end
    object getFpCancelStopContentProcSTOP_FA_PACK_ID: TStringField
      FieldName = 'STOP_FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object getFpCancelStopContentProcSTOP_CRE_DTTM: TDateTimeField
      FieldName = 'STOP_CRE_DTTM'
    end
    object getFpCancelStopContentProcNOTICE_FA_ID: TStringField
      FieldName = 'NOTICE_FA_ID'
      FixedChar = True
      Size = 10
    end
    object getFpCancelStopContentProcNOTICE_FA_PACK_ID: TStringField
      FieldName = 'NOTICE_FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object getFpCancelStopContentProcNOTICE_CRE_DTTM: TDateTimeField
      FieldName = 'NOTICE_CRE_DTTM'
    end
    object getFpCancelStopContentProcST_P_DT: TDateTimeField
      FieldName = 'ST_P_DT'
    end
    object getFpCancelStopContentProcCITY: TStringField
      FieldName = 'CITY'
      Size = 60
    end
    object getFpCancelStopContentProcADDRESS: TStringField
      FieldName = 'ADDRESS'
      Size = 315
    end
    object getFpCancelStopContentProcPREM_TYPE_DESCR: TStringField
      FieldName = 'PREM_TYPE_DESCR'
      Size = 60
    end
  end
  object createFaStopProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.CREATE_FA_STOP'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      
        '  :RESULT := PK_NASEL_SWEETY.CREATE_FA_STOP(:P_ACCT_ID, :P_FA_PA' +
        'CK_ID);'
      'end;')
    Left = 688
    Top = 744
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
    CommandStoredProcName = 'PK_NASEL_SWEETY.CREATE_FA_STOP'
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
    Left = 1168
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
  object getReconnectListDataSource: TOraDataSource
    DataSet = getReconnectListProc
    Left = 1088
    Top = 296
  end
  object getReconnectListFilter: TDataSetFilter
    OnChange = OnFilterChange
    Glue = ' AND '
    DataSet = getReconnectListRam
    Left = 1088
    Top = 400
  end
  object getReconnectListRam: TVirtualTable
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 1088
    Top = 464
    Data = {03000000000000000000}
  end
  object getReconnectListProc: TOraStoredProc
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
    object getReconnectListProcROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
    object getReconnectListProcCHECK_DATA: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object getReconnectListProcFA_PACK_ID: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object getReconnectListProcCRE_DTTM: TDateTimeField
      FieldName = 'CRE_DTTM'
    end
    object getReconnectListProcFA_PACK_STATUS_FLG: TStringField
      FieldName = 'FA_PACK_STATUS_FLG'
      FixedChar = True
      Size = 2
    end
    object getReconnectListProcPRNT_FA_ID: TStringField
      FieldName = 'PRNT_FA_ID'
      Size = 10
    end
    object getReconnectListProcRT_SPR: TStringField
      FieldName = 'RT_SPR'
      Size = 255
    end
    object getReconnectListProcRT_ADDR: TStringField
      FieldName = 'RT_ADDR'
      Size = 255
    end
    object getReconnectListProcRT_POST: TStringField
      FieldName = 'RT_POST'
      Size = 255
    end
    object getReconnectListProcRT_NAME: TStringField
      FieldName = 'RT_NAME'
      Size = 255
    end
    object getReconnectListProcFA_PACK_STATUS_DESCR: TStringField
      FieldName = 'FA_PACK_STATUS_DESCR'
      Size = 60
    end
    object getReconnectListProcACCT_ID_CNT: TFloatField
      FieldName = 'ACCT_ID_CNT'
    end
    object getReconnectListProcOWNER: TStringField
      FieldName = 'OWNER'
      Size = 22
    end
  end
  object getFpReconnectContentProc: TOraStoredProc
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
    object getFpReconnectContentProcPHONES: TStringField
      FieldName = 'PHONES'
      Size = 254
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
end
