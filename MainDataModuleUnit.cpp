/*
  Основной управляющий модуль программы.

  Примечание:
  На текущий момент в данном модуле также хранится набор всех основных используемых
  запросов. В дальнейшем необходимо перенести в отдельный модуль.

  Использование.
  1. Для выполнения запросов в фоновом режиме

  Важно:
  1. Запросы
    getOtdelenListQuery
    getFaPackInfo
    являются стратегически важными. В них хранится текущее состояние модели.

*/

// Режим отладки
//#define DEBUG
//#undef NDEBUG

#include <vcl.h>
#pragma hdrstop

#include "MainDataModuleUnit.h"
#include "NoticesDataModuleUnit.h"
#include "StopDataModuleUnit.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBAccess"
#pragma link "Ora"
#pragma link "MemDS"
#pragma link "VirtualTable"
#pragma link "DataSetFilter"
#pragma link "OraSmart"
#pragma resource "*.dfm"
TMainDataModule *MainDataModule;

using namespace Dateutils;
using namespace strtools;


/* Копирует данные из источника в приемник */
void __fastcall TMainDataModule::CopyDataSet(TDataSet* sourceDs, TDataSet* destinationDs)
{
    destinationDs->DisableControls();
    destinationDs->FieldDefs->Assign(sourceDs->FieldDefs);
    destinationDs->Open();
    destinationDs->Assign(sourceDs);
    destinationDs->EnableControls();
}

/*
void __fastcall TMainDataModule::CopyDataSet(TDataSet* sourceDs, TDataSet* destinationDs)
{
    destinationDs->FieldDefs->Assign(sourceDs->FieldDefs);
    destinationDs->Open();
    destinationDs->Assign(sourceDs);
    //ShowMessage(MainDataModule->VirtualTable1->RecordCount);
    //DBGridAltGeneral->DataSource->DataSet = MainDataModule->VirtualTable1;
    //MainDataModule->VirtualTable1->Filtered = true;
}  */


/*
  Описание объектов:
  getConfigQuery - запрос для получения конфигурационных данных для текущего пользователя


  getCcStatusFlgListQuery - Типы статусов контактов
  getCcTypeCdQuery - Типы контактов

  getDebtors
  getFaPackQuery
  getApprovalListQuery
  getStopListQuery
  selectFaPackQuery

*/


// Авторизация пользователя в программе
//void __fastcall TMainDataModule::Auth()
//{
    //TLoginForm* LoginForm = new TLoginForm(Application);
    //bool loggedon = LoginForm->Execute(EsaleSession);

    /*_username = UpperCase(LoginForm->getUsername());
    AddSystemVariable("username", _username);
    delete LoginForm;*/
   /* return loggedon;*/
//}

// Открывает запрос или обновляет (параметры)
void TMainDataModule::openOrRefresh(TDataSet* query)
{
    //query->Close();
   /* if (query->State == dsOpening)
    {
        Sleep(500);
    }*/
    if (query->Active)
    {
        query->Refresh();
    }
    else
    {
        query->Open();
    }
}


DualList::DualList() :
    _used(false),
    _sourceQuery(NULL)

{
    _descrList = new TStringList();
    _valueList = new TStringList();
}

DualList::~DualList()
{
    if (_descrList != NULL)
    {
        delete _descrList;
        _descrList = NULL;
        delete _valueList;
        _valueList = NULL;
    }
}

void DualList::assignTo(TComboBox* comboBox)
{
    if (!_used && _sourceQuery != NULL)
    {
        addFromQuery(_sourceQuery);
    }

    comboBox->Clear();
    comboBox->Items->Assign(_descrList);
    comboBox->ItemIndex = 0;
}


void DualList::setUsed()
{
    _used = true;
}

void DualList::setSourceQuery(TOraQuery* query)
{
    _sourceQuery = query;
}

//---------------------------------------------------------------------------
// добавляет "наименование - значение" в список
void DualList::add(const String& descr, const String& value)
{
    setUsed();
    _valueList->Add(value);
    _descrList->Add(descr);
}

//---------------------------------------------------------------------------
// Добавляет список "наименование - значение" из запроса
void DualList::addFromQuery(TOraQuery* listQuery)
{
    _sourceQuery->Open();
    _sourceQuery->First();
    while ( !listQuery->Eof )
    {
        add(listQuery->FieldByName("descr")->AsString, listQuery->FieldByName("value")->AsString);
        listQuery->Next();
    }
    _sourceQuery->Close();
}

/*
*/
String DualList::getValue(int index)
{
    if (!_used && _sourceQuery != NULL)
    {
        addFromQuery(_sourceQuery);
    }
    //return _valueList->Values[this->OtdelenComboBox->ItemIndex];
    return _valueList->Strings[index];
}

/*
*/
String DualList::getValue(TComboBox* comboBox)
{
    return getValue(comboBox->ItemIndex);
}

/*
*/
__fastcall TMainDataModule::TMainDataModule(TComponent* Owner)
    : TDataModule(Owner)
    //_currentFaPackId("")
{
    // Список для комбобокса
    //otdelenList.setSourceQuery(getOtdelenList);
    //getOtdelenListDataSource->DataSet = getOtdelenListRam;
    //getOpAreaDataSource->DataSet = getOpAreaRam;

    //getFpReconnectDataSource

    getPreOverdueListDataSource->DataSet = getPreOverdueListRam;        // Список просроченных заявок
    getFpOverdueContentDataSource->DataSet = getFpOverdueContentRam;    // Список абонентов в реестре просроченных заявок
    getFpOverdueListDataSource->DataSet = getFpOverdueListRam;          // Список реестров просроченных заявок

    //getFaPackListNoticesDataSource->DataSet = getFaPackListNoticesRam;

    findFaPackListNoticesDS->DataSet = findFaPackListNoticesRam;
    findFaPackListStopDS->DataSet = findFpStopListRam;
    findFpOverdueListDataSource->DataSet = findFpOverdueListRam;

}

/*
*/
void __fastcall TMainDataModule::connectEsale()
{
    MainDataModule->EsaleSession->Connect();
}

/*
*/
void __fastcall TMainDataModule::DataModuleCreate(TObject *Sender)
{
    /* Авторизация пользователя */
    //#ifdef _DEBUG
    EsaleSession->Username = "";
    EsaleSession->Password = "";
    //#endif

    TLoginForm* loginForm = new TLoginForm(this, EsaleSession, false);
    bool auth = loginForm->execute();



    userRole.insert(TUserRole::UNDEFINED);
    if ( auth )
    {
        // Если соединение установлено, то определяем роль
        if (loginForm->checkRole("SWT_USER_ROLE") || loginForm->checkRole("TASK_SWEETY_USER_ROLE"))
        {
            userRole.insert(TUserRole::USER_BASE);
        }
        if (loginForm->checkRole("SWT_APPROVER_ROLE") || loginForm->checkRole("TASK_SWEETY_APPROVER_ROLE") )
        {
            userRole.insert(TUserRole::APPROVER);
        }
        if ( loginForm->checkRole("SWT_OPERATOR_ROLE") || loginForm->checkRole("TASK_SWEETY_OPERATOR_ROLE") )
        {
            userRole.insert(TUserRole::OPERATOR);
        }
        if ( loginForm->checkRole("SWT_ADMINISTRATOR_ROLE") || loginForm->checkRole("TASK_SWEETY_ADMINISTRATOR_ROLE") )
        {
            userRole.insert(TUserRole::ADMINISTRATOR);
        }
        if ( loginForm->checkRole("SWT_VIEWER_ROLE") || loginForm->checkRole("TASK_SWEETY_VIEWER_ROLE") )
        {
            userRole.insert(TUserRole::VIEWER);
        }
        if ( loginForm->checkRole("SWT_TESTER_ROLE") || loginForm->checkRole("TASK_SWEETY_TESTER_ROLE"))
        {
            userRole.insert(TUserRole::TESTER);
        }

        // Если ролей больше 1 то удаляем роль TUserRole::UNDEFINED
        if (userRole.size() > 1)
        {
            userRole.erase(TUserRole::UNDEFINED);
        }
    }
    else  // Выход если не произошло авторизации
    {
        delete loginForm;
        Application->Terminate();
        Application->ProcessMessages();
        return;
    }

    delete loginForm;

    if ( userRole.find(TUserRole::UNDEFINED) != userRole.end() )
    {   // Если роль не установлена то выходим из программы
        Application->Terminate();
        Application->ProcessMessages();
        MessageBoxStop("Вы не имеете полномочий для работы в этой программе.\nПрограмма будет закрыта.");
        return;
    }



    /*  */
    String appPath = ExtractFilePath(Application->ExeName);

    getConfigProc->ParamByName("p_app_path")->AsString = appPath;
    getConfigProc->ParamByName("p_app_ver")->AsString = AppVer::Build;
    getConfigProc->Open();

    // Проверяем разрешен ли доступ к программе
    // По версии программы
    // или по другим причинам
    // В будущем предусмотреть сообщение из БД


    if (!getConfigProc->FieldByName("stop_allert")->IsNull)
    {
        #ifndef _DEBUG
        //Form1->Caption = Form1->Caption + " (Debuging...)";
        Application->Terminate();
        Application->ProcessMessages();
        #endif

        MessageBoxStop(getConfigProc->FieldByName("stop_allert")->AsString);

        #ifndef _DEBUG
        return;
        #endif
    }

    // Время запуска программы
    TDateTime dt = getConfigProc->FieldByName("today")->AsDateTime;
    String beginDt = DateToStr(IncMonth(dt, -3));
    String endDt = DateToStr(dt);



    // Соединяемся с базой данных 
    //connectEsale();

    getCcStatusFlgListQuery->Open();
    getCcTypeCdQuery->Open();

    // Настройки программы
    getConfigQuery->ParamByName("app_path")->AsString = appPath;
    getConfigQuery->ParamByName("username")->AsString = EsaleSession->Username;
    getConfigQuery->Open();

    // Список отделений и прочая общая информация
    //getOtdelenListProc->ParamByName("p_app_path")->AsString = appPath;
    getOtdelenListProc->Open();
    getOpAreaProc->Open();

   
    if ( getOtdelenListProc->RecordCount == 0 )
    { // Если для пользователя нет доступных участков
        Application->Terminate();
        Application->ProcessMessages();
        MessageBoxStop("Вы не имеете доступных участков.\nПрограмма будет закрыта.");
        return;
    }


    /* Задаем текущее отделение */
    // 2017-10-04
    //setAcctOtdelen(getOtdelenListProc->FieldByName("acct_otdelen")->AsString);
    _acctOtdelen = getOtdelenListProc->FieldByName("acct_otdelen");     // Поле

    // 2017-10-05
    //CopyDataSet(getOtdelenListProc, getOtdelenListRam);
    //CopyDataSet(getOpAreaProc, getOpAreaRam);


    getOtdelenListFilter->add("acct_otdelen", "acct_otdelen = ':param'");

    /* Создание фильтров */
    /* Фильтр для работы с выделенными строками */
    getCheckedFilter->add("checked", "check_data = :param"); // Отмеченные
    getCheckedFilter->add("group", "grp_data = :param"); // С группировкой (например, для формирования заявок на отключение
                                                    // сгруппированных по сетевым в отдельные файлы)

    /* Фильтр для полного списка абонентов */
    NoticesDataModule->getAcctFullListFilter->DisableControls();
    NoticesDataModule->getAcctFullListFilter->add("AcctIdComboBox", "acct_id like '%:param%'");
    NoticesDataModule->getAcctFullListFilter->add("AddressComboBox", "address like '%:param%'");
    NoticesDataModule->getAcctFullListFilter->add("CityComboBox", "city like '%:param%'");
    NoticesDataModule->getAcctFullListFilter->add("FioComboBox", "fio like '%:param%'");
    NoticesDataModule->getAcctFullListFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");
    NoticesDataModule->getAcctFullListFilter->add("ServiceCompanyFilterComboBox", "service_org like '%:param%'");
    NoticesDataModule->getAcctFullListFilter->add("SaldoFilterEdit", "saldo_uch > :param");
    NoticesDataModule->getAcctFullListFilter->add("OpAreaDescrFilterComboBox", "op_area_descr like '%:param%'");
    //getAcctFullListFilter->add("cc_dttm", "(:param)");
    NoticesDataModule->getAcctFullListFilter->add("CcDttmStatusComboBox", "(:param = 0 or (:param=1 and cc_dttm is not null) or (:param=2 and cc_dttm is null) or (:param=3 and cc_dttm >= ':begin_dt' and cc_dttm < ':end_dt') )");
    NoticesDataModule->getAcctFullListFilter->setDefaultValue("CcDttmStatusComboBox", "param", "0");
    NoticesDataModule->getAcctFullListFilter->setDefaultValue("CcDttmStatusComboBox", "begin_dt", beginDt);
    NoticesDataModule->getAcctFullListFilter->setDefaultValue("CcDttmStatusComboBox", "end_dt", endDt);

    // Фильтры для пометок (мб перенести в отдельный фильтр?)
    NoticesDataModule->getAcctFullListFilter->add("cc_dttm_is", "cc_dttm is :param");
    NoticesDataModule->getAcctFullListFilter->add("cc_dttm_more", "(cc_dttm < ':param' or cc_dttm is null)");

    NoticesDataModule->getAcctFullListFilter->EnableControls();


    /* Фильтр для списка должников */
    NoticesDataModule->getPreDebtorListFilter->DisableControls();
    NoticesDataModule->getPreDebtorListFilter->add("AcctIdComboBox", "acct_id like '%:param%'");
    NoticesDataModule->getPreDebtorListFilter->add("AddressComboBox", "address like '%:param%'");
    NoticesDataModule->getPreDebtorListFilter->add("CityComboBox", "city like '%:param%'");
    NoticesDataModule->getPreDebtorListFilter->add("FioComboBox", "fio like '%:param%'");
    NoticesDataModule->getPreDebtorListFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");
    NoticesDataModule->getPreDebtorListFilter->add("ServiceCompanyFilterComboBox", "service_org like '%:param%'");
    NoticesDataModule->getPreDebtorListFilter->add("SaldoFilterEdit", "saldo_uch > :param");
    NoticesDataModule->getPreDebtorListFilter->add("OpAreaDescrFilterComboBox", "op_area_descr like '%:param%'");
    //getDebtorsFilter->add("cc_dttm", "(:param)");
    NoticesDataModule->getPreDebtorListFilter->add("CcDttmStatusComboBox", "(:param = 0 or (:param=1 and cc_dttm is not null) or (:param=2 and cc_dttm is null) or (:param=3 and cc_dttm >= ':begin_dt' and cc_dttm < ':end_dt') )");
    NoticesDataModule->getPreDebtorListFilter->setDefaultValue("CcDttmStatusComboBox", "param", "0");
    NoticesDataModule->getPreDebtorListFilter->setDefaultValue("CcDttmStatusComboBox", "begin_dt", beginDt);
    NoticesDataModule->getPreDebtorListFilter->setDefaultValue("CcDttmStatusComboBox", "end_dt", endDt);
    NoticesDataModule->getPreDebtorListFilter->add("MrRteCdFilterComboBox", "mr_rte_cd like '%:param%'");

    // Фильтры для пометок (мб перенести в отдельный фильтр?)
    NoticesDataModule->getPreDebtorListFilter->add("cc_dttm_is", "cc_dttm is :param");
    NoticesDataModule->getPreDebtorListFilter->add("cc_dttm_more", "(cc_dttm < ':param' or cc_dttm is null)");

    // Фильтр для контролов
    //getDebtorsFilter->add("vcl_ctrl", "");
    //getDebtorsFilter->setValue("vcl_ctrl", "begin_dt", beginDt);
    //getDebtorsFilter->setValue("vcl_ctrl", "end_dt", endDt);

    NoticesDataModule->getPreDebtorListFilter->EnableControls();


    /* Фильтр для списка уведомлений */
    //DBGridAltManual->Filtered = true;
    NoticesDataModule->getFpNoticesContentFilter->DisableControls();
    NoticesDataModule->getFpNoticesContentFilter->add("AcctIdComboBox", "acct_id like '%:param%'");
    NoticesDataModule->getFpNoticesContentFilter->add("AddressComboBox", "address like '%:param%'");
    NoticesDataModule->getFpNoticesContentFilter->add("CityComboBox", "city like '%:param%'");
    NoticesDataModule->getFpNoticesContentFilter->add("FioComboBox", "fio like '%:param%'");
    NoticesDataModule->getFpNoticesContentFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");
    NoticesDataModule->getFpNoticesContentFilter->add("ServiceCompanyFilterComboBox", "service_org like '%:param%'");
    NoticesDataModule->getFpNoticesContentFilter->add("SaldoFilterEdit", "saldo_uch > :param");
    NoticesDataModule->getFpNoticesContentFilter->add("OpAreaDescrFilterComboBox", "op_area_descr like '%:param%'");
    NoticesDataModule->getFpNoticesContentFilter->add("MrRteCdFilterComboBox", "mr_rte_cd like '%:param%'");
    NoticesDataModule->getFpNoticesContentFilter->add("CcCallerFilterEdit", "caller like '%:param%'");
    NoticesDataModule->getFpNoticesContentFilter->add("PremTypeComboBox", "prem_type_descr like '%:param%'");

    NoticesDataModule->getFpNoticesContentFilter->add("CcDttmStatusComboBox", "(:param = 0 or (:param=1 and cc_dttm is not null) or (:param=2 and cc_dttm is null) or (:param=3 and cc_dttm >= ':begin_dt' and cc_dttm < ':end_dt') )");
    NoticesDataModule->getFpNoticesContentFilter->setDefaultValue("CcDttmStatusComboBox", "param", "0");
    NoticesDataModule->getFpNoticesContentFilter->setDefaultValue("CcDttmStatusComboBox", "begin_dt", beginDt);
    NoticesDataModule->getFpNoticesContentFilter->setDefaultValue("CcDttmStatusComboBox", "end_dt", endDt);

    // Фильтры для пометок
    NoticesDataModule->getFpNoticesContentFilter->add("cc_dttm_is", "cc_dttm is :param");
    NoticesDataModule->getFpNoticesContentFilter->add("cc_dttm_more", "(cc_dttm < ':param' or cc_dttm is null)");

    NoticesDataModule->getFpNoticesContentFilter->EnableControls();



    /* Фильтр для списка уведомлений */
    //DBGridAltManual->Filtered = true;
    NoticesDataModule->getPrePostListFilter->DisableControls();
    NoticesDataModule->getPrePostListFilter->add("AcctIdComboBox", "acct_id like '%:param%'");
    NoticesDataModule->getPrePostListFilter->add("AddressComboBox", "address like '%:param%'");
    NoticesDataModule->getPrePostListFilter->add("CityComboBox", "city like '%:param%'");
    NoticesDataModule->getPrePostListFilter->add("FioComboBox", "fio like '%:param%'");
    NoticesDataModule->getPrePostListFilter->add("ServiceCompanyFilterComboBox", "service_org like '%:param%'");
    NoticesDataModule->getPrePostListFilter->add("SaldoFilterEdit", "saldo_uch > :param");
    NoticesDataModule->getPrePostListFilter->add("OpAreaDescrFilterComboBox", "op_area_descr like '%:param%'");
    //getPostListFilter->add("CcDttmStatusComboBox", "(:param = 0 or (:param=1 and cc_dttm is not null) or (:param=2 and cc_dttm is null) )");
    /*getPostListFilter->add("CcDttmStatusComboBox", "(:param = 0 or (:param=1 and cc_dttm is not null) or (:param=2 and cc_dttm is null) or (:param=3 and cc_dttm >= ':begin_dt' and cc_dttm < ':end_dt') )");
    getPostListFilter->setDefaultValue("CcDttmStatusComboBox", "param", "0");
    getPostListFilter->setDefaultValue("CcDttmStatusComboBox", "begin_dt", beginDt);
    getPostListFilter->setDefaultValue("CcDttmStatusComboBox", "end_dt", endDt);*/



    NoticesDataModule->getPrePostListFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");

    // Фильтры для пометок
    //getPostListFilter->add("cc_dttm_is", "cc_dttm is :param");
    //getPostListFilter->add("cc_dttm_more", "(cc_dttm < ':param' or cc_dttm is null)");
    NoticesDataModule->getPrePostListFilter->EnableControls();



    /* Список для утверждения */
    NoticesDataModule->getApprovalListFilter->DisableControls();
    NoticesDataModule->getApprovalListFilter->add("AcctIdComboBox", "acct_id like '%:param%'");
    NoticesDataModule->getApprovalListFilter->add("AddressComboBox", "address like '%:param%'");
    NoticesDataModule->getApprovalListFilter->add("CityComboBox", "city like '%:param%'");
    NoticesDataModule->getApprovalListFilter->add("FioComboBox", "fio like '%:param%'");
    //getApprovalListFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");
    NoticesDataModule->getApprovalListFilter->add("ServiceCompanyFilterComboBox", "service_org like '%:param%'");
    NoticesDataModule->getApprovalListFilter->add("SaldoFilterEdit", "saldo_uch > :param");
    //getApprovalListFilter->add("cc_dttm", "(:param)");
    //getApprovalListFilter->add("ccDttmIsApprovedCheckBox", "approval_dttm is not null :param");
    //getApprovalListFilter->add("ApprovedStatusComboBox", "approval_dttm is :param null"); // is [not] null
    NoticesDataModule->getApprovalListFilter->add("ApprovedStatusComboBox", "(:param = 0 or (:param=1 and cc_status_flg = '20') or (:param=2 and cc_status_flg='10') or (:param=3 and cc_status_flg = '50') )"); // is [not] null
    //getApprovalListFilter->setValue("ApprovedStatusComboBox", "param", "2");
    NoticesDataModule->getApprovalListFilter->setDefaultValue("ApprovedStatusComboBox", "param", "2");

    /*getApprovalListFilter->add("ApprovedStatusComboBox"
        , "(:param = 0 or (:param=1 and approval_dttm is null) or (:param=2 and approval_dttm is not null) )" ); // is [not] null    */

    // Фильтры для пометок
    NoticesDataModule->getApprovalListFilter->add("cc_dttm_is", "cc_dttm is :param");
    NoticesDataModule->getApprovalListFilter->add("cc_dttm_more", "(cc_dttm < ':param' or cc_dttm is null)");
    NoticesDataModule->getApprovalListFilter->EnableControls();




    /* Фильтр для списка на ограничение */
    StopDataModule->getPreStopListFilter->DisableControls();
    StopDataModule->getPreStopListFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");
    StopDataModule->getPreStopListFilter->add("AcctIdComboBox", "acct_id like '%:param%'");
    StopDataModule->getPreStopListFilter->add("AddressComboBox", "address like '%:param%'");
    StopDataModule->getPreStopListFilter->add("CityComboBox", "city like '%:param%'");
    StopDataModule->getPreStopListFilter->add("FioComboBox", "fio like '%:param%'");
    StopDataModule->getPreStopListFilter->add("SaldoFilterEdit", "saldo_uch > :param");
    StopDataModule->getPreStopListFilter->add("ServiceCompanyFilterComboBox", "rt_descr like '%:param%'");
    StopDataModule->getPreStopListFilter->add("PremTypeComboBox", "prem_type_descr like '%:param%'");
    StopDataModule->getPreStopListFilter->add("FaPackTypeFilterComboBox", "fa_pack_type_descr like '%:param%'");
    StopDataModule->getPreStopListFilter->add("CcDttmStatusComboBox", "(:param = 0 or (:param=1 and cc_dttm is not null) or (:param=2 and cc_dttm is null) or (:param=3 and cc_dttm >= ':begin_dt' and cc_dttm < ':end_dt') )");
    StopDataModule->getPreStopListFilter->setDefaultValue("CcDttmStatusComboBox", "param", "3");
    StopDataModule->getPreStopListFilter->setDefaultValue("CcDttmStatusComboBox", "begin_dt", "01.01.1900");
    StopDataModule->getPreStopListFilter->setDefaultValue("CcDttmStatusComboBox", "end_dt", IncDay(dt, -17));
    StopDataModule->getPreStopListFilter->EnableControls();

    /* Фильтр для списка реестров на ограничение */
    StopDataModule->getFpStopListFilter->DisableControls();
    StopDataModule->getFpStopListFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");
    StopDataModule->getFpStopListFilter->add("ServiceCompanyFilterComboBox", "rt_descr like '%:param%'");
    StopDataModule->getFpStopListFilter->add("FaPackStatusFilterComboBox", "(:param = 0 or "
        "(:param=1 and fa_pack_status_flg = '20') "
        "or (:param=2 and fa_pack_status_flg = '50') "
        "or (:param=3 and fa_pack_status_flg = '60')) "
        );
    //getFpStopListFilter->add("AddressComboBox", "address like '%:param%'");
    //getFpStopListFilter->add("FioComboBox", "fio like '%:param%'");
    StopDataModule->getFpStopListFilter->setDefaultValue("FaPackStatusFilterComboBox", "param", "2");
    StopDataModule->getFpStopListFilter->EnableControls();


    /* Фильтр для списка реестров на отмену ограничения */
    StopDataModule->getFpCancelListFilter->DisableControls();
    StopDataModule->getFpCancelListFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");
    StopDataModule->getFpCancelListFilter->add("ServiceCompanyFilterComboBox", "rt_descr like '%:param%'");
    StopDataModule->getFpCancelListFilter->add("FaPackStatusFilterComboBox", "(:param = 0 or "
        "(:param=1 and fa_pack_status_flg = '20') "
        "or (:param=2 and fa_pack_status_flg = '50') "
        "or (:param=3 and fa_pack_status_flg = '60'))"
        );
    StopDataModule->getFpCancelListFilter->setDefaultValue("FaPackStatusFilterComboBox", "param", "2");
    StopDataModule->getFpCancelListFilter->EnableControls();


    /* Фильтр для списка реестров на возобноление */
    StopDataModule->getFpReconnectListFilter->DisableControls();
    StopDataModule->getFpReconnectListFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");
    StopDataModule->getFpReconnectListFilter->add("ServiceCompanyFilterComboBox", "rt_descr like '%:param%'");
    StopDataModule->getFpReconnectListFilter->add("FaPackStatusFilterComboBox", "(:param = 0 or "
        "(:param=1 and fa_pack_status_flg = '20') "
        "or (:param=2 and fa_pack_status_flg = '50') "
        "or (:param=3 and fa_pack_status_flg = '60')) "
        );
    StopDataModule->getFpReconnectListFilter->setDefaultValue("FaPackStatusFilterComboBox", "param", "2");
    StopDataModule->getFpReconnectListFilter->EnableControls();


    /* Фильтр для реестра на ограничение */
    StopDataModule->getFpStopContentFilter->DisableControls();
    StopDataModule->getFpStopContentFilter->add("AcctIdComboBox", "acct_id like '%:param%'");
    StopDataModule->getFpStopContentFilter->add("FaIdFilterEdit", "fa_id like '%:param%'");
    StopDataModule->getFpStopContentFilter->add("AddressComboBox", "address like '%:param%'");
    StopDataModule->getFpStopContentFilter->add("CityComboBox", "city like '%:param%'");
    StopDataModule->getFpStopContentFilter->add("FioComboBox", "fio like '%:param%'");
    StopDataModule->getFpStopContentFilter->EnableControls();

    /* Фильтр для реестра на ограничение */
    StopDataModule->getFpCancelContentFilter->DisableControls();
    StopDataModule->getFpCancelContentFilter->add("AcctIdComboBox", "acct_id like '%:param%'");
    StopDataModule->getFpCancelContentFilter->add("FaIdFilterEdit", "fa_id like '%:param%'");
    StopDataModule->getFpCancelContentFilter->add("AddressComboBox", "address like '%:param%'");
    StopDataModule->getFpCancelContentFilter->add("CityComboBox", "city like '%:param%'");
    StopDataModule->getFpCancelContentFilter->add("FioComboBox", "fio like '%:param%'");
    StopDataModule->getFpCancelContentFilter->EnableControls();

    /* Фильтр для реестра на возобновление */
    StopDataModule->getFpReconnectContentFilter->DisableControls();
    StopDataModule->getFpReconnectContentFilter->add("AcctIdComboBox", "acct_id like '%:param%'");
    StopDataModule->getFpReconnectContentFilter->add("FaIdFilterEdit", "fa_id like '%:param%'");
    StopDataModule->getFpReconnectContentFilter->add("AddressComboBox", "address like '%:param%'");
    StopDataModule->getFpReconnectContentFilter->add("CityComboBox", "city like '%:param%'");
    StopDataModule->getFpReconnectContentFilter->add("FioComboBox", "fio like '%:param%'");
    StopDataModule->getFpReconnectContentFilter->EnableControls();






    /* Фильтр для списка просроченных заявок */
    getPreOverdueListFilter->DisableControls();
    getPreOverdueListFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");
    getPreOverdueListFilter->add("AcctIdComboBox", "acct_id like '%:param%'");
    getPreOverdueListFilter->add("AddressComboBox", "address like '%:param%'");
    getPreOverdueListFilter->add("CityComboBox", "city like '%:param%'");
    getPreOverdueListFilter->add("FioComboBox", "fio like '%:param%'");
    //getPreOverdueListFilter->add("SaldoFilterEdit", "saldo_uch > :param");
    getPreOverdueListFilter->add("ServiceCompanyFilterComboBox", "rt_descr like '%:param%'");
    getPreOverdueListFilter->add("PremTypeComboBox", "prem_type_descr like '%:param%'");
    //getPreOverdueListFilter->add("FaPackTypeFilterComboBox", "fa_pack_type_descr like '%:param%'");
    //getPreOverdueListFilter->add("CcDttmStatusComboBox", "(:param = 0 or (:param=1 and cc_dttm is not null) or (:param=2 and cc_dttm is null) or (:param=3 and cc_dttm >= ':begin_dt' and cc_dttm < ':end_dt') )");
    //getPreOverdueListFilter->setDefaultValue("CcDttmStatusComboBox", "param", "3");
    //getPreOverdueListFilter->setDefaultValue("CcDttmStatusComboBox", "begin_dt", "01.01.1900");
    //getPreOverdueListFilter->setDefaultValue("CcDttmStatusComboBox", "end_dt", IncDay(dt, -17));
    getPreOverdueListFilter->EnableControls();


    /* Фильтр для списка реестров просроченных заявок */
    getFpOverdueListFilter->DisableControls();
    getFpOverdueListFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");
    getFpOverdueListFilter->add("ServiceCompanyFilterComboBox", "rt_descr like '%:param%'");
    getFpOverdueListFilter->EnableControls();

    /* Фильтр для реестра просроченных заявок */
    getFpOverdueContentFilter->DisableControls();
    getFpOverdueContentFilter->add("AcctIdComboBox", "acct_id like '%:param%'");
    //getFpOverdueContentFilter->add("FaIdFilterEdit", "fa_id like '%:param%'");
    getFpOverdueContentFilter->add("AddressComboBox", "address like '%:param%'");
    getFpOverdueContentFilter->add("CityComboBox", "city like '%:param%'");
    getFpOverdueContentFilter->add("FioComboBox", "fio like '%:param%'");
    getFpOverdueContentFilter->EnableControls();




   /* Все
Отменен
Утвержден
Исполнен
Отправлен исполнителю
Отправлен абоненту*/


    /* Фильтры для выбора реестра уведомлений */
    findFaPackListNoticesFilter->DisableControls();
    findFaPackListNoticesFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");
    //findFaPackListNoticesFilter->add("FaPackTypeDescrFilterComboBox", "fa_pack_type_descr like '%:param%'");
    findFaPackListNoticesFilter->add("FaPackTypeCdFilterComboBox", "(:param = 0 or (:param=1 and fa_pack_type_cd = '10') or (:param=2 and fa_pack_type_cd = '20') or (:param=3 and fa_pack_type_cd = '40') or (:param=4 and fa_pack_type_cd = '45') or (:param=5 and fa_pack_type_cd = '50'))");
    findFaPackListNoticesFilter->add("FaPackStatusFlgFilterComboBox", "(:param = 0 or (:param=1 and fa_pack_status_flg = '50') or (:param=2 and fa_pack_status_flg = '20') )");
    findFaPackListNoticesFilter->add("OwnerFilterEdit", "owner like '%:param%'");
    findFaPackListNoticesFilter->setDefaultValue("FaPackTypeCdFilterComboBox", "param", "0");
    findFaPackListNoticesFilter->setDefaultValue("FaPackStatusFlgFilterComboBox", "param", "0");
    findFaPackListNoticesFilter->EnableControls();

    /* Фильтры для выбора реестра заявок на отключение */
    findFpStopListFilter->DisableControls();
    findFpStopListFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");
    //findFpStopListFilter->add("FaPackTypeDescrFilterComboBox", "fa_pack_type_descr like '%:param%'");
    findFpStopListFilter->add("FaPackTypeCdFilterComboBox", "(:param = 0 or (:param=1 and fa_pack_type_cd = '10') or (:param=2 and fa_pack_type_cd = '20') or (:param=3 and fa_pack_type_cd = '40') or (:param=4 and fa_pack_type_cd = '45') or (:param=5 and fa_pack_type_cd = '50'))");
    findFpStopListFilter->add("FaPackStatusFlgFilterComboBox", "(:param = 0 or (:param=1 and fa_pack_status_flg = '50') or (:param=2 and fa_pack_status_flg = '20') )");
    findFpStopListFilter->setDefaultValue("FaPackTypeCdFilterComboBox", "param", "0");
    findFpStopListFilter->setDefaultValue("FaPackStatusFlgFilterComboBox", "param", "0");
    findFpStopListFilter->add("OwnerFilterEdit", "owner like '%:param%'");
    findFpStopListFilter->EnableControls();


    /* Фильтры для выбора реестра заявок на отключение */
    findFpOverdueListFilter->DisableControls();
    findFpOverdueListFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");
    findFpOverdueListFilter->add("FaPackTypeCdFilterComboBox", "(:param = 0 or (:param=1 and fa_pack_type_cd = '10') or (:param=2 and fa_pack_type_cd = '20') or (:param=3 and fa_pack_type_cd = '40') or (:param=4 and fa_pack_type_cd = '45') or (:param=5 and fa_pack_type_cd = '50'))");
    findFpOverdueListFilter->add("FaPackStatusFlgFilterComboBox", "(:param = 0 or (:param=1 and fa_pack_status_flg = '50') or (:param=2 and fa_pack_status_flg = '20') )");
    findFpOverdueListFilter->setDefaultValue("FaPackTypeCdFilterComboBox", "param", "0");
    findFpOverdueListFilter->setDefaultValue("FaPackStatusFlgFilterComboBox", "param", "0");
    findFpOverdueListFilter->add("OwnerFilterEdit", "owner like '%:param%'");
    findFpOverdueListFilter->EnableControls();




    //getOtdelenList->Open();
    //TOtdelenComboBoxFrame::add("тестирование","ddd");
    //TOtdelenComboBoxFrame::addFromQuery(getOtdelenList);
    //getOtdelenList->Close();


    /*faTypesList.add("Все", "0");
    faTypesList.add("Реестр контролеру", "1");
    faTypesList.add("Реестр по почте", "2");
    faTypesList.add("Реестр на отключение", "3");*/

    /*faTypesAndDebtorList.add("Должники", "0");
    faTypesAndDebtorList.add("Реестр контролеру", "1");
    faTypesAndDebtorList.add("Реестр по почте", "2");
    faTypesAndDebtorList.add("Реестр на отключение", "3");*/







    //getFaPackInfProc->ParamByName("app_path")->AsString = appPath;
    /* DataSet Powerfull Filters */
    //_filterForApprove;
    //_filterForApprove.add("1", "check_data = 1");

        // Список для утверждения
/*    {
        //ApproveListGrid->Filtered = true;
        //ApproveListGrid->assignFilter(&_filterApproveList);
        _filterApproveList->add(AcctIdComboBox->Name, "acct_id like '%:param%'");
        _filterApproveList->add(AddressComboBox->Name, "address like '%:param%'");
        _filterApproveList->add(FioComboBox->Name, "fio like '%:param%'");
        _filterApproveList->add(FaPackIdEdit->Name, "fa_pack_id like '%:param%'");
        _filterApproveList->add(ServiceCompanyFilterComboBox->Name, "service_org like '%:param%'");
        _filterApproveList->add(SaldoFilterEdit->Name, "saldo_uch > :param");
        _filterApproveList->add(CityComboBox->Name, "city like '%:param%'");

        //_filter.add("cc_dttm", "cc_dttm >= ':begin_cc_dttm' and cc_dttm <= ':end_cc_dttm'");
        TDBGridAltFilterItem* filterItem = _filterApproveList.add("cc_dttm", "((cc_dttm >= ':begin_cc_dttm' and cc_dttm <= ':end_cc_dttm') :or_cc_dttm_is_null)");
        filterItem->addParameter(":begin_cc_dttm");
        filterItem->addParameter(":end_cc_dttm");
        filterItem->addParameter(":or_cc_dttm_is_null");

        // Фильтры для пометок
        _filterApproveList->add("cc_dttm_is", "cc_dttm is :param");
        _filterApproveList->add("cc_dttm_more", "(cc_dttm < ':param' or cc_dttm is null)");
    } */



}

/* Обработка событий в потоке */
void _fastcall TMainDataModule::OnThreadEvent(TThreadEventMessage Message, void* ds)
{

    switch(Message)
    {
    case TEM_THREAD_BEGIN:
    {
        if (_beforeOpenDataSet != NULL)
        {
            _beforeOpenDataSet(this);
        }
        break;
    }
    case TEM_THREAD_END:
    {

        if ( _afterOpenDataSet != NULL )
        {
            _afterOpenDataSet(this);
        }
        _threadDataSet = NULL;
        break;

    }
    case TEM_DATABASE_ERROR:
    {
        if ( _afterOpenDataSet != NULL )
        {
            _afterOpenDataSet(this);
        }
        _threadDataSet = NULL;
        MessageBoxStop( *((String*)ds) );
        break;
    }
    case TEM_DATASET_COPY_BEGIN:
    {
        break;
    }
    }
}

/* Удаляет контакт
*/
void TMainDataModule::deleteCc(
    TDataSet* ds,
    Variant ccId
)
{
    try
    {
        deleteCcProc->ParamByName("p_cc_id")->Value = ccId;
        deleteCcProc->ExecProc();

        ds->DisableControls();
        ds->Edit();
        ds->FieldByName("cc_id")->Clear();
        ds->FieldByName("cc_dttm")->Clear();
        ds->Post();
        ds->EnableControls();
    }
    catch(Exception &e)
    {
        throw Exception(e);
    }
}

/* Задает новые параметры контракта
*/
void TMainDataModule::updateCc(
    TDataSet* ds,
    Variant ccId,
    TDateTime ccDttm,
    const String& descr,
    TAgentTypeCd::Type agentTypeCd,
    const String& agentId,
    const String& agentDescr,
    TCcTypeCd::Type ccTypeCd/*
    TCcStatusFlg::Type ccStatusFlg */
)
{
    try
    {
        updateCcProc->ParamByName("p_cc_id")->Value = ccId;
        updateCcProc->ParamByName("p_cc_dttm")->Value = ccDttm;
        updateCcProc->ParamByName("p_cc_type_cd")->Value = FormatFloat("00", ccTypeCd);//IntToStr(statusFlg);
        //updateCcProc->ParamByName("p_cc_status_flg")->Value = FormatFloat("00", ccStatusFlg);//IntToStr(statusFlg);
        updateCcProc->ParamByName("p_descr")->Value = descr;
        updateCcProc->ParamByName("p_agent_type_cd")->Value = agentTypeCd;
        updateCcProc->ParamByName("p_agent_id")->Value = agentId;

        updateCcProc->ExecProc();

        // Для быстрого отображения
        ds->DisableControls();
        ds->Edit();
        ds->FieldByName("cc_id")->Value = updateCcProc->ParamByName("p_cc_id")->Value;
        ds->FieldByName("cc_dttm")->Value = updateCcProc->ParamByName("p_cc_dttm")->Value;
        ds->FieldByName("cc_type_cd")->Value = updateCcProc->ParamByName("p_cc_type_cd")->Value;
        ds->FieldByName("agent_id")->Value = updateCcProc->ParamByName("p_agent_id")->Value;
        ds->FieldByName("agent_descr")->Value = agentDescr;

        //ds->FieldByName("agent_descr")->Value = updateCcProc->ParamByName("p_agent_id")->Value;
        //ds->FieldByName("agent_descr")->Value = updateCcProc->ParamByName("p_cc_dttm")->Value;
        //ds->FieldByName("cc_status_flg")->Value = addCcProc->ParamByName("p_cc_status_flg")->Value;

        ds->Post();
        ds->EnableControls();
        closeCcApprovalList();
    }
    catch(Exception &e)
    {
        throw Exception(e);
    }
}

/* Создает новый контакт
*/
String TMainDataModule::addCc(
    TDataSet* ds,
    TDateTime ccDttm,
    const String& acct_id,
    const String& descr,
    const String& srcId,
    TAgentTypeCd::Type agentTypeCd,
    const String& agentId,
    const String& agentDescr,
    TCcTypeCd::Type ccTypeCd,
    //TCcStatusFlg::Type ccStatusFlg,
    TCcSourceTypeCd::Type ccSourceTypeCd
)
{
    try {

        addCcProc->ParamByName("p_cc_dttm")->Value = ccDttm;
        addCcProc->ParamByName("p_cc_type_cd")->Value = FormatFloat("00", ccTypeCd);//IntToStr(statusFlg);
        addCcProc->ParamByName("p_src_type_cd")->Value = FormatFloat("00", ccSourceTypeCd);
        addCcProc->ParamByName("p_acct_id")->Value = acct_id;
        addCcProc->ParamByName("p_descr")->Value = descr;
        addCcProc->ParamByName("p_src_id")->Value = srcId;
        addCcProc->ParamByName("p_agent_type_cd")->Value = agentTypeCd;
        addCcProc->ParamByName("p_agent_id")->Value = agentId;

        addCcProc->ExecProc();

        // Для моментального отображения
        if ( !addCcProc->ParamByName("result")->IsNull )
        {
            ds->DisableControls();
            ds->Edit();
            ds->FieldByName("cc_id")->Value = addCcProc->ParamByName("result")->Value;
            ds->FieldByName("cc_dttm")->Value = addCcProc->ParamByName("p_cc_dttm")->Value;
            ds->FieldByName("cc_type_cd")->Value = addCcProc->ParamByName("p_cc_type_cd")->Value;
            ds->FieldByName("agent_id")->Value = addCcProc->ParamByName("p_agent_id")->Value;
            ds->FieldByName("agent_descr")->Value = agentDescr;
            //ds->FieldByName("cc_status_flg")->Value = addCcProc->ParamByName("p_cc_status_flg")->Value;
            //ds->FieldByName("cc_dttm")->RefreshLookupList();
            //ds->FieldByName("cc_dttm")->Value = ccDttm;
            ds->Post();
            ds->EnableControls();
        }
        closeCcApprovalList();
        return addCcProc->ParamByName("result")->AsString;

    }
    catch(Exception &e)
    {
        throw Exception(e);
    }
}

/* Возвращает информацию по контакту
*/
TDataSet* TMainDataModule::getCcInfo(const String& ccId)
{
    getCcInfProc->ParamByName("p_cc_id")->AsString = ccId;
    openOrRefresh(getCcInfProc);
    return getCcInfProc;
}

/* Утверждает контакт
*/
void __fastcall TMainDataModule::setCcStatusApproval()
{
    TDataSetFilter* approvalList = NoticesDataModule->getApprovalListFilter;

    approvalList->LockDataSetPos();

    getCheckedFilter->clearAllValues();
    getCheckedFilter->setValue("checked", "param", "1");
    getCheckedFilter->DataSet = approvalList->DataSet;


    //approvalList->DisableControls();
    //int N = getApprovalListQuery->RecNo;
    //getApprovalListQuery->Filtered = false;
    getCheckedFilter->DataSet->First();
    // снять все фильтры
    // возможно наложить фильтр соответственно cancelApproval
    // или анализировать в цикле

    while ( !approvalList->DataSet->Eof )
    {
        if ( !approvalList->DataSet->FieldByName("cc_id")->IsNull )
        {

            // Утверждаем контакт
            setCcApprovalProc->ParamByName("p_cc_id")->AsString = approvalList->DataSet->FieldByName("cc_id")->AsString;
            setCcApprovalProc->ExecProc();

            //setCcApprovalDttmProc->ParamByName("p_approval_dttm")->Clear();
            //approvalList->DataSet->Edit();
            //approvalList->DataSet->FieldByName("approval_dttm")->Value = setCcApprovalDttmProc->ParamByName("p_approval_dttm")->Value;
            //approvalList->DataSet->Post();
            //setCcApprovalDttm(approvalList->DataSet->FieldByName("cc_id")->Value);
        }
        approvalList->DataSet->Next();
    }

    getCheckedFilter->DataSet = NULL;
    NoticesDataModule->getApprovalListFilter->UnlockDataSetPos();

    NoticesDataModule->getApprovalListFilter->DataSet->Close();

    //getApprovalListQuery->Filtered = true;
    //getApprovalListQuery->RecNo = N;

    // вернуть фильтры
    //getApprovalListQuery->EnableControls();
}

/* Отклонить контакты */
bool __fastcall TMainDataModule::setCcStatusRefuse()
{
    FillProcListParameter(NoticesDataModule->getApprovalListFilter, "cc_id", setCcStatusRefuseProc, "p_cc_id_list");

    try
    {
        setCcStatusRefuseProc->Execute();
        return true;
    }
    catch(Exception& e)
    {
        MessageBoxStop(e.Message);
        return false;
    }
}

/* Принудительное отключение абонента */
void __fastcall TMainDataModule::setFaSaEndDt(
    TDataSet* ds,
    const String& faPackid,
    TDateTime ccDttm
)
{
    try
    {
        setFaSaEndDtProc->ParamByName("p_sa_e_dt")->Value = ccDttm;
        setFaSaEndDtProc->ParamByName("p_fa_id")->Value = faPackid;

        setFaSaEndDtProc->ExecProc();

        closeFpCancelList();
        closeFpReconnectList();

        // Для моментального отображения
        ds->DisableControls();
        ds->Edit();
        ds->FieldByName("sa_e_dt")->Value = ccDttm;
        ds->Post();
        ds->EnableControls();
    }
    catch(Exception &e)
    {
        throw Exception(e);
    }
}

/* Заполняет параметр процедуры, являющийся списком, используя заданное поле dataset */
void __fastcall TMainDataModule::FillProcListParameter(TDataSetFilter* dsFilter, const String& filterParamName, TOraStoredProc* procedure, const String& procParamName)
{
    BeginProcessing(dsFilter);

    // Очищаем значения параметров
    procedure->ParamByName(procParamName)->Length = 0;

    // Заполняем параметр - список абонентов
    int i = 0;
    while ( !dsFilter->DataSet->Eof )
    {
        procedure->ParamByName(procParamName)->ItemAsString[++i] = dsFilter->DataSet->FieldByName(filterParamName)->AsString;
        dsFilter->DataSet->Next();
    }

    EndProcessing(dsFilter);
}




/* Создать реестр
   Для каждой обслуживающей организации создается отдельный реестр на отключение
*/
bool __fastcall TMainDataModule::createPackStop(bool forceSelf)
{
    TDataSetFilter* filter = StopDataModule->getPreStopListFilter;

    FillProcListParameter(StopDataModule->getPreStopListFilter, "acct_id", createFpStopProc, "p_acct_id_list");    // 2017-08-09
    createFpStopProc->ParamByName("p_force_self")->AsString = forceSelf? 'Y': 'N';

    /*BeginProcessing(filter);    2017-08-09

    // Очищаем значения параметров
    createFpStopProc->ParamByName("p_acct_id_list")->Length = 0;
    createFpStopProc->ParamByName("p_force_self")->AsString = forceSelf? 'Y': 'N';

    // Заполняем параметр - список абонентов
    int i = 0;
    while ( !filter->DataSet->Eof )
    {
        createFpStopProc->ParamByName("p_acct_id_list")->ItemAsString[++i] = filter->DataSet->FieldByName("acct_id")->AsString;
        filter->DataSet->Next();
    }

    EndProcessing(filter);   */

    if (createFpStopProc->ParamByName("p_acct_id_list")->Length == 0)
    {
        return false;
    }

    try
    {
        createFpStopProc->Execute();
        return true;
    }
    catch(Exception& e)
    {
        MessageBoxStop(e.Message);
        return false;
    }
}

/* Создать реестр уведомлений
*/
/*String __fastcall TMainDataModule::createFaPackFree(TFaPackTypeCd faPackTypeCd)
{
    try
    {
        CreateFaPackProc->ParamByName("p_fa_pack_type_cd")->Value = faPackTypeCd;
        CreateFaPackProc->ParamByName("p_acct_otdelen")->AsString = _acctOtdelen->AsString;
        CreateFaPackProc->ExecProc();
        String faPackId = CreateFaPackProc->ParamByName("Result")->Value;
        return faPackId;
    }
    catch(Exception &e)
    {
        ShowMessage(e.Message);
    }
}  */

/* Создать реестр уведомлений
*/
String __fastcall TMainDataModule::createFpNotice(TFaPackTypeCd faPackTypeCd)
{
    // Цикл по выделенным строкам
    // из каждой строки по очереди берутся параметры город, улица, контрлер
    // и подставляются в запрос
    // Полученные данные выводятся в шаблон Excel,
    // затем действия повторяются для следующей строки из списка с параметрами
    //_currentDbGrid->DataSource->DataSet->DisableControls();

    //TDataSetFilter* filter = getDebtorsFilter;


    TDataSetFilter* filter = _currentFilter;
    BeginProcessing(filter);

    // Очищаем значения параметров
    createFpNoticeProc->ParamByName("p_acct_id_list")->Length = 0;

    createFpNoticeProc->ParamByName("p_fp_type")->AsString = faPackTypeCd;

    // Заполняем параметр - список абонентов
    int i = 0;
    while ( !filter->DataSet->Eof )
    {
        createFpNoticeProc->ParamByName("p_acct_id_list")->ItemAsString[++i] = filter->DataSet->FieldByName("acct_id")->AsString;
        filter->DataSet->Next();
    } 

    EndProcessing(filter);

    if (createFpNoticeProc->ParamByName("p_acct_id_list")->Length == 0)
    {
        return "";
    }

    try
    {
        createFpNoticeProc->Execute();
        return createFpNoticeProc->ParamByName("Result")->AsString;
    }
    catch(Exception& e)
    {
        MessageBoxStop(e.Message);
        return "";
    }
}

/* используется, если необходимо обновить информацию*/
void __fastcall TMainDataModule::closePreDebtorList()
{
    // Чтобы при открытии "Всех должников" после создания нового реестра произошло обновление
    //getDebtors->ParamByName("acct_otdelen")->AsString = "";
    NoticesDataModule->getPreDebtorListProc->ParamByName("p_acct_otdelen")->AsString = "";
    NoticesDataModule->getPreDebtorListRam->Close();
}

/* Закрывает DataSet
   используется, если необходимо обновить список реестров на ограничение
*/
void __fastcall TMainDataModule::closeFpStopList()
{
    StopDataModule->getFpStopListFilter->DataSet->Close();
}

void __fastcall TMainDataModule::closePreStopList()
{
    StopDataModule->getPreStopListFilter->DataSet->Close();
}

/* Закрывает список реестров заявок на отмену отключения */
void __fastcall TMainDataModule::closeFpCancelList()
{
    StopDataModule->getFpCancelListFilter->DataSet->Close();
}

/* Закрывает список реестров заявок на возобновление подключения */
void __fastcall TMainDataModule::closeFpReconnectList()
{
    StopDataModule->getFpReconnectListFilter->DataSet->Close();
}

void __fastcall TMainDataModule::closePreOverdueList()
{
    getPreOverdueListFilter->DataSet->Close();
}


void __fastcall TMainDataModule::closeFpOverdueList()
{
    getFpOverdueListFilter->DataSet->Close();
}



/* Закрывает содержание заявки на отключение*/
void __fastcall TMainDataModule::closeFpStopContent()
{
    StopDataModule->getFpStopContentFilter->DataSet->Close();
}

void __fastcall TMainDataModule::closeCcApprovalList()
{
    NoticesDataModule->getApprovalListFilter->DataSet->Close();
}

void __fastcall TMainDataModule::closeFaPackNoticesList()
{
    NoticesDataModule->getFpNoticesContentFilter->DataSet->Close();
}

//void __fastcall TMainDataModule::setFilter(const String& filterName, const String& filterValue)
void __fastcall TMainDataModule::setFilterParamValue(TDataSetFilter* filter, const String& filterName, const String& paramName, Variant paramValue)
{
    filter->setValue(filterName, paramName, paramValue);
    //_currentFilter->setValue(filterName, "param", filterValue);
    //_currentDbGrid->refreshFilter();
}

/**/
void __fastcall TMainDataModule::selectCcDttmIsNull(TDataSetFilter* filter)
{
    //filter->BeginUpdate();
    filter->LockDataSetPos();
    filter->DisableControls();

    filter->setValue("cc_dttm_is", "param", "null");
    setCheckAll(filter->DataSet, true);
    filter->setValue("cc_dttm_is", "param", "");

    filter->EnableControls();
    filter->UnlockDataSetPos();
    //filter->DataSet->EnableControls();
}

/**/
void __fastcall TMainDataModule::selectCcDttmMoreThanThree(TDataSetFilter* filter)
{
    filter->LockDataSetPos();
    filter->DisableControls();

    String dttm = DateToStr( IncMonth(Now(), -3) );
    filter->setValue("cc_dttm_more", "param", dttm);

    setCheckAll(filter->DataSet, true);
    filter->setValue("cc_dttm_more", "param", "");

    filter->DataSet->EnableControls();
    filter->EnableControls();
    filter->UnlockDataSetPos();
}



/*void __fastcall TMainDataModule::LockDataSetPos(TDataSet* dataSet)
{
    int N = dataSet->RecNo;
    dataSet->DisableControls();
}

void __fastcall TMainDataModule::UnlockDataSetPos(TDataSet* dataSet)
{
    dataSet->RecNo = N;
    dataSet->EnableControls();
}  */

//---------------------------------------------------------------------------
// Пометить все строки
void __fastcall TMainDataModule::setCheckAll(TDataSet* dataSet, bool value)
{
    //int N = dataSet->RecNo;
    //dataSet->DisableControls();
    if ( !dataSet->Active )
    {
        return;
    }
    dataSet->First();
    while( !dataSet->Eof )
    {
        dataSet->Edit();
        dataSet->FieldByName("CHECK_DATA")->Value = (value ? TCheckTypes::CT_CHECKED : TCheckTypes::CT_UNCHECKED);
        dataSet->Post();
        dataSet->Next();
    }

    //dataSet->RecNo = N;
    //dataSet->EnableControls();
}


/* Отображает список на утверждение
   по выбранному участку */
void __fastcall TMainDataModule::getApprovalList()
{
    if (_threadDataSet != NULL)
    {   // Если поток уже запущен
        return;
    }

    if (!NoticesDataModule->getApprovalListFilter->DataSet->Active || NoticesDataModule->getApprovalListProc->ParamByName("p_acct_otdelen")->AsString != _acctOtdelen->AsString)
    {
        NoticesDataModule->getApprovalListProc->ParamByName("p_acct_otdelen")->AsString = _acctOtdelen->AsString;
        _threadDataSet = new TThreadDataSet(false, NoticesDataModule->getApprovalListProc, NoticesDataModule->getApprovalListRam, &OnThreadEvent);
    }
}

/* Отображает список на введение ограничения
   по выбранному участку */
void __fastcall TMainDataModule::getStopList()
{
    if (_threadDataSet != NULL)
    {   // Если поток уже запущен
        return;
    }

    if ( !StopDataModule->getPreStopListFilter->DataSet->Active ||
        StopDataModule->getPreStopListProc->ParamByName("p_acct_otdelen")->AsString != _acctOtdelen->AsString)
    {
        StopDataModule->getPreStopListProc->ParamByName("p_acct_otdelen")->AsString = _acctOtdelen->AsString;
        _threadDataSet = new TThreadDataSet(false, StopDataModule->getPreStopListProc, StopDataModule->getPreStopListRam, &OnThreadEvent);
    }
}

/* Отображает список реестров на ограничение
   по выбранному участку */
void __fastcall TMainDataModule::getFpStopList()
{
    _currentFilter = StopDataModule->getFpStopListFilter;
    getFpList(StopDataModule->getFpStopListProc, StopDataModule->getFpStopListFilter, StopDataModule->getFpStopListRam, _acctOtdelen->AsString);
}

/* Отображает список просроченных заявок
   по выбранному участку */
void __fastcall TMainDataModule::getPreOverdueList()
{
    if (_threadDataSet != NULL)
    {   // Если поток уже запущен
        return;
    }

    if (!getPreOverdueListFilter->DataSet->Active || getPreOverdueListProc->ParamByName("p_acct_otdelen")->AsString != _acctOtdelen->AsString)
    {
        getPreOverdueListProc->ParamByName("p_acct_otdelen")->AsString = _acctOtdelen->AsString;
        _threadDataSet = new TThreadDataSet(false, getPreOverdueListProc, getPreOverdueListRam, &OnThreadEvent);
    }
}




/* Отображает список реестров
   по выбранному участку */
void __fastcall TMainDataModule::findFaPackListNotices(const String& acctOtdelen, const String& faId, const String& acctId)
{
    findFaPackListNoticesProc->ParamByName("p_acct_otdelen")->AsString = acctOtdelen;
    findFaPackListNoticesProc->ParamByName("p_fa_id")->AsString = faId;
    findFaPackListNoticesProc->ParamByName("p_acct_id")->AsString = acctId;
    findFaPackListNoticesProc->Open();
    CopyDataSet(findFaPackListNoticesProc, findFaPackListNoticesFilter->DataSet);
    findFaPackListNoticesProc->Close();

    // Без потока, потому что нужно открывать форму в режиме Modal
    //_threadDataSet = new TThreadDataSet(false, findFaPackListNoticesProc, findFaPackListNoticesRam, &OnThreadEvent);

}

/**/
void __fastcall TMainDataModule::findFaPackListStop(const String& acctOtdelen, const String& faId, const String& acctId)
{

    findFpStopListProc->ParamByName("p_acct_otdelen")->AsString = acctOtdelen;
    findFpStopListProc->ParamByName("p_fa_id")->AsString = faId;
    findFpStopListProc->ParamByName("p_acct_id")->AsString = acctId;
    findFpStopListProc->Open();
    CopyDataSet(findFpStopListProc, findFpStopListFilter->DataSet);
    findFpStopListProc->Close();
}

/**/
void __fastcall TMainDataModule::findFpOverdueList(const String& acctOtdelen, const String& faId, const String& acctId)
{

    findFpOverdueListProc->ParamByName("p_acct_otdelen")->AsString = acctOtdelen;
    findFpOverdueListProc->ParamByName("p_fa_id")->AsString = faId;
    findFpOverdueListProc->ParamByName("p_acct_id")->AsString = acctId;
    findFpOverdueListProc->Open();
    CopyDataSet(findFpOverdueListProc, findFpOverdueListFilter->DataSet);
    findFpOverdueListProc->Close();
}


/* Отображает полный список абонентов
   по выбранному участку */
void __fastcall TMainDataModule::getAcctFullList()
{
    if (_threadDataSet != NULL)
    {
        return;
    }

    _currentFilter = NoticesDataModule->getAcctFullListFilter;

    if ( !NoticesDataModule->getAcctFullListFilter->DataSet->Active
        || NoticesDataModule->getAcctFullListProc->ParamByName("p_acct_otdelen")->AsString != _acctOtdelen->AsString)
    {
        NoticesDataModule->getAcctFullListProc->ParamByName("p_acct_otdelen")->AsString = _acctOtdelen->AsString;
        _threadDataSet = new TThreadDataSet(false, NoticesDataModule->getAcctFullListProc, NoticesDataModule->getAcctFullListRam, &OnThreadEvent);
    }
}

/* Отображает список должников
   по выбранному участку */
void __fastcall TMainDataModule::getPreDebtorList()
{
    if (_threadDataSet != NULL)
    {
        return;
    }

    _currentFilter = NoticesDataModule->getPreDebtorListFilter;

    if ( !NoticesDataModule->getPreDebtorListFilter->DataSet->Active
        || NoticesDataModule->getPreDebtorListProc->ParamByName("p_acct_otdelen")->AsString != _acctOtdelen->AsString)
    {
        if (_beforeOpenDataSet != NULL)
        {
            _beforeOpenDataSet(this);
        }
        NoticesDataModule->getPreDebtorListProc->ParamByName("p_acct_otdelen")->AsString = _acctOtdelen->AsString;

        _threadDataSet = new TThreadDataSet(false, NoticesDataModule->getPreDebtorListProc, NoticesDataModule->getPreDebtorListRam, &OnThreadEvent);
    }
}

/* Отображает список на почту
   по выбранному участку */
void __fastcall TMainDataModule::getPrePostList()
{
    if (_threadDataSet != NULL)
    {
        return;
    }

    _currentFilter  = NoticesDataModule->getPrePostListFilter;

    if ( !NoticesDataModule->getPrePostListFilter->DataSet->Active
        || NoticesDataModule->getPrePostListProc->ParamByName("p_acct_otdelen")->AsString != _acctOtdelen->AsString)
    {
        NoticesDataModule->getPrePostListProc->ParamByName("p_acct_otdelen")->AsString = _acctOtdelen->AsString;
        _threadDataSet = new TThreadDataSet(false, NoticesDataModule->getPrePostListProc, NoticesDataModule->getPrePostListRam, &OnThreadEvent);
    }
}

/* Отображает список на отмену ограничения */
void __fastcall TMainDataModule::getFpCancelList()
{
    _currentFilter = StopDataModule->getFpCancelListFilter;
    getFpList(StopDataModule->getFpCancelListProc, StopDataModule->getFpCancelListFilter, StopDataModule->getFpCancelListRam, _acctOtdelen->AsString);
}

void __fastcall TMainDataModule::getOpAreaList()
{
    getOpAreaProc->ParamByName("p_acct_otdelen")->AsString = _acctOtdelen->AsString; //acctOtdelen;
    openOrRefresh(getOpAreaProc);
}

/* Задает текущее отделение
   updateOnly = true то меняется только значение _currentAcctOtdelen
*/
void __fastcall TMainDataModule::setAcctOtdelen(const String& acctOtdelen, bool updateOnly)
{
    static String oldAcctOtdelen = "";
    if (oldAcctOtdelen != acctOtdelen)
    {
        oldAcctOtdelen = acctOtdelen;

        getOtdelenListFilter->setValue("acct_otdelen", "param", acctOtdelen);

        getOtdelenListFilter->DataSet->FieldByName("acct_otdelen")->AsString;


        //getOtdelenListProc->data
        //getOpAreaProc->ParamByName("p_acct_otdelen")->AsString = _acctOtdelen->AsString;
        /*getOpAreaProc->ParamByName("p_acct_otdelen")->AsString = acctOtdelen;
        openOrRefresh(getOpAreaProc);      */

        // Сделать открытие запроса getOtdelenListQuery с параметром acctOtdelen
        // или переход на соответствующую запись
        // в случае DBGridComboBox ничего не делать

        /*if ( updateOnly == false )
        {
            // Закрываем открытые наборы
            getAcctFullListFilter->DataSet->Close();
            getPreDebtorListFilter->DataSet->Close();
            getFpNoticesContentFilter->DataSet->Close();
            getPrePostListFilter->DataSet->Close();
            getApprovalListFilter->DataSet->Close();
            getFpStopListFilter->DataSet->Close();
            getFpStopContentFilter->DataSet->Close();
            getFpCancelListFilter->DataSet->Close();

            getFaPackInfProc->Close();
            getPreStopListProc->ParamByName("p_acct_otdelen")->Clear();
            getFpNoticesContentProc->ParamByName("p_fa_pack_id")->Clear();
            getFpStopContentProc->ParamByName("p_fa_pack_id")->Clear();
        } */
    }
}

/**/
//void __fastcall TMainDataModule::setCurrentFpInf(TOraStoredProc* faPackInfProc, const String& faPackId)
//{
//    getFaPackInfProc->ParamByName("p_fa_pack_id")->AsString = faPackId;
//    openOrRefresh(getFaPackInfProc);

/*    getFaPackInfProc->ParamByName("p_fa_pack_id")->AsString = faPackId;
    openOrRefresh(getFaPackInfProc);
    setAcctOtdelen(getFaPackInfProc->FieldByName("acct_otdelen")->AsString, true);  */
//}

/* Задает текущий реестр
    TOraStoredProc* proc    - источник
    TDataSetFilter* filter  - фильтра
    TVirtualTable* vtable   - приемник
    const String& faPackId  - ID реестра
*/
void __fastcall TMainDataModule::setCurrentFp(
    TOraStoredProc* proc,               // Процедура - Источник
    TDataSetFilter* filter,             // Фильтр
    TVirtualTable* vtable,              // Приемник в памяти
    TOraStoredProc* faPackInfProc,      // Информация по текущему реестру
    const String& faPackId)
{
    if (_threadDataSet != NULL)
    {
        return;   // Если поток уже запущен
    }

    _currentFilter  = filter;

    if (faPackId != "" && proc->ParamByName("p_fa_pack_id")->AsString != faPackId)
    {
        proc->ParamByName("p_fa_pack_id")->Value = faPackId;
        filter->DataSet->Close();
    }

    if ( !filter->DataSet->Active && !proc->ParamByName("p_fa_pack_id")->IsNull)
    {
        if ( faPackInfProc != NULL )    // Характеристики реестра
        {
            faPackInfProc->ParamByName("p_fa_pack_id")->AsString = faPackId;
            openOrRefresh(faPackInfProc);
        }

        // Задаем текущий участок по участку из характеристик реестра
        setAcctOtdelen( faPackInfProc->FieldByName("acct_otdelen")->AsString );

        // Получаем строки реестра
        _threadDataSet = new TThreadDataSet(false, proc, vtable, &OnThreadEvent);

        // Запрос для хранения текущей информации по пакету
        //setCurrentFp(proc->ParamByName("p_fa_pack_id")->AsString);  // проверить, нужно ли это  2017-08-21
    }
}


/* Задает текущий реестр
*/
void __fastcall TMainDataModule::setCurrentFpNoticesId(const String& faPackId)
{
    setCurrentFp(NoticesDataModule->getFpNoticesContentProc, NoticesDataModule->getFpNoticesContentFilter, NoticesDataModule->getFpNoticesContentRam, NoticesDataModule->getFpNoticesInfoProc, faPackId);
}

/* Задает текущий пакет
*/
void __fastcall TMainDataModule::setCurrentFpStopId(const String& faPackId)
{
    setCurrentFp(StopDataModule->getFpStopContentProc, StopDataModule->getFpStopContentFilter, StopDataModule->getFpStopContentRam, StopDataModule->getFpStopInfoProc, faPackId);
}

/* Задает текущий реестр на отмену
*/
void __fastcall TMainDataModule::setCurrentFpCancel(const String& faPackId)
{
    setCurrentFp(StopDataModule->getFpCancelContentProc, StopDataModule->getFpCancelContentFilter, StopDataModule->getFpCancelContentRam, StopDataModule->getFpCancelInfoProc, faPackId);
}

/* Задает текущий реестр на возобновление
*/
void __fastcall TMainDataModule::setCurrentFpReconnect(const String& faPackId)
{
    setCurrentFp(StopDataModule->getFpReconnectContentProc, StopDataModule->getFpReconnectContentFilter, StopDataModule->getFpReconnectContentRam, StopDataModule->getFpReconnectInfoProc, faPackId);
}

/* Задает текущий реестр просроченных заявок
*/
void __fastcall TMainDataModule::setCurrentFpOverdue(const String& faPackId)
{
    setCurrentFp(getFpOverdueContentProc, getFpOverdueContentFilter, getFpOverdueContentRam, getFpOverdueInfoProc, faPackId);
}

/* Возвращает ID текущего участка
*/
Variant __fastcall TMainDataModule::getAcctOtdelen()
{
    return getOtdelenListFilter->DataSet->FieldByName("acct_otdelen")->Value;
}

/* Возвращает ID текущее реестра уведомлений */
String __fastcall TMainDataModule::getFpNoticesId() const
{
    return NoticesDataModule->getFpNoticesContentProc->ParamByName("p_fa_pack_id")->AsString;
}

/* Возвращает ID текущего реестра на отключение */
String __fastcall TMainDataModule::getFpStopId() const
{
    return StopDataModule->getFpStopContentProc->ParamByName("p_fa_pack_id")->AsString;
}

/* Возвращает ID текущего реестра на отмену остановки */
String __fastcall TMainDataModule::getFpCancelId() const
{
    return StopDataModule->getFpCancelContentProc->ParamByName("p_fa_pack_id")->AsString;
}

/* Возвращает ID текущего реестра на возобновление */
String __fastcall TMainDataModule::getFpReconnectId() const
{
    return StopDataModule->getFpReconnectContentProc->ParamByName("p_fa_pack_id")->AsString;
}

/* Возвращает ID текущего реестра просроченных заявок */
String __fastcall TMainDataModule::getFpOverdueId() const
{
    return getFpOverdueContentProc->ParamByName("p_fa_pack_id")->AsString;
}


/* Функция для подготовки к обработке данных
   Фильтрует dataset оставляя только отмеченные */
void __fastcall TMainDataModule::BeginProcessing(TDataSetFilter* filter)
{
    filter->LockDataSetPos();      // Запоминаем позицию в dataset  и блокируем отображение изменений

    // Внимание, здесь, использовать локальный фильтр
    getCheckedFilter->clearAllValues();
    getCheckedFilter->setValue("checked", "param", "1"); //
    getCheckedFilter->DataSet = filter->DataSet;   // Присоединяем фильтр к dataset
}

/* Функция, вызываемая при завершении обработки данных */
void __fastcall TMainDataModule::EndProcessing(TDataSetFilter* filter)
{
    getCheckedFilter->DataSet = NULL;
    filter->UnlockDataSetPos();
}

/* Удаление реестров */
bool __fastcall TMainDataModule::deleteFaPack()
{
    TDataSetFilter* filter = StopDataModule->getFpStopListFilter;
    BeginProcessing(filter);

    while ( !filter->DataSet->Eof )
    {
        try
        {
            deleteFaPackProc->ParamByName("p_fa_pack_id")->Value =  filter->DataSet->FieldByName("fa_pack_id")->AsString;
            deleteFaPackProc->ExecProc();
        }
        catch(Exception& e)
        {
            MessageBoxStop(e.Message);
            //MessageBoxStop("Реестр " + filter->DataSet->FieldByName("fa_pack_id")->AsString + " не был удален, так как находится в статусе " + filter->DataSet->FieldByName("fa_pack_status_descr")->AsString);
            return false;
        }
        filter->DataSet->Next();
    }

    EndProcessing(filter);
    return true;
}

/* Переводит реестры в статус Отменен
   В качестве списка реестров используется filter
   */
bool __fastcall TMainDataModule::setFpStatusCancel(TDataSetFilter* filter)
{
    BeginProcessing(filter);

    while ( !filter->DataSet->Eof )
    {
        try
        {
            setFpStatusFlgCancelProc->ParamByName("p_fa_pack_id")->Value =  filter->DataSet->FieldByName("fa_pack_id")->AsString;
            setFpStatusFlgCancelProc->ExecProc();
        }
        catch(Exception& e)
        {
            EndProcessing(filter);
            MessageBoxStop(e.Message);
            return false;
        }
        filter->DataSet->Next();
    }

    EndProcessing(filter);
    return true;
}

bool __fastcall TMainDataModule::setFpStopStatusCancel()
{
    return setFpStatusCancel(StopDataModule->getFpStopListFilter);
}

bool __fastcall TMainDataModule::setFpCancelStatusCancel()
{
    return setFpStatusCancel(StopDataModule->getFpCancelListFilter);
}

bool __fastcall TMainDataModule::setFpReconnectStatusCancel()
{
    return setFpStatusCancel(StopDataModule->getFpReconnectListFilter);
}

bool __fastcall TMainDataModule::setFpOverdueStatusCancel()
{
    return setFpStatusCancel(getFpOverdueListFilter);
}

bool __fastcall TMainDataModule::setFaPackStatusFrozen()
{
    TDataSetFilter* filter = StopDataModule->getFpStopListFilter;
    BeginProcessing(filter);

    while ( !filter->DataSet->Eof )
    {
        try
        {
            setFaPackStatusFlgFrozenProc->ParamByName("p_fa_pack_id")->Value =  filter->DataSet->FieldByName("fa_pack_id")->AsString;
            setFaPackStatusFlgFrozenProc->ExecProc();
        }
        catch(Exception& e)
        {
            MessageBoxStop(e.Message);
            return false;
        }
        filter->DataSet->Next();
    }

    EndProcessing(filter);
    return true;
}


/* Задает функции, вызываемые при начале и по окончанию длительных по времени запросов и процедур
   Служат для синхронизации с графическим интерфейсом
*/
void __fastcall TMainDataModule::setOpenDataSetEvents(TNotifyEvent beforeOpenDataSet, TNotifyEvent afterOpenDataSet)
{
    _beforeOpenDataSet = beforeOpenDataSet;
    _afterOpenDataSet = afterOpenDataSet;
}

/* Событие при изменение фильтра
   Служат для синхронизации с графическим интерфейсом
*/
void __fastcall TMainDataModule::setOnChangeFilterMethod(TNotifyEvent onChangeFilterMethod)
{
    _onChangeFilterMethod = onChangeFilterMethod;
}

/* При изменении фильтра
   Служит для синхронизации с графическим интерфейсом
*/
void __fastcall TMainDataModule::OnFilterChange(
      TDataSetFilter *Sender, AnsiString filterName)
{
    if (_onChangeFilterMethod != NULL)
    {
        _onChangeFilterMethod(this);
    }
}

/**/
/*bool __fastcall TMainDataModule::setFaPackCancelStopStatusComplete()
{
    TDataSetFilter* filter = getFpCancelListFilter;
    BeginProcessing(filter);

    while ( !filter->DataSet->Eof )
    {
        try
        {
            setFaPackStatSentPerformerProc->ParamByName("p_fa_pack_id")->Value =  filter->DataSet->FieldByName("fa_pack_id")->AsString;
            setFaPackStatSentPerformerProc->ExecProc();
        }
        catch(Exception& e)
        {
            MessageBoxStop(e.Message);
            return false;
        }
        filter->DataSet->Next();
    }

    EndProcessing(filter);

    return true;
} */


void __fastcall TMainDataModule::EsaleSessionAfterDisconnect(
      TObject *Sender)
{
    // Поддерживать соединение
    /*if (!Application->Terminated)
    {
        ShowMessage("Соединение прервано.");
    }*/
}
/**/
void __fastcall TMainDataModule::getFpReconnectList()
{
    _currentFilter = StopDataModule->getFpReconnectListFilter;
    getFpList(StopDataModule->getFpReconnectListProc, StopDataModule->getFpReconnectListFilter, StopDataModule->getFpReconnectListRam, _acctOtdelen->AsString);
}

String __fastcall TMainDataModule::getFaPackStats()
{
    TDateTime dt = getConfigProc->FieldByName("today")->AsDateTime;

    double start_month = StartOfTheMonth(dt);
    String result = "";

    // За текущий день
    getFaPackStatsProc->ParamByName("p_start_dt")->AsDateTime = dt;
    getFaPackStatsProc->ParamByName("p_end_dt")->AsDateTime = dt;//start_month-1;
    getFaPackStatsProc->Open();

    result += StrPadR("За текущий день ", 120, "_") + "\n";
        /*+ FormatDateTime("dd.mm.yyyy", getFaPackStatsProc->ParamByName("p_start_dt")->AsDateTime )
        + " - "
        + FormatDateTime("dd.mm.yyyy", getFaPackStatsProc->ParamByName("p_end_dt")->AsDateTime )
        + ":\n"; */

    result += StrPadR("Участок", 20, " ") + StrPadR("Увед. контр.", 20, " ") + StrPadR("Увед. почта", 20, " ") + StrPadR("Остан.", 20, " ") + StrPadR("Отмен.", 20, " ") + StrPadR("Возобн.", 20, " ") + "\n";
    while (! getFaPackStatsProc->Eof )
    {
        result +=
            StrPadR(getFaPackStatsProc->FieldByName("acct_otdelen_descr")->AsString, 20, ".") +
            StrPadR(getFaPackStatsProc->FieldByName("fa_notices_self")->AsString, 20, " ") +
            StrPadR(getFaPackStatsProc->FieldByName("fa_notices_post")->AsString, 20, " ") +
            StrPadR(getFaPackStatsProc->FieldByName("fa_pack_stop")->AsString, 20, " ") +
            StrPadR(getFaPackStatsProc->FieldByName("fa_pack_cancel")->AsString, 20, " ") +
            StrPadR(getFaPackStatsProc->FieldByName("fa_pack_reconnect")->AsString, 20, " ") + "\n";

        getFaPackStatsProc->Next();
    }
    getFaPackStatsProc->Close();
    result += "\n";


    // За текущий месяц
    getFaPackStatsProc->ParamByName("p_start_dt")->AsDateTime = start_month;
    getFaPackStatsProc->ParamByName("p_end_dt")->AsDateTime = dt;//start_month-1;
    getFaPackStatsProc->Open();

    result += StrPadR("За период "
        + FormatDateTime("dd.mm.yyyy", getFaPackStatsProc->ParamByName("p_start_dt")->AsDateTime )
        + " - "
        + FormatDateTime("dd.mm.yyyy", getFaPackStatsProc->ParamByName("p_end_dt")->AsDateTime )
        , 120, "_") + "\n";

    result += StrPadR("Участок", 20, " ") + StrPadR("Увед. контр.", 20, " ") + StrPadR("Увед. почта", 20, " ") + StrPadR("Остан.", 20, " ") + StrPadR("Отмен.", 20, " ") + StrPadR("Возобн.", 20, " ") + "\n";
    while (! getFaPackStatsProc->Eof )
    {
        result +=
            StrPadR(getFaPackStatsProc->FieldByName("acct_otdelen_descr")->AsString, 20, ".") +
            StrPadR(getFaPackStatsProc->FieldByName("fa_notices_self")->AsString, 20, " ") +
            StrPadR(getFaPackStatsProc->FieldByName("fa_notices_post")->AsString, 20, " ") +
            StrPadR(getFaPackStatsProc->FieldByName("fa_pack_stop")->AsString, 20, " ") +
            StrPadR(getFaPackStatsProc->FieldByName("fa_pack_cancel")->AsString, 20, " ") +
            StrPadR(getFaPackStatsProc->FieldByName("fa_pack_reconnect")->AsString, 20, " ") + "\n";

        getFaPackStatsProc->Next();
    }

    getFaPackStatsProc->Close();
    result += "\n";


    // За два последних месяца
    getFaPackStatsProc->ParamByName("p_start_dt")->AsDateTime = IncMonth(start_month,-1);
    getFaPackStatsProc->ParamByName("p_end_dt")->AsDateTime = dt;//start_month-1;
    getFaPackStatsProc->Open();

    result += StrPadR("За период "
        + FormatDateTime("dd.mm.yyyy", getFaPackStatsProc->ParamByName("p_start_dt")->AsDateTime )
        + " - "
        + FormatDateTime("dd.mm.yyyy", getFaPackStatsProc->ParamByName("p_end_dt")->AsDateTime )
        , 120, "_") + "\n";

    result += StrPadR("Участок", 20, " ") + StrPadR("Увед. контр.", 20, " ") + StrPadR("Увед. почта", 20, " ") + StrPadR("Остан.", 20, " ") + StrPadR("Отмен.", 20, " ") + StrPadR("Возобн.", 20, " ") + "\n";
    while (! getFaPackStatsProc->Eof )
    {
        result +=
            StrPadR(getFaPackStatsProc->FieldByName("acct_otdelen_descr")->AsString, 20, ".") +
            StrPadR(getFaPackStatsProc->FieldByName("fa_notices_self")->AsString, 20, " ") +
            StrPadR(getFaPackStatsProc->FieldByName("fa_notices_post")->AsString, 20, " ") +
            StrPadR(getFaPackStatsProc->FieldByName("fa_pack_stop")->AsString, 20, " ") +
            StrPadR(getFaPackStatsProc->FieldByName("fa_pack_cancel")->AsString, 20, " ") +
            StrPadR(getFaPackStatsProc->FieldByName("fa_pack_reconnect")->AsString, 20, " ") + "\n";

        getFaPackStatsProc->Next();
    }

    getFaPackStatsProc->Close();
    result += "\n";


    return result;
}

/* Отмена заявки на остановку */
bool __fastcall TMainDataModule::createFpCancelForce()
{
    TDataSetFilter* filter = StopDataModule->getFpStopContentFilter;
    BeginProcessing(filter);

    int i = 1;
    while ( !filter->DataSet->Eof )
    {
        createFpCancelForceProc->ParamByName("p_fa_id_list")->ItemAsString[i++] = filter->DataSet->FieldByName("fa_id")->AsString;
        filter->DataSet->Next();
    }

    EndProcessing(filter);

    try
    {
        createFpCancelForceProc->Execute();
        return true;
    }
    catch(Exception& e)
    {
        MessageBoxStop(e.Message);
        return false;
    }

}

bool __fastcall TMainDataModule::createFpOverdue()
{
    TDataSetFilter* filter = getPreOverdueListFilter;

    FillProcListParameter(getPreOverdueListFilter, "fa_id", createFpOverdueProc, "p_fa_id_list");    // Заполняем список

    if (createFpOverdueProc->ParamByName("p_fa_id_list")->Length == 0)
    {
        return false;
    }

    try
    {
        createFpOverdueProc->Execute();
        return true;
    }
    catch(Exception& e)
    {
        MessageBoxStop(e.Message);
        return false;
    }
}



//void __fastcall TMainDataModule::setCurrentFp(TOraStoredProc* proc, TDataSetFilter* filter, TVirtualTable* vtable, const String& faPackId)
/**/
void __fastcall TMainDataModule::getFpList(TOraStoredProc* proc, TDataSetFilter* filter, TVirtualTable* vtable, const String& acctOtdelen)
{
    if (_threadDataSet != NULL)
    {   // Если поток уже запущен
        return;
    }

    //if (!getPackStopListQuery->Active || getPackStopListQuery->ParamByName("acct_otdelen")->Value != _acctOtdelen->Value)
    if (!filter->DataSet->Active || proc->ParamByName("p_acct_otdelen")->AsString != acctOtdelen)
    {
        proc->ParamByName("p_acct_otdelen")->AsString = acctOtdelen;
        _threadDataSet = new TThreadDataSet(false, proc, vtable, &OnThreadEvent);
    }

}

/**/
void __fastcall TMainDataModule::getFpOverdueList()
{
    _currentFilter = getFpOverdueListFilter;
    getFpList(getFpOverdueListProc, getFpOverdueListFilter, getFpOverdueListRam, _acctOtdelen->AsString);
}

/**/
void __fastcall TMainDataModule::resetSession()
{
    EsaleSession->Close();
    EsaleSession->Open();
}



