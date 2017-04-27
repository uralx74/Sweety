object MainDataModule: TMainDataModule
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 246
  Top = 131
  Height = 908
  Width = 1519
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
    Left = 24
    Top = 16
    EncryptedPassword = '94FF8AFF85FF92FF9AFF93FF'
  end
  object GeneralFaList: TOraQuery
    Session = EsaleSession
    SQL.Strings = (
      'select '
      '  rownum'
      '  , nasel_fa.fa_id'
      '  , nasel_fa.acct_id'
      '  , nasel_ccb_prem.address'
      '  , nasel_ccb_prem.fio '
      '  , nasel_ccb_ft.saldo_bt_uch saldo'
      '  , cc_dttm'
      '  '
      'from nasel_fa'
      
        'inner join nasel_ccb_prem on nasel_ccb_prem.acct_id = nasel_fa.a' +
        'cct_id'
      
        'inner join nasel_ccb_ft on nasel_ccb_ft.acct_id = nasel_fa.acct_' +
        'id'
      'for update')
    FilterOptions = [foCaseInsensitive]
    Left = 248
    Top = 440
  end
  object getDebtorsDataSource: TOraDataSource
    DataSet = getDebtors
    Left = 456
    Top = 8
  end
  object GeneralDebtorList: TOraQuery
    Session = EsaleSession
    SQL.Strings = (
      'select '
      '  rownum'
      '  , nasel_ccb_prem.acct_id'
      '  , nasel_ccb_prem.address'
      '  , nasel_ccb_prem.fio '
      '  , nasel_ccb_ft.saldo_bt_uch saldo'
      '  , null cc_dttm'
      '  , nasel_ccb_prem.acct_otdelen'
      'from nasel_ccb_prem '
      
        'inner join nasel_ccb_ft on nasel_ccb_ft.acct_id = nasel_ccb_prem' +
        '.acct_id and nasel_ccb_ft.saldo_bt_uch > 50000'
      '  and (:otdelen is null or acct_otdelen = :otdelen)')
    FetchAll = True
    FilterOptions = [foCaseInsensitive]
    Left = 248
    Top = 592
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'otdelen'
      end>
  end
  object CreateFaProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.CREATE_FA'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      
        '  :RESULT := PK_NASEL_SWEETY.CREATE_FA(:P_ACCT_ID, :P_FA_PACK_ID' +
        ');'
      'end;')
    Left = 848
    Top = 720
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
    StoredProcName = 'PK_NASEL_SWEETY.CREATE_FA_PACK'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      
        '  :RESULT := PK_NASEL_SWEETY.CREATE_FA_PACK(:P_FA_PACK_TYPE_CD, ' +
        ':P_PRNT_FA_PACK_ID, :P_ACCT_OTDELEN);'
      'end;')
    Left = 808
    Top = 664
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
        DataType = ftString
        Name = 'P_ACCT_OTDELEN'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.CREATE_FA_PACK'
  end
  object getFaPackQuery: TOraQuery
    Session = EsaleSession
    SQL.Strings = (
      'select'
      '  rownum'
      '  , 0 CHECK_DATA'
      '  , t.*'
      'from ('
      'select '
      '  nasel_fa.fa_id'
      '  , nasel_fa.acct_id'
      
        '  , nasel_ccb_prem.ulitsa || nvl2(nasel_ccb_prem.dom, '#39', '#1076'. '#39'  |' +
        '| nasel_ccb_prem.dom,'#39#39') || nvl2(nasel_ccb_prem.korp, '#39', '#1082#1086#1088#1087'. '#39 +
        '  || nasel_ccb_prem.korp,'#39#39') || nvl2(nasel_ccb_prem.kvartira, '#39',' +
        ' '#1082#1074'. '#39'  || nasel_ccb_prem.kvartira,'#39#39') address'
      '  --, nasel_ccb_prem.address'
      ''
      '  , nasel_ccb_prem.city'
      '  , initcap(nasel_ccb_prem.fio) fio '
      '  , nasel_ccb_prem.postal'
      ''
      '  , cc.cc_dttm   '
      '  , cc.src_type_cd'
      '  , nasel_ccb_spr.descr service_org '
      '  , nasel_ccb_prem.phones'
      
        '  , trim(substr(nasel_ccb_prem.phones, 1, instr(nasel_ccb_prem.p' +
        'hones,'#39','#39')-1)) phone'
      '  '
      '  '
      
        '  , case when nasel_ccb_sp.cont_qty_sz = 1 then nvl(nasel_fa.end' +
        '_reg_reading1, 0) + nvl(nasel_fa.end_reg_reading2, 0) end end_re' +
        'g_reading_sz1'
      '  , nvl(nasel_fa.end_reg_reading1, 0) end_reg_reading1'
      '  , nvl(nasel_fa.end_reg_reading2, 0) end_reg_reading2'
      ''
      
        '  --, nvl(nasel_ccb_ft_hist.saldo_bt_uch, 0) + nvl(nasel_ccb_ft_' +
        'hist.saldo_odn_uch, 0) + nvl(nasel_ccb_ft_hist.saldo_a'#1089't_uch, 0)' +
        ' saldo_m3'
      '  , nvl(nasel_fa.saldo_uch, 0) saldo_uch'
      '  , nasel_fa.mtr_serial_nbr '
      '  , nasel_fa_pack.fa_pack_id '
      '  , nasel_fa_pack.acct_otdelen '
      '  , nasel_fa_pack.cre_dttm'
      '  , nasel_ccb_sp.op_area_descr'
      '  , nasel_fa_pack.fa_pack_type_cd'
      '  , nvl(nasel_ccb_sp.cont_qty_sz,0) cont_qty_sz'
      '  , cc.cc_id'
      '  , cc.cc_status_flg'
      '  , cc.cc_type_cd'
      ''
      '  --, to_char(nasel_fa_pack.cre_dttm, '#39'dd.mm.yyyy'#39') cre_dt'
      '  --, nasel_ccb_prem.ulitsa'
      '  --, nasel_ccb_prem.dom'
      '  --, nasel_ccb_prem.korp'
      '  --, nasel_ccb_prem.kvartira'
      '  '
      'from nasel_fa_pack'
      
        'inner join nasel_fa on nasel_fa.fa_pack_id = nasel_fa_pack.fa_pa' +
        'ck_id'
      
        'inner join nasel_ccb_prem on nasel_ccb_prem.acct_id = nasel_fa.a' +
        'cct_id'
      
        'inner join nasel_ccb_sp on nasel_ccb_sp.acct_id = nasel_ccb_prem' +
        '.acct_id'
      ''
      
        '--left join nasel_ccb_bseg_read on nasel_ccb_bseg_read.acct_id =' +
        ' nasel_ccb_prem.acct_id '
      
        '--left join nasel_ccb_ft_hist on nasel_ccb_ft_hist.acct_id = nas' +
        'el_ccb_prem.acct_id and nasel_ccb_ft_hist.calc_dt = trunc(add_mo' +
        'nths(sysdate,-2), '#39'mm'#39')'
      
        '--inner join nasel_ccb_ft on nasel_ccb_ft.acct_id = nasel_fa.acc' +
        't_id'
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
      'left join nasel_ccb_spr on nasel_ccb_spr.spr_cd = sa_rel.spr_cd'
      ''
      'left join ('
      '  select '
      '     nasel_cc.src_id'
      '    , nasel_cc.cc_dttm'
      '    , nasel_cc.descr'
      '    , nasel_cc.src_type_cd '
      '    , nasel_cc.cc_id'
      '    , nasel_cc.cc_status_flg'
      '    , nasel_cc.cc_type_cd'
      
        '    , row_number() over (partition by nasel_cc.src_id, nasel_cc.' +
        'src_type_cd  order by nasel_cc.cc_dttm desc) n'
      '  from nasel_cc    '
      '  --where nasel_cc.src_type_cd = '#39'10'#39
      ') cc on cc.src_id = nasel_fa.fa_id and cc.n = 1'
      ''
      'where /*nasel_fa_pack.fa_pack_type_cd = '#39'20'#39
      '   and*/ nasel_fa_pack.fa_pack_id = :fa_pack_id'
      
        '  --and nasel_fa.acct_id in ('#39'0408650000'#39', '#39'1608650000'#39', '#39'178385' +
        '0000'#39' , '#39'4595850000'#39')'
      'order by nasel_ccb_prem.city, nasel_ccb_prem.address '
      ''
      ') t')
    FetchAll = True
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 576
    Top = 56
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'fa_pack_id'
      end>
    object getFaPackQueryROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
    object getFaPackQueryCHECK_DATA: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object getFaPackQueryFA_ID: TStringField
      FieldName = 'FA_ID'
      FixedChar = True
      Size = 10
    end
    object getFaPackQueryACCT_ID: TStringField
      FieldName = 'ACCT_ID'
      FixedChar = True
      Size = 10
    end
    object getFaPackQueryADDRESS: TStringField
      FieldName = 'ADDRESS'
      Size = 254
    end
    object getFaPackQueryCITY: TStringField
      FieldName = 'CITY'
      Size = 60
    end
    object getFaPackQueryFIO: TStringField
      FieldName = 'FIO'
      Size = 254
    end
    object getFaPackQueryCC_DTTM: TDateTimeField
      FieldName = 'CC_DTTM'
    end
    object getFaPackQuerySRC_TYPE_CD: TStringField
      FieldName = 'SRC_TYPE_CD'
      FixedChar = True
      Size = 10
    end
    object getFaPackQuerySERVICE_ORG: TStringField
      FieldName = 'SERVICE_ORG'
      Size = 50
    end
    object getFaPackQueryPHONES: TStringField
      FieldName = 'PHONES'
      Size = 254
    end
    object getFaPackQueryEND_REG_READING1: TFloatField
      FieldName = 'END_REG_READING1'
    end
    object getFaPackQueryEND_REG_READING2: TFloatField
      FieldName = 'END_REG_READING2'
    end
    object getFaPackQuerySALDO_UCH: TFloatField
      FieldName = 'SALDO_UCH'
    end
    object getFaPackQueryMTR_SERIAL_NBR: TStringField
      FieldName = 'MTR_SERIAL_NBR'
      Size = 16
    end
    object getFaPackQueryFA_PACK_ID: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object getFaPackQueryCRE_DTTM: TDateTimeField
      FieldName = 'CRE_DTTM'
    end
    object getFaPackQueryACCT_OTDELEN: TStringField
      FieldName = 'ACCT_OTDELEN'
      Size = 6
    end
    object getFaPackQueryPHONE: TStringField
      FieldName = 'PHONE'
      Size = 254
    end
    object getFaPackQueryPOSTAL: TStringField
      FieldName = 'POSTAL'
      Size = 10
    end
    object getFaPackQueryOP_AREA_DESCR: TStringField
      FieldName = 'OP_AREA_DESCR'
      Size = 60
    end
    object getFaPackQueryFA_PACK_TYPE_CD: TStringField
      FieldName = 'FA_PACK_TYPE_CD'
      FixedChar = True
      Size = 8
    end
    object getFaPackQueryCONT_QTY_SZ: TFloatField
      FieldName = 'CONT_QTY_SZ'
    end
    object getFaPackQueryEND_REG_READING_SZ1: TFloatField
      FieldName = 'END_REG_READING_SZ1'
    end
    object getFaPackQueryCC_ID: TStringField
      FieldName = 'CC_ID'
      FixedChar = True
      Size = 10
    end
    object getFaPackQueryCC_STATUS_FLG: TStringField
      FieldName = 'CC_STATUS_FLG'
      FixedChar = True
      Size = 2
    end
    object getFaPackQueryCC_TYPE_CD: TStringField
      FieldName = 'CC_TYPE_CD'
      FixedChar = True
      Size = 10
    end
  end
  object selectFaPackDataSource: TOraDataSource
    DataSet = selectFaPackQuery
    Left = 960
    Top = 8
  end
  object selectFaPackQuery: TOraQuery
    Session = EsaleSession
    SQL.Strings = (
      'select'
      '  rownum'
      '  , 0 CHECK_DATA '
      '  , t.cre_dttm'
      '  , t.acct_otdelen'
      '  , t.fa_pack_id'
      '  , t.fa_pack_type_cd'
      
        '  --, decode(trim(t.fa_pack_type_cd),'#39'20'#39','#39#1059#1074#1077#1076#1086#1084#1083#1077#1085#1080#1077#39', '#39'40'#39', '#39 +
        #1054#1075#1088#1072#1085#1080#1095#1077#1085#1080#1077#39') fa_pack_type_descr'
      '  , t.cnt fa_cnt'
      '  , t.fa_pack_type_descr'
      
        '  , (select descr from nasel_lookup_val where field_name= '#39'FA_PA' +
        'CK_STATUS_FLG'#39' and field_value=t.fa_pack_status_flg) fa_pack_sta' +
        'tus_descr'
      'from ('
      '  select'
      '    nasel_fa_pack.*'
      '    , fa.cnt'
      '    , nasel_lookup_val.descr fa_pack_type_descr'
      '  from nasel_fa_pack'
      '  '
      '  left join ('
      '    select'
      '      nasel_fa.fa_pack_id'
      '      , count(*) cnt'
      '    from nasel_fa'
      '    group by nasel_fa.fa_pack_id'
      '  ) fa on fa.fa_pack_id = nasel_fa_pack.fa_pack_id'
      ''
      
        '  left join nasel_lookup_val on nasel_lookup_val.field_name = '#39'F' +
        'A_PACK_TYPE_CD'#39' '
      
        '    and nasel_lookup_val.field_value = nasel_fa_pack.fa_pack_typ' +
        'e_cd'
      ' '
      ''
      '  where nasel_fa_pack.acct_otdelen = :acct_otdelen'
      '    and ( ( 0 = :app_mode and fa_pack_type_cd in ('#39'10'#39','#39'20'#39') ) '
      '     or (:app_mode = 1 and fa_pack_type_cd in ('#39'40'#39') ) )'
      '    --and trim(fa_pack_type_cd) = :fa_pack_type_cd'
      ''
      '  order by nasel_fa_pack.cre_dttm desc '
      ') t')
    FetchAll = True
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 960
    Top = 56
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'acct_otdelen'
      end
      item
        DataType = ftUnknown
        Name = 'app_mode'
      end>
    object selectFaPackQueryROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
    object selectFaPackQueryCHECK_DATA: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object selectFaPackQueryCRE_DTTM: TDateTimeField
      FieldName = 'CRE_DTTM'
    end
    object selectFaPackQueryACCT_OTDELEN: TStringField
      FieldName = 'ACCT_OTDELEN'
      Size = 6
    end
    object selectFaPackQueryFA_PACK_ID: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object selectFaPackQueryFA_PACK_TYPE_CD: TStringField
      FieldName = 'FA_PACK_TYPE_CD'
      FixedChar = True
      Size = 8
    end
    object selectFaPackQueryFA_CNT: TFloatField
      FieldName = 'FA_CNT'
    end
    object selectFaPackQueryFA_PACK_TYPE_DESCR: TStringField
      FieldName = 'FA_PACK_TYPE_DESCR'
      Size = 60
    end
    object selectFaPackQueryFA_PACK_STATUS_DESCR: TStringField
      FieldName = 'FA_PACK_STATUS_DESCR'
      Size = 60
    end
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
    MasterSource = getDebtorsDataSource
    Left = 1072
    Top = 648
  end
  object getDebtors: TOraQuery
    Session = EsaleSession
    SQL.Strings = (
      '-- '#1042#1089#1077' '#1076#1086#1083#1078#1085#1080#1082#1080
      '-- 2017-02-16'
      '-- '#1072#1074#1090#1086#1088': '#1042#1057#1054#1074#1095#1080#1085#1085#1080#1082#1086#1074
      '-- '#1045'.'#1042'.'#1053#1072#1079#1072#1088#1086#1074
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
      '  , op_area_descr'
      '   '
      'from ('
      '  select'
      '    nasel_ccb_prem.acct_id  '
      '    , nasel_ccb_prem.acct_otdelen'
      '    , nasel_ccb_prem.fio   '
      '    , nasel_ccb_prem.city'
      
        '    , nasel_ccb_prem.ulitsa || nvl2(nasel_ccb_prem.dom, '#39', '#1076'. '#39' ' +
        ' || nasel_ccb_prem.dom,'#39#39') || nvl2(nasel_ccb_prem.korp, '#39', '#1082#1086#1088#1087'.' +
        ' '#39'  || nasel_ccb_prem.korp,'#39#39') || nvl2(nasel_ccb_prem.kvartira, ' +
        #39', '#1082#1074'. '#39'  || nasel_ccb_prem.kvartira,'#39#39') address'
      
        '    , (select descr from nasel_lookup_val where field_name = '#39'PR' +
        'EM_TYPE_CD'#39' and field_value = nasel_ccb_prem.prem_type_cd) prem_' +
        'type_descr'
      '    , nvl(ccb_ft.bill_otch, 0) bill_otch'
      
        '    --, nvl(nasel_ccb_ft.saldo_bt_uch, 0) + nvl(nasel_ccb_ft.sal' +
        'do_odn_uch, 0) + nvl(nasel_ccb_ft.saldo_act_uch, 0) saldo_uch'
      '    , ccb_ft.saldo_uch'
      '    , ccb_ft_hist.saldo_m3'
      
        '    --, nvl(nasel_ccb_ft_hist.saldo_bt_uch, 0) + nvl(nasel_ccb_f' +
        't_hist.saldo_odn_uch, 0) + nvl(nasel_ccb_ft_hist.saldo_act_uch, ' +
        '0) saldo_m3'
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
      ''
      '  from nasel_ccb_prem'
      ''
      
        '  inner join nasel_ccb_sp on nasel_ccb_sp.acct_id = nasel_ccb_pr' +
        'em.acct_id and nasel_ccb_sp.sa_status_flg in ('#39'20'#39')'
      '  '
      '  '
      
        '  --left join nasel_ccb_ft on nasel_ccb_ft.acct_id = nasel_ccb_p' +
        'rem.acct_id --and nasel_ccb_ft_hist.calc_dt = trunc(add_months(s' +
        'ysdate,-1), '#39'mm'#39')'
      '  left join ('
      '    select '
      '      nasel_ccb_ft.acct_id'
      '      , nasel_ccb_ft.uch_begin_dt'
      
        '      , nvl(nasel_ccb_ft.bill_bt_otch,0) + nvl(nasel_ccb_ft.bill' +
        '_odn_otch,0) bill_otch -- '#1058#1086#1083#1100#1082#1086' '#1101#1090#1080' '#1087#1086' '#1091#1082#1072#1079#1072#1085#1080#1102' '#1045'.'#1053#1072#1079#1072#1088#1086#1074#1072' 2017' +
        '-04-21'
      
        '      , nvl(nasel_ccb_ft.saldo_bt_uch,0) + nvl(nasel_ccb_ft.sald' +
        'o_odn_uch,0) + nvl(nasel_ccb_ft.saldo_act_uch,0)  saldo_uch'
      
        '      , nvl(nasel_ccb_ft.saldo_bt_uch,0) + nvl(nasel_ccb_ft.sald' +
        'o_act_uch,0) saldo_uch_without_odn'
      '      , nvl(nasel_ccb_ft.sum_pay_uch,0) sum_pay_uch'
      '    from nasel_ccb_ft'
      '  ) ccb_ft on ccb_ft.acct_id = nasel_ccb_prem.acct_id'
      '  '
      '  '
      '  left join ('
      '    select'
      '      nasel_ccb_ft_hist.acct_id'
      
        '      , max(case when nasel_ccb_ft_hist.uch_begin_dt = trunc(add' +
        '_months((select char_val_dttm from cfg_task where char_type_cd =' +
        ' '#39'REP_DTTM'#39' and task_name = '#39'P_UPDATE_NASEL_JOB_DAY'#39'),-3), '#39'mm'#39')' +
        ' then nvl(nasel_ccb_ft_hist.saldo_bt_uch, 0) + nvl(nasel_ccb_ft_' +
        'hist.saldo_act_uch, 0) end) saldo_m3'
      
        '      , nvl(sum(case when nasel_ccb_ft_hist.uch_begin_dt between' +
        ' trunc(add_months((select char_val_dttm from cfg_task where char' +
        '_type_cd = '#39'REP_DTTM'#39' and task_name = '#39'P_UPDATE_NASEL_JOB_DAY'#39'),' +
        '-2), '#39'mm'#39') and sysdate'
      '      then nasel_ccb_ft_hist.sum_pay_uch end),0) sum_pay_uch'
      '    from nasel_ccb_ft_hist'
      '    group by nasel_ccb_ft_hist.acct_id'
      '  ) ccb_ft_hist on ccb_ft_hist.acct_id = nasel_ccb_prem.acct_id'
      ''
      '  '
      
        '  /*left join nasel_ccb_ft_hist on nasel_ccb_ft_hist.acct_id = n' +
        'asel_ccb_prem.acct_id and nasel_ccb_ft_hist.calc_dt = trunc(add_' +
        'months((select char_val_dttm from cfg_task where char_type_cd = ' +
        #39'REP_DTTM'#39' and task_name = '#39'P_UPDATE_NASEL_JOB_DAY'#39'),-3), '#39'mm'#39')*' +
        '/'
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
      ''
      
        '  left join nasel_calc on nasel_calc.acct_id = nasel_ccb_prem.ac' +
        'ct_id'
      '  '
      '  -- '#1056#1077#1089#1090#1088#1091#1082#1090#1091#1088#1080#1079#1072#1094#1080#1103' '#1044#1047
      
        '  left join nasel_ccb_pp on nasel_ccb_pp.acct_id = nasel_ccb_pre' +
        'm.acct_id and nasel_ccb_pp.pp_stat_flg = '#39'20'#39
      ''
      '  where nasel_ccb_prem.acct_otdelen = :acct_otdelen'
      
        '    /*and nasel_ccb_prem.acct_id in ('#39'4015250000'#39', '#39'4046250000'#39',' +
        ' '#39'6046250000'#39','#39'1441170000'#39','#39'0000003304'#39', '#39'7474750000'#39','#39'720475000' +
        '0'#39','#39'4006750000'#39','#39'6333850000'#39','#39'1390950000'#39', '#39'6326650000'#39', '#39'304385' +
        '0000'#39', '#39'9226650000'#39', '
      
        '      '#39'0408650000'#39', '#39'1608650000'#39', '#39'1783850000'#39' , '#39'4595850000'#39') /' +
        '**/'
      '  '
      
        '    and nvl(ccb_ft.saldo_uch_without_odn,0) - nvl(ccb_ft.bill_ot' +
        'ch,0) > nasel_calc.norm_amt * 2 * nasel_ccb_sp.fl_tar11 '
      
        '    and nvl(ccb_ft_hist.saldo_m3,0) - nvl(ccb_ft_hist.sum_pay_uc' +
        'h,0) - nvl(ccb_ft.sum_pay_uch,0) > nasel_calc.norm_amt * 2 * nas' +
        'el_ccb_sp.fl_tar11 '
      
        '    and nvl(ccb_ft.saldo_uch_without_odn,0) > nasel_calc.norm_am' +
        't * 2 * nasel_ccb_sp.fl_tar11 '
      
        '    and (last_cc.cc_dttm is null or months_between(last_cc.cc_dt' +
        'tm, sysdate) > 6) '
      
        '    and (last_fa.cre_dttm is null or months_between(last_fa.cre_' +
        'dttm, sysdate) > 2)'
      
        '    and (ccb_ft.saldo_uch - nvl(nasel_ccb_pp.pp_tot_sched_amt,0)' +
        ' ) > nasel_calc.norm_amt * 2 * nasel_ccb_sp.fl_tar11'
      '    '
      '  order by city, address'
      ')')
    FetchAll = True
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 456
    Top = 64
    ParamData = <
      item
        DataType = ftString
        Name = 'acct_otdelen'
      end>
    object getDebtorsROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
    object getDebtorsCHECK_DATA: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object getDebtorsACCT_ID: TStringField
      FieldName = 'ACCT_ID'
      FixedChar = True
      Size = 10
    end
    object getDebtorsFIO: TStringField
      FieldName = 'FIO'
      Size = 254
    end
    object getDebtorsCITY: TStringField
      FieldName = 'CITY'
      Size = 60
    end
    object getDebtorsADDRESS: TStringField
      FieldName = 'ADDRESS'
      Size = 254
    end
    object getDebtorsSALDO_UCH: TFloatField
      FieldName = 'SALDO_UCH'
    end
    object getDebtorsSALDO_M3: TFloatField
      FieldName = 'SALDO_M3'
    end
    object getDebtorsCC_DTTM: TDateTimeField
      FieldName = 'CC_DTTM'
    end
    object getDebtorsFA_ID: TStringField
      FieldName = 'FA_ID'
      FixedChar = True
      Size = 10
    end
    object getDebtorsFA_PACK_ID: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object getDebtorsCRE_DTTM: TDateTimeField
      FieldName = 'CRE_DTTM'
    end
    object getDebtorsACCT_OTDELEN: TStringField
      FieldName = 'ACCT_OTDELEN'
      Size = 6
    end
    object getDebtorsSERVICE_ORG: TStringField
      FieldName = 'SERVICE_ORG'
      Size = 50
    end
    object getDebtorsOP_AREA_DESCR: TStringField
      FieldName = 'OP_AREA_DESCR'
      Size = 60
    end
    object getDebtorsPREM_TYPE_DESCR: TStringField
      FieldName = 'PREM_TYPE_DESCR'
      Size = 60
    end
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
    Left = 248
    Top = 544
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
    DataSet = getFaPackQuery
    Left = 576
    Top = 8
  end
  object addCcProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.ADD_CC'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      
        '  :RESULT := PK_NASEL_SWEETY.ADD_CC(:P_CC_DTTM, :P_CC_TYPE_CD, :' +
        'P_CC_STATUS_FLG, :P_ACCT_ID, :P_DESCR, :P_SRC_ID, :P_SRC_TYPE_CD' +
        ', :P_CALLER);'
      'end;')
    Left = 848
    Top = 552
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
    CommandStoredProcName = 'PK_NASEL_SWEETY.ADD_CC'
  end
  object setCcStatusFlgProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.SET_CC_STATUS_FLG'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.SET_CC_STATUS_FLG(:P_CC_ID, :P_CC_STATUS_FLG);'
      'end;')
    Left = 848
    Top = 600
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
  object getApprovalListQuery: TOraQuery
    Session = EsaleSession
    SQL.Strings = (
      'select'
      '  rownum'
      '  , 0 CHECK_DATA'
      '  , t.*'
      'from ('
      '  select '
      '    nasel_fa.acct_id  '
      '    , nasel_fa.fa_id'
      '    , nasel_fa.saldo_uch'
      
        '    , nasel_ccb_prem.ulitsa || nvl2(nasel_ccb_prem.dom, '#39', '#1076'. '#39' ' +
        ' || nasel_ccb_prem.dom,'#39#39') || nvl2(nasel_ccb_prem.korp, '#39', '#1082#1086#1088#1087'.' +
        ' '#39'  || nasel_ccb_prem.korp,'#39#39') || nvl2(nasel_ccb_prem.kvartira, ' +
        #39', '#1082#1074'. '#39'  || nasel_ccb_prem.kvartira,'#39#39') address'
      '    , nasel_ccb_prem.city'
      '    , initcap(nasel_ccb_prem.fio) fio'
      '    , nasel_ccb_spr.descr service_org'
      '    '
      '    , cc.cc_id'
      '    , cc.cc_dttm   '
      '    , cc.src_type_cd'
      '    , cc.approval_dttm'
      '  '
      
        '    , row_number() over (partition by nasel_fa.acct_id order by ' +
        'nasel_fa_pack.cre_dttm desc) n'
      '  from nasel_fa '
      
        '  inner join nasel_fa_pack on nasel_fa_pack.fa_pack_id = nasel_f' +
        'a.fa_pack_id'
      '  '
      '  left join ('
      '    select nasel_ccb_sa_rel.acct_id'
      '      , nasel_ccb_sa_rel.spr_cd'
      
        '      , row_number() over (partition by  nasel_ccb_sa_rel.acct_i' +
        'd order by nasel_ccb_sa_rel.sa_rel_type_cd desc) n'
      '    from nasel_ccb_sa_rel '
      '    --where acct_id in ('#39'0129250000'#39')'
      '  ) sa_rel on sa_rel.acct_id = nasel_fa.acct_id and sa_rel.n = 1'
      
        '  left join nasel_ccb_spr on nasel_ccb_spr.spr_cd = sa_rel.spr_c' +
        'd'
      '                                                          '
      '  inner join ('
      '    select '
      '      nasel_cc.acct_id'
      '      , nasel_cc.cc_id'
      '      , nasel_cc.cc_dttm'
      '      , nasel_cc.descr'
      '      , nasel_cc.src_type_cd '
      '      , nasel_cc.approval_dttm'
      
        '      , row_number() over (partition by nasel_cc.src_id, nasel_c' +
        'c.src_type_cd  order by nasel_cc.cre_dttm desc) n'
      '    from nasel_cc    '
      
        '    where nasel_cc.src_type_cd = '#39'10'#39' and nasel_cc.cc_status_flg' +
        ' = '#39'20'#39
      '  ) cc on cc.acct_id = nasel_fa.acct_id and cc.n = 1'
      '  '
      
        '  left join nasel_ccb_prem on nasel_ccb_prem.acct_id = nasel_fa.' +
        'acct_id'
      '  where nasel_fa_pack.acct_otdelen = :acct_otdelen'
      ''
      '  order by nasel_ccb_prem.city, nasel_ccb_prem.address '
      ''
      ') t where t.n = 1')
    FetchAll = True
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 704
    Top = 56
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'acct_otdelen'
      end>
    object FloatField1: TFloatField
      FieldName = 'ROWNUM'
      ReadOnly = True
    end
    object FloatField2: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object StringField1: TStringField
      FieldName = 'FA_ID'
      ReadOnly = True
      FixedChar = True
      Size = 10
    end
    object StringField2: TStringField
      FieldName = 'ACCT_ID'
      ReadOnly = True
      FixedChar = True
      Size = 10
    end
    object StringField3: TStringField
      FieldName = 'ADDRESS'
      ReadOnly = True
      Size = 254
    end
    object StringField4: TStringField
      FieldName = 'FIO'
      ReadOnly = True
      Size = 254
    end
    object DateTimeField1: TDateTimeField
      FieldName = 'CC_DTTM'
    end
    object getApprovalListQueryCC_ID: TStringField
      FieldName = 'CC_ID'
      FixedChar = True
      Size = 10
    end
    object getApprovalListQuerySRC_TYPE_CD: TStringField
      FieldName = 'SRC_TYPE_CD'
      FixedChar = True
      Size = 10
    end
    object getApprovalListQueryAPPROVAL_DTTM: TDateTimeField
      FieldName = 'APPROVAL_DTTM'
    end
    object getApprovalListQueryCITY: TStringField
      FieldName = 'CITY'
      Size = 60
    end
    object getApprovalListQuerySERVICE_ORG: TStringField
      FieldName = 'SERVICE_ORG'
      Size = 50
    end
    object getApprovalListQuerySALDO_UCH: TFloatField
      FieldName = 'SALDO_UCH'
    end
  end
  object getApprovalListDataSource: TOraDataSource
    DataSet = getApprovalListQuery
    Left = 704
    Top = 8
  end
  object setCcApprovalDttmProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.SET_CC_APPROVAL_DTTM'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      
        '  PK_NASEL_SWEETY.SET_CC_APPROVAL_DTTM(:P_CC_ID, :P_APPROVAL_DTT' +
        'M);'
      'end;')
    Left = 928
    Top = 488
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_CC_ID'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'P_APPROVAL_DTTM'
        ParamType = ptInputOutput
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.SET_CC_APPROVAL_DTTM'
  end
  object getFaPackFilter: TDataSetFilter
    OnChange = OnFilterChange
    Glue = ' AND '
    DataSet = getFaPackRam
    Left = 576
    Top = 112
  end
  object selectFaPackFilter: TDataSetFilter
    Glue = ' AND '
    DataSet = selectFaPackQuery
    Left = 960
    Top = 112
  end
  object getApprovalListFilter: TDataSetFilter
    OnChange = OnFilterChange
    Glue = ' AND '
    DataSet = getApprovalListRam
    Left = 704
    Top = 112
  end
  object getDebtorsFilter: TDataSetFilter
    OnChange = OnFilterChange
    Glue = ' AND '
    DataSet = getDebtorsRam
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
    DataSet = getStopListQuery
    Left = 360
    Top = 288
  end
  object getStopListQuery: TOraQuery
    Session = EsaleSession
    SQL.Strings = (
      
        '-- '#1047#1072#1087#1088#1086#1089' '#1076#1083#1103' '#1087#1088#1077#1076#1089#1090#1072#1074#1083#1077#1085#1080#1103' '#1089#1087#1080#1089#1082#1072' '#1072#1073#1086#1085#1077#1085#1090#1086#1074' '#1076#1083#1103' '#1076#1072#1083#1100#1085#1077#1081#1096#1077#1075#1086' '#1086#1090#1082 +
        #1083#1102#1095#1077#1085#1080#1103
      '-- '#1040#1074#1090#1086#1088': '#1042'.'#1057'.'#1054#1074#1095#1080#1085#1085#1080#1082#1086#1074
      '-- '#1057#1086#1079#1076#1072#1085': 2017-02-01'
      ''
      'select '
      '  rownum'
      '  , 0 CHECK_DATA  '
      '  , t.* '
      
        '  , max(t.grp_data) over() grp_data_max -- '#1082#1086#1083'-'#1074#1086' '#1086#1073#1089#1083#1091#1078#1080#1074#1072#1102#1097#1080#1093' ' +
        #1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081
      'from ('
      'select '
      ''
      
        '  dense_rank() over (order by spr.descr, case when nasel_ccb_pre' +
        'm.prem_type_cd in ('#39'CD'#39') then 1 end) grp_data -- '#1080#1085#1076#1077#1082#1089' '#1086#1073#1089#1083#1091#1078#1080#1074 +
        #1072#1102#1097#1077#1081' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080' '
      
        '  --dense_rank() over (order by spr.descr) grp_data -- '#1080#1085#1076#1077#1082#1089' '#1086#1073 +
        #1089#1083#1091#1078#1080#1074#1072#1102#1097#1077#1081' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
      
        '  --, count(distinct nvl(spr.descr, '#39' '#39')) over() grp_data_max --' +
        ' '#1082#1086#1083'-'#1074#1086' '#1086#1073#1089#1083#1091#1078#1080#1074#1072#1102#1097#1080#1093' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081
      ''
      '  , nasel_ccb_prem.acct_id'
      '  , nasel_cc.approval_dttm'
      '  , nasel_cc.cc_dttm'
      '  , nasel_ccb_prem.fio '
      '  , nasel_ccb_prem.postal '
      '  , nasel_ccb_prem.city '
      
        '  , nasel_ccb_prem.ulitsa || nvl2(nasel_ccb_prem.dom, '#39', '#1076'. '#39'  |' +
        '| nasel_ccb_prem.dom,'#39#39') || nvl2(nasel_ccb_prem.korp, '#39', '#1082#1086#1088#1087'. '#39 +
        '  || nasel_ccb_prem.korp,'#39#39') || nvl2(nasel_ccb_prem.kvartira, '#39',' +
        ' '#1082#1074'. '#39'  || nasel_ccb_prem.kvartira,'#39#39') address'
      
        '  , (select nasel_lookup_val.descr from nasel_lookup_val where n' +
        'asel_lookup_val.field_name = '#39'PREM_TYPE_CD'#39' and nasel_lookup_val' +
        '.field_value = nasel_ccb_prem.prem_type_cd) prem_type_descr     '
      '  --, trim(nasel_ccb_prem.acct_otdelen) acct_otdelen'
      '  , ccb_ft.saldo_uch'
      '  , spr.descr spr_descr'
      '  , fa.fa_pack_id'
      
        '  , (select nasel_lookup_val.descr from nasel_lookup_val where n' +
        'asel_lookup_val.field_name = '#39'FA_PACK_TYPE_CD'#39' and nasel_lookup_' +
        'val.field_value = fa.fa_pack_type_cd) fa_pack_type_descr     '
      '  '
      'from nasel_ccb_prem'
      
        'inner join nasel_ccb_sp on nasel_ccb_sp.acct_id = nasel_ccb_prem' +
        '.acct_id and nasel_ccb_sp.sa_status_flg = '#39'20'#39
      ''
      '-- '#1053#1072#1095#1080#1089#1083#1077#1085#1080#1077' '#1087#1088#1077#1076#1087#1088#1077#1076#1099#1076#1091#1097#1077#1075#1086' '#1084#1077#1089#1103#1094#1072
      'inner join ('
      '  select'
      '    nasel_ccb_ft_hist.acct_id'
      
        '    , nvl(nasel_ccb_ft_hist.bill_bt_otch, 0) + nvl(nasel_ccb_ft_' +
        'hist.bill_odn_otch, 0) bill_otch'
      '  from nasel_ccb_ft_hist'
      
        '  where nasel_ccb_ft_hist.uch_begin_dt = add_months(trunc(sysdat' +
        'e, '#39'mm'#39'),-2)'
      
        ') nasel_ccb_ft_hist_m1 on nasel_ccb_ft_hist_m1.acct_id = nasel_c' +
        'cb_prem.acct_id'
      ''
      '--'
      'inner join ('
      '  select '
      '    nasel_ccb_ft.acct_id'
      '    , nasel_ccb_ft.uch_begin_dt'
      
        '    , nvl(nasel_ccb_ft.bill_bt_otch,0) + nvl(nasel_ccb_ft.bill_o' +
        'dn_otch,0) bill_otch'
      '    , nvl(nasel_ccb_ft.saldo_bt_uch,0) saldo_bt_uch'
      
        '    , nvl(nasel_ccb_ft.saldo_bt_uch,0) + nvl(nasel_ccb_ft.saldo_' +
        'odn_uch,0) + nvl(nasel_ccb_ft.saldo_act_uch,0) saldo_uch'
      '  from nasel_ccb_ft'
      ') ccb_ft on ccb_ft.acct_id = nasel_ccb_prem.acct_id'
      ''
      'left join ('
      '  select '
      '    nasel_fa.fa_pack_id'
      '    , nasel_fa_pack.fa_pack_type_cd'
      '    , nasel_fa_pack.cre_dttm'
      '    , nasel_fa.acct_id'
      '    , nasel_fa.fa_id'
      
        '    , row_number() over (partition by nasel_fa.acct_id order by ' +
        'nasel_fa_pack.cre_dttm desc) N'
      '  from nasel_fa'
      
        '  inner join nasel_fa_pack on nasel_fa_pack.fa_pack_id = nasel_f' +
        'a.fa_pack_id'
      ') fa on fa.acct_id = nasel_ccb_prem.acct_id and fa.n = 1'
      ''
      
        'inner join nasel_cc on nasel_cc.src_id = fa.fa_id and nasel_cc.s' +
        'rc_type_cd = '#39'10'#39' and'
      
        '  nasel_cc.approval_dttm is not null -- and nasel_cc.cc_dttm < s' +
        'ysdate -30 -- '#1047#1072#1082#1086#1084#1077#1085#1090#1080#1088#1086#1074#1072#1085#1086' '#1087#1086' '#1090#1088#1077#1073#1086#1074#1072#1085#1080#1077#1102' '#1045'.'#1042'.'#1053#1072#1079#1072#1088#1086#1074#1072' 2017-0' +
        '3-23'
      ''
      'left join ('
      '  select        '
      '    nasel_ccb_sa_rel.acct_id'
      '    , nasel_ccb_spr.descr'
      
        '    , row_number() over (partition by nasel_ccb_sa_rel.acct_id o' +
        'rder by nasel_ccb_sa_rel.sa_rel_type_cd) n'
      '  from nasel_ccb_sa_rel'
      
        '  inner join nasel_ccb_spr on nasel_ccb_spr.spr_cd = nasel_ccb_s' +
        'a_rel.spr_cd'
      ') spr on spr.acct_id = nasel_cc.acct_id and spr.n = 1'
      ''
      '-- '#1056#1077#1089#1090#1088#1091#1082#1090#1091#1088#1080#1079#1072#1094#1080#1103' '#1044#1047
      
        'left join nasel_ccb_pp on nasel_ccb_pp.acct_id = nasel_ccb_prem.' +
        'acct_id and nasel_ccb_pp.pp_stat_flg = '#39'20'#39
      ''
      'where'
      '  ( '
      '      (   '
      
        '         trunc(ccb_ft.uch_begin_dt,'#39'mm'#39') > trunc(fa.cre_dttm,'#39'mm' +
        #39')  '
      '         and'
      
        '         nvl(ccb_ft.saldo_uch,0) - nvl(nasel_ccb_pp.pp_tot_sched' +
        '_amt,0) - nvl(ccb_ft.bill_otch, 0) - nvl(nasel_ccb_ft_hist_m1.bi' +
        'll_otch, 0) > 0'
      
        '         --ccb_ft.saldo_uch - ccb_ft.nach_otch - nvl(nasel_ccb_p' +
        'p.pp_tot_sched_amt,0) > 0'
      '      ) '
      '    or '
      '      ( '
      
        '         trunc(ccb_ft.uch_begin_dt,'#39'mm'#39') <= trunc(fa.cre_dttm,'#39'm' +
        'm'#39')'
      '         and'
      
        '         nvl(ccb_ft.saldo_uch,0) - nvl(nasel_ccb_pp.pp_tot_sched' +
        '_amt,0) - nvl(ccb_ft.bill_otch, 0) > 0 '
      '      )'
      '  )'
      '  and'
      '    nasel_ccb_prem.acct_otdelen = :acct_otdelen'
      '  '
      '  -- and saldo_uch > normativ * 2 and saldo_m3 > normativ * 2'
      
        '  --and nasel_ccb_prem.acct_id in ('#39'1426650000'#39','#39'5426650000'#39','#39'55' +
        '26650000'#39','#39'7526650000'#39','#39'9926650000'#39', '#39'0000070000'#39')'
      ''
      'order by nasel_ccb_prem.city, nasel_ccb_prem.address '
      ') t')
    FetchAll = True
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 360
    Top = 336
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'acct_otdelen'
      end>
    object getStopListQueryROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
    object getStopListQueryCHECK_DATA: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object getStopListQueryACCT_ID: TStringField
      FieldName = 'ACCT_ID'
      FixedChar = True
      Size = 10
    end
    object getStopListQueryFIO: TStringField
      FieldName = 'FIO'
      Size = 254
    end
    object getStopListQueryPOSTAL: TStringField
      FieldName = 'POSTAL'
      Size = 10
    end
    object getStopListQueryCITY: TStringField
      FieldName = 'CITY'
      Size = 60
    end
    object getStopListQueryADDRESS: TStringField
      FieldName = 'ADDRESS'
      Size = 254
    end
    object getStopListQuerySALDO_UCH: TFloatField
      FieldName = 'SALDO_UCH'
    end
    object getStopListQueryAPPROVAL_DTTM: TDateTimeField
      FieldName = 'APPROVAL_DTTM'
    end
    object getStopListQueryCC_DTTM: TDateTimeField
      FieldName = 'CC_DTTM'
    end
    object getStopListQueryGRP_DATA: TFloatField
      FieldName = 'GRP_DATA'
    end
    object getStopListQueryGRP_DATA_MAX: TFloatField
      FieldName = 'GRP_DATA_MAX'
    end
    object getStopListQuerySPR_DESCR: TStringField
      FieldName = 'SPR_DESCR'
      Size = 50
    end
    object getStopListQueryFA_PACK_ID: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object getStopListQueryPREM_TYPE_DESCR: TStringField
      FieldName = 'PREM_TYPE_DESCR'
      Size = 60
    end
    object getStopListQueryFA_PACK_TYPE_DESCR: TStringField
      FieldName = 'FA_PACK_TYPE_DESCR'
      Size = 60
    end
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
    Left = 136
    Top = 440
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
    Left = 1080
    Top = 600
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
        #1086#1075#1086' '#1091#1095#1072#1089#1090#1082#1072#39'  post  '
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
    Left = 136
    Top = 544
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
    Left = 1072
    Top = 704
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
  object getFaPackInfo: TOraQuery
    Session = EsaleSession
    SQL.Strings = (
      'select'
      '  rownum'
      '  , sysdate'
      '  , t.cre_dttm'
      '  , t.acct_otdelen'
      '  , t.fa_pack_id'
      '  , t.fa_count'
      '  '
      '  --, t.acct_otdelen_descr'
      '  --, t.address'
      '  --, t.post'
      '  --, t.phone'
      '  --, t.nachalnik  '
      '  --, t.visa'
      ''
      'from ('
      '  select'
      '    nasel_fa_pack.* '
      '    , nasel_uch.fname'
      '    , raion.fname acct_otdelen_descr'
      '    , raion.address'
      '    , raion.nachalnik'
      '    , raion.phone'
      '    , raion.ccb_acct_char_val       '
      
        '    , :app_path || '#39'report\visa\'#39'|| raion.nachalnik || '#39'.png'#39' vi' +
        'sa'
      
        '    --, substr(trim(raion.FNAME),1,length(trim(raion.FNAME))-2) ' +
        '|| '#39#1086#1075#1086' '#1091#1095#1072#1089#1090#1082#1072#39'  post'
      '    , fa.fa_count'
      '  from nasel_fa_pack'
      
        '  left join nasel_uch on nasel_uch.acct_otdelen = nasel_fa_pack.' +
        'acct_otdelen'
      '  left join raion on raion.id = nasel_uch.id_rn'
      ''
      '  left join (    '
      '    select'
      '      nasel_fa.fa_pack_id'
      '      , count(*) fa_count '
      '    from nasel_fa'
      '    group by nasel_fa.fa_pack_id'
      '  ) fa on fa.fa_pack_id = nasel_fa_pack.fa_pack_id'
      ''
      ' '
      '  where nasel_fa_pack.fa_pack_id = :fa_pack_id --'#39'0000000416'#39
      '  order by nasel_fa_pack.cre_dttm desc '
      ') t')
    FetchAll = True
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 136
    Top = 600
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'app_path'
      end
      item
        DataType = ftUnknown
        Name = 'fa_pack_id'
      end>
    object getFaPackInfoROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
    object getFaPackInfoSYSDATE: TDateTimeField
      FieldName = 'SYSDATE'
    end
    object getFaPackInfoCRE_DTTM: TDateTimeField
      FieldName = 'CRE_DTTM'
    end
    object getFaPackInfoFA_PACK_ID: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object getFaPackInfoFA_COUNT: TFloatField
      FieldName = 'FA_COUNT'
    end
    object getFaPackInfoACCT_OTDELEN: TStringField
      FieldName = 'ACCT_OTDELEN'
      FixedChar = True
      Size = 7
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
    Left = 32
    Top = 488
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
    Left = 32
    Top = 312
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
  object getFaPackStopQuery: TOraQuery
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
      
        '  , nasel_ccb_prem.ulitsa || nvl2(nasel_ccb_prem.dom, '#39', '#1076'. '#39'  |' +
        '| nasel_ccb_prem.dom,'#39#39') || nvl2(nasel_ccb_prem.korp, '#39', '#1082#1086#1088#1087'. '#39 +
        '  || nasel_ccb_prem.korp,'#39#39') || nvl2(nasel_ccb_prem.kvartira, '#39',' +
        ' '#1082#1074'. '#39'  || nasel_ccb_prem.kvartira,'#39#39') address'
      '  --, nasel_ccb_prem.address'
      ''
      '  , nasel_ccb_prem.city'
      '  , nasel_ccb_prem.fio '
      '  , nasel_ccb_prem.postal'
      ''
      '  , cc.cc_dttm   '
      '  , cc.src_type_cd'
      '  , nasel_ccb_spr.descr spr_descr'
      '  , nasel_ccb_prem.phones'
      
        '  , trim(substr(nasel_ccb_prem.phones, 1, instr(nasel_ccb_prem.p' +
        'hones,'#39','#39')-1)) phone'
      '  '
      '  '
      '  , nvl(nasel_fa.end_reg_reading1, 0) end_reg_reading1'
      '  , nvl(nasel_fa.end_reg_reading2, 0) end_reg_reading2'
      ''
      
        '  --, nvl(nasel_ccb_ft_hist.saldo_bt_uch, 0) + nvl(nasel_ccb_ft_' +
        'hist.saldo_odn_uch, 0) + nvl(nasel_ccb_ft_hist.saldo_a'#1089't_uch, 0)' +
        ' saldo_m3'
      '  , nvl(nasel_fa.saldo_uch, 0) saldo_uch'
      '  , nasel_fa.mtr_serial_nbr '
      '  , nasel_fa_pack.fa_pack_id '
      '  , nasel_fa_pack.acct_otdelen '
      '  , nasel_fa_pack.cre_dttm'
      '  , nasel_ccb_sp.op_area_descr'
      '  , nasel_fa_pack.fa_pack_type_cd'
      
        '  , dense_rank() over(order by case when nasel_ccb_prem.prem_typ' +
        'e_cd in ('#39'CD'#39') then  nasel_ccb_spr.descr else '#39'0'#39' end) grp '
      
        '  , (select descr from nasel_lookup_val where nasel_lookup_val.f' +
        'ield_name = '#39'PREM_TYPE_CD'#39' and nasel_lookup_val.field_value = na' +
        'sel_ccb_prem.prem_type_cd) prem_type_descr'
      '  , fa_char.st_p_dt -- '#1087#1083#1072#1085#1086#1074#1072#1103' '#1076#1072#1090#1072' '#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103' '
      '  , nasel_ccb_sp.sa_end_dt'
      ''
      '  --, to_char(nasel_fa_pack.cre_dttm, '#39'dd.mm.yyyy'#39') cre_dt'
      ''
      '  --, nasel_ccb_prem.ulitsa'
      '  --, nasel_ccb_prem.dom'
      '  --, nasel_ccb_prem.korp'
      '  --, nasel_ccb_prem.kvartira'
      '  '
      'from nasel_fa_pack'
      
        'inner join nasel_fa on nasel_fa.fa_pack_id = nasel_fa_pack.fa_pa' +
        'ck_id'
      
        'inner join nasel_ccb_prem on nasel_ccb_prem.acct_id = nasel_fa.a' +
        'cct_id'
      
        'inner join nasel_ccb_sp on nasel_ccb_sp.acct_id = nasel_ccb_prem' +
        '.acct_id'
      ''
      
        '--left join nasel_ccb_bseg_read on nasel_ccb_bseg_read.acct_id =' +
        ' nasel_ccb_prem.acct_id '
      
        '--left join nasel_ccb_ft_hist on nasel_ccb_ft_hist.acct_id = nas' +
        'el_ccb_prem.acct_id and nasel_ccb_ft_hist.calc_dt = trunc(add_mo' +
        'nths(sysdate,-2), '#39'mm'#39')'
      
        '--inner join nasel_ccb_ft on nasel_ccb_ft.acct_id = nasel_fa.acc' +
        't_id'
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
      'left join nasel_ccb_spr on nasel_ccb_spr.spr_cd = sa_rel.spr_cd'
      ''
      'left join ('
      '  select '
      '     nasel_cc.acct_id'
      '    , nasel_cc.cc_dttm'
      '    , nasel_cc.descr'
      '    , nasel_cc.src_type_cd '
      
        '    , row_number() over (partition by nasel_cc.src_id, nasel_cc.' +
        'src_type_cd  order by nasel_cc.cc_dttm desc) n'
      '  from nasel_cc    '
      '  --where nasel_cc.src_type_cd = '#39'10'#39
      ') cc on cc.acct_id = nasel_fa.acct_id and cc.n = 1'
      ''
      '-- '#1055#1083#1072#1085#1080#1088#1091#1077#1084#1072#1103' '#1076#1072#1090#1072' '#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103
      'left join ('
      '   select'
      '     nasel_fa_char.fa_id'
      '     , nasel_fa_char.char_val_dttm st_p_dt '
      
        '     , row_number() over(partition by nasel_fa_char.fa_id, nasel' +
        '_fa_char.char_type_cd order by nasel_fa_char.effdt desc) n'
      '   from nasel_fa_char '
      '   where trim(char_type_cd) = '#39'ST-P-DT'#39
      ') fa_char on fa_char.fa_id = nasel_fa.fa_id and fa_char.n = 1'
      ''
      'where nasel_fa_pack.fa_pack_type_cd = '#39'40'#39
      '   and nasel_fa_pack.fa_pack_id = :fa_pack_id'
      
        '  --and nasel_fa.acct_id in ('#39'0408650000'#39', '#39'1608650000'#39', '#39'178385' +
        '0000'#39' , '#39'4595850000'#39')'
      ''
      'order by nasel_ccb_prem.city, nasel_ccb_prem.address '
      ''
      ') t')
    FetchAll = True
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 488
    Top = 336
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'fa_pack_id'
      end>
    object FloatField14: TFloatField
      FieldName = 'ROWNUM'
    end
    object FloatField15: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object StringField36: TStringField
      FieldName = 'FA_ID'
      FixedChar = True
      Size = 10
    end
    object StringField37: TStringField
      FieldName = 'ACCT_ID'
      FixedChar = True
      Size = 10
    end
    object StringField38: TStringField
      FieldName = 'ADDRESS'
      Size = 254
    end
    object StringField39: TStringField
      FieldName = 'CITY'
      Size = 60
    end
    object StringField40: TStringField
      FieldName = 'FIO'
      Size = 254
    end
    object DateTimeField8: TDateTimeField
      FieldName = 'CC_DTTM'
    end
    object StringField41: TStringField
      FieldName = 'SRC_TYPE_CD'
      FixedChar = True
      Size = 10
    end
    object StringField43: TStringField
      FieldName = 'PHONES'
      Size = 254
    end
    object FloatField16: TFloatField
      FieldName = 'END_REG_READING1'
    end
    object FloatField17: TFloatField
      FieldName = 'END_REG_READING2'
    end
    object FloatField18: TFloatField
      FieldName = 'SALDO_UCH'
    end
    object StringField44: TStringField
      FieldName = 'MTR_SERIAL_NBR'
      Size = 16
    end
    object StringField45: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object DateTimeField9: TDateTimeField
      FieldName = 'CRE_DTTM'
    end
    object StringField46: TStringField
      FieldName = 'ACCT_OTDELEN'
      Size = 6
    end
    object StringField47: TStringField
      FieldName = 'PHONE'
      Size = 254
    end
    object StringField48: TStringField
      FieldName = 'POSTAL'
      Size = 10
    end
    object StringField49: TStringField
      FieldName = 'OP_AREA_DESCR'
      Size = 60
    end
    object getFaPackStopQueryFA_PACK_TYPE_CD: TStringField
      FieldName = 'FA_PACK_TYPE_CD'
      FixedChar = True
      Size = 8
    end
    object getFaPackStopQueryGRP: TFloatField
      FieldName = 'GRP'
    end
    object getFaPackStopQueryPREM_TYPE_DESCR: TStringField
      FieldName = 'PREM_TYPE_DESCR'
      Size = 60
    end
    object getFaPackStopQueryST_P_DT: TDateTimeField
      FieldName = 'ST_P_DT'
    end
    object getFaPackStopQuerySPR_DESCR: TStringField
      FieldName = 'SPR_DESCR'
      Size = 50
    end
    object getFaPackStopQuerySA_END_DT: TDateTimeField
      FieldName = 'SA_END_DT'
    end
  end
  object getFaPackStopDataSource: TOraDataSource
    DataSet = getFaPackStopQuery
    Left = 488
    Top = 288
  end
  object getFaPackStopFilter: TDataSetFilter
    OnChange = OnFilterChange
    Glue = ' AND '
    DataSet = getFaPackStopRam
    Left = 488
    Top = 392
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
  object getPackStopListQuery: TOraQuery
    Session = EsaleSession
    SQL.Strings = (
      '-- '#1047#1072#1087#1088#1086#1089' '#1076#1083#1103' '#1087#1086#1083#1091#1095#1077#1085#1080#1103' '#1089#1087#1080#1089#1082#1072' '#1088#1077#1077#1089#1090#1088#1086#1074
      '-- '#1089#1086#1079#1076#1072#1085': 2017-02-08'
      '-- '#1072#1074#1090#1086#1088': vsovchinnikov'
      '--'
      ''
      'select'
      '  rownum'
      '  , 0 CHECK_DATA'
      '  , t.*'
      'from ('
      'select '
      '  nasel_fa_pack.fa_pack_id'
      '  , fa_pack_char.rt_spr recipient_spr_descr'
      '  , fa_pack_char.rt_addr recipient_address'
      '  , fa_pack_char.rt_post recipient_official_post'
      '  , fa_pack_char.rt_name recipient_official_name'
      ' '
      
        '  --, padeg_pack.Padeg_FIO(nasel_ccb_spr_l.official_post, '#39#1044#39') o' +
        'fficial_post'
      
        '  --, padeg_pack.Padeg_FIO(nasel_ccb_spr_l.official_name, '#39#1044#39') o' +
        'fficial_name'
      '  '
      '  , nasel_fa_pack.cre_dttm'
      '  , fa_char.st_p_dt  -- '#1087#1083#1072#1085#1080#1088#1091#1077#1084#1072#1103' '#1076#1072#1090#1072' '#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103
      '    '
      '  /*, acct_id_cnt   '
      '*/'
      '  , (select descr from nasel_lookup_val '
      
        '     where nasel_lookup_val.field_name = '#39'FA_PACK_STATUS_FLG'#39' an' +
        'd nasel_lookup_val.field_value = nasel_fa_pack.fa_pack_status_fl' +
        'g) fa_pack_status_descr'
      '     '
      
        '   , (select count(nasel_fa.acct_id) from nasel_fa where nasel_f' +
        'a.fa_pack_id = nasel_fa_pack.fa_pack_id) acct_id_cnt'
      ''
      ' /* , (select nasel_lookup_val.descr from nasel_lookup_val '
      
        '     where nasel_lookup_val.field_name = '#39'PREM_TYPE_CD'#39' and nase' +
        'l_lookup_val.field_value = nasel_ccb_prem.prem_type_cd) prem_typ' +
        'e_descr    '
      '*/'
      '  '
      '  --, padeg_pack.Padeg_FIO('#39#1063#1077#1083#1103#1073#1101#1085#1077#1088#1075#1086#1089#1073#1099#1090#39','#39#1042#39')'
      
        '  --, char_st_p_dt.char_val_dttm st_p_dt -- '#1087#1083#1072#1085#1080#1088#1091#1077#1084#1072#1103' '#1076#1072#1090#1072' '#1086#1090#1082 +
        #1083#1102#1095#1077#1085#1080#1103
      '  --, nasel_ccb_spr_l.official_post'
      '  --, nasel_ccb_spr_l.official_name'
      ''
      'from nasel_fa_pack'
      ''
      'left join ('
      '  select'
      '    fa_pack_id'
      
        '    , max(case when char_type_cd = '#39'RT-SPR'#39' then char_val_str en' +
        'd) rt_spr'
      
        '    , max(case when char_type_cd = '#39'RT-ADDR'#39' then char_val_str e' +
        'nd) rt_addr'
      
        '    , max(case when char_type_cd = '#39'RT-POST'#39' then char_val_str e' +
        'nd) rt_post'
      
        '    , max(case when char_type_cd = '#39'RT-NAME'#39' then char_val_str e' +
        'nd) rt_name'
      '  from ('
      '    select '
      '      nasel_fa_pack_char.fa_pack_id'
      '      , trim(nasel_fa_pack_char.char_type_cd) char_type_cd'
      '      , nasel_fa_pack_char.char_val_str'
      
        '      , row_number() over (partition by nasel_fa_pack_char.fa_pa' +
        'ck_id, nasel_fa_pack_char.char_type_cd order by nasel_fa_pack_ch' +
        'ar.effdt desc) N'
      '    from nasel_fa_pack_char'
      '  )'
      '  where n = 1 '
      '  group by fa_pack_id'
      
        ') fa_pack_char on fa_pack_char.fa_pack_id = nasel_fa_pack.fa_pac' +
        'k_id'
      ''
      '-- '#1055#1083#1072#1085#1080#1088#1091#1077#1084#1072#1103' '#1076#1072#1090#1072' '#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103
      'left join ('
      '  select '
      '    nasel_fa.fa_pack_id '
      '    , max(st_p_dt) st_p_dt '
      '  from ('
      '    select     '
      '      nasel_fa_char.fa_id'
      '      , nasel_fa_char.char_val_dttm st_p_dt '
      
        '      , row_number() over(partition by nasel_fa_char.fa_id, nase' +
        'l_fa_char.char_type_cd order by nasel_fa_char.effdt desc) n'
      '    from nasel_fa_char '
      '    where trim(char_type_cd) = '#39'ST-P-DT'#39' '
      '  ) t'
      '  left join nasel_fa on nasel_fa.fa_id = t.fa_id    '
      '  where t.n = 1'
      '  group by nasel_fa.fa_pack_id     '
      ') fa_char on fa_char.fa_pack_id = nasel_fa_pack.fa_pack_id '
      ''
      ''
      'where '
      
        '  fa_pack_type_cd = '#39'40'#39' and nasel_fa_pack.acct_otdelen = :acct_' +
        'otdelen'
      '  --nasel_fa_pack.fa_pack_id = '#39'0000002160'#39
      ''
      'order by nasel_fa_pack.cre_dttm desc'
      ''
      ') t')
    FetchAll = True
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 608
    Top = 336
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'acct_otdelen'
      end>
    object getPackStopListQueryFA_PACK_ID: TStringField
      FieldName = 'FA_PACK_ID'
      Required = True
      FixedChar = True
      Size = 10
    end
    object getPackStopListQueryCRE_DTTM: TDateTimeField
      FieldName = 'CRE_DTTM'
      Required = True
    end
    object getPackStopListQueryACCT_ID_CNT: TFloatField
      FieldName = 'ACCT_ID_CNT'
    end
    object getPackStopListQueryST_P_DT: TDateTimeField
      FieldName = 'ST_P_DT'
    end
    object getPackStopListQueryROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
    object getPackStopListQueryCHECK_DATA: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object getPackStopListQueryFA_PACK_STATUS_DESCR: TStringField
      FieldName = 'FA_PACK_STATUS_DESCR'
      Size = 60
    end
    object getPackStopListQueryRECIPIENT_SPR_DESCR: TStringField
      FieldName = 'RECIPIENT_SPR_DESCR'
      Size = 255
    end
    object getPackStopListQueryRECIPIENT_ADDRESS: TStringField
      FieldName = 'RECIPIENT_ADDRESS'
      Size = 255
    end
    object getPackStopListQueryRECIPIENT_OFFICIAL_POST: TStringField
      FieldName = 'RECIPIENT_OFFICIAL_POST'
      Size = 255
    end
    object getPackStopListQueryRECIPIENT_OFFICIAL_NAME: TStringField
      FieldName = 'RECIPIENT_OFFICIAL_NAME'
      Size = 255
    end
  end
  object getPackStopListDataSource: TOraDataSource
    DataSet = getPackStopListQuery
    Left = 608
    Top = 288
  end
  object getPackStopListFilter: TDataSetFilter
    OnChange = OnFilterChange
    Glue = ' AND '
    DataSet = getPackStopListRam
    Left = 608
    Top = 392
  end
  object AddFaToPackStopProc_: TOraStoredProc
    StoredProcName = 'PK_NASEL_OTDEL.ADD_FA_TO_PACK_STOP'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_OTDEL.ADD_FA_TO_PACK_STOP(:P_ACCT_ID, :P_FA_PACK_ID);'
      'end;')
    Left = 848
    Top = 776
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
  object getDebtorsRam: TVirtualTable
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 456
    Top = 168
    Data = {03000000000000000000}
  end
  object getPostListDataSource: TOraDataSource
    DataSet = getPostListQuery
    Left = 824
    Top = 8
  end
  object getPostListQuery: TOraQuery
    Session = EsaleSession
    SQL.Strings = (
      '-- '#1057#1087#1080#1089#1086#1082' '#1085#1072' '#1087#1086#1095#1090#1091
      '-- 2017-02-22'
      '-- '#1072#1074#1090#1086#1088': '#1042#1057#1054#1074#1095#1080#1085#1085#1080#1082#1086#1074
      '-- '#1045'.'#1042'.'#1053#1072#1079#1072#1088#1086#1074
      '--'
      '-- '#1059#1089#1083#1086#1074#1080#1103
      '-- 1. '#1058#1086#1095#1082#1072' '#1091#1095#1077#1090#1072' '#1074' '#1089#1090#1072#1090#1091#1089#1077' '#1091#1089#1090#1072#1085#1086#1074#1083#1077#1085#1072' (20)'
      '-- 2. saldo_uch > normativ * 2 and saldo_m3 > normativ * 2'
      
        '-- 3. '#1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1091#1090#1074#1077#1088#1078#1076#1077#1085#1085#1086#1075#1086' '#1082#1086#1085#1090#1072#1082#1090#1072' '#1073#1086#1083#1077#1077' 6 '#1084#1077#1089#1103#1094#1077#1074' '#1080#1083#1080 +
        ' '#1087#1091#1089#1090#1072#1103
      '-- 4. '#1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1103' '#1073#1086#1083#1077#1077' 2 '#1084#1077#1089#1103#1094#1077#1074' '#1080#1083#1080' '#1087#1091#1089#1090#1072#1103
      ''
      '/*'
      'select'
      '  rownum '
      '  , 0 CHECK_DATA '
      '  , acct_id  '
      '  , initcap(fio) fio   '
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
      '  , op_area_descr'
      '   '
      '*/'
      ''
      'select'
      '  rownum '
      '  , 0 CHECK_DATA '
      '  , t.*'
      'from ('
      ''
      '  select nasel_ccb_prem.acct_id'
      '    , fa.cre_dttm'
      '    , fa.fa_pack_id'
      '    , nasel_ccb_ft.saldo_bt_uch'
      '    , nasel_ccb_ft.saldo_act_uch     '
      '    '
      '    , initcap(nasel_ccb_prem.fio) fio   '
      '    , nasel_ccb_prem.city'
      
        '    , nasel_ccb_prem.ulitsa || nvl2(nasel_ccb_prem.dom, '#39', '#1076'. '#39' ' +
        ' || nasel_ccb_prem.dom,'#39#39') || nvl2(nasel_ccb_prem.korp, '#39', '#1082#1086#1088#1087'.' +
        ' '#39'  || nasel_ccb_prem.korp,'#39#39') || nvl2(nasel_ccb_prem.kvartira, ' +
        #39', '#1082#1074'. '#39'  || nasel_ccb_prem.kvartira,'#39#39') address'
      ''
      ''
      
        '    , nvl(nasel_ccb_ft.saldo_bt_uch, 0) + nvl(nasel_ccb_ft.saldo' +
        '_odn_uch, 0) + nvl(nasel_ccb_ft.saldo_act_uch, 0) saldo_uch'
      
        '    , nvl(nasel_ccb_ft_hist.saldo_bt_uch, 0) + nvl(nasel_ccb_ft_' +
        'hist.saldo_odn_uch, 0) + nvl(nasel_ccb_ft_hist.saldo_act_uch, 0)' +
        ' saldo_m3'
      '                              '
      
        '    --, pk_nasel_otdel.get_normativ(nasel_ccb_prem.acct_id) norm' +
        'ativ'
      '      '
      '    , nasel_ccb_spr.descr service_org'
      '    , nasel_ccb_sp.op_area_descr'
      '    , nasel_ccb_sp.fl_tar11'
      '    , nasel_calc.norm_amt'
      '       '
      '  from nasel_ccb_prem'
      ''
      '  inner join ('
      '    select nasel_fa.acct_id '
      '      , nasel_fa.fa_id'
      '      , nasel_fa_pack.cre_dttm'
      '      , nasel_fa_pack.fa_pack_id'
      '      --fa_pack_id'
      
        '      , row_number() over (partition by nasel_fa.acct_id order b' +
        'y nasel_fa_pack.cre_dttm desc) n'
      '    from nasel_fa           '
      
        '    inner join nasel_fa_pack on nasel_fa_pack.fa_pack_id = nasel' +
        '_fa.fa_pack_id'
      
        '  ) fa on fa.acct_id = nasel_ccb_prem.acct_id and fa.n = 1 and f' +
        'a.cre_dttm < sysdate - 0   '
      ''
      
        '  /*inner join nasel_fa on nasel_fa.acct_id = nasel_ccb_prem.acc' +
        't_id '
      
        '  inner join nasel_fa_pack on nasel_fa_pack.fa_pack_id = nasel_f' +
        'a.fa_pack_id'
      '    and nasel_fa_pack.cre_dttm < sysdate - 0 */  '
      '                             '
      
        '  left join nasel_cc on nasel_cc.src_id = fa.fa_id and nasel_cc.' +
        'src_type_cd = '#39'10'#39
      ''
      
        '  inner join nasel_ccb_sp on nasel_ccb_sp.acct_id = nasel_ccb_pr' +
        'em.acct_id and nasel_ccb_sp.sa_status_flg in ('#39'20'#39')'
      
        '  left join nasel_ccb_ft on nasel_ccb_ft.acct_id = nasel_ccb_pre' +
        'm.acct_id'
      
        '  left join nasel_ccb_ft_hist on nasel_ccb_ft_hist.acct_id = nas' +
        'el_ccb_prem.acct_id and nasel_ccb_ft_hist.uch_begin_dt = trunc(a' +
        'dd_months((select char_val_dttm from cfg_task where char_type_cd' +
        ' = '#39'REP_DTTM'#39' and task_name = '#39'P_UPDATE_NASEL_JOB_DAY'#39'),-3), '#39'mm' +
        #39')'
      '                           '
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
      
        '  inner join nasel_calc on nasel_calc.acct_id = nasel_ccb_prem.a' +
        'cct_id  '
      ''
      '  where nasel_cc.cc_id is null '
      '    and acct_otdelen = :acct_otdelen'
      
        '    /*and acct_id in ('#39'4015250000'#39', '#39'4046250000'#39', '#39'6046250000'#39','#39 +
        '1441170000'#39','#39'0000003304'#39', '#39'7474750000'#39','#39'7204750000'#39','#39'4006750000'#39 +
        ','#39'6333850000'#39','#39'1390950000'#39', '#39'6326650000'#39', '#39'3043850000'#39', '#39'9226650' +
        '000'#39', '
      
        '      '#39'0408650000'#39', '#39'1608650000'#39', '#39'1783850000'#39' , '#39'4595850000'#39') /' +
        '**/'
      '  '
      
        ') t where saldo_uch > norm_amt * 2 * fl_tar11 and saldo_m3 > nor' +
        'm_amt * 2 * fl_tar11'
      
        '    --and (cc_dttm is null or months_between(cc_dttm, sysdate) >' +
        ' 6) '
      
        '    --and (cre_dttm is null or months_between(cre_dttm, sysdate)' +
        ' > 2)')
    FetchAll = True
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 824
    Top = 64
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'acct_otdelen'
      end>
    object getPostListQueryACCT_ID: TStringField
      FieldName = 'ACCT_ID'
      FixedChar = True
      Size = 10
    end
    object getPostListQueryCRE_DTTM: TDateTimeField
      FieldName = 'CRE_DTTM'
    end
    object getPostListQuerySALDO_BT_UCH: TFloatField
      FieldName = 'SALDO_BT_UCH'
    end
    object getPostListQuerySALDO_ACT_UCH: TFloatField
      FieldName = 'SALDO_ACT_UCH'
    end
    object getPostListQueryFIO: TStringField
      FieldName = 'FIO'
      Size = 254
    end
    object getPostListQueryCITY: TStringField
      FieldName = 'CITY'
      Size = 60
    end
    object getPostListQueryADDRESS: TStringField
      FieldName = 'ADDRESS'
      Size = 254
    end
    object getPostListQuerySALDO_UCH: TFloatField
      FieldName = 'SALDO_UCH'
    end
    object getPostListQuerySALDO_M3: TFloatField
      FieldName = 'SALDO_M3'
    end
    object getPostListQuerySERVICE_ORG: TStringField
      FieldName = 'SERVICE_ORG'
      Size = 50
    end
    object getPostListQueryOP_AREA_DESCR: TStringField
      FieldName = 'OP_AREA_DESCR'
      Size = 60
    end
    object getPostListQueryFL_TAR11: TFloatField
      FieldName = 'FL_TAR11'
    end
    object getPostListQueryROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
    object getPostListQueryCHECK_DATA: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object getPostListQueryNORM_AMT: TFloatField
      FieldName = 'NORM_AMT'
    end
    object getPostListQueryFA_PACK_ID: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
  end
  object getPostListFilter: TDataSetFilter
    OnChange = OnFilterChange
    Glue = ' AND '
    DataSet = getPostListRam
    Left = 824
    Top = 120
  end
  object getPostListRam: TVirtualTable
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 832
    Top = 184
    Data = {03000000000000000000}
  end
  object getFaPackType: TOraQuery
    KeyFields = 'ACCT_OTDELEN'
    Session = EsaleSession
    SQL.Strings = (
      'select '
      '  nasel_lookup_val.field_value'
      '  , nasel_lookup_val.descr'
      'from nasel_lookup_val'
      'where field_name = '#39'FA_PACK_TYPE_CD'#39
      '  and eff_status = '#39'A'#39)
    FetchAll = True
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 136
    Top = 496
    object StringField21: TStringField
      FieldName = 'OTDELEN_DESCR'
      Size = 25
    end
    object IntegerField1: TIntegerField
      FieldName = 'ACCT_OTDELEN'
      Required = True
    end
    object StringField22: TStringField
      FieldName = 'ADDRESS'
      Size = 100
    end
    object StringField23: TStringField
      FieldName = 'NACHALNIK'
      Size = 30
    end
    object StringField24: TStringField
      FieldName = 'PHONE'
      Size = 50
    end
    object StringField25: TStringField
      FieldName = 'CCB_ACCT_CHAR_VAL'
      Size = 30
    end
    object StringField26: TStringField
      FieldName = 'VISA'
      Size = 2046
    end
    object StringField42: TStringField
      FieldName = 'POST'
      Size = 36
    end
  end
  object updateCcProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.UPDATE_CC'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      
        '  PK_NASEL_SWEETY.UPDATE_CC(:P_CC_ID, :P_CC_DTTM, :P_CC_TYPE_CD,' +
        ' :P_CC_STATUS_FLG, :P_DESCR, :P_CALLER);'
      'end;')
    Left = 928
    Top = 552
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
    Left = 1008
    Top = 584
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_CC_ID'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.DELETE_CC'
  end
  object setFaPackStatusFlgFrozenProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.SET_FA_PACK_STATUS_FLG_FROZEN'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.SET_FA_PACK_STATUS_FLG_FROZEN(:P_FA_PACK_ID);'
      'end;')
    Left = 952
    Top = 664
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_FA_PACK_ID'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.SET_FA_PACK_STATUS_FLG_FROZEN'
  end
  object setFaCharStPDt: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.SET_FA_CHAR_ST_P_DT'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.SET_FA_CHAR_ST_P_DT(:P_FA_ID);'
      'end;')
    Left = 936
    Top = 608
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_FA_ID'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.SET_FA_CHAR_ST_P_DT'
  end
  object getFullListQuery: TOraQuery
    Session = EsaleSession
    SQL.Strings = (
      '-- '#1042#1089#1077' '#1076#1086#1083#1078#1085#1080#1082#1080
      '-- 2017-02-16'
      '-- '#1072#1074#1090#1086#1088': '#1042#1057#1054#1074#1095#1080#1085#1085#1080#1082#1086#1074
      '-- '#1045'.'#1042'.'#1053#1072#1079#1072#1088#1086#1074
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
  object getFullListDataSource: TOraDataSource
    DataSet = getFullListQuery
    Left = 360
    Top = 8
  end
  object getFullListRam: TVirtualTable
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 360
    Top = 176
    Data = {03000000000000000000}
  end
  object getCcInfoQuery: TOraQuery
    Session = EsaleSession
    SQL.Strings = (
      'select'
      '*'
      'from nasel_cc'
      'where nasel_cc.cc_id = :cc_id')
    FetchAll = True
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 136
    Top = 656
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'cc_id'
      end>
    object getCcInfoQueryCC_ID: TStringField
      FieldName = 'CC_ID'
      Required = True
      FixedChar = True
      Size = 10
    end
    object getCcInfoQueryACCT_ID: TStringField
      FieldName = 'ACCT_ID'
      Required = True
      FixedChar = True
      Size = 10
    end
    object getCcInfoQueryCC_TYPE_CD: TStringField
      FieldName = 'CC_TYPE_CD'
      Required = True
      FixedChar = True
      Size = 10
    end
    object getCcInfoQueryCC_DTTM: TDateTimeField
      FieldName = 'CC_DTTM'
      Required = True
    end
    object getCcInfoQuerySRC_ID: TStringField
      FieldName = 'SRC_ID'
      FixedChar = True
      Size = 10
    end
    object getCcInfoQuerySRC_TYPE_CD: TStringField
      FieldName = 'SRC_TYPE_CD'
      FixedChar = True
      Size = 10
    end
    object getCcInfoQueryCRE_DTTM: TDateTimeField
      FieldName = 'CRE_DTTM'
      Required = True
    end
    object getCcInfoQueryCALLER: TStringField
      FieldName = 'CALLER'
      Size = 100
    end
    object getCcInfoQueryDESCR: TStringField
      FieldName = 'DESCR'
      Size = 254
    end
    object getCcInfoQueryCC_STATUS_FLG: TStringField
      FieldName = 'CC_STATUS_FLG'
      Required = True
      FixedChar = True
      Size = 2
    end
    object getCcInfoQueryAPPROVAL_DTTM: TDateTimeField
      FieldName = 'APPROVAL_DTTM'
    end
    object getCcInfoQueryAPPROVER_USER_ID: TStringField
      FieldName = 'APPROVER_USER_ID'
      Size = 30
    end
    object getCcInfoQueryCC_CREATOR_USER_ID: TStringField
      FieldName = 'CC_CREATOR_USER_ID'
      Size = 30
    end
  end
  object OraStoredTEST: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.GET_OP_AREA_CD_LIST'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      
        '  :RESULT := PK_NASEL_SWEETY.GET_OP_AREA_CD_LIST(:P_ACCT_OTDELEN' +
        ');'
      'end;')
    Left = 352
    Top = 720
    ParamData = <
      item
        DataType = ftCursor
        Name = 'RESULT'
        ParamType = ptResult
        Value = 'Object'
        IsResult = True
      end
      item
        DataType = ftString
        Name = 'P_ACCT_OTDELEN'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.GET_OP_AREA_CD_LIST'
    object OraStoredTESTOP_AREA_CD: TStringField
      FieldName = 'OP_AREA_CD'
      Size = 8
    end
    object OraStoredTESTACCT_OTDELEN: TStringField
      FieldName = 'ACCT_OTDELEN'
      Size = 6
    end
    object OraStoredTESTOP_AREA_DESCR: TStringField
      FieldName = 'OP_AREA_DESCR'
      Size = 60
    end
  end
  object OraDataSourceTEST: TOraDataSource
    DataSet = OraStoredTEST
    Left = 360
    Top = 688
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
  object getPackStopListRam: TVirtualTable
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 600
    Top = 456
    Data = {03000000000000000000}
  end
  object getFaCancelListDataSource: TOraDataSource
    DataSet = getFaCancelListQuery
    Left = 736
    Top = 288
  end
  object getFaCancelListQuery: TOraQuery
    Session = EsaleSession
    SQL.Strings = (
      '-- '#1047#1072#1087#1088#1086#1089' '#1076#1083#1103' '#1089#1087#1080#1089#1082#1072' '#1088#1077#1077#1089#1090#1088#1086#1074' '#1085#1072' '#1086#1090#1084#1077#1085#1091' '#1079#1072#1103#1074#1086#1082' '#1085#1072' '#1086#1075#1088#1072#1085#1080#1095#1077#1085#1080#1103
      '-- '#1040#1074#1090#1086#1088': '#1042'.'#1057'.'#1054#1074#1095#1080#1085#1085#1080#1082#1086#1074
      '-- '#1057#1086#1079#1076#1072#1085': 2017-04-20'
      ''
      'select'
      '  rownum'
      '  , 0 CHECK_DATA  '
      '  , t.* '
      'from'
      '('
      'select'
      '  nasel_fa_pack.fa_pack_id'
      '  , nasel_fa_pack.cre_dttm'
      '  , nasel_fa_pack.fa_pack_status_flg'
      '  , fa.prnt_fa_id'
      '  , prnt_fa.*'
      'from nasel_fa_pack'
      ''
      'left join ('
      '  select nasel_fa.fa_pack_id'
      '    , count(*) cnt'
      '    , max(nasel_fa_char.char_val_str) prnt_fa_id '
      '  from nasel_fa'
      
        '  left join nasel_fa_char on nasel_fa_char.fa_id = nasel_fa.fa_i' +
        'd and nasel_fa_char.char_type_cd = '#39'PRNT-FA'#39
      '  group by nasel_fa.fa_pack_id'
      ') fa on fa.fa_pack_id = nasel_fa_pack.fa_pack_id'
      ''
      'left join ('
      '  select'
      '    nasel_fa.fa_id'
      '    --, nasel_fa.fa_pack_id'
      
        '    , max(case when trim(nasel_fa_pack_char.char_type_cd) = '#39'RT-' +
        'SPR'#39' then nasel_fa_pack_char.char_val_str end) rt_spr'
      
        '    , max(case when nasel_fa_pack_char.char_type_cd = '#39'RT-ADDR'#39' ' +
        'then nasel_fa_pack_char.char_val_str end) rt_addr'
      
        '    , max(case when nasel_fa_pack_char.char_type_cd = '#39'RT-POST'#39' ' +
        'then nasel_fa_pack_char.char_val_str end) rt_post'
      
        '    , max(case when nasel_fa_pack_char.char_type_cd = '#39'RT-NAME'#39' ' +
        'then nasel_fa_pack_char.char_val_str end) rt_name'
      '  from nasel_fa '
      
        '  left join nasel_fa_pack_char on nasel_fa_pack_char.fa_pack_id ' +
        '= nasel_fa.fa_pack_id'
      '  group by nasel_fa.fa_id'
      ') prnt_fa on prnt_fa.fa_id = fa.prnt_fa_id'
      ''
      ''
      'where acct_otdelen = :acct_otdelen --'#39'02-61FL'#39
      '  and nasel_fa_pack.fa_pack_type_cd = '#39'45'#39
      ' ) t')
    FetchAll = True
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 736
    Top = 336
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'acct_otdelen'
      end>
    object getFaCancelListQueryROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
    object getFaCancelListQueryCHECK_DATA: TFloatField
      FieldName = 'CHECK_DATA'
    end
    object getFaCancelListQueryFA_PACK_ID: TStringField
      FieldName = 'FA_PACK_ID'
      FixedChar = True
      Size = 10
    end
    object getFaCancelListQueryCRE_DTTM: TDateTimeField
      FieldName = 'CRE_DTTM'
    end
    object getFaCancelListQueryFA_PACK_STATUS_FLG: TStringField
      FieldName = 'FA_PACK_STATUS_FLG'
      FixedChar = True
      Size = 2
    end
    object getFaCancelListQueryPRNT_FA_ID: TStringField
      FieldName = 'PRNT_FA_ID'
      Size = 10
    end
    object getFaCancelListQueryFA_ID: TStringField
      FieldName = 'FA_ID'
      FixedChar = True
      Size = 10
    end
    object getFaCancelListQueryRT_SPR: TStringField
      FieldName = 'RT_SPR'
      Size = 255
    end
    object getFaCancelListQueryRT_ADDR: TStringField
      FieldName = 'RT_ADDR'
      Size = 255
    end
    object getFaCancelListQueryRT_POST: TStringField
      FieldName = 'RT_POST'
      Size = 255
    end
    object getFaCancelListQueryRT_NAME: TStringField
      FieldName = 'RT_NAME'
      Size = 255
    end
  end
  object getFaCancelListFilter: TDataSetFilter
    OnChange = OnFilterChange
    Glue = ' AND '
    DataSet = getFaCancelListRam
    Left = 736
    Top = 392
  end
  object getFaCancelListRam: TVirtualTable
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Left = 736
    Top = 456
    Data = {03000000000000000000}
  end
  object deleteFaPackProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.DELETE_FA_PACK'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.DELETE_FA_PACK(:P_FA_PACK_ID);'
      'end;')
    Left = 1056
    Top = 496
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_FA_PACK_ID'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.DELETE_FA_PACK'
  end
  object setFaPackStatusFlgCancelProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.SET_FA_PACK_STATUS_FLG_CANCEL'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.SET_FA_PACK_STATUS_FLG_CANCEL(:P_FA_PACK_ID);'
      'end;')
    Left = 952
    Top = 728
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_FA_PACK_ID'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.SET_FA_PACK_STATUS_FLG_CANCEL'
  end
  object updateFaPackCharRecipientProc: TOraStoredProc
    StoredProcName = 'PK_NASEL_SWEETY.UPDATE_FA_PACK_CHAR_RECIPIENT'
    Session = EsaleSession
    SQL.Strings = (
      'begin'
      '  PK_NASEL_SWEETY.UPDATE_FA_PACK_CHAR_RECIPIENT(:P_FA_PACK_ID);'
      'end;')
    Left = 632
    Top = 530
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'P_FA_PACK_ID'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'PK_NASEL_SWEETY.UPDATE_FA_PACK_CHAR_RECIPIENT'
  end
end
