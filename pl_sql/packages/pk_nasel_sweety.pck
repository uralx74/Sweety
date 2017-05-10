create or replace package pk_nasel_sweety is

  -- Author  : V.OVCHINNIKOV
  -- Created : 22.03.2017 14:43:43
  -- Purpose : Package for Sweety application
  
  type refcursor is REF CURSOR;
  
  -- Public type declarations
  /*type <TypeName> is <Datatype>;
  
  -- Public constant declarations
  <ConstantName> constant <Datatype> := <Value>;

  -- Public variable declarations
  <VariableName> <Datatype>;

  -- Public function and procedure declarations
  function <FunctionName>(<Parameter> <Datatype>) return <Datatype>;*/
    
  
  
  
    /* Процедуры для программы для работы с уведомлениями
  */

  -- Добавляет пачку
  function add_fa_pack(
    p_fa_pack_type_cd  IN nasel_fa_pack.fa_pack_type_cd%type,
    p_prnt_fa_pack_id  IN nasel_fa_pack.prnt_fa_pack_id%type default null ,
    p_acct_otdelen in nasel_fa_pack.acct_otdelen%type
  )
  return nasel_fa_pack.fa_pack_id%type; 

  function create_fa_pack(
    p_fa_pack_type_cd  in nasel_fa_pack.fa_pack_type_cd%type,
    p_prnt_fa_pack_id  in nasel_fa_pack.prnt_fa_pack_id%type default null ,
    p_acct_otdelen in nasel_fa_pack.acct_otdelen%type
  )
  return nasel_fa_pack.fa_pack_id%type;                      
                       
  procedure add_fa_pack_char_recipient(
    p_fa_pack_id in nasel_fa_pack_char.fa_pack_id%type,
    p_rt_spr_cd in nasel_fa_pack_char.char_val_str%type,        -- Код организации
    p_rt_spr in nasel_fa_pack_char.char_val_str%type,
    p_rt_addr in nasel_fa_pack_char.char_val_str%type,
    p_rt_post in nasel_fa_pack_char.char_val_str%type,
    p_rt_name in nasel_fa_pack_char.char_val_str%type
  );
  
  procedure update_fa_pack_char_recipient(p_fa_pack_id in nasel_fa_pack_char.fa_pack_id%type);

     
  procedure set_fa_pack_status_flg(
    p_fa_pack_id IN nasel_fa_pack_char.fa_pack_id%type,
    p_fa_pack_status_flg in nasel_fa_pack.fa_pack_status_flg%type
  );

  -- 
  procedure set_fa_pack_status_flg_frozen(
    p_fa_pack_id in nasel_fa_pack.fa_pack_id%type
  );
  --procedure set_fa_pack_status_flg_incomp(  p_fa_pack_id in nasel_fa_pack.fa_pack_id%type);
  
  procedure set_fa_pack_status_flg_cancel(
    p_fa_pack_id in nasel_fa_pack.fa_pack_id%type
  );


  -- Добавляет характеристику для реестра
  procedure add_fa_pack_char_str(
    p_fa_pack_id in nasel_fa_pack_char.fa_pack_id%type,
    p_fa_pack_char_type_cd in nasel_fa_pack_char.char_type_cd%type,
    p_fa_pack_char_val_str in nasel_fa_pack_char.char_val_str%type
  );

  -- Добавляет характеристику для реестра
  procedure add_fa_pack_char_dttm(
    p_fa_pack_id in nasel_fa_pack_char.fa_pack_id%type,
    p_fa_pack_char_type_cd in nasel_fa_pack_char.char_type_cd%type,
    p_fa_pack_char_val_dttm in nasel_fa_pack_char.char_val_dttm%type
  );

  -- Устанавливает флаг состояния для Деятельности fa
  procedure set_fa_status_flg(
    p_fa_id in nasel_fa.fa_id%type,
    p_fa_status_flg in nasel_fa.fa_status_flg%type
  );

  -- Добавляет лицевой в реестр (ручной вариант)
  function create_fa_stg (
    p_acct_id  in nasel_fa.acct_id%type,
    p_fa_pack_id in nasel_fa.fa_pack_id%type,
    p_saldo_uch in nasel_fa.saldo_uch%type,
    p_mtr_serial_nbr in nasel_fa.mtr_serial_nbr%type,
    p_end_reg_reading1 in nasel_fa.end_reg_reading1%type,
    p_end_reg_reading2 in nasel_fa.end_reg_reading2%type,
    p_fa_status_flg in nasel_fa.fa_status_flg%type
  ) return nasel_fa.fa_id%type; 

  procedure create_fa_pack_stg (acct_otdelen nasel_fa_pack.acct_otdelen%type);

  -- Добавляет лицевой в реестр
  -- В будущем переименовать create_fa_notice 
  -- Создает уведомление абоненту
  function create_fa (
    p_acct_id  in nasel_fa.acct_id%type,
    p_fa_pack_id in nasel_fa.fa_pack_id%type
  ) return nasel_fa.fa_id%type; 

  -- Создает заявку на отключение
  function create_fa_stop (
    p_acct_id  in nasel_fa.acct_id%type,
    p_fa_pack_id in nasel_fa.fa_pack_id%type
  ) return nasel_fa.fa_id%type; 


  -- Добавляет характеристку 'ST-P-DT' (плановая дата ввода ограничения) 
  -- в таблицу характеристик nasel_fa_char
  procedure set_fa_char_st_p_dt (
    p_fa_id nasel_fa.fa_id%type
  );

  -- Добавляет лицевой счет в пачку                               
  /*procedure add_fa_to_pack_stop (
    p_acct_id  IN nasel_fa.acct_id%type,
    p_fa_pack_id  IN nasel_fa.fa_pack_id%type
  );*/


  -- Добавляет характеристику к FA  
  procedure add_fa_char_str(
    p_fa_id IN nasel_fa_char.fa_id%type,
    p_fa_char_type_cd in nasel_fa_char.char_type_cd%type,
    p_fa_char_val_str in nasel_fa_char.char_val_str%type
  );
  -- Добавляет характеристику к FA  
  procedure add_fa_char_dttm(
    p_fa_id IN nasel_fa_char.fa_id%type,
    p_fa_char_type_cd in nasel_fa_char.char_type_cd%type,
    p_fa_char_val_dttm in nasel_fa_char.char_val_dttm%type
  );

     
  -- Устанавливает дату контакта
  /*procedure set_fa_cc_dttm(
    p_fa_id  IN nasel_fa.fa_id%type,
    p_cc_dttm IN nasel_fa.cc_dttm%type
     );*/  
        
   
  -- Добавляет контакт 
  function add_cc(
    p_cc_dttm  in out nasel_cc.cc_dttm%type,
    p_cc_type_cd  IN nasel_cc.cc_type_cd%type,
    p_cc_status_flg in nasel_cc.cc_status_flg%type,
    p_acct_id  IN nasel_cc.acct_id%type,
    p_descr  IN nasel_cc.descr%type,
    p_src_id  IN nasel_cc.src_id%type,
    p_src_type_cd  in nasel_cc.src_type_cd%type,
    p_caller  IN nasel_cc.caller%type
  ) return nasel_cc.cc_id%type;

  procedure update_cc (  
    p_cc_id in nasel_cc.cc_id%type,
    p_cc_dttm  in out nasel_cc.cc_dttm%type,
    p_cc_type_cd  IN nasel_cc.cc_type_cd%type,
    p_cc_status_flg in nasel_cc.cc_status_flg%type,
    p_descr  IN nasel_cc.descr%type,
    p_caller  in nasel_cc.caller%type  
  );
  procedure delete_cc (p_cc_id in nasel_cc.cc_id%type);
  procedure delete_fa_pack (p_fa_pack_id in nasel_fa_pack.fa_pack_id%type);
  procedure set_cc_status_flg(p_cc_id in nasel_cc.cc_id%type, p_cc_status_flg in nasel_cc.cc_status_flg%type);
  procedure set_cc_approval(p_cc_id in nasel_cc.cc_id%type);
  
  procedure add_fa_char_sa_e_dt;
  procedure create_fa_pack_cancel_stop;


  



  /* Процедуры, возвращающие набор данных */  
  procedure get_app_config(p_app_path in varchar2, p_app_ver in varchar2, rc out sys_refcursor);
  procedure get_acct_otdelen_list(rc out sys_refcursor);
  procedure get_op_area_cd_list(p_acct_otdelen in nasel_ccb_prem.acct_otdelen%type, rc out sys_refcursor);
  procedure get_fa_pack_type_list(rc out sys_refcursor);
  
  procedure get_fa_pack_inf(p_fa_pack_id in nasel_fa_pack.fa_pack_id%type, rc out sys_refcursor);
  procedure get_fa_cc_inf(p_cc_id in nasel_cc.cc_id%type, rc out sys_refcursor);
  
  procedure get_debtor_list(p_acct_otdelen in nasel_ccb_prem.acct_otdelen%type, rc out sys_refcursor);
  procedure get_post_list(p_acct_otdelen in nasel_ccb_prem.acct_otdelen%type, rc out sys_refcursor);
  procedure get_approval_list(p_acct_otdelen in nasel_ccb_prem.acct_otdelen%type, rc out sys_refcursor);
  procedure get_stop_list(p_acct_otdelen in nasel_ccb_prem.acct_otdelen%type, rc out sys_refcursor);
  procedure get_cancel_list(p_acct_otdelen in nasel_ccb_prem.acct_otdelen%type, rc out sys_refcursor);
  procedure get_fa_pack_notices(p_fa_pack_id in nasel_ccb_prem.acct_otdelen%type, rc out sys_refcursor);
  procedure get_fa_pack_stop(p_fa_pack_id in nasel_ccb_prem.acct_otdelen%type, rc out sys_refcursor);
  procedure get_fa_pack_stop_list(p_acct_otdelen in nasel_ccb_prem.acct_otdelen%type, rc out sys_refcursor);
  procedure get_fa_pack_notices_list(p_acct_otdelen in nasel_ccb_prem.acct_otdelen%type, rc out sys_refcursor);
  procedure get_fa_pack_cancel_stop_list(p_fa_pack_id in nasel_ccb_prem.acct_otdelen%type, rc out sys_refcursor);


end pk_nasel_sweety;
/
create or replace package body pk_nasel_sweety is

  -- Private type declarations
  /*type <TypeName> is <Datatype>;
  
  -- Private constant declarations
  <ConstantName> constant <Datatype> := <Value>;

  -- Private variable declarations
  <VariableName> <Datatype>;

  -- Function and procedure implementations
  function <FunctionName>(<Parameter> <Datatype>) return <Datatype> is
    <LocalVariable> <Datatype>;
  begin
    <Statement>;
    return(<Result>);
  end;*/



/* Процедуры для программы для работы с уведомлениями
*/
-- Добавляет пачку
function add_fa_pack(
  p_fa_pack_type_cd  IN nasel_fa_pack.fa_pack_type_cd%type,
  p_prnt_fa_pack_id  IN nasel_fa_pack.prnt_fa_pack_id%type,
  p_acct_otdelen in nasel_fa_pack.acct_otdelen%type
   )
  return nasel_fa_pack.fa_pack_id%type
is
begin
  return create_fa_pack(p_fa_pack_type_cd, p_prnt_fa_pack_id, p_acct_otdelen);
end;

-- Добавляет пачку
function create_fa_pack(
  p_fa_pack_type_cd  IN nasel_fa_pack.fa_pack_type_cd%type,
  p_prnt_fa_pack_id  IN nasel_fa_pack.prnt_fa_pack_id%type,
  p_acct_otdelen in nasel_fa_pack.acct_otdelen%type
   )
  return nasel_fa_pack.fa_pack_id%type
is
  v_fa_pack_id nasel_fa_pack.fa_pack_id%type;
begin
  select lpad(seq_nasel_fa_pack_id.nextval, 10, '0')
  into v_fa_pack_id
  from dual;
  
  insert into nasel_fa_pack (
    fa_pack_id
    , fa_pack_type_cd
    , prnt_fa_pack_id
    , acct_otdelen
    , fa_pack_status_flg
  )
  values (
    v_fa_pack_id
    , p_fa_pack_type_cd
    , p_prnt_fa_pack_id
    , p_acct_otdelen  
    , '10'
  ); 
  commit;
  return v_fa_pack_id; 
end create_fa_pack;


-- Устанавливает параметры получателя для реестра
procedure add_fa_pack_char_recipient(
  p_fa_pack_id in nasel_fa_pack_char.fa_pack_id%type,         -- реестр
  p_rt_spr_cd in nasel_fa_pack_char.char_val_str%type,        -- Код организации
  p_rt_spr in nasel_fa_pack_char.char_val_str%type,           -- Наименование организации
  p_rt_addr in nasel_fa_pack_char.char_val_str%type,          -- Адрес организации
  p_rt_post in nasel_fa_pack_char.char_val_str%type,          -- Должность 
  p_rt_name in nasel_fa_pack_char.char_val_str%type           -- ФИО
)
is
begin
  insert into nasel_fa_pack_char (
    fa_pack_id
    , char_type_cd
    , char_val_str
    , effdt
  )
  values (
    p_fa_pack_id
    , 'RT-SPRCD'
    , p_rt_spr_cd
    , sysdate
  ); 
  insert into nasel_fa_pack_char (
    fa_pack_id
    , char_type_cd
    , char_val_str
    , effdt
  )
  values (
    p_fa_pack_id
    , 'RT-SPR'
    , p_rt_spr
    , sysdate
  );
   
  insert into nasel_fa_pack_char (
    fa_pack_id
    , char_type_cd
    , char_val_str
    , effdt
  )
  values (
    p_fa_pack_id
    , 'RT-ADDR'
    , p_rt_addr
    , sysdate
  );
   
  insert into nasel_fa_pack_char (
    fa_pack_id
    , char_type_cd
    , char_val_str
    , effdt
  )
  values (
    p_fa_pack_id
    , 'RT-POST'
    , p_rt_post
    , sysdate
  ); 
  insert into nasel_fa_pack_char (
    fa_pack_id
    , char_type_cd
    , char_val_str
    , effdt
  )
  values (
    p_fa_pack_id
    , 'RT-NAME'
    , p_rt_name
    , sysdate
  ); 
  commit;
end;

procedure update_fa_pack_char_recipient(p_fa_pack_id in nasel_fa_pack_char.fa_pack_id%type)
is
  v_rt_spr_cd nasel_fa_pack_char.char_val_str%type;        -- Код поставщика услуг
  v_rt_spr nasel_fa_pack_char.char_val_str%type;           -- Наименование организации
  v_rt_addr nasel_fa_pack_char.char_val_str%type;          -- Адрес организации
  v_rt_post nasel_fa_pack_char.char_val_str%type;          -- Должность 
  v_rt_name nasel_fa_pack_char.char_val_str%type;           -- ФИО
begin
  select 
    first_acct.spr_cd
    , nvl(nasel_ccb_spr_l.descr,first_acct.spr_descr)
    , nasel_ccb_spr_l.address
    , padeg_pack.Padeg_FIO(nasel_ccb_spr_l.official_post, 'Д') official_post
    , padeg_pack.Padeg_FIO(nasel_ccb_spr_l.official_name, 'Д') official_name
  into 
    v_rt_spr_cd
    , v_rt_spr 
    , v_rt_addr
    , v_rt_post
    , v_rt_name
  from nasel_fa_pack

  left join
  (
    select 
      nasel_fa.fa_pack_id   
      , spr.descr spr_descr  
      , spr.spr_cd
      , row_number() over (partition by nasel_fa.fa_pack_id order by null) n  
      , count(nasel_fa.acct_id) over (partition by nasel_fa.fa_pack_id order by null) acct_id_cnt
    from nasel_fa
      
    left join (
      select        
        nasel_ccb_sa_rel.acct_id
        , nasel_ccb_spr.descr 
        , nasel_ccb_spr.spr_cd
        , row_number() over (partition by nasel_ccb_sa_rel.acct_id order by nasel_ccb_sa_rel.sa_rel_type_cd) n
      from nasel_ccb_sa_rel
      inner join nasel_ccb_spr on nasel_ccb_spr.spr_cd = nasel_ccb_sa_rel.spr_cd
    ) spr on spr.acct_id = nasel_fa.acct_id and spr.n = 1    
  ) first_acct on first_acct.fa_pack_id = nasel_fa_pack.fa_pack_id and first_acct.n = 1

  left join nasel_ccb_spr_l on nasel_ccb_spr_l.spr_cd = first_acct.spr_cd
  where nasel_fa_pack.fa_pack_id = p_fa_pack_id; 

  add_fa_pack_char_recipient(p_fa_pack_id, v_rt_spr_cd, v_rt_spr, v_rt_addr, v_rt_post, v_rt_name);
end;

-- Устанавливает флаг состояния для реестра fa_pack
procedure set_fa_pack_status_flg(
  p_fa_pack_id IN nasel_fa_pack_char.fa_pack_id%type,
  p_fa_pack_status_flg in nasel_fa_pack.fa_pack_status_flg%type
)
is
  update_failed exception; 
begin
  update nasel_fa_pack 
  set nasel_fa_pack.fa_pack_status_flg = p_fa_pack_status_flg
  where nasel_fa_pack.fa_pack_id = p_fa_pack_id;
 
  if (sql%rowcount > 0) then 
    commit;
  else 
    raise update_failed;
  end if;  
  
  exception 
    when update_failed then
      rollback; 
      raise_application_error(-20000, 'Не удалось найти реестр ID ' || p_fa_pack_id || '.'); 
  /*exception
   when NO_DATA_FOUND then
    raise_application_error(-20000, 'Не удалось найти реестра с ID ' || p_fa_pack_id || '.'); 
      dbms_output.put_line('Table name not found in query ');*/
end;

-- Утверждает (фиксирует) реестр
procedure set_fa_pack_status_flg_frozen(
  p_fa_pack_id in nasel_fa_pack.fa_pack_id%type
)
is
  v_fa_count integer;
begin
  select count(*)
  into v_fa_count
  from nasel_fa
  where nasel_fa.fa_pack_id = p_fa_pack_id; 
  
  if v_fa_count <> 0 then
    -- здесь сделать проверку на тип реестра
    --update_fa_pack_char_recipient(p_fa_pack_id); -- Добавляем характеристики адресата для реестра на ограничение - вынесено в клиентскую часть
    
    set_fa_pack_status_flg(p_fa_pack_id, '50'); 
  else
    raise_application_error(-20000, 'Нельзя утвердить реестр с ID ' || p_fa_pack_id || ' так как он пустой.'); 
  end if;
end;

-- Переводит реестр в статус Не завершен
/*procedure set_fa_pack_status_flg_incomp(
  p_fa_pack_id in nasel_fa_pack.fa_pack_id%type
)
is
  --v_fa_count integer;
begin
  set_fa_pack_status_flg(p_fa_pack_id, '10'); 
end;*/

-- Переводит реестр в статус Отменен
procedure set_fa_pack_status_flg_cancel(
  p_fa_pack_id in nasel_fa_pack.fa_pack_id%type
)
is
begin
  set_fa_pack_status_flg(p_fa_pack_id, '20'); 
end;


--
procedure add_fa_pack_char_str(
  p_fa_pack_id IN nasel_fa_pack_char.fa_pack_id%type,
  p_fa_pack_char_type_cd in nasel_fa_pack_char.char_type_cd%type,
  p_fa_pack_char_val_str in nasel_fa_pack_char.char_val_str%type
)
is
begin
  insert into nasel_fa_pack_char (
    fa_pack_id
    , char_type_cd
    , char_val_str
  )
  values (
    p_fa_pack_id
    , p_fa_pack_char_type_cd
    , p_fa_pack_char_val_str
  ); 
end add_fa_pack_char_str;

--
procedure add_fa_pack_char_dttm(
  p_fa_pack_id IN nasel_fa_pack_char.fa_pack_id%type,
  p_fa_pack_char_type_cd in nasel_fa_pack_char.char_type_cd%type,
  p_fa_pack_char_val_dttm in nasel_fa_pack_char.char_val_dttm%type
)
is
begin
  insert into nasel_fa_pack_char (
    fa_pack_id
    , char_type_cd
    , char_val_dttm
  )
  values (
    p_fa_pack_id
    , p_fa_pack_char_type_cd
    , p_fa_pack_char_val_dttm
  ); 
end add_fa_pack_char_dttm;

--
procedure add_fa_char_str(
  p_fa_id IN nasel_fa_char.fa_id%type,
  p_fa_char_type_cd in nasel_fa_char.char_type_cd%type,
  p_fa_char_val_str in nasel_fa_char.char_val_str%type
)
is
begin
  insert into nasel_fa_char (
    fa_id
    , char_type_cd
    , char_val_str
  )
  values (
    p_fa_id
    , p_fa_char_type_cd
    , p_fa_char_val_str
  ); 
end add_fa_char_str;

--
procedure add_fa_char_dttm(
  p_fa_id IN nasel_fa_char.fa_id%type,
  p_fa_char_type_cd in nasel_fa_char.char_type_cd%type,
  p_fa_char_val_dttm in nasel_fa_char.char_val_dttm%type
)
is
begin
  insert into nasel_fa_char (
    fa_id
    , char_type_cd
    , char_val_dttm
  )
  values (
    p_fa_id
    , p_fa_char_type_cd
    , p_fa_char_val_dttm
  ); 
end add_fa_char_dttm;



-- Добавляет лицевой счет в пачку
-- Эту функцию УДАЛИТЬ!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!                               
/*procedure add_fa_to_pack_stop (
  p_acct_id  IN nasel_fa.acct_id%type,
  p_fa_pack_id  IN nasel_fa.fa_pack_id%type
   )
is
  --v_pack_cre_dttm nasel_fa_pack.cre_dttm%type;
  v_st_p_dt nasel_fa_char.char_val_dttm%type;
  v_fa_id number;
begin
  add_fa(p_acct_id, p_fa_pack_id);
  
  -- Получаем номер созданного field Activity 
  --v_fa_id := SEQ_NASEL_FA_ID.currval;
  select SEQ_NASEL_FA_ID.currval
  into v_fa_id
  from dual;

  -- Вычисляем плановую дату ввода ограничения
  select greatest (
    (
      select nasel_fa_pack.cre_dttm + 10
      from nasel_fa_pack
      where nasel_fa_pack.fa_pack_id = p_fa_pack_id
    ),
    (
      select max(cc_dttm) + 30 
      from nasel_cc 
      where acct_id = p_acct_id and approval_dttm is not null
    )
  )
  into v_st_p_dt
  from dual; 
  
  -- Добавляем плановую дату к созданной заявке
  add_fa_char_dttm(lpad(v_fa_id, 10, '0'), 'ST-P-DT', trunc(v_st_p_dt,'dd'));

end add_fa_to_pack_stop;*/

-- Добавляет характеристку 'ST-P-DT' (плановая дата ввода ограничения) 
-- в таблицу характеристик nasel_fa_char
procedure set_fa_char_st_p_dt (
  p_fa_id nasel_fa.fa_id%type
)
is
  v_st_p_dt nasel_fa_char.char_val_dttm%type;
begin
  -- Вычисляем плановую дату ввода ограничения
  select 
    trunc(
      greatest(
        nvl(cc.cc_dttm + 30, to_date(1721424,'J'))
        , nasel_fa_pack.cre_dttm + 11
      ), 'dd')
  into v_st_p_dt
  from nasel_fa
  left join nasel_fa_pack on nasel_fa_pack.fa_pack_id = nasel_fa.fa_pack_id
  left join (
    select 
      nasel_cc.acct_id
      , max(nasel_cc.cc_dttm) cc_dttm
    from nasel_cc 
    where approval_dttm is not null
    group by nasel_cc.acct_id
  ) cc on cc.acct_id = nasel_fa.acct_id 
  where nasel_fa.fa_id = p_fa_id;--'0000009922'
  
  -- Вычисляем первый рабочий день, если дата попала на выходной
  select
    min(nasel_cal_work.day_dt)
  into v_st_p_dt
  from nasel_cal_work 
  where day_type_cd <> 'H' and day_dt >= v_st_p_dt;
  
  -- Добавляем плановую дату к созданной заявке
  add_fa_char_dttm(p_fa_id, 'ST-P-DT', v_st_p_dt);
end;




-- Устанавливает флаг состояния для Деятельности fa
procedure set_fa_status_flg(
  p_fa_id IN nasel_fa.fa_id%type,
  p_fa_status_flg in nasel_fa.fa_status_flg%type
)
is
  update_failed exception; 
begin
  update nasel_fa 
  set nasel_fa.fa_status_flg = p_fa_status_flg
  where nasel_fa.fa_id = p_fa_id;
 
  if (sql%rowcount > 0) then 
    commit;
  else 
    raise update_failed;
  end if;  
  
  exception 
    when update_failed then
      rollback; 
      raise_application_error(-20000, 'Не удалось найти ДМ ID ' || p_fa_id || '.'); 
  /*exception
   when NO_DATA_FOUND then
    raise_application_error(-20000, 'Не удалось найти реестра с ID ' || p_fa_pack_id || '.'); 
      dbms_output.put_line('Table name not found in query ');*/
end;

-- Создает деятельность по лицевому счету и добавляет ее в реестр (ручной вариант)
function create_fa_stg (
  p_acct_id  in nasel_fa.acct_id%type,
  p_fa_pack_id in nasel_fa.fa_pack_id%type,
  p_saldo_uch in nasel_fa.saldo_uch%type,
  p_mtr_serial_nbr in nasel_fa.mtr_serial_nbr%type,
  p_end_reg_reading1 in nasel_fa.end_reg_reading1%type,
  p_end_reg_reading2 in nasel_fa.end_reg_reading2%type,
  p_fa_status_flg in nasel_fa.fa_status_flg%type
) return nasel_fa.fa_id%type 
is
  v_fa_id nasel_fa.fa_id%type;
begin
  insert into nasel_fa (
    acct_id
    , fa_pack_id
    , saldo_uch
    , mtr_serial_nbr
    , end_reg_reading1
    , end_reg_reading2
    , fa_status_flg
  )
  values (
    p_acct_id
    , p_fa_pack_id
    , p_saldo_uch
    , p_mtr_serial_nbr
    , p_end_reg_reading1
    , p_end_reg_reading2
    , p_fa_status_flg
  ) 
  returning fa_id into v_fa_id;
  commit;
  
  DBMS_OUTPUT.put_line('FA ' || to_char(v_fa_id) || 
                           ' (acct_id: ' || to_char(p_acct_id) || ') added to PACK: ' || to_char(p_fa_pack_id));
  
  return v_fa_id;
end create_fa_stg;


procedure create_fa_pack_stg (acct_otdelen nasel_fa_pack.acct_otdelen%type)
is
  v_fa_pack_id nasel_fa_pack.fa_pack_id%type;
  v_fa_id nasel_fa.fa_id%type;
  
  cursor p_cursor is 
  select * from joiner_stgup;
  
  v_res p_cursor%rowtype;
  
begin
  
  v_fa_pack_id := pk_nasel_sweety.create_fa_pack('10',null, acct_otdelen);
  
  --v_fa_pack_id := '0000002222';

  for v_res in p_cursor
  loop
    v_fa_id := pk_nasel_sweety.create_fa_stg(
      lpad(v_res.F1,10,'0')      -- acct_id
      , v_fa_pack_id                        -- fa_pack_id
      , to_number(v_res.F2, '999999999.99') -- saldo_uch
      , ''                                  -- mtr_serial_nbr
      , to_number(v_res.F3, '999999999.99') -- end_reg_reading1
      , to_number(v_res.F4, '999999999.99') -- end_reg_reading2
      , null);
  end loop;

  pk_nasel_sweety.set_fa_pack_status_flg_frozen(v_fa_pack_id);

end create_fa_pack_stg;


-- Создает деятельность по лицевому счету и добавляет ее в реестр
function create_fa (
  p_acct_id  in nasel_fa.acct_id%type,
  p_fa_pack_id in nasel_fa.fa_pack_id%type
) return nasel_fa.fa_id%type 
is
  v_fa_id nasel_fa.fa_id%type; 
  insert_failed exception; 
  --v_fa_pack_status_flg nasel_fa_pack.fa_pack_status_flg%type;  
  --fa_pack_closed exception;   
  --fa_pack_not_found exception;
begin
  /*insert into nasel_fa (acct_id, fa_pack_id)
  values (p_acct_id, p_fa_pack_id); */   
                     
  /*greatest(1,2)
  select p_fa_pack_id
  into
  from nasel_fa_pack;  */
  
  /*select fa_pack_status_flg
  into v_fa_pack_status_flg
  from nasel_fa_pack
  where nasel_fa_pack.fa_pack_id = p_fa_pack_id;
  
  if (v_fa_pack_status_flg = '50') then -- Нельзя добавлять в реестр в статусе Утвержден
    raise fa_pack_closed;
  end if;*/
  
  insert into nasel_fa (
    acct_id
    , fa_pack_id
    , saldo_uch
    , mtr_serial_nbr
    , end_reg_reading1
    , end_reg_reading2
  )
  select 
    p_acct_id
    , p_fa_pack_id 
    , nvl(nasel_ccb_ft.saldo_bt_uch, 0) + nvl(nasel_ccb_ft.saldo_odn_uch, 0) + nvl(nasel_ccb_ft.saldo_act_uch, 0) + nvl(nasel_ccb_ft.saldo_pen_uch, 0)  saldo_uch
    , nasel_ccb_sp.mtr_serial_nbr
    , nasel_ccb_bseg_read.end_reg_reading1
    , nasel_ccb_bseg_read.end_reg_reading2
  from nasel_ccb_ft
  left join nasel_ccb_bseg_read on nasel_ccb_bseg_read.acct_id = nasel_ccb_ft.acct_id
  left join nasel_ccb_sp on nasel_ccb_sp.acct_id = nasel_ccb_ft.acct_id
  where nasel_ccb_ft.acct_id = p_acct_id;
    
      
  if (sql%rowcount > 0) then 
    commit;
    select lpad(SEQ_NASEL_FA_ID.currval, 10, '0')
    into v_fa_id
    from dual;
  else 
    raise insert_failed;
  end if;  
  
  return v_fa_id;

  exception 
    when insert_failed then
      raise_application_error(-20000, 'Добавление в реестр не произведено.'); 
  
  

 /* if (sql%rowcount > 0) then 
    commit;
    return v_fa_id;
  else 
    raise fa_pack_not_found;
  end if;  */

  /*exception 
    when fa_pack_closed then
      rollback; 
      raise_application_error(-20001, 'Реестр с ID ' || p_fa_pack_id || ' находится в статусе ''Утвержден''. Добавление в него дополнительных объектов запрещено.'); 
    when fa_pack_not_found then
      rollback; 
      raise_application_error(-20000, 'Не удалось найти реестра с ID ' || p_fa_pack_id || '.'); 
 */ 
end create_fa;



-- Создает деятельность по лицевому счету и добавляет ее в реестр
function create_fa_stop (
  p_acct_id  in nasel_fa.acct_id%type,
  p_fa_pack_id in nasel_fa.fa_pack_id%type
) return nasel_fa.fa_id%type 
is
  v_fa_id nasel_fa.fa_id%type;
  v_fa_notice nasel_fa.fa_id%type; 
  insert_failed exception; 
  --v_fa_pack_status_flg nasel_fa_pack.fa_pack_status_flg%type;  
  --fa_pack_closed exception;   
  --fa_pack_not_found exception;
begin
  insert into nasel_fa (
    acct_id
    , fa_pack_id
    , saldo_uch
    , mtr_serial_nbr
    , end_reg_reading1
    , end_reg_reading2
  )
  select 
    p_acct_id
    , p_fa_pack_id 
    , nvl(nasel_ccb_ft.saldo_bt_uch, 0) + nvl(nasel_ccb_ft.saldo_odn_uch, 0) + nvl(nasel_ccb_ft.saldo_act_uch, 0) + nvl(nasel_ccb_ft.saldo_pen_uch, 0)  saldo_uch
    , nasel_ccb_sp.mtr_serial_nbr
    , nasel_ccb_bseg_read.end_reg_reading1
    , nasel_ccb_bseg_read.end_reg_reading2
  from nasel_ccb_ft
  left join nasel_ccb_bseg_read on nasel_ccb_bseg_read.acct_id = nasel_ccb_ft.acct_id
  left join nasel_ccb_sp on nasel_ccb_sp.acct_id = nasel_ccb_ft.acct_id
  where nasel_ccb_ft.acct_id = p_acct_id;
    
      
  if (sql%rowcount > 0) then 
    commit;
    select lpad(SEQ_NASEL_FA_ID.currval, 10, '0')
    into v_fa_id
    from dual;
  else 
    raise insert_failed;
  end if;  
  
  -- Добавляем характеристику ST-P-DT - Плановая дата отключения
  set_fa_char_st_p_dt(v_fa_id);
  
  -- Добавляем характеристику PRNT-FA
  select
    fa_notice.fa_id
  into
    v_fa_notice 
  from (
    select 
      nasel_fa.fa_pack_id
      --, nasel_fa_pack.fa_pack_type_cd
      --, nasel_fa_pack.cre_dttm
      --, nasel_fa_pack.user_id
      , nasel_fa.acct_id
      , nasel_fa.fa_id
      --, nasel_cc.approval_dttm
      ---, nasel_cc.cc_dttm
      , row_number() over (partition by nasel_fa.acct_id order by nasel_fa_pack.cre_dttm desc) N
    from nasel_fa
    inner join nasel_fa_pack on nasel_fa_pack.fa_pack_id = nasel_fa.fa_pack_id 
      and nasel_fa_pack.fa_pack_type_cd in ('10','20') 
      and nasel_fa_pack.fa_pack_status_flg = '50'
    inner join nasel_cc on nasel_cc.src_id = nasel_fa.fa_id 
      and nasel_cc.src_type_cd = '10' 
      and nasel_cc.approval_dttm is not null
  ) fa_notice where fa_notice.acct_id = p_acct_id and fa_notice.n = 1;
  
   -- Добавляем плановую дату к созданной заявке
  add_fa_char_str(v_fa_id, 'PRNT-FA', v_fa_notice); 
  
  commit;
  
  return v_fa_id;

  exception 
    when insert_failed then
      raise_application_error(-20000, 'Добавление в реестр не произведено.'); 
  
end create_fa_stop;



/*procedure set_fa_cc_dttm(
  p_fa_id  IN nasel_fa.fa_id%type,
  p_cc_dttm IN nasel_fa.cc_dttm%type
   )
is
begin
  update nasel_fa set nasel_fa.cc_dttm = p_cc_dttm
  where nasel_fa.fa_id = p_fa_id;
  commit;
end;*/


-- Задает статус контакта с абонентом
procedure set_cc_status_flg( 
  p_cc_id in nasel_cc.cc_id%type,
  p_cc_status_flg in nasel_cc.cc_status_flg%type
)
is
begin
  update nasel_cc set nasel_cc.cc_status_flg = p_cc_status_flg
  where nasel_cc.cc_id = p_cc_id;
  commit;
end;


-- Задает дату утверждения
-- Или, иначе, утверждает контакт.
procedure set_cc_approval( 
  p_cc_id in nasel_cc.cc_id%type
)
is
begin
  update nasel_cc set nasel_cc.approval_dttm = sysdate
--    , nasel_cc.approver_user_id = substr(sys_context('USERENV','SESSION_USER'),1,10)
  where nasel_cc.cc_id = p_cc_id
    and trim(nasel_cc.cc_status_flg) = '20' -- Если контакт успешен
    and nasel_cc.approval_dttm is null;    -- Если контакт еще не утвержден
  commit;
end;

-- Удаляет контакт
procedure delete_cc (p_cc_id in nasel_cc.cc_id%type)
is
  v_cc_id nasel_cc.cc_id%type;
  v_approval_dttm nasel_cc.approval_dttm%type;
begin
  select nasel_cc.cc_id, nasel_cc.approval_dttm
  into v_cc_id, v_approval_dttm  
  from nasel_cc 
  where nasel_cc.cc_id = p_cc_id; 
  
  if v_approval_dttm is not null then
    raise_application_error(-20000, 'Контакт с ID ' || p_cc_id || ' уже утвержден. Вы не можете его удалить.'); 
  else
    delete from nasel_cc where nasel_cc.cc_id = p_cc_id;
    commit; 
  end if;
end;

-- Вносит изменения в параметры контакта
procedure update_cc (  
  p_cc_id in nasel_cc.cc_id%type,
  p_cc_dttm in out nasel_cc.cc_dttm%type,
  p_cc_type_cd  IN nasel_cc.cc_type_cd%type,
  p_cc_status_flg in nasel_cc.cc_status_flg%type,
  p_descr  IN nasel_cc.descr%type,
  p_caller  in nasel_cc.caller%type  
) 
is
  v_cc_id nasel_cc.cc_id%type;
  v_approval_dttm nasel_cc.approval_dttm%type;
begin
  select nasel_cc.cc_id
    , nasel_cc.approval_dttm
  into v_cc_id
    , v_approval_dttm  
  from nasel_cc 
  where nasel_cc.cc_id = p_cc_id; 
  
  if v_approval_dttm is not null then
    raise_application_error(-20000, 'Контакт с ID ' || p_cc_id || ' уже утвержден. Вы не можете его изменить.'); 
  end if;
  
  -- Если есть ранее созданный контакт, тогда обновляем информацию 
  if v_cc_id is not null then
    update nasel_cc 
    set nasel_cc.cc_dttm = p_cc_dttm 
      , nasel_cc.cc_type_cd = p_cc_type_cd
      , nasel_cc.cc_status_flg = p_cc_status_flg 
      , nasel_cc.descr = p_descr
      , nasel_cc.caller = p_caller 
    where nasel_cc.cc_id = p_cc_id; 
    commit;  
  else
    raise_application_error(-20001, 'Контакт с ID ' || p_cc_id || ' не найден'); 
  end if;
end;

-- Добавляет контакт с абонентом
function add_cc (
  p_cc_dttm  in out nasel_cc.cc_dttm%type,
  p_cc_type_cd  IN nasel_cc.cc_type_cd%type,
  p_cc_status_flg in nasel_cc.cc_status_flg%type,
  p_acct_id  IN nasel_cc.acct_id%type,
  p_descr  IN nasel_cc.descr%type,
  p_src_id  IN nasel_cc.src_id%type,
  p_src_type_cd  IN nasel_cc.src_type_cd%type,
  p_caller  in nasel_cc.caller%type
) return nasel_cc.cc_id%type  
is
  cc_count integer;
  v_cc_id nasel_cc.cc_id%type; 
begin
 
  -- Если тип источника - Реестр должников, тогда ищем ранее созданый контакт
  /*if p_src_type_cd = '10' && p_cc_id is not null then
    select nasel_cc.cc_id
    into v_cc_id 
    from nasel_cc 
    where nasel_cc.src_id = p_src_id and nasel_cc.src_type_cd = '10';
  end if;*/
  
  if p_src_type_cd = '10' then
    select 
      count(*) 
    into cc_count 
    from nasel_cc 
    where nasel_cc.src_type_cd = '10' 
      and nasel_cc.src_id = p_src_id;    
  end if;      
  
 -- raise_application_error(-20000, 'Тест ' || p_src_id || ' - ' || cc_count || '  < ' ); 

  
  if nvl(cc_count, 0) = 0 then 
    -- Создаем новый контакт
    insert into nasel_cc (
      cc_dttm, cc_type_cd, cc_status_flg, acct_id, descr, src_id, src_type_cd, caller
    )
    values (
      p_cc_dttm, p_cc_type_cd, p_cc_status_flg, p_acct_id, p_descr, p_src_id, p_src_type_cd, p_caller
    ) returning cc_id into v_cc_id; 
      
    commit; 
  end if;   
    
  return v_cc_id;
end; 


-- Удаляет контакт
procedure delete_fa_pack (p_fa_pack_id in nasel_fa_pack.fa_pack_id%type)
is
begin
  delete from nasel_fa_pack where nasel_fa_pack.fa_pack_id = p_fa_pack_id;
  commit;
  /*select nasel_cc.cc_id, nasel_cc.approval_dttm
  into v_cc_id, v_approval_dttm  
  from nasel_cc 
  where nasel_cc.cc_id = p_cc_id; 
  
  if v_approval_dttm is not null then
    raise_application_error(-20000, 'Контакт с ID ' || p_cc_id || ' уже утвержден. Вы не можете его удалить.'); 
  else
    delete from nasel_cc where nasel_cc.cc_id = p_cc_id;
    commit; 
  end if;*/
end;


-- Процедура для автоматического выполнения
-- Проставляет характеристику SA-E-DT (дату отключения РДО) для абонентов на отключении
-- Важно! Возможно следует проверять, есть ли заявки на возобновление.
-- Возможно следует брать только последнюю заявку на отключение. Внесено.
procedure add_fa_char_sa_e_dt
  is
begin
  insert 
  into nasel_fa_char(
    nasel_fa_char.fa_id
    , nasel_fa_char.char_type_cd
    , nasel_fa_char.char_val_dttm
    , nasel_fa_char.effdt
  )
  select fa.fa_id
    , 'SA-E-DT' 
    , nasel_ccb_sp.sa_end_dt 
    , sysdate
  from nasel_ccb_sp
  
  -- Последнее ДМ из заявки на отключение
  inner join (
    select 
      nasel_fa.acct_id
      , nasel_fa.fa_id
      , row_number() over (partition by nasel_fa.fa_id order by nasel_fa_pack.cre_dttm) n
    from nasel_fa_pack
    inner join nasel_fa on nasel_fa.fa_pack_id = nasel_fa_pack.fa_pack_id
    where nasel_fa_pack.fa_pack_type_cd = '40' and nasel_fa_pack.fa_pack_status_flg = '50'
  ) fa on fa.acct_id = nasel_ccb_sp.acct_id and fa.n = 1
 
  left join (
    select
      nasel_fa_char.fa_id
      , nasel_fa_char.char_val_dttm sa_e_dt
    from nasel_fa_char
    where nasel_fa_char.char_type_cd = 'SA-E-DT'
  ) fa_char on fa_char.fa_id = fa.fa_id
  
  where nasel_ccb_sp.sa_status_flg in ('40','60') and nasel_ccb_sp.sa_end_dt is not null and fa_char.sa_e_dt is null;

  commit;  
  /*select nasel_fa.fa_id
    , 'SA-E-DT' 
    , nasel_ccb_sp.sa_end_dt 
    , sysdate
  from nasel_fa_pack
  inner join nasel_fa on nasel_fa.fa_pack_id = nasel_fa_pack.fa_pack_id
  left join (
    select
      nasel_fa_char.fa_id
      , nasel_fa_char.char_val_dttm sa_e_dt
    from nasel_fa_char
    where nasel_fa_char.char_type_cd = 'SA-E-DT'
  ) fa_char on fa_char.fa_id = nasel_fa.fa_id
  inner join nasel_ccb_sp on nasel_ccb_sp.acct_id = nasel_fa.acct_id and nasel_ccb_sp.sa_end_dt is not null 
  where nasel_fa_pack.fa_pack_type_cd = '40' and nasel_fa_pack.fa_pack_status_flg = '50'
    and fa_char.sa_e_dt is null;*/
end;

-- Процедура для автоматического выполнения
-- Создает реестр на отмену заявок на ограничение
-- При добавлении заявок в реестр, устанавливает параметр создаваемой заявки в 'PRNT-FA' = значению отменяемой заявки
-- Меняет значение fa_status_flg отменяемой заявки на 60 (Отменено)
procedure create_fa_pack_cancel_stop
  is
  cursor p_cursor is 
  select nasel_ccb_prem.acct_id
    , nasel_ccb_prem.acct_otdelen
    , fa.fa_id
    --, fa.fa_pack_id
  
    , dense_rank() over (order by  nasel_ccb_prem.acct_otdelen, nasel_ccb_spr.spr_cd) fa_pack_index   

  from nasel_ccb_sp
  inner join nasel_ccb_prem on nasel_ccb_prem.acct_id = nasel_ccb_sp.acct_id
  inner join nasel_ccb_sa_rel on nasel_ccb_sa_rel.acct_id = nasel_ccb_sp.acct_id
  inner join nasel_ccb_spr on nasel_ccb_spr.spr_cd = nasel_ccb_sa_rel.spr_cd
  
  -- Последнее ДМ из заявки на отключение
  inner join (
    select 
      nasel_fa.acct_id
      , nasel_fa.fa_id
      , nasel_fa_pack.cre_dttm
      , nasel_fa_pack.fa_pack_id
      , row_number() over (partition by nasel_fa.fa_id order by nasel_fa_pack.cre_dttm) n
    from nasel_fa_pack
    inner join nasel_fa on nasel_fa.fa_pack_id = nasel_fa_pack.fa_pack_id and nasel_fa.fa_status_flg = '20'
    where nasel_fa_pack.fa_pack_type_cd = '40' and nasel_fa_pack.fa_pack_status_flg = '50'
  ) fa on fa.acct_id = nasel_ccb_sp.acct_id and fa.n = 1
  
  left join nasel_fa_pack fa_pack_cancel on fa_pack_cancel.prnt_fa_pack_id = fa.fa_pack_id 
    and fa_pack_cancel.fa_pack_type_cd = '45' and fa_pack_cancel.fa_pack_status_flg = '50'
  
  inner join (
    select 
      nasel_ccb_ft.acct_id
      , nasel_ccb_ft.uch_begin_dt
      , nvl(nasel_ccb_ft.bill_bt_otch, 0) + nvl(nasel_ccb_ft.bill_odn_otch, 0) 
        + nvl(nasel_ccb_ft.bill_act_otch, 0) + nvl(nasel_ccb_ft.bill_pen_otch, 0) nach_otch
      , nvl(nasel_ccb_ft.saldo_bt_uch,0) + nvl(nasel_ccb_ft.saldo_odn_uch,0) 
        + nvl(nasel_ccb_ft.saldo_act_uch,0) + nvl(nasel_ccb_ft.saldo_pen_uch,0) saldo_uch
    from nasel_ccb_ft
  ) ccb_ft on ccb_ft.acct_id = nasel_ccb_prem.acct_id
 
  left join (
    select        
      nasel_ccb_sa_rel.acct_id
      , nasel_ccb_spr.descr
      , row_number() over (partition by nasel_ccb_sa_rel.acct_id order by nasel_ccb_sa_rel.sa_rel_type_cd) n
    from nasel_ccb_sa_rel
    inner join nasel_ccb_spr on nasel_ccb_spr.spr_cd = nasel_ccb_sa_rel.spr_cd
  ) spr on spr.acct_id = nasel_ccb_sp.acct_id and spr.n = 1

  -- Реструктуризация ДЗ
  left join nasel_ccb_pp on nasel_ccb_pp.acct_id = nasel_ccb_prem.acct_id and nasel_ccb_pp.pp_stat_flg = '20'
 
  where ccb_ft.saldo_uch - ccb_ft.nach_otch - nvl(nasel_ccb_pp.pp_tot_sched_amt,0) <= 0
    and fa_pack_cancel.fa_pack_id is null  -- только те, по которым еще не созданы заявки на отмену
  
    --and nasel_ccb_prem.acct_id in ('2010170000','2324070000','2912270000')
  
  order by acct_otdelen, nasel_ccb_spr.spr_cd;
  
  v_res p_cursor%rowtype;
  
  v_fa_pack_id nasel_fa_pack.fa_pack_id%type;
  v_fa_pack_index number;  -- Индекс группы для разделения на реестры
  v_fa_id nasel_fa.fa_id%type;
begin
  DBMS_OUTPUT.enable;
  
  v_fa_pack_id := null;
  v_fa_pack_index := 0;
  for v_res in p_cursor
  loop
    if v_fa_pack_index <> v_res.fa_pack_index then -- Создаем реестр
      if (v_fa_pack_id is not null) then
        set_fa_pack_status_flg_frozen(v_fa_pack_id);  -- Фиксируем заполненный Реестр
        DBMS_OUTPUT.put_line('FA_PACK frozen: ' || to_char(v_fa_pack_id));
      end if;
      v_fa_pack_id := create_fa_pack('45', null, v_res.acct_otdelen);
      v_fa_pack_index := v_res.fa_pack_index;
      DBMS_OUTPUT.put_line('FA_PACK created: ' || to_char(v_fa_pack_id));
    end if;
    
    -- Добавляем в реестр абонентов
    v_fa_id := create_fa(v_res.acct_id, v_fa_pack_id);
    set_fa_status_flg(v_fa_id, '20');
    add_fa_char_str(v_fa_id, 'PRNT-FA',v_res.fa_id);
    set_fa_status_flg(v_res.fa_id, '60');
    
    DBMS_OUTPUT.put_line('FA ' || to_char(v_fa_id) || ' (acct_id: ' || to_char(v_res.acct_id) || 
                             ') added to PACK: ' || to_char(v_fa_pack_id) 
                        );
  end loop;
  
  if (v_fa_pack_id is not null) then
    set_fa_pack_status_flg_frozen(v_fa_pack_id);  -- Фиксируем последний созданный Реестр
       DBMS_OUTPUT.put_line('FA_PACK frozen: ' || to_char(v_fa_pack_id));
  end if;
end;








 

/*************************************
**************************************/


-- Общая конфигурационная информация
procedure get_app_config(p_app_path in varchar2, p_app_ver in varchar2, rc out sys_refcursor)
is
begin
  open rc for 
  select
    t.*
    , case when to_date(p_app_ver, 'yyyymmddhh24miss') < to_date(min_app_ver, 'yyyymmddhh24miss') then 0 else 1 end allowed
  from(
    
    select sysdate
      , p_app_path app_path
      , p_app_path || 'report\' report_path
      , p_app_path || 'report\visa\' visa_path
      --, :app_path || 'report\template_document_notice.dotx'
      , sys_context('USERENV','SESSION_USER') username
      , 20170510 min_app_ver                  -- Минимально допустимая версия
      , 20991231 max_app_ver                  -- Максимально допустимая версия
    from dual
  ) t;
  
  /*update rc 
  set rc.allowed = 2;*/
  --where nasel_fa_pack.fa_pack_id = p_fa_pack_id;
end;

/* Список отделений */
procedure get_acct_otdelen_list(rc out sys_refcursor)
is
begin
  open rc for 
  -- Общая информация по участкам
  select nasel_uch.fname otdelen_descr 
    , nasel_uch.acct_otdelen
    , raion.address
    , raion.nachalnik
    , raion.phone
    , raion.ccb_acct_char_val
    --, :app_path || 'report\visa\'|| raion.nachalnik || '.png' visa
    , substr(trim(raion.FNAME),1,length(trim(raion.FNAME))-2) || 'ого участка'  post
    , nasel_uch.descr_l 
   
  from acc_grp_dar
  inner join spr_users on spr_users.access_grp_cd = acc_grp_dar.access_grp_cd
  inner join nasel_uch on nasel_uch.dar_cd = acc_grp_dar.dar_cd

  inner join raion on raion.id = nasel_uch.id_rn
  --where name_u = 'U062000'
  where name_u = sys_context('USERENV','SESSION_USER');
end;



/* Возвращает список контролеров */
procedure get_op_area_cd_list(p_acct_otdelen in nasel_ccb_prem.acct_otdelen%type, rc out sys_refcursor)
is
begin
  open rc for 
    select nasel_ccb_sp.op_area_cd
      , initcap(nasel_ccb_sp.op_area_descr) op_area_descr
      , nasel_ccb_prem.acct_otdelen  
    from nasel_ccb_prem
    inner join nasel_ccb_sp on nasel_ccb_sp.acct_id = nasel_ccb_prem.acct_id
    where nasel_ccb_prem.acct_otdelen = p_acct_otdelen
    group by op_area_cd, nasel_ccb_sp.op_area_descr, nasel_ccb_prem.acct_otdelen
    order by op_area_descr;
end;

/* Возвращает список типов реестров */
procedure get_fa_pack_type_list(rc out sys_refcursor)
is
begin
  open rc for 
  select 
    nasel_lookup_val.field_value fa_pack_type_cd
    , nasel_lookup_val.descr
  from nasel_lookup_val
  where field_name = 'FA_PACK_TYPE_CD'
    and eff_status = 'A';
end;



/* Возвращает информацию по реестру */
procedure get_fa_pack_inf(p_fa_pack_id in nasel_fa_pack.fa_pack_id%type, rc out sys_refcursor)
is
begin
  open rc for
  select
    /*rownum
    , sysdate*/
    t.cre_dttm
    , t.acct_otdelen
    , t.fa_pack_id
    , t.fa_count
    
    --, t.acct_otdelen_descr
    --, t.address
    --, t.post
    --, t.phone
    --, t.nachalnik  
    --, t.visa

  from (
    select
      nasel_fa_pack.* 
      , nasel_uch.fname
      , raion.fname acct_otdelen_descr
      , raion.address
      , raion.nachalnik
      , raion.phone
      , raion.ccb_acct_char_val       
      --, :app_path || 'report\visa\'|| raion.nachalnik || '.png' visa
      --, substr(trim(raion.FNAME),1,length(trim(raion.FNAME))-2) || 'ого участка'  post
      , fa.fa_count
    from nasel_fa_pack
    left join nasel_uch on nasel_uch.acct_otdelen = nasel_fa_pack.acct_otdelen
    left join raion on raion.id = nasel_uch.id_rn

    left join (    
      select
        nasel_fa.fa_pack_id
        , count(*) fa_count 
      from nasel_fa
      group by nasel_fa.fa_pack_id
    ) fa on fa.fa_pack_id = nasel_fa_pack.fa_pack_id
   
    where nasel_fa_pack.fa_pack_id = p_fa_pack_id --'0000000416'
    order by nasel_fa_pack.cre_dttm desc 
  ) t;
end;

/* Возвращает информацию по контакту */
procedure get_fa_cc_inf(p_cc_id in nasel_cc.cc_id%type, rc out sys_refcursor)
is
begin
  open rc for
  select
    *
  from nasel_cc
  where nasel_cc.cc_id = p_cc_id;
end;

/* Список должников */
procedure get_debtor_list(p_acct_otdelen in nasel_ccb_prem.acct_otdelen%type, rc out sys_refcursor)
is
begin
  open rc for 
-- Все должники
-- 2017-02-16
-- автор: ВСОвчинников
-- Е.В.Назаров
--
-- Условия
-- 1. Точка учета в статусе установлена (20)
-- 2. saldo_uch > normativ * 2 and saldo_m3 > normativ * 2
-- 3. Дата последнего утвержденного контакта более 6 месяцев или пустая
-- 4. Дата последнего уведомления более 2 месяцев или пустая

select
  rownum 
  , 0 CHECK_DATA 
  , acct_id  
  , initcap(fio) fio   
  , city
  , address 
  , prem_type_descr

  , saldo_uch 
  , saldo_m3 
  , cc_dttm  
  , fa_id
  , fa_pack_id
  , cre_dttm 
  , acct_otdelen
  , service_org

  , op_area_descr
   
from (
  select
    nasel_ccb_prem.acct_id  
    , nasel_ccb_prem.acct_otdelen
    , nasel_ccb_prem.fio   
    , nasel_ccb_prem.city
    , nasel_ccb_prem.ulitsa || nvl2(nasel_ccb_prem.dom, ', д. '  || nasel_ccb_prem.dom,'') || nvl2(nasel_ccb_prem.korp, ', корп. '  || nasel_ccb_prem.korp,'') || nvl2(nasel_ccb_prem.kvartira, ', кв. '  || nasel_ccb_prem.kvartira,'') address
    , (select descr from nasel_lookup_val where field_name = 'PREM_TYPE_CD' and field_value = nasel_ccb_prem.prem_type_cd) prem_type_descr
    , nvl(ccb_ft.bill_otch, 0) bill_otch
    --, nvl(nasel_ccb_ft.saldo_bt_uch, 0) + nvl(nasel_ccb_ft.saldo_odn_uch, 0) + nvl(nasel_ccb_ft.saldo_act_uch, 0) saldo_uch
    , ccb_ft.saldo_uch
    , ccb_ft_hist.saldo_m3
    --, nvl(nasel_ccb_ft_hist.saldo_bt_uch, 0) + nvl(nasel_ccb_ft_hist.saldo_odn_uch, 0) + nvl(nasel_ccb_ft_hist.saldo_act_uch, 0) saldo_m3
    --, nasel_ccb_ft_hist.saldo_odn_uch
      
    , last_cc.cc_dttm
    , last_cc.cc_id
    , last_fa.fa_id
    , last_fa.fa_pack_id
    , last_fa.cre_dttm 
    , nasel_ccb_spr.descr service_org
    , nasel_ccb_sp.op_area_descr
    , nasel_ccb_sp.fl_tar11
    , nasel_calc.norm_amt

  from nasel_ccb_prem

  inner join nasel_ccb_sp on nasel_ccb_sp.acct_id = nasel_ccb_prem.acct_id and nasel_ccb_sp.sa_status_flg in ('20')
  
  
  --left join nasel_ccb_ft on nasel_ccb_ft.acct_id = nasel_ccb_prem.acct_id --and nasel_ccb_ft_hist.calc_dt = trunc(add_months(sysdate,-1), 'mm')
  left join (
    select 
      nasel_ccb_ft.acct_id
      , nasel_ccb_ft.uch_begin_dt
      , nvl(nasel_ccb_ft.bill_bt_otch,0) + nvl(nasel_ccb_ft.bill_odn_otch,0) bill_otch -- Только эти по указанию Е.Назарова 2017-04-21
      , nvl(nasel_ccb_ft.saldo_bt_uch,0) + nvl(nasel_ccb_ft.saldo_odn_uch,0) + nvl(nasel_ccb_ft.saldo_act_uch,0)  saldo_uch
      , nvl(nasel_ccb_ft.saldo_bt_uch,0) + nvl(nasel_ccb_ft.saldo_act_uch,0) saldo_uch_without_odn
      , nvl(nasel_ccb_ft.sum_pay_uch,0) sum_pay_uch
    from nasel_ccb_ft
  ) ccb_ft on ccb_ft.acct_id = nasel_ccb_prem.acct_id
  
  
  left join (
    select
      nasel_ccb_ft_hist.acct_id
      , max(case when nasel_ccb_ft_hist.uch_begin_dt = trunc(add_months((select char_val_dttm from cfg_task where char_type_cd = 'REP_DTTM' and task_name = 'P_UPDATE_NASEL_JOB_DAY'),-3), 'mm') then nvl(nasel_ccb_ft_hist.saldo_bt_uch, 0) + nvl(nasel_ccb_ft_hist.saldo_act_uch, 0) end) saldo_m3
      , nvl(sum(case when nasel_ccb_ft_hist.uch_begin_dt between trunc(add_months((select char_val_dttm from cfg_task where char_type_cd = 'REP_DTTM' and task_name = 'P_UPDATE_NASEL_JOB_DAY'),-2), 'mm') and sysdate
      then nasel_ccb_ft_hist.sum_pay_uch end),0) sum_pay_uch
    from nasel_ccb_ft_hist
    group by nasel_ccb_ft_hist.acct_id
  ) ccb_ft_hist on ccb_ft_hist.acct_id = nasel_ccb_prem.acct_id

  
  /*left join nasel_ccb_ft_hist on nasel_ccb_ft_hist.acct_id = nasel_ccb_prem.acct_id and nasel_ccb_ft_hist.calc_dt = trunc(add_months((select char_val_dttm from cfg_task where char_type_cd = 'REP_DTTM' and task_name = 'P_UPDATE_NASEL_JOB_DAY'),-3), 'mm')*/
    
  left join (
    select 
      nasel_cc.acct_id  
      , nasel_cc.cc_dttm 
      , nasel_cc.src_id
      , nasel_cc.cc_id
      , row_number() over (partition by nasel_cc.acct_id order by nasel_cc.cc_dttm desc) n
    from nasel_cc        
    where nasel_cc.src_type_cd = '10' and nasel_cc.approval_dttm is not null  
  ) last_cc on last_cc.acct_id = nasel_ccb_prem.acct_id and last_cc.n = 1    
  
  left join (
    select
      nasel_fa.acct_id  
      , nasel_fa.fa_id
      , nasel_fa.fa_pack_id     
      , nasel_fa_pack.cre_dttm
      , row_number() over (partition by nasel_fa.acct_id order by nasel_fa_pack.cre_dttm desc nulls last) n
    from nasel_fa
    inner join nasel_fa_pack on nasel_fa_pack.fa_pack_id = nasel_fa.fa_pack_id and nasel_fa_pack.fa_pack_status_flg in ('50')
  ) last_fa on last_fa.acct_id = nasel_ccb_prem.acct_id and last_fa.n = 1    
     
  left join (
    select nasel_ccb_sa_rel.acct_id
      , nasel_ccb_sa_rel.spr_cd
      , row_number() over (partition by  nasel_ccb_sa_rel.acct_id order by nasel_ccb_sa_rel.sa_rel_type_cd desc) n
    from nasel_ccb_sa_rel 
  ) sa_rel on sa_rel.acct_id = nasel_ccb_prem.acct_id and sa_rel.n = 1
  left join nasel_ccb_spr on nasel_ccb_spr.spr_cd = sa_rel.spr_cd

  left join nasel_calc on nasel_calc.acct_id = nasel_ccb_prem.acct_id
  
  -- Реструктуризация ДЗ
  left join nasel_ccb_pp on nasel_ccb_pp.acct_id = nasel_ccb_prem.acct_id and nasel_ccb_pp.pp_stat_flg = '20'

  where nasel_ccb_prem.acct_otdelen = p_acct_otdelen
    /*and nasel_ccb_prem.acct_id in ('4015250000', '4046250000', '6046250000','1441170000','0000003304', '7474750000','7204750000','4006750000','6333850000','1390950000', '6326650000', '3043850000', '9226650000', 
      '0408650000', '1608650000', '1783850000' , '4595850000') /**/
  
    and nvl(ccb_ft.saldo_uch_without_odn,0) - nvl(ccb_ft.bill_otch,0) > nasel_calc.norm_amt * 2 * nasel_ccb_sp.fl_tar11 
    and nvl(ccb_ft_hist.saldo_m3,0) - nvl(ccb_ft_hist.sum_pay_uch,0) - nvl(ccb_ft.sum_pay_uch,0) > nasel_calc.norm_amt * 2 * nasel_ccb_sp.fl_tar11 
    and nvl(ccb_ft.saldo_uch_without_odn,0) > nasel_calc.norm_amt * 2 * nasel_ccb_sp.fl_tar11 
    and (last_cc.cc_dttm is null or months_between(last_cc.cc_dttm, sysdate) > 6) 
    and (last_fa.cre_dttm is null or months_between(last_fa.cre_dttm, sysdate) > 2)
    and (ccb_ft.saldo_uch - nvl(nasel_ccb_pp.pp_tot_sched_amt,0) ) > nasel_calc.norm_amt * 2 * nasel_ccb_sp.fl_tar11
    
  order by city, address
);
end;




procedure get_fa_pack_notices(p_fa_pack_id in nasel_ccb_prem.acct_otdelen%type, rc out sys_refcursor)
is
begin
  open rc for 
select
  rownum
  , 0 CHECK_DATA
  , t.*
from (
select 
  nasel_fa.fa_id
  , nasel_fa.acct_id
  , nasel_ccb_prem.ulitsa || nvl2(nasel_ccb_prem.dom, ', д. '  || nasel_ccb_prem.dom,'') || nvl2(nasel_ccb_prem.korp, ', корп. '  || nasel_ccb_prem.korp,'') || nvl2(nasel_ccb_prem.kvartira, ', кв. '  || nasel_ccb_prem.kvartira,'') address
  --, nasel_ccb_prem.address

  , nasel_ccb_prem.city
  , initcap(nasel_ccb_prem.fio) fio 
  , nasel_ccb_prem.postal

  , cc.cc_dttm   
  , cc.src_type_cd
  , nasel_ccb_spr.descr service_org 
  , nasel_ccb_prem.phones
  , trim(substr(nasel_ccb_prem.phones, 1, instr(nasel_ccb_prem.phones,',')-1)) phone
  
  
  , case when nasel_ccb_sp.cont_qty_sz = 1 then nvl(nasel_fa.end_reg_reading1, 0) + nvl(nasel_fa.end_reg_reading2, 0) end end_reg_reading_sz1
  , nvl(nasel_fa.end_reg_reading1, 0) end_reg_reading1
  , nvl(nasel_fa.end_reg_reading2, 0) end_reg_reading2

  --, nvl(nasel_ccb_ft_hist.saldo_bt_uch, 0) + nvl(nasel_ccb_ft_hist.saldo_odn_uch, 0) + nvl(nasel_ccb_ft_hist.saldo_aсt_uch, 0) saldo_m3
  , nvl(nasel_fa.saldo_uch, 0) saldo_uch
  , nasel_fa.mtr_serial_nbr 
  , nasel_fa_pack.fa_pack_id 
  , nasel_fa_pack.acct_otdelen 
  , nasel_fa_pack.cre_dttm
  , nasel_ccb_sp.op_area_descr
  , nasel_fa_pack.fa_pack_type_cd
  , nvl(nasel_ccb_sp.cont_qty_sz,0) cont_qty_sz
  , cc.cc_id
  , cc.cc_status_flg
  , cc.cc_type_cd
  , trunc(cc.approval_dttm,'dd') approval_dttm
  --, case when cc.approval_dttm is null then 'Нет' else 'Да' end approval_flg
  --, (select name1 || substr(name2,1,1) || substr(name3,1,1)  from spr_users where name_u = trim(cc.approval_user_id)) approval_user 
  , (select name1 || substr(name2,1,1) || substr(name3,1,1)  from spr_users where name_u = trim(nasel_fa_pack.user_id)) owner 

  --, to_char(nasel_fa_pack.cre_dttm, 'dd.mm.yyyy') cre_dt
  --, nasel_ccb_prem.ulitsa
  --, nasel_ccb_prem.dom
  --, nasel_ccb_prem.korp
  --, nasel_ccb_prem.kvartira
  
from nasel_fa_pack
inner join nasel_fa on nasel_fa.fa_pack_id = nasel_fa_pack.fa_pack_id
inner join nasel_ccb_prem on nasel_ccb_prem.acct_id = nasel_fa.acct_id
inner join nasel_ccb_sp on nasel_ccb_sp.acct_id = nasel_ccb_prem.acct_id

--left join nasel_ccb_bseg_read on nasel_ccb_bseg_read.acct_id = nasel_ccb_prem.acct_id 
--left join nasel_ccb_ft_hist on nasel_ccb_ft_hist.acct_id = nasel_ccb_prem.acct_id and nasel_ccb_ft_hist.calc_dt = trunc(add_months(sysdate,-2), 'mm')
--inner join nasel_ccb_ft on nasel_ccb_ft.acct_id = nasel_fa.acct_id
  
left join (
  select nasel_ccb_sa_rel.acct_id
    , nasel_ccb_sa_rel.spr_cd
    , row_number() over (partition by  nasel_ccb_sa_rel.acct_id order by nasel_ccb_sa_rel.sa_rel_type_cd desc) n
  from nasel_ccb_sa_rel 
  --where acct_id in ('0129250000')
) sa_rel on sa_rel.acct_id = nasel_ccb_prem.acct_id and sa_rel.n = 1
left join nasel_ccb_spr on nasel_ccb_spr.spr_cd = sa_rel.spr_cd

left join (
  select 
     nasel_cc.src_id
    , nasel_cc.cc_dttm
    , nasel_cc.descr
    , nasel_cc.src_type_cd 
    , nasel_cc.cc_id
    , nasel_cc.cc_status_flg
    , nasel_cc.cc_type_cd
    , nasel_cc.approval_dttm
    , nasel_cc.approval_user_id
    , row_number() over (partition by nasel_cc.src_id, nasel_cc.src_type_cd  order by nasel_cc.cc_dttm desc) n
  from nasel_cc    
  --where nasel_cc.src_type_cd = '10'
) cc on cc.src_id = nasel_fa.fa_id and cc.n = 1

where /*nasel_fa_pack.fa_pack_type_cd = '20'
   and*/ nasel_fa_pack.fa_pack_id = p_fa_pack_id
  --and nasel_fa.acct_id in ('0408650000', '1608650000', '1783850000' , '4595850000')
order by nasel_ccb_prem.city, nasel_ccb_prem.address 

) t;
end;





procedure get_fa_pack_stop(p_fa_pack_id in nasel_ccb_prem.acct_otdelen%type, rc out sys_refcursor)
is
begin
  open rc for 
select
  rownum
  , 0 CHECK_DATA
  , t.*
from (
select 
  --row_number() over() rownum
  nasel_fa.fa_id
  , nasel_fa.acct_id
  , nasel_ccb_prem.ulitsa || nvl2(nasel_ccb_prem.dom, ', д. '  || nasel_ccb_prem.dom,'') || nvl2(nasel_ccb_prem.korp, ', корп. '  || nasel_ccb_prem.korp,'') || nvl2(nasel_ccb_prem.kvartira, ', кв. '  || nasel_ccb_prem.kvartira,'') address
  --, nasel_ccb_prem.address

  , nasel_ccb_prem.city
  , nasel_ccb_prem.fio 
  , nasel_ccb_prem.postal

  , cc.cc_dttm   
  , cc.src_type_cd
  , nasel_ccb_spr.descr spr_descr
  , nasel_ccb_prem.phones
  , trim(substr(nasel_ccb_prem.phones, 1, instr(nasel_ccb_prem.phones,',')-1)) phone
  
  
  , nvl(nasel_fa.end_reg_reading1, 0) end_reg_reading1
  , nvl(nasel_fa.end_reg_reading2, 0) end_reg_reading2

  --, nvl(nasel_ccb_ft_hist.saldo_bt_uch, 0) + nvl(nasel_ccb_ft_hist.saldo_odn_uch, 0) + nvl(nasel_ccb_ft_hist.saldo_aсt_uch, 0) saldo_m3
  , nvl(nasel_fa.saldo_uch, 0) saldo_uch
  , nasel_fa.mtr_serial_nbr 
  , nasel_fa_pack.fa_pack_id 
  , nasel_fa_pack.acct_otdelen 
  , nasel_fa_pack.cre_dttm
  , nasel_ccb_sp.op_area_descr
  , nasel_fa_pack.fa_pack_type_cd
  , dense_rank() over(order by case when nasel_ccb_prem.prem_type_cd in ('CD') then  nasel_ccb_spr.descr else '0' end) grp 
  , (select descr from nasel_lookup_val where nasel_lookup_val.field_name = 'PREM_TYPE_CD' and nasel_lookup_val.field_value = nasel_ccb_prem.prem_type_cd) prem_type_descr
  , fa_char.st_p_dt -- плановая дата отключения 
  , nasel_ccb_sp.sa_end_dt

  --, to_char(nasel_fa_pack.cre_dttm, 'dd.mm.yyyy') cre_dt

  --, nasel_ccb_prem.ulitsa
  --, nasel_ccb_prem.dom
  --, nasel_ccb_prem.korp
  --, nasel_ccb_prem.kvartira
  
from nasel_fa_pack
inner join nasel_fa on nasel_fa.fa_pack_id = nasel_fa_pack.fa_pack_id
inner join nasel_ccb_prem on nasel_ccb_prem.acct_id = nasel_fa.acct_id
inner join nasel_ccb_sp on nasel_ccb_sp.acct_id = nasel_ccb_prem.acct_id

--left join nasel_ccb_bseg_read on nasel_ccb_bseg_read.acct_id = nasel_ccb_prem.acct_id 
--left join nasel_ccb_ft_hist on nasel_ccb_ft_hist.acct_id = nasel_ccb_prem.acct_id and nasel_ccb_ft_hist.calc_dt = trunc(add_months(sysdate,-2), 'mm')
--inner join nasel_ccb_ft on nasel_ccb_ft.acct_id = nasel_fa.acct_id
  
left join (
  select nasel_ccb_sa_rel.acct_id
    , nasel_ccb_sa_rel.spr_cd
    , row_number() over (partition by  nasel_ccb_sa_rel.acct_id order by nasel_ccb_sa_rel.sa_rel_type_cd desc) n
  from nasel_ccb_sa_rel 
  --where acct_id in ('0129250000')
) sa_rel on sa_rel.acct_id = nasel_ccb_prem.acct_id and sa_rel.n = 1
left join nasel_ccb_spr on nasel_ccb_spr.spr_cd = sa_rel.spr_cd

left join (
  select 
     nasel_cc.acct_id
    , nasel_cc.cc_dttm
    , nasel_cc.descr
    , nasel_cc.src_type_cd 
    , row_number() over (partition by nasel_cc.src_id, nasel_cc.src_type_cd  order by nasel_cc.cc_dttm desc) n
  from nasel_cc    
  --where nasel_cc.src_type_cd = '10'
) cc on cc.acct_id = nasel_fa.acct_id and cc.n = 1

-- Планируемая дата отключения
left join (
   select
     nasel_fa_char.fa_id
     , nasel_fa_char.char_val_dttm st_p_dt 
     , row_number() over(partition by nasel_fa_char.fa_id, nasel_fa_char.char_type_cd order by nasel_fa_char.effdt desc) n
   from nasel_fa_char 
   where trim(char_type_cd) = 'ST-P-DT'
) fa_char on fa_char.fa_id = nasel_fa.fa_id and fa_char.n = 1

where nasel_fa_pack.fa_pack_type_cd = '40'
   and nasel_fa_pack.fa_pack_id = p_fa_pack_id
  --and nasel_fa.acct_id in ('0408650000', '1608650000', '1783850000' , '4595850000')

order by nasel_ccb_prem.city, nasel_ccb_prem.address 

) t;
end;




procedure get_fa_pack_stop_list(p_acct_otdelen in nasel_ccb_prem.acct_otdelen%type, rc out sys_refcursor)
is
begin
  open rc for 
-- Запрос для получения списка реестров
-- создан: 2017-02-08
-- автор: vsovchinnikov
--

  select
    rownum
    , 0 CHECK_DATA
    , t.*
  from (
  select 
    nasel_fa_pack.fa_pack_id
    , fa_pack_char.rt_spr recipient_spr_descr
    , fa_pack_char.rt_addr recipient_address
    , fa_pack_char.rt_post recipient_official_post
    , fa_pack_char.rt_name recipient_official_name
   
    --, padeg_pack.Padeg_FIO(nasel_ccb_spr_l.official_post, 'Д') official_post
    --, padeg_pack.Padeg_FIO(nasel_ccb_spr_l.official_name, 'Д') official_name
    
    , nasel_fa_pack.cre_dttm
    , nasel_fa_pack.fa_pack_status_flg
    , fa_char.st_p_dt  -- планируемая дата отключения
    , (select name1 || substr(name2,1,1) || substr(name3,1,1)  from spr_users where name_u = trim(nasel_fa_pack.user_id)) owner 
 
    , (
      select descr from nasel_lookup_val 
       where nasel_lookup_val.field_name = 'FA_PACK_STATUS_FLG' and nasel_lookup_val.field_value = nasel_fa_pack.fa_pack_status_flg
       ) fa_pack_status_descr
       
    , (
      select count(nasel_fa.fa_id) 
       from nasel_fa 
       where nasel_fa.fa_pack_id = nasel_fa_pack.fa_pack_id
       ) fa_cnt
    , (
      select nasel_lookup_val.descr
      from nasel_lookup_val
      where nasel_lookup_val.field_name = 'FA_PACK_TYPE_CD' 
        and nasel_lookup_val.field_value = nasel_fa_pack.fa_pack_type_cd
      ) fa_pack_type_descr     


   /* , (select nasel_lookup_val.descr from nasel_lookup_val 
       where nasel_lookup_val.field_name = 'PREM_TYPE_CD' and nasel_lookup_val.field_value = nasel_ccb_prem.prem_type_cd) prem_type_descr    
  */
    
    --, padeg_pack.Padeg_FIO('Челябэнергосбыт','В')
    --, char_st_p_dt.char_val_dttm st_p_dt -- планируемая дата отключения
    --, nasel_ccb_spr_l.official_post
    --, nasel_ccb_spr_l.official_name

  from nasel_fa_pack

  left join (
    select
      fa_pack_id
      , max(case when char_type_cd = 'RT-SPR' then char_val_str end) rt_spr
      , max(case when char_type_cd = 'RT-ADDR' then char_val_str end) rt_addr
      , max(case when char_type_cd = 'RT-POST' then char_val_str end) rt_post
      , max(case when char_type_cd = 'RT-NAME' then char_val_str end) rt_name
    from (
      select 
        nasel_fa_pack_char.fa_pack_id
        , trim(nasel_fa_pack_char.char_type_cd) char_type_cd
        , nasel_fa_pack_char.char_val_str
        , row_number() over (partition by nasel_fa_pack_char.fa_pack_id, nasel_fa_pack_char.char_type_cd order by nasel_fa_pack_char.effdt desc) N
      from nasel_fa_pack_char
    )
    where n = 1 
    group by fa_pack_id
  ) fa_pack_char on fa_pack_char.fa_pack_id = nasel_fa_pack.fa_pack_id

  -- Планируемая дата отключения
  left join (
    select 
      nasel_fa.fa_pack_id 
      , max(st_p_dt) st_p_dt 
    from (
      select     
        nasel_fa_char.fa_id
        , nasel_fa_char.char_val_dttm st_p_dt 
        , row_number() over(partition by nasel_fa_char.fa_id, nasel_fa_char.char_type_cd order by nasel_fa_char.effdt desc) n
      from nasel_fa_char 
      where trim(char_type_cd) = 'ST-P-DT' 
    ) t
    left join nasel_fa on nasel_fa.fa_id = t.fa_id    
    where t.n = 1
    group by nasel_fa.fa_pack_id     
  ) fa_char on fa_char.fa_pack_id = nasel_fa_pack.fa_pack_id 


  where 
    fa_pack_type_cd = '40' and nasel_fa_pack.acct_otdelen = p_acct_otdelen
    --nasel_fa_pack.fa_pack_id = '0000002160'

  order by nasel_fa_pack.cre_dttm desc

) t;
end;



procedure get_stop_list(p_acct_otdelen in nasel_ccb_prem.acct_otdelen%type, rc out sys_refcursor)
is
begin
  open rc for 
-- Запрос для представления списка абонентов для дальнейшего отключения
-- Автор: В.С.Овчинников
-- Создан: 2017-02-01

  select 
    rownum
    , 0 CHECK_DATA  
    , t.* 
    , max(t.grp_data) over() grp_data_max -- кол-во обслуживающих организаций
  from (
  select 

    dense_rank() over (order by spr.descr, case when nasel_ccb_prem.prem_type_cd in ('CD') then 1 end) grp_data -- индекс обслуживающей организации 
    --dense_rank() over (order by spr.descr) grp_data -- индекс обслуживающей организации
    --, count(distinct nvl(spr.descr, ' ')) over() grp_data_max -- кол-во обслуживающих организаций

    , nasel_ccb_prem.acct_id
    , fa_notice.approval_dttm
    , fa_notice.cc_dttm
    , nasel_ccb_prem.fio 
    , nasel_ccb_prem.postal 
    , nasel_ccb_prem.city 
    , nasel_ccb_prem.ulitsa || nvl2(nasel_ccb_prem.dom, ', д. '  || nasel_ccb_prem.dom,'') || nvl2(nasel_ccb_prem.korp, ', корп. '  || nasel_ccb_prem.korp,'') || nvl2(nasel_ccb_prem.kvartira, ', кв. '  || nasel_ccb_prem.kvartira,'') address
    , (select nasel_lookup_val.descr from nasel_lookup_val where nasel_lookup_val.field_name = 'PREM_TYPE_CD' and nasel_lookup_val.field_value = nasel_ccb_prem.prem_type_cd) prem_type_descr     
    --, trim(nasel_ccb_prem.acct_otdelen) acct_otdelen
    , ccb_ft.saldo_uch
    , spr.descr spr_descr
    , fa_notice.fa_pack_id
    , (select nasel_lookup_val.descr from nasel_lookup_val where nasel_lookup_val.field_name = 'FA_PACK_TYPE_CD' and nasel_lookup_val.field_value = fa_notice.fa_pack_type_cd) fa_pack_type_descr     
    
    
  from nasel_ccb_prem
  inner join nasel_ccb_sp on nasel_ccb_sp.acct_id = nasel_ccb_prem.acct_id and nasel_ccb_sp.sa_status_flg = '20'

  -- Начисление предпредыдущего месяца
  inner join (
    select
      nasel_ccb_ft_hist.acct_id
      , nvl(nasel_ccb_ft_hist.bill_bt_otch, 0) + nvl(nasel_ccb_ft_hist.bill_odn_otch, 0) bill_otch
    from nasel_ccb_ft_hist
    where nasel_ccb_ft_hist.uch_begin_dt = add_months(trunc(sysdate, 'mm'),-2)
  ) nasel_ccb_ft_hist_m1 on nasel_ccb_ft_hist_m1.acct_id = nasel_ccb_prem.acct_id

  --
  inner join (
    select 
      nasel_ccb_ft.acct_id
      , nasel_ccb_ft.uch_begin_dt
      , nvl(nasel_ccb_ft.bill_bt_otch,0) + nvl(nasel_ccb_ft.bill_odn_otch,0) bill_otch
      , nvl(nasel_ccb_ft.saldo_bt_uch,0) saldo_bt_uch
      , nvl(nasel_ccb_ft.saldo_bt_uch,0) + nvl(nasel_ccb_ft.saldo_odn_uch,0) + nvl(nasel_ccb_ft.saldo_act_uch,0) saldo_uch
    from nasel_ccb_ft
  ) ccb_ft on ccb_ft.acct_id = nasel_ccb_prem.acct_id

  -- Последнее уведомление
  inner join (
    select 
      nasel_fa.fa_pack_id
      , nasel_fa_pack.fa_pack_type_cd
      , nasel_fa_pack.cre_dttm
      , nasel_fa_pack.user_id
      , nasel_fa.acct_id
      , nasel_fa.fa_id
      , nasel_cc.approval_dttm
      , nasel_cc.cc_dttm
      , row_number() over (partition by nasel_fa.acct_id order by nasel_fa_pack.cre_dttm desc) N
    from nasel_fa
    inner join nasel_fa_pack on nasel_fa_pack.fa_pack_id = nasel_fa.fa_pack_id 
      and nasel_fa_pack.fa_pack_type_cd in ('10','20') and nasel_fa_pack.fa_pack_status_flg = '50'
    inner join nasel_cc on nasel_cc.src_id = nasel_fa.fa_id and nasel_cc.src_type_cd = '10' 
      and nasel_cc.approval_dttm is not null      -- and nasel_cc.cc_dttm < sysdate -30 -- Закоментировано по требованиею Е.В.Назарова 2017-03-23
  ) fa_notice on fa_notice.acct_id = nasel_ccb_prem.acct_id and fa_notice.n = 1

  -- Заявка на отключение по последнему уведомлению
  left join (
    select nasel_fa_char.char_val_str prnt_fa_id
    from nasel_fa_char
    inner join nasel_fa on nasel_fa.fa_id = nasel_fa_char.fa_id
    inner join nasel_fa_pack on nasel_fa_pack.fa_pack_id = nasel_fa.fa_pack_id 
      and nasel_fa_pack.fa_pack_type_cd = '40' 
      and nasel_fa_pack.fa_pack_status_flg in ('50','60') 
    where nasel_fa_char.char_type_cd = 'PRNT-FA'
  ) fa_stop on fa_stop.prnt_fa_id = fa_notice.fa_id

  left join (
    select        
      nasel_ccb_sa_rel.acct_id
      , nasel_ccb_spr.descr
      , row_number() over (partition by nasel_ccb_sa_rel.acct_id order by nasel_ccb_sa_rel.sa_rel_type_cd) n
    from nasel_ccb_sa_rel
    inner join nasel_ccb_spr on nasel_ccb_spr.spr_cd = nasel_ccb_sa_rel.spr_cd
  ) spr on spr.acct_id = fa_notice.acct_id and spr.n = 1

  -- Реструктуризация ДЗ
  left join nasel_ccb_pp on nasel_ccb_pp.acct_id = nasel_ccb_prem.acct_id and nasel_ccb_pp.pp_stat_flg = '20'

  where
    fa_stop.prnt_fa_id is null -- По последнему уведомлению не было заявок на отключение
    and    
    ( 
        (   
           trunc(ccb_ft.uch_begin_dt,'mm') > trunc(fa_notice.cre_dttm,'mm')  
           and
           nvl(ccb_ft.saldo_uch,0) - nvl(nasel_ccb_pp.pp_tot_sched_amt,0) - nvl(ccb_ft.bill_otch, 0) - nvl(nasel_ccb_ft_hist_m1.bill_otch, 0) > 0
           --ccb_ft.saldo_uch - ccb_ft.nach_otch - nvl(nasel_ccb_pp.pp_tot_sched_amt,0) > 0
        ) 
      or 
        ( 
           trunc(ccb_ft.uch_begin_dt,'mm') <= trunc(fa_notice.cre_dttm,'mm')
           and
           nvl(ccb_ft.saldo_uch,0) - nvl(nasel_ccb_pp.pp_tot_sched_amt,0) - nvl(ccb_ft.bill_otch, 0) > 0 
        )
    )
    and
      nasel_ccb_prem.acct_otdelen = p_acct_otdelen
    
    -- and saldo_uch > normativ * 2 and saldo_m3 > normativ * 2
    --and nasel_ccb_prem.acct_id in ('1426650000','5426650000','5526650000','7526650000','9926650000', '0000070000')

  order by nasel_ccb_prem.city, nasel_ccb_prem.address 
  ) t;
end;



procedure get_cancel_list(p_acct_otdelen in nasel_ccb_prem.acct_otdelen%type, rc out sys_refcursor)
is
begin
  open rc for 
-- Запрос для списка реестров на отмену заявок на ограничения
-- Автор: В.С.Овчинников
-- Создан: 2017-04-20

  select
    rownum
    , 0 CHECK_DATA  
    , t.* 
  from
  (
  select
    nasel_fa_pack.fa_pack_id
    , nasel_fa_pack.cre_dttm
    , nasel_fa_pack.fa_pack_status_flg
    , fa.prnt_fa_id
    --, prnt_fa.*
    
    , nvl(nasel_ccb_spr_l.descr, nasel_ccb_spr.descr) rt_spr   -- Наименование организации
    , nasel_ccb_spr_l.address rt_addr  -- Адрес организации
    , nasel_ccb_spr_l.official_post rt_post  -- Должность 
    , nasel_ccb_spr_l.official_name rt_name   -- ФИО

    
    , (select count(nasel_fa.acct_id) from nasel_fa where nasel_fa.fa_pack_id = nasel_fa_pack.fa_pack_id) acct_id_cnt

     , (select name1 || substr(name2,1,1) || substr(name3,1,1)  from spr_users where name_u = trim(nasel_fa_pack.user_id)) owner 
  from nasel_fa_pack

  left join (
    select nasel_fa.fa_pack_id
      , count(*) cnt
      , max(nasel_fa_char.char_val_str) prnt_fa_id 
    from nasel_fa
    left join nasel_fa_char on nasel_fa_char.fa_id = nasel_fa.fa_id and nasel_fa_char.char_type_cd = 'PRNT-FA'
    group by nasel_fa.fa_pack_id
  ) fa on fa.fa_pack_id = nasel_fa_pack.fa_pack_id

  -- Адресат (код организации из характеристик)
  left join (
    select
      nasel_fa.fa_id
      --, nasel_fa.fa_pack_id
      , nasel_fa_pack_char.char_val_str rt_spr_cd
    from nasel_fa 
    left join nasel_fa_pack_char on nasel_fa_pack_char.fa_pack_id = nasel_fa.fa_pack_id
    where trim(nasel_fa_pack_char.char_type_cd) = 'RT-SPRCD'
  ) prnt_fa on prnt_fa.fa_id = fa.prnt_fa_id

  left join nasel_ccb_spr on trim(nasel_ccb_spr.spr_cd) = trim(prnt_fa.rt_spr_cd)
  left join nasel_ccb_spr_l on nasel_ccb_spr_l.spr_cd = nasel_ccb_spr.spr_cd  
  
  /*left join (
    select nasel_ccb_sa_rel.acct_id
      , nasel_ccb_sa_rel.spr_cd
      , row_number() over (partition by  nasel_ccb_sa_rel.acct_id order by nasel_ccb_sa_rel.sa_rel_type_cd desc) n
    from nasel_ccb_sa_rel 
  ) sa_rel on sa_rel.acct_id = nasel_ccb_prem.acct_id and sa_rel.n = 1
  left join nasel_ccb_spr on nasel_ccb_spr.spr_cd = sa_rel.spr_cd
  left join nasel_ccb_spr_l on nasel_ccb_spr_l.spr_cd = sa_rel.spr_cd*/

  /*left join (
    select
      nasel_fa.fa_id
      --, nasel_fa.fa_pack_id
      , max(case when trim(nasel_fa_pack_char.char_type_cd) = 'RT-SPR' then nasel_fa_pack_char.char_val_str end) rt_spr
      , max(case when nasel_fa_pack_char.char_type_cd = 'RT-ADDR' then nasel_fa_pack_char.char_val_str end) rt_addr
      , max(case when nasel_fa_pack_char.char_type_cd = 'RT-POST' then nasel_fa_pack_char.char_val_str end) rt_post
      , max(case when nasel_fa_pack_char.char_type_cd = 'RT-NAME' then nasel_fa_pack_char.char_val_str end) rt_name
    from nasel_fa 
    left join nasel_fa_pack_char on nasel_fa_pack_char.fa_pack_id = nasel_fa.fa_pack_id
    group by nasel_fa.fa_id
  ) prnt_fa on prnt_fa.fa_id = fa.prnt_fa_id*/


  where acct_otdelen = p_acct_otdelen --'02-61FL'
    and nasel_fa_pack.fa_pack_type_cd = '45'
  ) t;
end;






procedure get_approval_list(p_acct_otdelen in nasel_ccb_prem.acct_otdelen%type, rc out sys_refcursor)
is
begin
  open rc for 
select
  rownum
  , 0 CHECK_DATA
  , t.*
from (
  select 
    nasel_fa.acct_id  
    , nasel_fa.fa_id
    , nasel_fa.saldo_uch
    , nasel_ccb_prem.ulitsa || nvl2(nasel_ccb_prem.dom, ', д. '  || nasel_ccb_prem.dom,'') || nvl2(nasel_ccb_prem.korp, ', корп. '  || nasel_ccb_prem.korp,'') || nvl2(nasel_ccb_prem.kvartira, ', кв. '  || nasel_ccb_prem.kvartira,'') address
    , nasel_ccb_prem.city
    , initcap(nasel_ccb_prem.fio) fio
    , nasel_ccb_spr.descr service_org
    
    , cc.cc_id
    , cc.cc_dttm   
    , cc.src_type_cd
    , cc.approval_dttm
  
    , row_number() over (partition by nasel_fa.acct_id order by nasel_fa_pack.cre_dttm desc) n
  from nasel_fa 
  inner join nasel_fa_pack on nasel_fa_pack.fa_pack_id = nasel_fa.fa_pack_id
  
  left join (
    select nasel_ccb_sa_rel.acct_id
      , nasel_ccb_sa_rel.spr_cd
      , row_number() over (partition by  nasel_ccb_sa_rel.acct_id order by nasel_ccb_sa_rel.sa_rel_type_cd desc) n
    from nasel_ccb_sa_rel 
    --where acct_id in ('0129250000')
  ) sa_rel on sa_rel.acct_id = nasel_fa.acct_id and sa_rel.n = 1
  left join nasel_ccb_spr on nasel_ccb_spr.spr_cd = sa_rel.spr_cd
                                                          
  inner join (
    select 
      nasel_cc.acct_id
      , nasel_cc.cc_id
      , nasel_cc.cc_dttm
      , nasel_cc.descr
      , nasel_cc.src_type_cd 
      , nasel_cc.approval_dttm
      , row_number() over (partition by nasel_cc.src_id, nasel_cc.src_type_cd  order by nasel_cc.cre_dttm desc) n
    from nasel_cc    
    where nasel_cc.src_type_cd = '10' and nasel_cc.cc_status_flg = '20'
  ) cc on cc.acct_id = nasel_fa.acct_id and cc.n = 1
  
  left join nasel_ccb_prem on nasel_ccb_prem.acct_id = nasel_fa.acct_id
  where nasel_fa_pack.acct_otdelen = p_acct_otdelen

  order by nasel_ccb_prem.city, nasel_ccb_prem.address 

) t where t.n = 1;
end;







procedure get_post_list(p_acct_otdelen in nasel_ccb_prem.acct_otdelen%type, rc out sys_refcursor)
is
begin
  open rc for 
-- Список на почту
-- 2017-02-22
-- автор: ВСОвчинников
-- Е.В.Назаров
--
-- Условия
-- 1. Точка учета в статусе установлена (20)
-- 2. saldo_uch > normativ * 2 and saldo_m3 > normativ * 2
-- 3. Дата последнего утвержденного контакта более 6 месяцев или пустая
-- 4. Дата последнего уведомления более 2 месяцев или пустая

/*
select
  rownum 
  , 0 CHECK_DATA 
  , acct_id  
  , initcap(fio) fio   
  , city
  , address 
  , saldo_uch 
  , saldo_m3 
  , cc_dttm  
  , fa_id
  , fa_pack_id
  , cre_dttm 
  , acct_otdelen
  , service_org

  , op_area_descr
   
*/

select
  rownum 
  , 0 CHECK_DATA 
  , t.*
from (

  select nasel_ccb_prem.acct_id
    , fa.cre_dttm
    , fa.fa_pack_id
    , nasel_ccb_ft.saldo_bt_uch
    , nasel_ccb_ft.saldo_act_uch     
    
    , initcap(nasel_ccb_prem.fio) fio   
    , nasel_ccb_prem.city
    , nasel_ccb_prem.ulitsa || nvl2(nasel_ccb_prem.dom, ', д. '  || nasel_ccb_prem.dom,'') || nvl2(nasel_ccb_prem.korp, ', корп. '  || nasel_ccb_prem.korp,'') || nvl2(nasel_ccb_prem.kvartira, ', кв. '  || nasel_ccb_prem.kvartira,'') address


    , nvl(nasel_ccb_ft.saldo_bt_uch, 0) + nvl(nasel_ccb_ft.saldo_odn_uch, 0) + nvl(nasel_ccb_ft.saldo_act_uch, 0) saldo_uch
    , nvl(nasel_ccb_ft_hist.saldo_bt_uch, 0) + nvl(nasel_ccb_ft_hist.saldo_odn_uch, 0) + nvl(nasel_ccb_ft_hist.saldo_act_uch, 0) saldo_m3
                              
    --, pk_nasel_otdel.get_normativ(nasel_ccb_prem.acct_id) normativ
      
    , nasel_ccb_spr.descr service_org
    , nasel_ccb_sp.op_area_descr
    , nasel_ccb_sp.fl_tar11
    , nasel_calc.norm_amt
       
  from nasel_ccb_prem

  inner join (
    select nasel_fa.acct_id 
      , nasel_fa.fa_id
      , nasel_fa_pack.cre_dttm
      , nasel_fa_pack.fa_pack_id
      --fa_pack_id
      , row_number() over (partition by nasel_fa.acct_id order by nasel_fa_pack.cre_dttm desc) n
    from nasel_fa           
    inner join nasel_fa_pack on nasel_fa_pack.fa_pack_id = nasel_fa.fa_pack_id
  ) fa on fa.acct_id = nasel_ccb_prem.acct_id and fa.n = 1 and fa.cre_dttm < sysdate - 0   

  /*inner join nasel_fa on nasel_fa.acct_id = nasel_ccb_prem.acct_id 
  inner join nasel_fa_pack on nasel_fa_pack.fa_pack_id = nasel_fa.fa_pack_id
    and nasel_fa_pack.cre_dttm < sysdate - 0 */  
                             
  left join nasel_cc on nasel_cc.src_id = fa.fa_id and nasel_cc.src_type_cd = '10'

  inner join nasel_ccb_sp on nasel_ccb_sp.acct_id = nasel_ccb_prem.acct_id and nasel_ccb_sp.sa_status_flg in ('20')
  left join nasel_ccb_ft on nasel_ccb_ft.acct_id = nasel_ccb_prem.acct_id
  left join nasel_ccb_ft_hist on nasel_ccb_ft_hist.acct_id = nasel_ccb_prem.acct_id and nasel_ccb_ft_hist.uch_begin_dt = trunc(add_months((select char_val_dttm from cfg_task where char_type_cd = 'REP_DTTM' and task_name = 'P_UPDATE_NASEL_JOB_DAY'),-3), 'mm')
                           
  left join (
    select nasel_ccb_sa_rel.acct_id
      , nasel_ccb_sa_rel.spr_cd
      , row_number() over (partition by  nasel_ccb_sa_rel.acct_id order by nasel_ccb_sa_rel.sa_rel_type_cd desc) n
    from nasel_ccb_sa_rel 
  ) sa_rel on sa_rel.acct_id = nasel_ccb_prem.acct_id and sa_rel.n = 1
  left join nasel_ccb_spr on nasel_ccb_spr.spr_cd = sa_rel.spr_cd
  
  inner join nasel_calc on nasel_calc.acct_id = nasel_ccb_prem.acct_id  

  where nasel_cc.cc_id is null 
    and acct_otdelen = p_acct_otdelen
    /*and acct_id in ('4015250000', '4046250000', '6046250000','1441170000','0000003304', '7474750000','7204750000','4006750000','6333850000','1390950000', '6326650000', '3043850000', '9226650000', 
      '0408650000', '1608650000', '1783850000' , '4595850000') /**/
  
) t where saldo_uch > norm_amt * 2 * fl_tar11 and saldo_m3 > norm_amt * 2 * fl_tar11;
    --and (cc_dttm is null or months_between(cc_dttm, sysdate) > 6) 
    --and (cre_dttm is null or months_between(cre_dttm, sysdate) > 2)
end;



procedure get_fa_pack_notices_list(p_acct_otdelen in nasel_ccb_prem.acct_otdelen%type, rc out sys_refcursor)
is
begin
  open rc for 
  select
    rownum
    , 0 CHECK_DATA 
    , t.*
   from (
    select
      nasel_fa_pack.*
      , fa.cnt
      , (
        select descr 
        from nasel_lookup_val 
        where field_name= 'FA_PACK_STATUS_FLG' 
          and field_value= nasel_fa_pack.fa_pack_status_flg
        ) fa_pack_status_descr
      , (
        select nasel_lookup_val.descr
        from nasel_lookup_val
        where nasel_lookup_val.field_name = 'FA_PACK_TYPE_CD' 
          and nasel_lookup_val.field_value = nasel_fa_pack.fa_pack_type_cd
      ) fa_pack_type_descr     

    , (select name1 || substr(name2,1,1) || substr(name3,1,1)  from spr_users where name_u = trim(nasel_fa_pack.user_id)) owner 
    from nasel_fa_pack
    
    left join (
      select
        nasel_fa.fa_pack_id
        , count(*) cnt
      from nasel_fa
      group by nasel_fa.fa_pack_id
    ) fa on fa.fa_pack_id = nasel_fa_pack.fa_pack_id

    where nasel_fa_pack.acct_otdelen = p_acct_otdelen
      and nasel_fa_pack.fa_pack_type_cd in ('10','20')

    order by nasel_fa_pack.cre_dttm desc 
  ) t;
end;



procedure get_fa_pack_cancel_stop_list(p_fa_pack_id in nasel_ccb_prem.acct_otdelen%type, rc out sys_refcursor)
is
begin
  open rc for 
  select 
    nasel_ccb_prem.acct_id
    , nasel_ccb_prem.fio
    , fa_stop.fa_id stop_fa_id
    , fa_stop.fa_pack_id stop_pack_id
    , fa_pack_stop.cre_dttm stop_cre_dttm
    
    , fa_notice.fa_id notice_fa_id
    , fa_notice.fa_pack_id notice_pack_id
    , fa_pack_notice.cre_dttm notice_cre_dttm
    , fa_char_notice.st_p_dt

    , nasel_ccb_prem.city
    , nasel_ccb_prem.ulitsa || nvl2(nasel_ccb_prem.dom, ', д. '  || nasel_ccb_prem.dom,'') || nvl2(nasel_ccb_prem.korp, ', корп. '  || nasel_ccb_prem.korp,'') || nvl2(nasel_ccb_prem.kvartira, ', кв. '  || nasel_ccb_prem.kvartira,'') address
    , (select descr from nasel_lookup_val where field_name = 'PREM_TYPE_CD' and field_value = nasel_ccb_prem.prem_type_cd) prem_type_descr
    
    /*, nvl(nasel_ccb_spr_l.descr, nasel_ccb_spr.descr) rt_spr1   -- Наименование организации
    , nasel_ccb_spr_l.address rt_addr  -- Адрес организации
    , nasel_ccb_spr_l.official_post rt_post  -- Должность 
    , nasel_ccb_spr_l.official_name rt_name   -- ФИО*/

     
  -- Заявка на отмену ограничения
  from nasel_fa_pack
  left join nasel_fa on nasel_fa.fa_pack_id = nasel_fa_pack.fa_pack_id
  left join (
    select nasel_fa_char.fa_id
      , nasel_fa_char.char_val_str prnt_fa
    from nasel_fa_char
    where nasel_fa_char.char_type_cd = 'PRNT-FA'
  ) fa_char on fa_char.fa_id = nasel_fa.fa_id 
  
  -- Заявка на ограничение  
  left join nasel_fa fa_stop on fa_stop.fa_id = fa_char.prnt_fa
  left join nasel_fa_pack fa_pack_stop on fa_pack_stop.fa_pack_id = fa_stop.fa_pack_id
  left join (
    select nasel_fa_char.fa_id
      , nasel_fa_char.char_val_str prnt_fa
    from nasel_fa_char
    where nasel_fa_char.char_type_cd = 'PRNT-FA'
  ) fa_char_stop on fa_char_stop.fa_id = fa_stop.fa_id 
  
  -- Уведомления
  left join nasel_fa fa_notice on fa_notice.fa_id = fa_char_stop.prnt_fa
  left join nasel_fa_pack fa_pack_notice on fa_pack_notice.fa_pack_id = fa_notice.fa_pack_id
  left join (
    select nasel_fa_char.fa_id
      , nasel_fa_char.char_val_dttm st_p_dt
    from nasel_fa_char
    where nasel_fa_char.char_type_cd = 'ST-P-DT'
  ) fa_char_notice on fa_char_notice.fa_id = fa_stop.fa_id 

  -- Объект обслуживания
  inner join nasel_ccb_prem on nasel_ccb_prem.acct_id = nasel_fa.acct_id
  
  /*-- Адресат
  left join (
    select nasel_ccb_sa_rel.acct_id
      , nasel_ccb_sa_rel.spr_cd
      , row_number() over (partition by  nasel_ccb_sa_rel.acct_id order by nasel_ccb_sa_rel.sa_rel_type_cd desc) n
    from nasel_ccb_sa_rel 
  ) sa_rel on sa_rel.acct_id = nasel_ccb_prem.acct_id and sa_rel.n = 1
  left join nasel_ccb_spr on nasel_ccb_spr.spr_cd = sa_rel.spr_cd
  left join nasel_ccb_spr_l on nasel_ccb_spr_l.spr_cd = sa_rel.spr_cd*/
  
  where nasel_fa_pack.fa_pack_type_cd = '45' 
    and nasel_fa_pack.fa_pack_id = p_fa_pack_id
  order by nasel_fa_pack.cre_dttm desc;
end;


/*
procedure get_fa_pack_stop_list(p_acct_otdelen in nasel_ccb_prem.acct_otdelen%type, rc out sys_refcursor)
is
begin
  open rc for 
select
  rownum
  , 0 CHECK_DATA 
  , t.cre_dttm
  , t.acct_otdelen
  , t.fa_pack_id
  , t.fa_pack_type_cd
  --, decode(trim(t.fa_pack_type_cd),'20','Уведомление', '40', 'Ограничение') fa_pack_type_descr
  , t.cnt fa_cnt
  , t.fa_pack_type_descr
  , (select descr from nasel_lookup_val where field_name= 'FA_PACK_STATUS_FLG' and field_value=t.fa_pack_status_flg) fa_pack_status_descr
from (
  select
    nasel_fa_pack.*
    , fa.cnt
    , nasel_lookup_val.descr fa_pack_type_descr
  from nasel_fa_pack
  
  left join (
    select
      nasel_fa.fa_pack_id
      , count(*) cnt
    from nasel_fa
    group by nasel_fa.fa_pack_id
  ) fa on fa.fa_pack_id = nasel_fa_pack.fa_pack_id

  left join nasel_lookup_val on nasel_lookup_val.field_name = 'FA_PACK_TYPE_CD' 
    and nasel_lookup_val.field_value = nasel_fa_pack.fa_pack_type_cd
 

  where nasel_fa_pack.acct_otdelen = p_acct_otdelen
    and ( ( 0 = :app_mode and fa_pack_type_cd in ('10','20') ) 
     or (:app_mode = 1 and fa_pack_type_cd in ('40') ) )
    --and trim(fa_pack_type_cd) = :fa_pack_type_cd

  order by nasel_fa_pack.cre_dttm desc 
) t;
end;*/



 
begin
  null;
end pk_nasel_sweety;



  /*open p_cursor;
  loop
    fetch p_cursor into v_res;
    exit when p_cursor%notfound;
    DBMS_OUTPUT.put_line(v_res.acct_id);
  end loop;
  close p_cursor; */ 
 
  /*for r in p_cursor
  loop
    null;
  end loop;*/
/
