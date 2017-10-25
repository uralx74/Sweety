object MainDataModule: TMainDataModule
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 288
  Top = 136
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
  object CreateFaProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.CREATE_FA'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      
        '  :RESULT := PK_NASEL_SWEETY.CREATE_FA(:P_ACCT_ID, :P_FA_PACK_ID' +
        ');'
      'end;')
    Left = 680
    Top = 464
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
    Left = 584
    Top = 288
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
  object addCcProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.ADD_FA_CC'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      
        '  :RESULT := PK_NASEL_SWEETY.ADD_FA_CC(:P_CC_DTTM, :P_CC_TYPE_CD' +
        ', :P_ACCT_ID, :P_DESCR, :P_SRC_ID, :P_SRC_TYPE_CD, :P_AGENT_TYPE' +
        '_CD, :P_AGENT_ID);'
      'end;')
    Left = 728
    Top = 288
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
        DataType = ftFixedChar
        Name = 'P_AGENT_TYPE_CD'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'P_AGENT_ID'
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
    Left = 728
    Top = 336
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
  object setCcApprovalProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.SET_CC_APPROVAL'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.SET_CC_APPROVAL(:P_CC_ID);'
      'end;')
    Left = 840
    Top = 280
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_CC_ID'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.SET_CC_APPROVAL'
  end
  object getCheckedFilter: TDataSetFilter
    Glue = ' AND '
    Left = 448
    Top = 296
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
  object getOtdelenListDataSource: TOraDataSource
    DataSet = getOtdelenListProc
    Left = 120
    Top = 248
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
    Left = 800
    Top = 104
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
  object updateCcProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.UPDATE_CC'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      
        '  PK_NASEL_SWEETY.UPDATE_CC(:P_CC_ID, :P_CC_DTTM, :P_CC_TYPE_CD,' +
        ' :P_DESCR, :P_AGENT_TYPE_CD, :P_AGENT_ID);'
      'end;')
    Left = 840
    Top = 344
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
        DataType = ftFixedChar
        Name = 'P_AGENT_TYPE_CD'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'P_AGENT_ID'
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
    Left = 944
    Top = 344
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
    Left = 920
    Top = 440
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_FA_PACK_ID'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.SET_FP_STATUS_FLG_FROZEN'
  end
  object deleteFaPackProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.DELETE_FP'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.DELETE_FP(:P_FA_PACK_ID);'
      'end;')
    Left = 1056
    Top = 280
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
    Left = 800
    Top = 424
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
    Left = 1136
    Top = 80
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
  object getOtdelenListProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_ACCT_OTDELEN_LIST'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.GET_ACCT_OTDELEN_LIST(:RC);'
      'end;')
    FetchAll = True
    Filtered = True
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
  object getOpAreaProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_OP_AREA_CD_LIST'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.GET_OP_AREA_CD_LIST(:P_ACCT_OTDELEN, :RC);'
      'end;')
    FetchAll = True
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
    object getOpAreaProcOP_AREA_CD: TStringField
      FieldName = 'OP_AREA_CD'
      Size = 8
    end
    object getOpAreaProcACCT_OTDELEN: TStringField
      FieldName = 'ACCT_OTDELEN'
      FixedChar = True
      Size = 7
    end
    object getOpAreaProcDESCR: TStringField
      FieldName = 'DESCR'
      Size = 60
    end
  end
  object getConfigProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_APP_CONFIG'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.GET_APP_CONFIG(:P_APP_PATH, :P_APP_VER, :RC);'
      'end;')
    FetchAll = True
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
    Left = 1032
    Top = 80
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
    Left = 1056
    Top = 424
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
  object createFpCancelForceProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.CREATE_FP_CANCEL_FORCE'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.CREATE_FP_CANCEL_FORCE(:P_FA_ID_LIST);'
      'end;')
    Left = 528
    Top = 448
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
    Left = 528
    Top = 384
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
    Left = 408
    Top = 440
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
    Left = 840
    Top = 232
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
  object setCcStatusRefuseProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.SET_CC_STATUS_REFUSE'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.SET_CC_STATUS_REFUSE(:P_CC_ID_LIST);'
      'end;')
    Left = 944
    Top = 280
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
    Left = 336
    Top = 656
  end
  object getPreOverdueListFilter: TDataSetFilter
    OnChange = OnFilterChange
    Glue = ' AND '
    DataSet = getPreOverdueListRam
    Left = 336
    Top = 760
  end
  object getPreOverdueListRam: TVirtualTable
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 336
    Top = 824
    Data = {03000000000000000000}
  end
  object getPreOverdueListProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_PRE_OVERDUE_LIST'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.GET_PRE_OVERDUE_LIST(:P_ACCT_OTDELEN, :RC);'
      'end;')
    Left = 328
    Top = 712
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
    Left = 648
    Top = 384
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
    Left = 648
    Top = 656
  end
  object getFpOverdueContentFilter: TDataSetFilter
    OnChange = OnFilterChange
    Glue = ' AND '
    DataSet = getFpOverdueContentRam
    Left = 648
    Top = 760
  end
  object getFpOverdueContentRam: TVirtualTable
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 648
    Top = 824
    Data = {03000000000000000000}
  end
  object getFpOverdueContentProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_FP_OVERDUE_CONTENT'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.GET_FP_OVERDUE_CONTENT(:P_FA_PACK_ID, :RC);'
      'end;')
    Left = 648
    Top = 712
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
    Left = 488
    Top = 656
  end
  object getFpOverdueListFilter: TDataSetFilter
    OnChange = OnFilterChange
    Glue = ' AND '
    DataSet = getFpOverdueListRam
    Left = 488
    Top = 760
  end
  object getFpOverdueListRam: TVirtualTable
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 488
    Top = 824
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
    Left = 488
    Top = 712
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
  object getFpOverdueInfoProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_FP_INF'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.GET_FP_INF(:P_FA_PACK_ID, :RC);'
      'end;')
    Left = 648
    Top = 888
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
    object DateTimeField15: TDateTimeField
      FieldName = 'CRE_DTTM'
    end
    object StringField45: TStringField
      FieldName = 'ACCT_OTDELEN'
      FixedChar = True
      Size = 7
    end
    object StringField46: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object FloatField11: TFloatField
      FieldName = 'FA_COUNT'
    end
  end
end
