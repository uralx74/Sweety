object MainDataModule: TMainDataModule
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 582
  Top = 292
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
  object getOtdelenList_old: TOraQuery
    Session = EsaleSession
    SQL.Strings = (
      'select null value'
      '  , '#39#1042#1089#1077#39' descr '
      'from dual'
      'union all'
      'select to_char(uch) value --otdeln_id'
      '   , fname  --otdelen_descr '
      'from nasel_uch')
    MasterSource = getPreDebtorListDataSource
    Left = 1432
    Top = 672
  end
  object OraQuery2: TOraQuery
    Session = EsaleSession
    SQL.Strings = (
      'select'
      '  rownum  '
      '  , acct_id  '
      '  , fio   '
      '  , city'
      '  , address '
      '  , saldo_uch '
      '  , saldo_m3 '
      '  , cc_dttm  '
      '  , fa_id'
      '  , fa_pack_id'
      '  , cre_dttm '
      '  , acct_otdelen'
      '  , service_org'
      ''
      'from ('
      '  select'
      '    nasel_ccb_prem.acct_id  '
      '    , nasel_ccb_prem.acct_otdelen'
      '    , nasel_ccb_prem.fio   '
      '    , nasel_ccb_prem.city'
      '    , nasel_ccb_prem.address'
      
        '    , nvl(nasel_ccb_ft.saldo_bt_uch, 0) + nvl(nasel_ccb_ft.saldo' +
        '_odn_uch, 0) + nvl(nasel_ccb_ft.saldo_act_uch, 0) saldo_uch'
      
        '    , nvl(nasel_ccb_ft_hist.saldo_bt_uch, 0) + nvl(nasel_ccb_ft_' +
        'hist.saldo_odn_uch, 0) + nvl(nasel_ccb_ft_hist.saldo_act_uch, 0)' +
        ' saldo_m3'
      '    --, nasel_ccb_ft_hist.saldo_odn_uch'
      '    , case '
      
        '       --when nasel_ccb_sp.sa_nal_enu = '#39'1'#39' then m_ust_en * 24 *' +
        ' 30  '
      
        '        when /*nasel_ccb_sp.sa_nal_enu = '#39'0'#39' and*/ nasel_ccb_pre' +
        'm.square < 100 and nasel_ccb_prem.kol_prop <= 1 then decode(nase' +
        'l_ccb_sp.sa_tip_papr, 1, 180, 100) '
      
        '        when /*nasel_ccb_sp.sa_nal_enu = '#39'0'#39' and*/ nasel_ccb_pre' +
        'm.square < 100 and nasel_ccb_prem.kol_prop > 1 then nasel_ccb_pr' +
        'em.kol_prop * decode(nasel_ccb_sp.sa_tip_papr, 1, 130, 90)  '
      
        '        when /*nasel_ccb_sp.sa_nal_enu = '#39'0'#39' and*/ nasel_ccb_pre' +
        'm.prem_type_cd in ('#39'CD'#39', '#39'DCA'#39') and nasel_ccb_prem.square betwee' +
        'n 100 and 200 and nasel_ccb_prem.kol_prop <= 1 then decode(nasel' +
        '_ccb_sp.sa_tip_papr, 1, 300, 220) '
      
        '        when /*nasel_ccb_sp.sa_nal_enu = '#39'0'#39' and*/ nasel_ccb_pre' +
        'm.prem_type_cd in ('#39'CD'#39', '#39'DCA'#39') and nasel_ccb_prem.square betwee' +
        'n 100 and 200 and nasel_ccb_prem.kol_prop > 1 then nasel_ccb_pre' +
        'm.kol_prop * decode(nasel_ccb_sp.sa_tip_papr, 1, 240, 200)  '
      
        '        when /*nasel_ccb_sp.sa_nal_enu = '#39'0'#39' and*/ nasel_ccb_pre' +
        'm.prem_type_cd in ('#39'CD'#39', '#39'DCA'#39') and nasel_ccb_prem.square > 200 ' +
        'and nasel_ccb_prem.kol_prop <= 1 then decode(nasel_ccb_sp.sa_tip' +
        '_papr, 1, 350, 270) '
      
        '        when /*nasel_ccb_sp.sa_nal_enu = '#39'0'#39' and*/ nasel_ccb_pre' +
        'm.prem_type_cd in ('#39'CD'#39', '#39'DCA'#39') and nasel_ccb_prem.square > 200 ' +
        'and nasel_ccb_prem.kol_prop > 1 then nasel_ccb_prem.kol_prop * d' +
        'ecode(nasel_ccb_sp.sa_tip_papr, 1, 280, 240)  '
      '      end normativ '
      '      '
      '    , last_fa.cc_dttm'
      '    , last_fa.fa_id'
      '    , last_fa.fa_pack_id'
      '    , nasel_fa_pack.cre_dttm '
      '    , nasel_ccb_spr.descr service_org'
      '  from nasel_ccb_prem'
      ''
      
        '  inner join nasel_ccb_sp on nasel_ccb_sp.acct_id = nasel_ccb_pr' +
        'em.acct_id and nasel_ccb_sp.sa_status_flg in ('#39'20'#39')'
      
        '  left join nasel_ccb_ft on nasel_ccb_ft.acct_id = nasel_ccb_pre' +
        'm.acct_id --and nasel_ccb_ft_hist.calc_dt = trunc(add_months(sys' +
        'date,-1), '#39'mm'#39')'
      
        '  left join nasel_ccb_ft_hist on nasel_ccb_ft_hist.acct_id = nas' +
        'el_ccb_prem.acct_id and nasel_ccb_ft_hist.calc_dt = trunc(add_mo' +
        'nths(sysdate,-2), '#39'mm'#39')'
      '    '
      '  left join ('
      '    select '
      '      nasel_fa.acct_id  '
      '      , nasel_fa.cc_dttm'
      '      , nasel_fa.fa_id'
      '      , nasel_fa.fa_pack_id'
      
        '      , row_number() over (partition by nasel_fa.acct_id order b' +
        'y nasel_fa.cc_dttm) n'
      '    from nasel_fa        '
      ''
      
        '  ) last_fa on last_fa.acct_id = nasel_ccb_prem.acct_id and last' +
        '_fa.n = 1'
      
        '  left join nasel_fa_pack on nasel_fa_pack.fa_pack_id = last_fa.' +
        'fa_pack_id'
      ''
      '  left join ('
      '    select nasel_ccb_sa_rel.acct_id'
      '      , nasel_ccb_sa_rel.spr_cd'
      
        '      , row_number() over (partition by  nasel_ccb_sa_rel.acct_i' +
        'd order by nasel_ccb_sa_rel.sa_rel_type_cd desc) n'
      '    from nasel_ccb_sa_rel '
      '    --where acct_id in ('#39'0129250000'#39')'
      
        '  ) sa_rel on sa_rel.acct_id = nasel_ccb_prem.acct_id and sa_rel' +
        '.n = 1'
      
        '  left join nasel_ccb_spr on nasel_ccb_spr.spr_cd = sa_rel.spr_c' +
        'd'
      ''
      ') where saldo_uch > normativ * 2 and saldo_m3 > normativ * 2'
      '    and (:otdelen is null or acct_otdelen = :otdelen)'
      
        '    --and acct_id in ('#39'0000070000'#39','#39'5030270000'#39','#39'2301960000'#39','#39'04' +
        '82721000'#39')'
      
        '    and acct_id in ('#39'7474750000'#39','#39'7204750000'#39','#39'4006750000'#39','#39'6333' +
        '850000'#39','#39'1390950000'#39')')
    FetchAll = True
    FilterOptions = [foCaseInsensitive]
    Left = 1400
    Top = 560
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'otdelen'
      end>
    object OraQuery2ROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
    object OraQuery2ACCT_ID: TStringField
      FieldName = 'ACCT_ID'
      FixedChar = True
      Size = 10
    end
    object OraQuery2FIO: TStringField
      FieldName = 'FIO'
      Size = 254
    end
    object OraQuery2CITY: TStringField
      FieldName = 'CITY'
      Size = 60
    end
    object OraQuery2ADDRESS: TStringField
      FieldName = 'ADDRESS'
      Size = 254
    end
    object OraQuery2SALDO_UCH: TFloatField
      FieldName = 'SALDO_UCH'
    end
    object OraQuery2SALDO_M3: TFloatField
      FieldName = 'SALDO_M3'
    end
    object OraQuery2CC_DTTM: TDateTimeField
      FieldName = 'CC_DTTM'
    end
    object OraQuery2FA_ID: TStringField
      FieldName = 'FA_ID'
      FixedChar = True
      Size = 10
    end
    object OraQuery2FA_PACK_ID: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object OraQuery2CRE_DTTM: TDateTimeField
      FieldName = 'CRE_DTTM'
    end
    object OraQuery2ACCT_OTDELEN: TStringField
      FieldName = 'ACCT_OTDELEN'
      Size = 6
    end
    object OraQuery2SERVICE_ORG: TStringField
      FieldName = 'SERVICE_ORG'
      Size = 50
    end
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
    DataSet = getOtdelenListQuery
    Left = 128
    Top = 224
  end
  object OraQuery3_old: TOraQuery
    Session = EsaleSession
    SQL.Strings = (
      'select r.* '
      '  --, '#39'/**:reg_dt**/'#39' reg_dt'
      '  --, substr(ccb_acct_char_val,4,2) file_infix'
      
        '  --, '#39#1055#1086' '#1089#1086#1089#1090#1086#1103#1085#1080#1102' '#1085#1072': '#39' || to_char(sysdate,'#39'dd.mm.yyyy hh24.mi' +
        '.ss'#39') param_rep_dttm'
      '  --, '#39#1044#1072#1090#1072' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1080' '#1087#1080#1089#1077#1084': '#39' || '#39'/**:reg_dt**/'#39' reg_dt_param'
      
        '  --, '#39#1059#1095#1072#1089#1090#1086#1082': '#39' || nvl2('#39'/**:uchastok**/'#39', FRAION1,'#39#1042#1089#1077' '#1091#1095#1072#1089#1090#1082 +
        #1080#39') filial_userparam'
      '  --, '#39#1053#1072#1089#1077#1083#1077#1085#1085#1099#1081' '#1087#1091#1085#1082#1090':/** :city**/'#39' city_userparam'
      '  --, '#39#1059#1083#1080#1094#1072':/** :street**/'#39' street_userparam'
      '  --, '#39#1057#1091#1084#1084#1072' '#1076#1086#1083#1075#1072' '#1086#1090':/** :min_dolg**/'#39' min_dolg_userparam'
      'from ( '
      '  select'
      '    trim(fname) || '#39' '#1091#1095#1072#1089#1090#1086#1082#39' AS FRAION'
      
        '    , substr( trim(FNAME), 1, length(trim(FNAME))-2 ) || '#39#1086#1075#1086' '#1091#1095 +
        #1072#1089#1090#1082#1072#39'  post'
      '    , NACHALNIK'
      '    , address '
      '    , PHONE'
      '    , ADR1'
      '    , PRIEM1'
      '    , ADR2'
      '    , PRIEM2'
      '    , phone2 '
      '    , ADR1 || '#39'. '#1063#1072#1089#1099' '#1087#1088#1080#1077#1084#1072': '#39'||PRIEM1 || '#39', '#1090#1077#1083'.: '#39' || PHONE'
      
        '      || decode(priem2, null, '#39#39', '#39'; '#39'|| ADR2 || '#39'. '#1063#1072#1089#1099' '#1087#1088#1080#1077#1084#1072':' +
        ' '#39'|| PRIEM2 || '#39', '#1090#1077#1083'.: '#39' || phone2) uch_address'
      '    , '#39'report\visa\'#39'|| nachalnik || '#39'.png'#39' visa'
      '    --, /**'#39':reg_dt'#39'**/ reg_dt'
      '   '
      '    , raion.id'
      
        '    , substr(replace(raion.ccb_acct_char_val,'#39'.*'#39','#39#39'),(l-1)*6+1,' +
        '5) ccb_acct_otdelen'
      '  from raion'
      '  left join ('
      '    select level l from dual'
      '    connect by level <= 2  '
      '  ) dt on null is null'
      '  --where raion.ssp_dolg is not null'
      ') r where r.ccb_acct_otdelen is not null'
      
        ' -- and ccb_acct_char_val like '#39'%02-'#39' || '#39'/**:uchastok**/'#39' || '#39'%' +
        #39
      'order by r.ccb_acct_otdelen')
    FetchAll = True
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 1424
    Top = 616
    object FloatField4: TFloatField
      FieldName = 'ROWNUM'
    end
    object StringField5: TStringField
      FieldName = 'ACCT_ID'
      FixedChar = True
      Size = 10
    end
    object StringField6: TStringField
      FieldName = 'FIO'
      Size = 254
    end
    object StringField7: TStringField
      FieldName = 'CITY'
      Size = 60
    end
    object StringField8: TStringField
      FieldName = 'ADDRESS'
      Size = 254
    end
    object FloatField5: TFloatField
      FieldName = 'SALDO_UCH'
    end
    object FloatField6: TFloatField
      FieldName = 'SALDO_M3'
    end
    object DateTimeField2: TDateTimeField
      FieldName = 'CC_DTTM'
    end
    object StringField9: TStringField
      FieldName = 'FA_ID'
      FixedChar = True
      Size = 10
    end
    object StringField10: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object DateTimeField3: TDateTimeField
      FieldName = 'CRE_DTTM'
    end
    object StringField11: TStringField
      FieldName = 'ACCT_OTDELEN'
      Size = 6
    end
    object StringField12: TStringField
      FieldName = 'SERVICE_ORG'
      Size = 50
    end
    object FloatField7: TFloatField
      FieldName = 'CHECK_DATA'
    end
  end
  object getOtdelenListQuery: TOraQuery
    KeyFields = 'ACCT_OTDELEN'
    Session = EsaleSession
    SQL.Strings = (
      '-- '#1054#1073#1097#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1087#1086' '#1091#1095#1072#1089#1090#1082#1072#1084
      ''
      'select nasel_uch.fname otdelen_descr '
      '  , nasel_uch.acct_otdelen'
      '  , raion.address'
      '  , raion.nachalnik'
      '  , raion.phone'
      '  , raion.ccb_acct_char_val'
      '  , :app_path || '#39'report\visa\'#39'|| raion.nachalnik || '#39'.png'#39' visa'
      
        '  , substr(trim(raion.FNAME),1,length(trim(raion.FNAME))-2) || '#39 +
        #1086#1075#1086' '#1091#1095#1072#1089#1090#1082#1072#39'  post'
      '  , nasel_uch.descr_l '
      ' '
      'from acc_grp_dar'
      
        'inner join spr_users on spr_users.access_grp_cd = acc_grp_dar.ac' +
        'cess_grp_cd'
      'inner join nasel_uch on nasel_uch.dar_cd = acc_grp_dar.dar_cd'
      ''
      'inner join raion on raion.id = nasel_uch.id_rn'
      '--where name_u = '#39'U062000'#39
      'where name_u = sys_context('#39'USERENV'#39','#39'SESSION_USER'#39')')
    FetchAll = True
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 1408
    Top = 496
    ParamData = <
      item
        DataType = ftString
        Name = 'app_path'
      end>
    object getOtdelenListQueryOTDELEN_DESCR: TStringField
      FieldName = 'OTDELEN_DESCR'
      Size = 25
    end
    object getOtdelenListQueryACCT_OTDELEN: TStringField
      FieldName = 'ACCT_OTDELEN'
      FixedChar = True
      Size = 7
    end
    object getOtdelenListQueryADDRESS: TStringField
      FieldName = 'ADDRESS'
      Size = 100
    end
    object getOtdelenListQueryNACHALNIK: TStringField
      FieldName = 'NACHALNIK'
      Size = 30
    end
    object getOtdelenListQueryPHONE: TStringField
      FieldName = 'PHONE'
      Size = 50
    end
    object getOtdelenListQueryCCB_ACCT_CHAR_VAL: TStringField
      FieldName = 'CCB_ACCT_CHAR_VAL'
      Size = 30
    end
    object getOtdelenListQueryVISA: TStringField
      FieldName = 'VISA'
      Size = 2046
    end
    object getOtdelenListQueryPOST: TStringField
      FieldName = 'POST'
      Size = 36
    end
    object getOtdelenListQueryDESCR_L: TStringField
      FieldName = 'DESCR_L'
      Size = 25
    end
  end
  object getApprovalListQuery_old: TOraQuery
    Session = EsaleSession
    SQL.Strings = (
      'select'
      '  rownum'
      '  , 0 CHECK_DATA'
      '  , t.*'
      'from ('
      'select '
      '  --row_number() over() rownum'
      '  nasel_fa.fa_id'
      '  , nasel_fa.acct_id'
      '  , cc.cc_id'
      '  , cc.cc_dttm   '
      '  , cc.src_type_cd'
      '  , cc.approval_dttm'
      '  , nasel_ccb_prem.address'
      '  , nasel_ccb_prem.city'
      '  , nasel_ccb_prem.fio '
      '  , nasel_ccb_ft.saldo_bt_uch saldo'
      ''
      '  , nasel_ccb_spr.descr service_org'
      '  '
      '   '
      'from nasel_fa_pack'
      
        'inner join nasel_fa on nasel_fa.fa_pack_id = nasel_fa_pack.fa_pa' +
        'ck_id'
      
        'inner join nasel_ccb_prem on nasel_ccb_prem.acct_id = nasel_fa.a' +
        'cct_id'
      
        'inner join nasel_ccb_ft on nasel_ccb_ft.acct_id = nasel_fa.acct_' +
        'id'
      'left join ('
      '  select nasel_ccb_sa_rel.acct_id'
      '    , nasel_ccb_sa_rel.spr_cd'
      
        '    , row_number() over (partition by  nasel_ccb_sa_rel.acct_id ' +
        'order by nasel_ccb_sa_rel.sa_rel_type_cd desc) n'
      '  from nasel_ccb_sa_rel '
      '  --where acct_id in ('#39'0129250000'#39')'
      
        ') sa_rel on sa_rel.acct_id = nasel_ccb_prem.acct_id and sa_rel.n' +
        ' = 1'
      'left join nasel_ccb_spr on nasel_ccb_spr.spr_cd = sa_rel.spr_cd'
      ''
      'left join ('
      '  select '
      '    nasel_cc.src_id'
      '    , nasel_cc.cc_id'
      '    , nasel_cc.cc_dttm'
      '    , nasel_cc.descr'
      '    , nasel_cc.src_type_cd '
      '    , nasel_cc.approval_dttm'
      
        '    , row_number() over (partition by nasel_cc.src_id, nasel_cc.' +
        'src_type_cd  order by nasel_cc.cc_dttm desc) n'
      '  from nasel_cc    '
      '  where nasel_cc.src_type_cd = '#39'10'#39
      ') cc on cc.src_id = nasel_fa.fa_id and cc.n = 1'
      ''
      
        'where nasel_fa_pack.cre_dttm > add_months(sysdate,-12) -- '#1087#1086#1083#1100#1079#1086 +
        #1074#1072#1090#1077#1083#1102' '#1076#1086#1089#1090#1091#1087#1085#1099' '#1076#1083#1103' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1103' '#1076#1072#1085#1085#1099#1077' '#1079#1072' 1 '#1075#1086#1076
      '  and nasel_fa_pack.acct_otdelen = :acct_otdelen'
      ''
      'order by nasel_ccb_prem.address'
      ') t')
    FetchAll = True
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 1432
    Top = 728
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'acct_otdelen'
      end>
    object FloatField8: TFloatField
      FieldName = 'ROWNUM'
      ReadOnly = True
    end
    object FloatField9: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object StringField13: TStringField
      FieldName = 'FA_ID'
      ReadOnly = True
      FixedChar = True
      Size = 10
    end
    object StringField14: TStringField
      FieldName = 'ACCT_ID'
      ReadOnly = True
      FixedChar = True
      Size = 10
    end
    object StringField15: TStringField
      FieldName = 'ADDRESS'
      ReadOnly = True
      Size = 254
    end
    object StringField16: TStringField
      FieldName = 'FIO'
      ReadOnly = True
      Size = 254
    end
    object FloatField10: TFloatField
      FieldName = 'SALDO'
      ReadOnly = True
    end
    object DateTimeField4: TDateTimeField
      FieldName = 'CC_DTTM'
    end
    object StringField17: TStringField
      FieldName = 'CC_ID'
      FixedChar = True
      Size = 10
    end
    object StringField18: TStringField
      FieldName = 'SRC_TYPE_CD'
      FixedChar = True
      Size = 10
    end
    object DateTimeField5: TDateTimeField
      FieldName = 'APPROVAL_DTTM'
    end
    object StringField19: TStringField
      FieldName = 'CITY'
      Size = 60
    end
    object StringField20: TStringField
      FieldName = 'SERVICE_ORG'
      Size = 50
    end
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
  object OraQuery33333333333333: TOraQuery
    Session = EsaleSession
    SQL.Strings = (
      '-- '#1059#1089#1083#1086#1074#1080#1103
      '-- '#1085#1077' '#1087#1086#1079#1076#1085#1077#1077' 10 '#1076#1086' '#1076#1072#1090#1099' '#1087#1083#1072#1085#1080#1088#1091#1077#1084#1086#1075#1086' '#1086#1090#1082#1083#1102#1095#1077#1085#1080#1077
      '-- '#1079#1072#1103#1074#1082#1080' '#1092#1086#1088#1084#1080#1088#1091#1102#1090#1089#1103' '#1076#1083#1103' '#1089#1077#1090#1077#1074#1099#1093' '#1090#1086#1083#1100#1082#1086' '#1076#1083#1103' prem_type_cd = '#39'CD'#39
      '-- '#1076#1083#1103' '#1076#1088#1091#1075#1080#1093' prem_type_cd '#1079#1072#1103#1074#1082#1080' '#1092#1086#1088#1084#1080#1088#1091#1102#1090#1089#1103' '#1076#1083#1103' '#1091#1095#1072#1089#1090#1082#1072
      ''
      'select '
      '  rownum   '
      '      '
      '  , nasel_ccb_prem.prem_type_cd '
      '  , dense_rank () over (order by nasel_ccb_spr.descr) '
      '  , case when nasel_ccb_prem.prem_type_cd in ('#39'CD'#39') then'
      '      dense_rank () over (order by nasel_ccb_spr.descr)'
      '    else'
      '      0'
      '    end grp_code'
      '  --, count(*) over (partition by nasel_ccb_spr.descr) grp_count'
      ''
      ''
      '  , 0 CHECK_DATA  '
      '  , nasel_cc.acct_id'
      '  , nasel_cc.approval_dttm'
      '  , nasel_cc.cc_dttm'
      '  , nasel_ccb_prem.fio '
      '  , nasel_ccb_prem.postal '
      '  , nasel_ccb_prem.city '
      '  , nasel_ccb_prem.address     '
      '  , trim(nasel_ccb_prem.acct_otdelen) acct_otdelen'
      '  , nasel_ccb_ft.saldo_bt_uch saldo_uch'
      '  , nasel_ccb_spr.descr '
      '  '
      '  '
      'from nasel_ccb_prem'
      
        'inner join nasel_cc on nasel_cc.acct_id = nasel_ccb_prem.acct_id' +
        ' and '
      
        '  nasel_cc.approval_dttm is not null and sysdate between nasel_c' +
        'c.cc_dttm and nasel_cc.cc_dttm + 20 '
      
        'inner join nasel_ccb_ft on nasel_ccb_ft.acct_id = nasel_ccb_prem' +
        '.acct_id'
      '  and nasel_ccb_ft.saldo_bt_uch > 500  '
      '  '
      '  '
      'left join ('
      '  select nasel_ccb_sa_rel.acct_id'
      '    , nasel_ccb_sa_rel.spr_cd'
      
        '    , row_number() over (partition by  nasel_ccb_sa_rel.acct_id ' +
        'order by nasel_ccb_sa_rel.sa_rel_type_cd desc) n'
      '  from nasel_ccb_sa_rel '
      '  --where acct_id in ('#39'0129250000'#39')'
      
        ') sa_rel on sa_rel.acct_id = nasel_ccb_prem.acct_id and sa_rel.n' +
        ' = 1'
      
        'left join nasel_ccb_spr on nasel_ccb_spr.spr_cd = sa_rel.spr_cd ' +
        ' '
      '  '
      '  '
      'where nasel_ccb_prem.acct_otdelen = :acct_otdelen'
      '  -- and saldo_uch > normativ * 2 and saldo_m3 > normativ * 2'
      '  -- nasel_ccb_prem.acct_otdelen = 62   '
      
        '  --(:otdelen is null or nasel_ccb_prem.acct_otdelen = :acct_otd' +
        'elen)'
      
        '  --and nasel_ccb_prem.acct_id in ('#39'1426650000'#39','#39'5426650000'#39','#39'55' +
        '26650000'#39','#39'7526650000'#39','#39'9926650000'#39', '#39'0000070000'#39')')
    FetchAll = True
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 1408
    Top = 464
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'acct_otdelen'
      end>
    object FloatField3: TFloatField
      FieldName = 'ROWNUM'
    end
    object StringField27: TStringField
      FieldName = 'ACCT_ID'
      FixedChar = True
      Size = 10
    end
    object StringField28: TStringField
      FieldName = 'FIO'
      Size = 254
    end
    object StringField29: TStringField
      FieldName = 'CITY'
      Size = 60
    end
    object StringField30: TStringField
      FieldName = 'ADDRESS'
      Size = 254
    end
    object FloatField11: TFloatField
      FieldName = 'SALDO_UCH'
    end
    object FloatField12: TFloatField
      FieldName = 'SALDO_M3'
    end
    object DateTimeField6: TDateTimeField
      FieldName = 'CC_DTTM'
    end
    object StringField31: TStringField
      FieldName = 'FA_ID'
      FixedChar = True
      Size = 10
    end
    object StringField32: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object DateTimeField7: TDateTimeField
      FieldName = 'CRE_DTTM'
    end
    object StringField33: TStringField
      FieldName = 'ACCT_OTDELEN'
      Size = 6
    end
    object StringField34: TStringField
      FieldName = 'SERVICE_ORG'
      Size = 50
    end
    object FloatField13: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object StringField35: TStringField
      FieldName = 'OP_AREA_DESCR'
      Size = 60
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
  object AddFaToPackStopProc_old: TOraStoredProc
    StoredProcName = 'PK_NASEL_OTDEL.ADD_FA_TO_PACK_STOP'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_OTDEL.ADD_FA_TO_PACK_STOP(:P_ACCT_ID, :P_FA_PACK_ID);'
      'end;')
    Left = 1344
    Top = 632
    ParamData = <
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
    CommandStoredProcName = 'PK_NASEL_OTDEL.ADD_FA_TO_PACK_STOP'
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
  object getFullListQuery: TOraQuery
    Session = EsaleSession
    SQL.Strings = (
      '-- '#1042#1089#1077' '#1072#1073#1086#1085#1077#1085#1090#1099
      '-- 2017-02-16'
      '-- '#1072#1074#1090#1086#1088': '#1042#1057#1054#1074#1095#1080#1085#1085#1080#1082#1086#1074
      '--'
      '-- '#1059#1089#1083#1086#1074#1080#1103
      '-- 1. '#1058#1086#1095#1082#1072' '#1091#1095#1077#1090#1072' '#1074' '#1089#1090#1072#1090#1091#1089#1077' '#1091#1089#1090#1072#1085#1086#1074#1083#1077#1085#1072' (20)'
      '-- 2. saldo_uch > normativ * 2 and saldo_m3 > normativ * 2'
      
        '-- 3. '#1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1091#1090#1074#1077#1088#1078#1076#1077#1085#1085#1086#1075#1086' '#1082#1086#1085#1090#1072#1082#1090#1072' '#1073#1086#1083#1077#1077' 6 '#1084#1077#1089#1103#1094#1077#1074' '#1080#1083#1080 +
        ' '#1087#1091#1089#1090#1072#1103
      '-- 4. '#1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1103' '#1073#1086#1083#1077#1077' 2 '#1084#1077#1089#1103#1094#1077#1074' '#1080#1083#1080' '#1087#1091#1089#1090#1072#1103
      ''
      'select'
      '  rownum '
      '  , 0 CHECK_DATA '
      '  , acct_id  '
      '  , initcap(fio) fio   '
      '  , city'
      '  , address '
      '  , prem_type_descr'
      ''
      '  , saldo_uch '
      '  , saldo_m3 '
      '  , cc_dttm  '
      '  , fa_id'
      '  , fa_pack_id'
      '  , cre_dttm '
      '  , acct_otdelen'
      '  , service_org'
      ''
      '  , op_area_descr '
      ''
      
        '  , case when saldo_uch - bill_otch > norm_amt * 2 * fl_tar11 an' +
        'd saldo_m3 > norm_amt * 2 * fl_tar11 and saldo_uch > norm_amt * ' +
        '2 * fl_tar11 '
      
        '        and (cc_dttm is null or months_between(cc_dttm, sysdate)' +
        ' > 6) '
      
        '        and (cre_dttm is null or months_between(cre_dttm, sysdat' +
        'e) > 2)'
      '    then 1 else 0 end debtor_flg'
      ''
      '   '
      'from ('
      'select'
      '  *'
      'from ('
      '  select'
      '    nasel_ccb_prem.acct_id  '
      '    , nasel_ccb_prem.acct_otdelen'
      '    , nasel_ccb_prem.fio   '
      '    , nasel_ccb_prem.city'
      '    , nasel_ccb_prem.address'
      
        '    , (select descr from nasel_lookup_val where field_name = '#39'PR' +
        'EM_TYPE_CD'#39' and field_value = nasel_ccb_prem.prem_type_cd) prem_' +
        'type_descr'
      '    '
      
        '    , nvl(nasel_ccb_ft.bill_bt_otch,0) + nvl(nasel_ccb_ft.bill_o' +
        'dn_otch,0) bill_otch'
      
        '    , nvl(nasel_ccb_ft.saldo_bt_uch, 0) + nvl(nasel_ccb_ft.saldo' +
        '_odn_uch, 0) + nvl(nasel_ccb_ft.saldo_act_uch, 0) saldo_uch'
      
        '    , nvl(nasel_ccb_ft_hist.saldo_bt_uch, 0) + nvl(nasel_ccb_ft_' +
        'hist.saldo_odn_uch, 0) + nvl(nasel_ccb_ft_hist.saldo_act_uch, 0)' +
        ' saldo_m3'
      '    --, nasel_ccb_ft_hist.saldo_odn_uch'
      '      '
      '    , last_cc.cc_dttm'
      '    , last_cc.cc_id'
      '    , last_fa.fa_id'
      '    , last_fa.fa_pack_id'
      '    , last_fa.cre_dttm '
      '    , nasel_ccb_spr.descr service_org'
      '    , nasel_ccb_sp.op_area_descr'
      '    , nasel_ccb_sp.fl_tar11'
      '    , nasel_calc.norm_amt'
      '  '
      ''
      '  from nasel_ccb_prem'
      ''
      
        '  inner join nasel_ccb_sp on nasel_ccb_sp.acct_id = nasel_ccb_pr' +
        'em.acct_id and nasel_ccb_sp.sa_status_flg in ('#39'20'#39')'
      
        '  left join nasel_ccb_ft on nasel_ccb_ft.acct_id = nasel_ccb_pre' +
        'm.acct_id --and nasel_ccb_ft_hist.calc_dt = trunc(add_months(sys' +
        'date,-1), '#39'mm'#39')'
      
        '  left join nasel_ccb_ft_hist on nasel_ccb_ft_hist.acct_id = nas' +
        'el_ccb_prem.acct_id and nasel_ccb_ft_hist.uch_begin_dt = trunc(a' +
        'dd_months((select char_val_dttm from cfg_task where char_type_cd' +
        ' = '#39'REP_DTTM'#39' and task_name = '#39'P_UPDATE_NASEL_JOB_DAY'#39'),-3), '#39'mm' +
        #39')'
      '    '
      '  left join ('
      '    select '
      '      nasel_cc.acct_id  '
      '      , nasel_cc.cc_dttm '
      '      , nasel_cc.src_id'
      '      , nasel_cc.cc_id'
      
        '      , row_number() over (partition by nasel_cc.acct_id order b' +
        'y nasel_cc.cc_dttm desc) n'
      '    from nasel_cc        '
      
        '    where nasel_cc.src_type_cd = '#39'10'#39' and nasel_cc.approval_dttm' +
        ' is not null  '
      
        '  ) last_cc on last_cc.acct_id = nasel_ccb_prem.acct_id and last' +
        '_cc.n = 1    '
      '  '
      '  left join ('
      '    select'
      '      nasel_fa.acct_id  '
      '      , nasel_fa.fa_id'
      '      , nasel_fa.fa_pack_id     '
      '      , nasel_fa_pack.cre_dttm'
      
        '      , row_number() over (partition by nasel_fa.acct_id order b' +
        'y nasel_fa_pack.cre_dttm desc nulls last) n'
      '    from nasel_fa'
      
        '    inner join nasel_fa_pack on nasel_fa_pack.fa_pack_id = nasel' +
        '_fa.fa_pack_id'
      
        '  ) last_fa on last_fa.acct_id = nasel_ccb_prem.acct_id and last' +
        '_fa.n = 1    '
      '     '
      '  left join ('
      '    select nasel_ccb_sa_rel.acct_id'
      '      , nasel_ccb_sa_rel.spr_cd'
      
        '      , row_number() over (partition by  nasel_ccb_sa_rel.acct_i' +
        'd order by nasel_ccb_sa_rel.sa_rel_type_cd desc) n'
      '    from nasel_ccb_sa_rel '
      
        '  ) sa_rel on sa_rel.acct_id = nasel_ccb_prem.acct_id and sa_rel' +
        '.n = 1'
      
        '  left join nasel_ccb_spr on nasel_ccb_spr.spr_cd = sa_rel.spr_c' +
        'd'
      '  '
      
        '  left join nasel_calc on nasel_calc.acct_id = nasel_ccb_prem.ac' +
        'ct_id'
      ''
      ''
      '  where acct_otdelen = :acct_otdelen'
      
        '    /*and acct_id in ('#39'4015250000'#39', '#39'4046250000'#39', '#39'6046250000'#39','#39 +
        '1441170000'#39','#39'0000003304'#39', '#39'7474750000'#39','#39'7204750000'#39','#39'4006750000'#39 +
        ','#39'6333850000'#39','#39'1390950000'#39', '#39'6326650000'#39', '#39'3043850000'#39', '#39'9226650' +
        '000'#39', '
      
        '      '#39'0408650000'#39', '#39'1608650000'#39', '#39'1783850000'#39' , '#39'4595850000'#39') /' +
        '**/'
      '  '
      ')     '
      'order by city, address'
      ')')
    FetchAll = True
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 360
    Top = 64
    ParamData = <
      item
        DataType = ftString
        Name = 'acct_otdelen'
      end>
    object FloatField19: TFloatField
      FieldName = 'ROWNUM'
    end
    object FloatField20: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object StringField50: TStringField
      FieldName = 'ACCT_ID'
      FixedChar = True
      Size = 10
    end
    object StringField51: TStringField
      FieldName = 'FIO'
      Size = 254
    end
    object StringField52: TStringField
      FieldName = 'CITY'
      Size = 60
    end
    object StringField53: TStringField
      FieldName = 'ADDRESS'
      Size = 254
    end
    object FloatField21: TFloatField
      FieldName = 'SALDO_UCH'
    end
    object FloatField22: TFloatField
      FieldName = 'SALDO_M3'
    end
    object DateTimeField10: TDateTimeField
      FieldName = 'CC_DTTM'
    end
    object StringField54: TStringField
      FieldName = 'FA_ID'
      FixedChar = True
      Size = 10
    end
    object StringField55: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object DateTimeField11: TDateTimeField
      FieldName = 'CRE_DTTM'
    end
    object StringField56: TStringField
      FieldName = 'ACCT_OTDELEN'
      Size = 6
    end
    object StringField57: TStringField
      FieldName = 'SERVICE_ORG'
      Size = 50
    end
    object StringField58: TStringField
      FieldName = 'OP_AREA_DESCR'
      Size = 60
    end
    object StringField59: TStringField
      FieldName = 'PREM_TYPE_DESCR'
      Size = 60
    end
    object getFullListQueryDEBTOR_FLG: TFloatField
      FieldName = 'DEBTOR_FLG'
    end
  end
  object getFullListFilter: TDataSetFilter
    OnChange = OnFilterChange
    Glue = ' AND '
    DataSet = getFullListRam
    Left = 360
    Top = 112
  end
  object getFullListRam: TVirtualTable
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 360
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
    StoredProcName = 'PK_NASEL_SWEETY.ADD_FA_PACK_CHAR_RECIPIENT'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      
        '  PK_NASEL_SWEETY.ADD_FA_PACK_CHAR_RECIPIENT(:P_FA_PACK_ID, :P_F' +
        'ORCE_SELF);'
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
    CommandStoredProcName = 'PK_NASEL_SWEETY.ADD_FA_PACK_CHAR_RECIPIENT'
  end
  object getOtdelenListFilter: TDataSetFilter
    OnChange = OnFilterChange
    Glue = ' AND '
    DataSet = getOtdelenListQuery
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
  object OraDataSource1: TOraDataSource
    DataSet = getPreDebtorListProc
    Left = 1312
    Top = 544
  end
  object VirtualTable1: TVirtualTable
    MasterSource = OraDataSource1
    Left = 1312
    Top = 496
    Data = {03000000000000000000}
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
  object getFullListDataSource: TOraDataSource
    DataSet = getFullListQuery
    Left = 352
    Top = 16
  end
  object MainDataSource: TOraDataSource
    DataSet = getFullListQuery
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
    object getOtdelenListProcOTDELEN_DESCR: TStringField
      FieldName = 'OTDELEN_DESCR'
      Size = 25
    end
    object getOtdelenListProcACCT_OTDELEN: TStringField
      FieldName = 'ACCT_OTDELEN'
      FixedChar = True
      Size = 7
    end
    object getOtdelenListProcADDRESS: TStringField
      FieldName = 'ADDRESS'
      Size = 100
    end
    object getOtdelenListProcNACHALNIK: TStringField
      FieldName = 'NACHALNIK'
      Size = 30
    end
    object getOtdelenListProcPHONE: TStringField
      FieldName = 'PHONE'
      Size = 50
    end
    object getOtdelenListProcCCB_ACCT_CHAR_VAL: TStringField
      FieldName = 'CCB_ACCT_CHAR_VAL'
      Size = 30
    end
    object getOtdelenListProcPOST: TStringField
      FieldName = 'POST'
      Size = 36
    end
    object getOtdelenListProcDESCR_L: TStringField
      FieldName = 'DESCR_L'
      Size = 25
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
  end
end
