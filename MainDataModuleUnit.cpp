/*
  �������� ����������� ������ ���������.

  ����������:
  �� ������� ������ � ������ ������ ����� �������� ����� ���� �������� ������������
  ��������. � ���������� ���������� ��������� � ��������� ������.

  �������������.
  1. ��� ���������� �������� � ������� ������

  �����:
  1. �������
    getOtdelenListQuery
    getFaPackInfo
    �������� ������������� �������. � ��� �������� ������� ��������� ������.

*/

// ����� �������
//#define DEBUG
//#undef NDEBUG

#include <vcl.h>
#pragma hdrstop

#include "MainDataModuleUnit.h"
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


/* �������� ������ �� ��������� � �������� */
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
  �������� ��������:
  getConfigQuery - ������ ��� ��������� ���������������� ������ ��� �������� ������������


  getCcStatusFlgListQuery - ���� �������� ���������
  getCcTypeCdQuery - ���� ���������

  getDebtors
  getFaPackQuery
  getApprovalListQuery
  getStopListQuery
  selectFaPackQuery

*/


// ����������� ������������ � ���������
//void __fastcall TMainDataModule::Auth()
//{
    //TLoginForm* LoginForm = new TLoginForm(Application);
    //bool loggedon = LoginForm->Execute(EsaleSession);

    /*_username = UpperCase(LoginForm->getUsername());
    AddSystemVariable("username", _username);
    delete LoginForm;*/
   /* return loggedon;*/
//}

// ��������� ������ ��� ��������� (���������)
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
// ��������� "������������ - ��������" � ������
void DualList::add(const String& descr, const String& value)
{
    setUsed();
    _valueList->Add(value);
    _descrList->Add(descr);
}

//---------------------------------------------------------------------------
// ��������� ������ "������������ - ��������" �� �������
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
    // ������ ��� ����������
    //otdelenList.setSourceQuery(getOtdelenList);

    getPreDebtorListDataSource->DataSet = getPreDebtorListRam;
    getAcctFullListDataSource->DataSet = getAcctFullListRam;
    getApprovalListDataSource->DataSet = getApprovalListRam;
    getFpNoticesContentDataSource->DataSet =  getFpNoticesContentRam;
    getPrePostListDataSource->DataSet = getPrePostListRam;
    getPreStopListDataSource->DataSet = getPreStopListRam;         // ������ �� �����������
    getFpStopListDataSource->DataSet = getFpStopListRam;  // ������ ��������
    getFpCancelListDataSource->DataSet = getFpCancelStopRam;
    getFpReconnectListDataSource->DataSet = getFpReconnectListRam;
    getFpStopContentDataSource->DataSet = getFpStopContentRam;    // ������
    getFpCancelContentDataSource->DataSet = getFpCancelContentRam;    // ������
    getFpReconnectContentDataSource->DataSet = getFpReconnectContentRam;    // ������
    //getFpReconnectDataSource

    getPreOverdueListDataSource->DataSet = getPreOverdueListRam;        // ������ ������������ ������
    getFpOverdueContentDataSource->DataSet = getFpOverdueContentRam;    // ������ ��������� � ������� ������������ ������
    getFpOverdueListDataSource->DataSet = getFpOverdueListRam;          // ������ �������� ������������ ������

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
    /* ����������� ������������ */
    //#ifdef _DEBUG
    EsaleSession->Username = "";
    EsaleSession->Password = "";
    //#endif

    TLoginForm* loginForm = new TLoginForm(this, EsaleSession, false);
    bool auth = loginForm->execute();



    userRole.insert(TUserRole::UNDEFINED);
    if ( auth )
    {
        // ���� ���������� �����������, �� ���������� ����
        if (loginForm->checkRole("TASK_SWEETY_USER_ROLE"))
        {
            userRole.insert(TUserRole::USER_BASE);
        }
        if (loginForm->checkRole("TASK_SWEETY_APPROVER_ROLE"))
        {
            userRole.insert(TUserRole::APPROVER);
        }
        if ( loginForm->checkRole("TASK_SWEETY_OPERATOR_ROLE") )
        {
            userRole.insert(TUserRole::OPERATOR);
        }
        if ( loginForm->checkRole("TASK_SWEETY_ADMINISTRATOR_ROLE") )
        {
            userRole.insert(TUserRole::ADMINISTRATOR);
        }
        if ( loginForm->checkRole("TASK_SWEETY_VIEWER_ROLE") )
        {
            userRole.insert(TUserRole::VIEWER);
        }
        if ( loginForm->checkRole("TASK_SWEETY_TESTER_ROLE") )
        {
            userRole.insert(TUserRole::TESTER);
        }

        // ���� ����� ������ 1 �� ������� ���� TUserRole::UNDEFINED
        if (userRole.size() > 1)
        {
            userRole.erase(TUserRole::UNDEFINED);
        }
    }
    else  // ����� ���� �� ��������� �����������
    {
        delete loginForm;
        Application->Terminate();
        Application->ProcessMessages();
        return;
    }

    delete loginForm;

    if ( userRole.find(TUserRole::UNDEFINED) != userRole.end() )
    {   // ���� ���� �� ����������� �� ������� �� ���������
        Application->Terminate();
        Application->ProcessMessages();
        MessageBoxStop("�� �� ������ ���������� ��� ������ � ���� ���������.\n��������� ����� �������.");
        return;
    }



    /*  */
    String appPath = ExtractFilePath(Application->ExeName);

    getConfigProc->ParamByName("p_app_path")->AsString = appPath;
    getConfigProc->ParamByName("p_app_ver")->AsString = AppVer::Build;
    getConfigProc->Open();

    // ��������� �������� �� ������ � ���������
    // �� ������ ���������
    // ��� �� ������ ��������
    // � ������� ������������� ��������� �� ��


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

    // ����� ������� ���������
    TDateTime dt = getConfigProc->FieldByName("today")->AsDateTime;
    String beginDt = DateToStr(IncMonth(dt, -3));
    String endDt = DateToStr(dt);



    // ����������� � ����� ������ 
    //connectEsale();

    getCcStatusFlgListQuery->Open();
    getCcTypeCdQuery->Open();

    // ��������� ���������
    getConfigQuery->ParamByName("app_path")->AsString = appPath;
    getConfigQuery->ParamByName("username")->AsString = EsaleSession->Username;
    getConfigQuery->Open();

    // ������ ��������� � ������ ����� ����������
    //getOtdelenListProc->ParamByName("p_app_path")->AsString = appPath;
    getOtdelenListProc->Open();




    
    if ( getOtdelenListProc->RecordCount == 0 )
    { // ���� ��� ������������ ��� ��������� ��������
        Application->Terminate();
        Application->ProcessMessages();
        MessageBoxStop("�� �� ������ ��������� ��������.\n��������� ����� �������.");
        return;
    }


    /* ������ ������� ��������� */
    setAcctOtdelen(getOtdelenListProc->FieldByName("acct_otdelen")->AsString);
    _acctOtdelen = getOtdelenListProc->FieldByName("acct_otdelen");



    /* �������� �������� */
    /* ������ ��� ������ � ����������� �������� */
    getCheckedFilter->add("checked", "check_data = :param"); // ����������
    getCheckedFilter->add("group", "grp_data = :param"); // � ������������ (��������, ��� ������������ ������ �� ����������
                                                    // ��������������� �� ������� � ��������� �����)

    /* ������ ��� ������� ������ ��������� */
    getAcctFullListFilter->DisableControls();
    getAcctFullListFilter->add("AcctIdComboBox", "acct_id like '%:param%'");
    getAcctFullListFilter->add("AddressComboBox", "address like '%:param%'");
    getAcctFullListFilter->add("CityComboBox", "city like '%:param%'");
    getAcctFullListFilter->add("FioComboBox", "fio like '%:param%'");
    getAcctFullListFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");
    getAcctFullListFilter->add("ServiceCompanyFilterComboBox", "service_org like '%:param%'");
    getAcctFullListFilter->add("SaldoFilterEdit", "saldo_uch > :param");
    getAcctFullListFilter->add("OpAreaDescrFilterComboBox", "op_area_descr like '%:param%'");
    //getAcctFullListFilter->add("cc_dttm", "(:param)");
    getAcctFullListFilter->add("CcDttmStatusComboBox", "(:param = 0 or (:param=1 and cc_dttm is not null) or (:param=2 and cc_dttm is null) or (:param=3 and cc_dttm >= ':begin_dt' and cc_dttm < ':end_dt') )");
    getAcctFullListFilter->setDefaultValue("CcDttmStatusComboBox", "param", "0");
    getAcctFullListFilter->setDefaultValue("CcDttmStatusComboBox", "begin_dt", beginDt);
    getAcctFullListFilter->setDefaultValue("CcDttmStatusComboBox", "end_dt", endDt);

    // ������� ��� ������� (�� ��������� � ��������� ������?)
    getAcctFullListFilter->add("cc_dttm_is", "cc_dttm is :param");
    getAcctFullListFilter->add("cc_dttm_more", "(cc_dttm < ':param' or cc_dttm is null)");

    getAcctFullListFilter->EnableControls();


    /* ������ ��� ������ ��������� */
    getPreDebtorListFilter->DisableControls();
    getPreDebtorListFilter->add("AcctIdComboBox", "acct_id like '%:param%'");
    getPreDebtorListFilter->add("AddressComboBox", "address like '%:param%'");
    getPreDebtorListFilter->add("CityComboBox", "city like '%:param%'");
    getPreDebtorListFilter->add("FioComboBox", "fio like '%:param%'");
    getPreDebtorListFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");
    getPreDebtorListFilter->add("ServiceCompanyFilterComboBox", "service_org like '%:param%'");
    getPreDebtorListFilter->add("SaldoFilterEdit", "saldo_uch > :param");
    getPreDebtorListFilter->add("OpAreaDescrFilterComboBox", "op_area_descr like '%:param%'");
    //getDebtorsFilter->add("cc_dttm", "(:param)");
    getPreDebtorListFilter->add("CcDttmStatusComboBox", "(:param = 0 or (:param=1 and cc_dttm is not null) or (:param=2 and cc_dttm is null) or (:param=3 and cc_dttm >= ':begin_dt' and cc_dttm < ':end_dt') )");
    getPreDebtorListFilter->setDefaultValue("CcDttmStatusComboBox", "param", "0");
    getPreDebtorListFilter->setDefaultValue("CcDttmStatusComboBox", "begin_dt", beginDt);
    getPreDebtorListFilter->setDefaultValue("CcDttmStatusComboBox", "end_dt", endDt);
    getPreDebtorListFilter->add("MrRteCdFilterComboBox", "mr_rte_cd like '%:param%'");

    // ������� ��� ������� (�� ��������� � ��������� ������?)
    getPreDebtorListFilter->add("cc_dttm_is", "cc_dttm is :param");
    getPreDebtorListFilter->add("cc_dttm_more", "(cc_dttm < ':param' or cc_dttm is null)");

    // ������ ��� ���������
    //getDebtorsFilter->add("vcl_ctrl", "");
    //getDebtorsFilter->setValue("vcl_ctrl", "begin_dt", beginDt);
    //getDebtorsFilter->setValue("vcl_ctrl", "end_dt", endDt);

    getPreDebtorListFilter->EnableControls();


    /* ������ ��� ������ ����������� */
    //DBGridAltManual->Filtered = true;
    getFpNoticesContentFilter->DisableControls();
    getFpNoticesContentFilter->add("AcctIdComboBox", "acct_id like '%:param%'");
    getFpNoticesContentFilter->add("AddressComboBox", "address like '%:param%'");
    getFpNoticesContentFilter->add("CityComboBox", "city like '%:param%'");
    getFpNoticesContentFilter->add("FioComboBox", "fio like '%:param%'");
    getFpNoticesContentFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");
    getFpNoticesContentFilter->add("ServiceCompanyFilterComboBox", "service_org like '%:param%'");
    getFpNoticesContentFilter->add("SaldoFilterEdit", "saldo_uch > :param");
    getFpNoticesContentFilter->add("OpAreaDescrFilterComboBox", "op_area_descr like '%:param%'");
    getFpNoticesContentFilter->add("MrRteCdFilterComboBox", "mr_rte_cd like '%:param%'");

    getFpNoticesContentFilter->add("CcDttmStatusComboBox", "(:param = 0 or (:param=1 and cc_dttm is not null) or (:param=2 and cc_dttm is null) or (:param=3 and cc_dttm >= ':begin_dt' and cc_dttm < ':end_dt') )");
    getFpNoticesContentFilter->setDefaultValue("CcDttmStatusComboBox", "param", "0");
    getFpNoticesContentFilter->setDefaultValue("CcDttmStatusComboBox", "begin_dt", beginDt);
    getFpNoticesContentFilter->setDefaultValue("CcDttmStatusComboBox", "end_dt", endDt);

    // ������� ��� �������
    getFpNoticesContentFilter->add("cc_dttm_is", "cc_dttm is :param");
    getFpNoticesContentFilter->add("cc_dttm_more", "(cc_dttm < ':param' or cc_dttm is null)");

    getFpNoticesContentFilter->EnableControls();



    /* ������ ��� ������ ����������� */
    //DBGridAltManual->Filtered = true;
    getPrePostListFilter->DisableControls();
    getPrePostListFilter->add("AcctIdComboBox", "acct_id like '%:param%'");
    getPrePostListFilter->add("AddressComboBox", "address like '%:param%'");
    getPrePostListFilter->add("CityComboBox", "city like '%:param%'");
    getPrePostListFilter->add("FioComboBox", "fio like '%:param%'");
    getPrePostListFilter->add("ServiceCompanyFilterComboBox", "service_org like '%:param%'");
    getPrePostListFilter->add("SaldoFilterEdit", "saldo_uch > :param");
    getPrePostListFilter->add("OpAreaDescrFilterComboBox", "op_area_descr like '%:param%'");
    //getPostListFilter->add("CcDttmStatusComboBox", "(:param = 0 or (:param=1 and cc_dttm is not null) or (:param=2 and cc_dttm is null) )");
    /*getPostListFilter->add("CcDttmStatusComboBox", "(:param = 0 or (:param=1 and cc_dttm is not null) or (:param=2 and cc_dttm is null) or (:param=3 and cc_dttm >= ':begin_dt' and cc_dttm < ':end_dt') )");
    getPostListFilter->setDefaultValue("CcDttmStatusComboBox", "param", "0");
    getPostListFilter->setDefaultValue("CcDttmStatusComboBox", "begin_dt", beginDt);
    getPostListFilter->setDefaultValue("CcDttmStatusComboBox", "end_dt", endDt);*/



    getPrePostListFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");

    // ������� ��� �������
    //getPostListFilter->add("cc_dttm_is", "cc_dttm is :param");
    //getPostListFilter->add("cc_dttm_more", "(cc_dttm < ':param' or cc_dttm is null)");
    getPrePostListFilter->EnableControls();



    /* ������ ��� ����������� */
    getApprovalListFilter->DisableControls();
    getApprovalListFilter->add("AcctIdComboBox", "acct_id like '%:param%'");
    getApprovalListFilter->add("AddressComboBox", "address like '%:param%'");
    getApprovalListFilter->add("CityComboBox", "city like '%:param%'");
    getApprovalListFilter->add("FioComboBox", "fio like '%:param%'");
    //getApprovalListFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");
    getApprovalListFilter->add("ServiceCompanyFilterComboBox", "service_org like '%:param%'");
    getApprovalListFilter->add("SaldoFilterEdit", "saldo_uch > :param");
    //getApprovalListFilter->add("cc_dttm", "(:param)");
    //getApprovalListFilter->add("ccDttmIsApprovedCheckBox", "approval_dttm is not null :param");
    //getApprovalListFilter->add("ApprovedStatusComboBox", "approval_dttm is :param null"); // is [not] null
    getApprovalListFilter->add("ApprovedStatusComboBox", "(:param = 0 or (:param=1 and cc_status_flg = '20') or (:param=2 and cc_status_flg='10') or (:param=3 and cc_status_flg = '50') )"); // is [not] null
    //getApprovalListFilter->setValue("ApprovedStatusComboBox", "param", "2");
    getApprovalListFilter->setDefaultValue("ApprovedStatusComboBox", "param", "2");

    /*getApprovalListFilter->add("ApprovedStatusComboBox"
        , "(:param = 0 or (:param=1 and approval_dttm is null) or (:param=2 and approval_dttm is not null) )" ); // is [not] null    */

    // ������� ��� �������
    getApprovalListFilter->add("cc_dttm_is", "cc_dttm is :param");
    getApprovalListFilter->add("cc_dttm_more", "(cc_dttm < ':param' or cc_dttm is null)");
    getApprovalListFilter->EnableControls();




    /* ������ ��� ������ �� ����������� */
    getPreStopListFilter->DisableControls();
    getPreStopListFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");
    getPreStopListFilter->add("AcctIdComboBox", "acct_id like '%:param%'");
    getPreStopListFilter->add("AddressComboBox", "address like '%:param%'");
    getPreStopListFilter->add("CityComboBox", "city like '%:param%'");
    getPreStopListFilter->add("FioComboBox", "fio like '%:param%'");
    getPreStopListFilter->add("SaldoFilterEdit", "saldo_uch > :param");
    getPreStopListFilter->add("ServiceCompanyFilterComboBox", "rt_descr like '%:param%'");
    getPreStopListFilter->add("PremTypeComboBox", "prem_type_descr like '%:param%'");
    getPreStopListFilter->add("FaPackTypeFilterComboBox", "fa_pack_type_descr like '%:param%'");
    getPreStopListFilter->add("CcDttmStatusComboBox", "(:param = 0 or (:param=1 and cc_dttm is not null) or (:param=2 and cc_dttm is null) or (:param=3 and cc_dttm >= ':begin_dt' and cc_dttm < ':end_dt') )");
    getPreStopListFilter->setDefaultValue("CcDttmStatusComboBox", "param", "3");
    getPreStopListFilter->setDefaultValue("CcDttmStatusComboBox", "begin_dt", "01.01.1900");
    getPreStopListFilter->setDefaultValue("CcDttmStatusComboBox", "end_dt", IncDay(dt, -17));
    getPreStopListFilter->EnableControls();

    /* ������ ��� ������ �������� �� ����������� */
    getFpStopListFilter->DisableControls();
    getFpStopListFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");
    getFpStopListFilter->add("ServiceCompanyFilterComboBox", "rt_descr like '%:param%'");
    //getFpStopListFilter->add("AddressComboBox", "address like '%:param%'");
    //getFpStopListFilter->add("FioComboBox", "fio like '%:param%'");
    getFpStopListFilter->EnableControls();


    /* ������ ��� ������ �������� �� ������ ����������� */
    getFpCancelListFilter->DisableControls();
    getFpCancelListFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");
    getFpCancelListFilter->add("FaPackStatusFilterComboBox", "(:param = 0 or "
        "(:param=1 and fa_pack_status_flg = '20') "
        "or (:param=2 and fa_pack_status_flg = '50') "
        "or (:param=3 and fa_pack_status_flg = '60'))"
        );
    getFpCancelListFilter->setDefaultValue("FaPackStatusFilterComboBox", "param", "2");
    getFpCancelListFilter->EnableControls();


    /* ������ ��� ������ �������� �� ������������ */
    getFpReconnectListFilter->DisableControls();
    getFpReconnectListFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");
    getFpReconnectListFilter->add("FaPackStatusFilterComboBox", "(:param = 0 or "
        "(:param=1 and fa_pack_status_flg = '20') "
        "or (:param=2 and fa_pack_status_flg = '50') "
        "or (:param=3 and fa_pack_status_flg = '60')) "
        );
    getFpReconnectListFilter->setDefaultValue("FaPackStatusFilterComboBox", "param", "2");
    getFpReconnectListFilter->EnableControls();


    /* ������ ��� ������� �� ����������� */
    getFpStopContentFilter->DisableControls();
    getFpStopContentFilter->add("AcctIdComboBox", "acct_id like '%:param%'");
    getFpStopContentFilter->add("FaIdFilterEdit", "fa_id like '%:param%'");
    getFpStopContentFilter->add("AddressComboBox", "address like '%:param%'");
    getFpStopContentFilter->add("CityComboBox", "city like '%:param%'");
    getFpStopContentFilter->add("FioComboBox", "fio like '%:param%'");
    getFpStopContentFilter->EnableControls();

    /* ������ ��� ������� �� ����������� */
    getFpCancelContentFilter->DisableControls();
    getFpCancelContentFilter->add("AcctIdComboBox", "acct_id like '%:param%'");
    getFpCancelContentFilter->add("FaIdFilterEdit", "fa_id like '%:param%'");
    getFpCancelContentFilter->add("AddressComboBox", "address like '%:param%'");
    getFpCancelContentFilter->add("CityComboBox", "city like '%:param%'");
    getFpCancelContentFilter->add("FioComboBox", "fio like '%:param%'");
    getFpCancelContentFilter->EnableControls();

    /* ������ ��� ������� �� ������������� */
    getFpReconnectContentFilter->DisableControls();
    getFpReconnectContentFilter->add("AcctIdComboBox", "acct_id like '%:param%'");
    getFpReconnectContentFilter->add("FaIdFilterEdit", "fa_id like '%:param%'");
    getFpReconnectContentFilter->add("AddressComboBox", "address like '%:param%'");
    getFpReconnectContentFilter->add("CityComboBox", "city like '%:param%'");
    getFpReconnectContentFilter->add("FioComboBox", "fio like '%:param%'");
    getFpReconnectContentFilter->EnableControls();






    /* ������ ��� ������ ������������ ������ */
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


    /* ������ ��� ������ �������� ������������ ������ */
    getFpOverdueListFilter->DisableControls();
    getFpOverdueListFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");
    getFpOverdueListFilter->add("ServiceCompanyFilterComboBox", "rt_descr like '%:param%'");
    getFpOverdueListFilter->EnableControls();

    /* ������ ��� ������� ������������ ������ */
    getFpOverdueContentFilter->DisableControls();
    getFpOverdueContentFilter->add("AcctIdComboBox", "acct_id like '%:param%'");
    //getFpOverdueContentFilter->add("FaIdFilterEdit", "fa_id like '%:param%'");
    getFpOverdueContentFilter->add("AddressComboBox", "address like '%:param%'");
    getFpOverdueContentFilter->add("CityComboBox", "city like '%:param%'");
    getFpOverdueContentFilter->add("FioComboBox", "fio like '%:param%'");
    getFpOverdueContentFilter->EnableControls();




   /* ���
�������
���������
��������
��������� �����������
��������� ��������*/


    /* ������� ��� ������ ������� ����������� */
    findFaPackListNoticesFilter->DisableControls();
    findFaPackListNoticesFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");
    //findFaPackListNoticesFilter->add("FaPackTypeDescrFilterComboBox", "fa_pack_type_descr like '%:param%'");
    findFaPackListNoticesFilter->add("FaPackTypeCdFilterComboBox", "(:param = 0 or (:param=1 and fa_pack_type_cd = '10') or (:param=2 and fa_pack_type_cd = '20') or (:param=3 and fa_pack_type_cd = '40') or (:param=4 and fa_pack_type_cd = '45') or (:param=5 and fa_pack_type_cd = '50'))");
    findFaPackListNoticesFilter->add("FaPackStatusFlgFilterComboBox", "(:param = 0 or (:param=1 and fa_pack_status_flg = '50') or (:param=2 and fa_pack_status_flg = '20') )");
    findFaPackListNoticesFilter->add("OwnerFilterEdit", "owner like '%:param%'");
    findFaPackListNoticesFilter->setDefaultValue("FaPackTypeCdFilterComboBox", "param", "0");
    findFaPackListNoticesFilter->setDefaultValue("FaPackStatusFlgFilterComboBox", "param", "0");
    findFaPackListNoticesFilter->EnableControls();

    /* ������� ��� ������ ������� ������ �� ���������� */
    findFpStopListFilter->DisableControls();
    findFpStopListFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");
    //findFpStopListFilter->add("FaPackTypeDescrFilterComboBox", "fa_pack_type_descr like '%:param%'");
    findFpStopListFilter->add("FaPackTypeCdFilterComboBox", "(:param = 0 or (:param=1 and fa_pack_type_cd = '10') or (:param=2 and fa_pack_type_cd = '20') or (:param=3 and fa_pack_type_cd = '40') or (:param=4 and fa_pack_type_cd = '45') or (:param=5 and fa_pack_type_cd = '50'))");
    findFpStopListFilter->add("FaPackStatusFlgFilterComboBox", "(:param = 0 or (:param=1 and fa_pack_status_flg = '50') or (:param=2 and fa_pack_status_flg = '20') )");
    findFpStopListFilter->setDefaultValue("FaPackTypeCdFilterComboBox", "param", "0");
    findFpStopListFilter->setDefaultValue("FaPackStatusFlgFilterComboBox", "param", "0");
    findFpStopListFilter->add("OwnerFilterEdit", "owner like '%:param%'");
    findFpStopListFilter->EnableControls();


    /* ������� ��� ������ ������� ������ �� ���������� */
    findFpOverdueListFilter->DisableControls();
    findFpOverdueListFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");
    findFpOverdueListFilter->add("FaPackTypeCdFilterComboBox", "(:param = 0 or (:param=1 and fa_pack_type_cd = '10') or (:param=2 and fa_pack_type_cd = '20') or (:param=3 and fa_pack_type_cd = '40') or (:param=4 and fa_pack_type_cd = '45') or (:param=5 and fa_pack_type_cd = '50'))");
    findFpOverdueListFilter->add("FaPackStatusFlgFilterComboBox", "(:param = 0 or (:param=1 and fa_pack_status_flg = '50') or (:param=2 and fa_pack_status_flg = '20') )");
    findFpOverdueListFilter->setDefaultValue("FaPackTypeCdFilterComboBox", "param", "0");
    findFpOverdueListFilter->setDefaultValue("FaPackStatusFlgFilterComboBox", "param", "0");
    findFpOverdueListFilter->add("OwnerFilterEdit", "owner like '%:param%'");
    findFpOverdueListFilter->EnableControls();




    //getOtdelenList->Open();
    //TOtdelenComboBoxFrame::add("������������","ddd");
    //TOtdelenComboBoxFrame::addFromQuery(getOtdelenList);
    //getOtdelenList->Close();


    /*faTypesList.add("���", "0");
    faTypesList.add("������ ����������", "1");
    faTypesList.add("������ �� �����", "2");
    faTypesList.add("������ �� ����������", "3");*/

    /*faTypesAndDebtorList.add("��������", "0");
    faTypesAndDebtorList.add("������ ����������", "1");
    faTypesAndDebtorList.add("������ �� �����", "2");
    faTypesAndDebtorList.add("������ �� ����������", "3");*/







    //getFaPackInfProc->ParamByName("app_path")->AsString = appPath;
    /* DataSet Powerfull Filters */
    //_filterForApprove;
    //_filterForApprove.add("1", "check_data = 1");

        // ������ ��� �����������
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

        // ������� ��� �������
        _filterApproveList->add("cc_dttm_is", "cc_dttm is :param");
        _filterApproveList->add("cc_dttm_more", "(cc_dttm < ':param' or cc_dttm is null)");
    } */



}

/* ��������� ������� � ������ */
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

/* ������� �������
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

/* ������ ����� ��������� ���������
*/
void TMainDataModule::updateCc(
    TDataSet* ds,
    Variant ccId,
    TDateTime ccDttm,
    const String& descr,
    const String& caller,
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
        updateCcProc->ParamByName("p_caller")->Value = caller;

        updateCcProc->ExecProc();

        ds->DisableControls();
        ds->Edit();
        ds->FieldByName("cc_id")->Value = updateCcProc->ParamByName("p_cc_id")->Value;
        ds->FieldByName("cc_dttm")->Value = updateCcProc->ParamByName("p_cc_dttm")->Value;
        ds->FieldByName("cc_type_cd")->Value = addCcProc->ParamByName("p_cc_type_cd")->Value;
        ds->FieldByName("cc_status_flg")->Value = addCcProc->ParamByName("p_cc_status_flg")->Value;

        ds->Post();
        ds->EnableControls();
        closeCcApprovalList();
    }
    catch(Exception &e)
    {
        throw Exception(e);
    }
}

/* �������������� ���������� �������� */
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

        closeFpCancelStopList();
        closeFpReconnectList();

        // ��� ������������� �����������
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




/* ������� ����� �������
*/
String TMainDataModule::addCc(
    TDataSet* ds,
    TDateTime ccDttm,
    const String& acct_id,
    const String& descr,
    const String& srcId,
    const String& caller,
    TCcTypeCd::Type ccTypeCd,
    //TCcStatusFlg::Type ccStatusFlg,
    TCcSourceTypeCd::Type ccSourceTypeCd
)
{
    try {

        addCcProc->ParamByName("p_cc_dttm")->Value = ccDttm;
        addCcProc->ParamByName("p_cc_type_cd")->Value = FormatFloat("00", ccTypeCd);//IntToStr(statusFlg);
        //addCcProc->ParamByName("p_cc_status_flg")->Value = FormatFloat("00", ccStatusFlg);//IntToStr(statusFlg);
        addCcProc->ParamByName("p_src_type_cd")->Value = FormatFloat("00", ccSourceTypeCd);//IntToStr(statusFlg);
        addCcProc->ParamByName("p_acct_id")->Value = acct_id;
        addCcProc->ParamByName("p_descr")->Value = descr;
        addCcProc->ParamByName("p_src_id")->Value = srcId;
        addCcProc->ParamByName("p_caller")->Value = caller;

        addCcProc->ExecProc();

        // ��� ������������� �����������
        if ( !addCcProc->ParamByName("result")->IsNull )
        {
            ds->DisableControls();
            ds->Edit();
            ds->FieldByName("cc_id")->Value = addCcProc->ParamByName("result")->Value;
            ds->FieldByName("cc_dttm")->Value = addCcProc->ParamByName("p_cc_dttm")->Value;
            ds->FieldByName("cc_type_cd")->Value = addCcProc->ParamByName("p_cc_type_cd")->Value;
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

/* ���������� ���������� �� �������� */
TFields* TMainDataModule::getCcInfo(const String& ccId)
{
    getCcInfProc->ParamByName("p_cc_id")->AsString = ccId;
    openOrRefresh(getCcInfProc);
    return getCcInfProc->Fields;
}

/*
*/
/*String TMainDataModule::setCcApprovalDttm(String ccId, bool cancelApproval)
{
    setCcApprovalDttmProc->ParamByName("p_cc_id")->Value = ccId;

    if (cancelApproval)
    {
        setCcApprovalDttmProc->ParamByName("p_approval_dttm")->Clear();
    }
    else
    {
        setCcApprovalDttmProc->ParamByName("p_approval_dttm")->Value = Now();
    }
    setCcApprovalDttmProc->ExecProc();
    //return setCcApprovalDttmProc->ParamByName("result")->AsString; /**
}               */

/* ���������� �������
*/
void __fastcall TMainDataModule::setCcStatusApproval()
{
    TDataSetFilter* approvalList = getApprovalListFilter;

    approvalList->LockDataSetPos();

    getCheckedFilter->clearAllValues();
    getCheckedFilter->setValue("checked", "param", "1");
    getCheckedFilter->DataSet = approvalList->DataSet;


    //approvalList->DisableControls();
    //int N = getApprovalListQuery->RecNo;
    //getApprovalListQuery->Filtered = false;
    getCheckedFilter->DataSet->First();
    // ����� ��� �������
    // �������� �������� ������ �������������� cancelApproval
    // ��� ������������� � �����

    while ( !approvalList->DataSet->Eof )
    {
        if ( !approvalList->DataSet->FieldByName("cc_id")->IsNull )
        {

            // ���������� �������
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
    getApprovalListFilter->UnlockDataSetPos();

    getApprovalListFilter->DataSet->Close();

    //getApprovalListQuery->Filtered = true;
    //getApprovalListQuery->RecNo = N;

    // ������� �������
    //getApprovalListQuery->EnableControls();
}

/* ��������� �������� */
bool __fastcall TMainDataModule::setCcStatusRefuse()
{
    FillProcListParameter(getApprovalListFilter, "cc_id", setCcStatusRefuseProc, "p_cc_id_list");

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


/* ��������� �������� ���������, ���������� �������, ��������� �������� ���� dataset */
void __fastcall TMainDataModule::FillProcListParameter(TDataSetFilter* dsFilter, const String& filterParamName, TOraStoredProc* procedure, const String& procParamName)
{
    BeginProcessing(dsFilter);

    // ������� �������� ����������
    procedure->ParamByName(procParamName)->Length = 0;

    // ��������� �������� - ������ ���������
    int i = 0;
    while ( !dsFilter->DataSet->Eof )
    {
        procedure->ParamByName(procParamName)->ItemAsString[++i] = dsFilter->DataSet->FieldByName(filterParamName)->AsString;
        dsFilter->DataSet->Next();
    }

    EndProcessing(dsFilter);
}




/* ������� ������
   ��� ������ ������������� ����������� ��������� ��������� ������ �� ����������
*/
bool __fastcall TMainDataModule::createPackStop(bool forceSelf)
{
    TDataSetFilter* filter = getPreStopListFilter;

    FillProcListParameter(getPreStopListFilter, "acct_id", createFpStopProc, "p_acct_id_list");    // 2017-08-09
    createFpStopProc->ParamByName("p_force_self")->AsString = forceSelf? 'Y': 'N';

    /*BeginProcessing(filter);    2017-08-09

    // ������� �������� ����������
    createFpStopProc->ParamByName("p_acct_id_list")->Length = 0;
    createFpStopProc->ParamByName("p_force_self")->AsString = forceSelf? 'Y': 'N';

    // ��������� �������� - ������ ���������
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

/* ������� ������ �����������
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

/* ������� ������ �����������
*/
String __fastcall TMainDataModule::createFpNotice(TFaPackTypeCd faPackTypeCd)
{
    // ���� �� ���������� �������
    // �� ������ ������ �� ������� ������� ��������� �����, �����, ��������
    // � ������������� � ������
    // ���������� ������ ��������� � ������ Excel,
    // ����� �������� ����������� ��� ��������� ������ �� ������ � �����������
    //_currentDbGrid->DataSource->DataSet->DisableControls();

    //TDataSetFilter* filter = getDebtorsFilter;


    TDataSetFilter* filter = _currentFilter;
    BeginProcessing(filter);

    // ������� �������� ����������
    createFpNoticeProc->ParamByName("p_acct_id_list")->Length = 0;

    createFpNoticeProc->ParamByName("p_fp_type")->AsString = faPackTypeCd;

    // ��������� �������� - ������ ���������
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

/* ������������, ���� ���������� �������� ����������*/
void __fastcall TMainDataModule::closePreDebtorList()
{
    // ����� ��� �������� "���� ���������" ����� �������� ������ ������� ��������� ����������
    //getDebtors->ParamByName("acct_otdelen")->AsString = "";
    getPreDebtorListProc->ParamByName("p_acct_otdelen")->AsString = "";
    getPreDebtorListRam->Close();
}

/* ��������� DataSet
   ������������, ���� ���������� �������� ������ �������� �� �����������
*/
void __fastcall TMainDataModule::closeFpStopList()
{
    getFpStopListFilter->DataSet->Close();
}

void __fastcall TMainDataModule::closePreStopList()
{
    getPreStopListFilter->DataSet->Close();
}

/* ��������� ������ �������� ������ �� ������ ���������� */
void __fastcall TMainDataModule::closeFpCancelStopList()
{
    getFpCancelListFilter->DataSet->Close();
}

/* ��������� ������ �������� ������ �� ������������� ����������� */
void __fastcall TMainDataModule::closeFpReconnectList()
{
    getFpReconnectListFilter->DataSet->Close();
}

void __fastcall TMainDataModule::closePreOverdueList()
{
    getPreOverdueListFilter->DataSet->Close();
}


void __fastcall TMainDataModule::closeFpOverdueList()
{
    getFpOverdueListFilter->DataSet->Close();
}



/* ��������� ���������� ������ �� ����������*/
void __fastcall TMainDataModule::closeFpStopContent()
{
    getFpStopContentFilter->DataSet->Close();
}

void __fastcall TMainDataModule::closeCcApprovalList()
{
    getApprovalListFilter->DataSet->Close();
}

void __fastcall TMainDataModule::closeFaPackNoticesList()
{
    getFpNoticesContentFilter->DataSet->Close();
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
// �������� ��� ������
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


/* ���������� ������ �� �����������
   �� ���������� ������� */
void __fastcall TMainDataModule::getApprovalList()
{
    if (_threadDataSet != NULL)
    {   // ���� ����� ��� �������
        return;
    }

    if (!getApprovalListFilter->DataSet->Active || getApprovalListProc->ParamByName("p_acct_otdelen")->AsString != _acctOtdelen->AsString)
    {
        getApprovalListProc->ParamByName("p_acct_otdelen")->AsString = _acctOtdelen->AsString;
        _threadDataSet = new TThreadDataSet(false, getApprovalListProc, getApprovalListRam, &OnThreadEvent);
    }
}

/* ���������� ������ �� �������� �����������
   �� ���������� ������� */
void __fastcall TMainDataModule::getStopList()
{
    if (_threadDataSet != NULL)
    {   // ���� ����� ��� �������
        return;
    }

    if (!getPreStopListFilter->DataSet->Active || getPreStopListProc->ParamByName("p_acct_otdelen")->AsString != _acctOtdelen->AsString)
    {
        getPreStopListProc->ParamByName("p_acct_otdelen")->AsString = _acctOtdelen->AsString;
        _threadDataSet = new TThreadDataSet(false, getPreStopListProc, getPreStopListRam, &OnThreadEvent);
    }
}

/* ���������� ������ �������� �� �����������
   �� ���������� ������� */
void __fastcall TMainDataModule::getFpStopList()
{
    getFpList(getFpStopListProc, getFpStopListFilter, getFpStopListRam, _acctOtdelen->AsString);

    /*if (_threadDataSet != NULL)
    {   // ���� ����� ��� �������
        return;
    }

    //if (!getPackStopListQuery->Active || getPackStopListQuery->ParamByName("acct_otdelen")->Value != _acctOtdelen->Value)
    if (!getFpStopListFilter->DataSet->Active || getFpStopListProc->ParamByName("p_acct_otdelen")->AsString != _acctOtdelen->AsString)
    {
        getFpStopListProc->ParamByName("p_acct_otdelen")->AsString = _acctOtdelen->AsString;
        _threadDataSet = new TThreadDataSet(false, getFpStopListProc, getFpStopListRam, &OnThreadEvent);
    }*/
}


/* ���������� ������ ������������ ������
   �� ���������� ������� */
void __fastcall TMainDataModule::getPreOverdueList()
{
    if (_threadDataSet != NULL)
    {   // ���� ����� ��� �������
        return;
    }

    if (!getPreOverdueListFilter->DataSet->Active || getPreOverdueListProc->ParamByName("p_acct_otdelen")->AsString != _acctOtdelen->AsString)
    {
        getPreOverdueListProc->ParamByName("p_acct_otdelen")->AsString = _acctOtdelen->AsString;
        _threadDataSet = new TThreadDataSet(false, getPreOverdueListProc, getPreOverdueListRam, &OnThreadEvent);
    }
}




/* ���������� ������ ��������
   �� ���������� ������� */
void __fastcall TMainDataModule::findFaPackListNotices(const String& acctOtdelen, const String& faId, const String& acctId)
{
    findFaPackListNoticesProc->ParamByName("p_acct_otdelen")->AsString = acctOtdelen;
    findFaPackListNoticesProc->ParamByName("p_fa_id")->AsString = faId;
    findFaPackListNoticesProc->ParamByName("p_acct_id")->AsString = acctId;
    findFaPackListNoticesProc->Open();
    CopyDataSet(findFaPackListNoticesProc, findFaPackListNoticesFilter->DataSet);
    findFaPackListNoticesProc->Close();

    // ��� ������, ������ ��� ����� ��������� ����� � ������ Modal
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


/* ���������� ������ ������ ���������
   �� ���������� ������� */
void __fastcall TMainDataModule::getAcctFullList()
{
    if (_threadDataSet != NULL)
    {
        return;
    }

    _currentFilter = getAcctFullListFilter;

    if (!getAcctFullListFilter->DataSet->Active
        || getAcctFullListProc->ParamByName("p_acct_otdelen")->AsString != _acctOtdelen->AsString)
    {
        getAcctFullListProc->ParamByName("p_acct_otdelen")->AsString = _acctOtdelen->AsString;
        _threadDataSet = new TThreadDataSet(false, getAcctFullListProc, getAcctFullListRam, &OnThreadEvent);
    }
}

/* ���������� ������ ���������
   �� ���������� ������� */
void __fastcall TMainDataModule::getPreDebtorList()
{
    if (_threadDataSet != NULL)
    {
        return;
    }

    _currentFilter = getPreDebtorListFilter;

    if (!getPreDebtorListFilter->DataSet->Active
        || getPreDebtorListProc->ParamByName("p_acct_otdelen")->AsString != _acctOtdelen->AsString)
    {
        if (_beforeOpenDataSet != NULL)
        {
            _beforeOpenDataSet(this);
        }
        getPreDebtorListProc->ParamByName("p_acct_otdelen")->AsString = _acctOtdelen->AsString;

        _threadDataSet = new TThreadDataSet(false, getPreDebtorListProc, getPreDebtorListRam, &OnThreadEvent);
    }
}

/* ���������� ������ �� �����
   �� ���������� ������� */
void __fastcall TMainDataModule::getPrePostList()
{
    if (_threadDataSet != NULL)
    {
        return;
    }

    _currentFilter  = getPrePostListFilter;

    if (!getPrePostListFilter->DataSet->Active
        || getPrePostListProc->ParamByName("p_acct_otdelen")->AsString != _acctOtdelen->AsString)
    {
        getPrePostListProc->ParamByName("p_acct_otdelen")->AsString = _acctOtdelen->AsString;
        _threadDataSet = new TThreadDataSet(false, getPrePostListProc, getPrePostListRam, &OnThreadEvent);
    }
}

/* ���������� ������ �� ������ ����������� */
void __fastcall TMainDataModule::getFpCancelList()
{
    if (_threadDataSet != NULL)
    {
        return;
    }

    _currentFilter  = getFpCancelListFilter;

    if (!getFpCancelListFilter->DataSet->Active
        || getFpCancelListProc->ParamByName("p_acct_otdelen")->AsString != _acctOtdelen->AsString)
    {
        getFpCancelListProc->ParamByName("p_acct_otdelen")->AsString = _acctOtdelen->AsString;
        _threadDataSet = new TThreadDataSet(false, getFpCancelListProc, getFpCancelStopRam, &OnThreadEvent);
    }
}

/* ������ ������� ���������
   updateOnly = true �� �������� ������ �������� _currentAcctOtdelen
*/
void __fastcall TMainDataModule::setAcctOtdelen(const String& acctOtdelen, bool updateOnly)
{
    static String oldAcctOtdelen = "";
    if (oldAcctOtdelen != acctOtdelen)
    {
        oldAcctOtdelen = acctOtdelen;

        // ������� �������� ������� getOtdelenListQuery � ���������� acctOtdelen
        // ��� ������� �� ��������������� ������
        // � ������ DBGridComboBox ������ �� ������

        if (updateOnly == false)
        {
            // ��������� �������� ������
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
        }
    }
}

void __fastcall TMainDataModule::setCurrentFp(const String& faPackId)
{
    getFaPackInfProc->ParamByName("p_fa_pack_id")->AsString = faPackId;
    openOrRefresh(getFaPackInfProc);

    setAcctOtdelen(getFaPackInfProc->FieldByName("acct_otdelen")->AsString, true);
}

/* ������ ������� ������ */
void __fastcall TMainDataModule::setCurrentFp(TOraStoredProc* proc, TDataSetFilter* filter, TVirtualTable* vtable, const String& faPackId)
{
    if (_threadDataSet != NULL)
    {   
        return;   // ���� ����� ��� �������
    }

    _currentFilter  = filter;

    if (faPackId != "" && proc->ParamByName("p_fa_pack_id")->AsString != faPackId)
    {
        proc->ParamByName("p_fa_pack_id")->Value = faPackId;
        filter->DataSet->Close();
    }

    if ( !filter->DataSet->Active && !proc->ParamByName("p_fa_pack_id")->IsNull)
    {
        _threadDataSet = new TThreadDataSet(false, proc, vtable, &OnThreadEvent);

        // ������ ��� �������� ������� ���������� �� ������
        //setCurrentFp(proc->ParamByName("p_fa_pack_id")->AsString);  // ���������, ����� �� ���  2017-08-21
    }

}


/* ������ ������� ������
*/
void __fastcall TMainDataModule::setCurrentFpNoticesId(const String& faPackId)
{
    setCurrentFp(getFpNoticesContentProc, getFpNoticesContentFilter, getFpNoticesContentRam, faPackId);

    // ����� ������� ��� ��� �������� ��� ������������ �������
    //  getFaPack ����� ���� ������������� � openFaPack.....
    /*if (_threadDataSet != NULL)
    {   // ���� ����� ��� �������
        return;
    }

    if ( !getFpNoticesContentFilter->DataSet->Active
        || getFpNoticesContentProc->ParamByName("p_fa_pack_id")->AsString != faPackId)
    {
        _currentFilter  = getFpNoticesContentFilter;

        /* ������ ��� ������*/
        /*getFpNoticesContentProc->ParamByName("p_fa_pack_id")->Value = faPackId;

        _threadDataSet = new TThreadDataSet(false, getFpNoticesContentProc, getFpNoticesContentRam, &OnThreadEvent);

        /* ������ ��� �������� ������� ���������� �� ������ */
        /*setFaPack(faPackId);
    }  */
}

/* ������ ������� �����
*/
void __fastcall TMainDataModule::setCurrentFpStopId(const String& faPackId)
{

    setCurrentFp(getFpStopContentProc, getFpStopContentFilter, getFpStopContentRam, faPackId);

    /*if (_threadDataSet != NULL)
    {   // ���� ����� ��� �������
        return;
    }



    _currentFilter  = getFpStopContentFilter;

    if (faPackId !="" && getFpStopContentProc->ParamByName("p_fa_pack_id")->AsString != faPackId)
    {
        getFpStopContentProc->ParamByName("p_fa_pack_id")->AsString = faPackId;
        getFpStopContentFilter->DataSet->Close();
    }

    if ( !getFpStopContentFilter->DataSet->Active  && !getFpStopContentProc->ParamByName("p_fa_pack_id")->IsNull)
    {
        _threadDataSet = new TThreadDataSet(false, getFpStopContentProc, getFpStopContentRam, &OnThreadEvent);

        // ������ ��� �������� ������� ���������� �� ������
        setFaPack(getFpStopContentProc->ParamByName("p_fa_pack_id")->AsString);
    } */




    /*if ( !getFpStopContentFilter->DataSet->Active
        || getFpStopContentProc->ParamByName("p_fa_pack_id")->Value != faPackId)
    {
        _currentFilter  = getFpStopListFilter;

        // ������ ��� ������
        getFpStopContentProc->ParamByName("p_fa_pack_id")->Value = faPackId;
        _threadDataSet = new TThreadDataSet(false, getFpStopContentProc, getFpStopContentRam, &OnThreadEvent);

        // ������ ��� �������� ������� ���������� �� ������
        setFaPack(faPackId);
    }  */
}

/* ������ ������� ������ �� ������
*/
void __fastcall TMainDataModule::setCurrentFpCancel(const String& faPackId)
{
    setCurrentFp(getFpCancelContentProc, getFpCancelContentFilter, getFpCancelContentRam, faPackId);

    /*if (_threadDataSet != NULL)
    {   // ���� ����� ��� �������
        return;
    }

    _currentFilter  = getFpCancelContentFilter;

    if (faPackId !="" && getFpCancelContentProc->ParamByName("p_fa_pack_id")->AsString != faPackId)
    {
        getFpCancelContentProc->ParamByName("p_fa_pack_id")->Value = faPackId;
        getFpCancelContentFilter->DataSet->Close();
    }

    if ( !getFpCancelContentFilter->DataSet->Active && !getFpCancelContentProc->ParamByName("p_fa_pack_id")->IsNull)
    {
        _threadDataSet = new TThreadDataSet(false, getFpCancelContentProc, getFpCancelContentRam, &OnThreadEvent);

        // ������ ��� �������� ������� ���������� �� ������
        setFaPack(getFpCancelContentProc->ParamByName("p_fa_pack_id")->AsString);
    }   */


    /*if ( !getFpCancelContentFilter->DataSet->Active
        || getFpCancelContentProc->ParamByName("p_fa_pack_id")->AsString != faPackId)
    {
        _currentFilter  = getFpCancelContentFilter;

        /* ������ ��� ������*/
        /*if (faPackId != "")
        {
            getFpCancelContentProc->ParamByName("p_fa_pack_id")->Value = faPackId;
        }
        _threadDataSet = new TThreadDataSet(false, getFpCancelContentProc, getFpCancelContentRam, &OnThreadEvent);

        /* ������ ��� �������� ������� ���������� �� ������ */
       /* setFaPack(getFpCancelContentProc->ParamByName("p_fa_pack_id")->AsString);
    }        */
}

/* ������ ������� ������ �� �������������
*/
void __fastcall TMainDataModule::setCurrentFpReconnect(const String& faPackId)
{
    setCurrentFp(getFpReconnectContentProc, getFpReconnectContentFilter, getFpReconnectContentRam, faPackId);
}

/* ������ ������� ������ ������������ ������
*/
void __fastcall TMainDataModule::setCurrentFpOverdue(const String& faPackId)
{
    setCurrentFp(getFpOverdueContentProc, getFpOverdueContentFilter, getFpOverdueContentRam, faPackId);
}



/* ���������� ID �������� �������
*/
Variant __fastcall TMainDataModule::getAcctOtdelen()
{
    return getOtdelenListProc->FieldByName("acct_otdelen")->Value;
}

/* ���������� ID ������� ������� ����������� */
String __fastcall TMainDataModule::getFpNoticesId() const
{
    return getFpNoticesContentProc->ParamByName("p_fa_pack_id")->AsString;
}

/* ���������� ID �������� ������� �� ���������� */
String __fastcall TMainDataModule::getFpStopId() const
{
    return getFpStopContentProc->ParamByName("p_fa_pack_id")->AsString;
}

/* ���������� ID �������� ������� �� ������ ��������� */
String __fastcall TMainDataModule::getFpCancelId() const
{
    return getFpCancelContentProc->ParamByName("p_fa_pack_id")->AsString;
}

/* ���������� ID �������� ������� �� ������������� */
String __fastcall TMainDataModule::getFpReconnectId() const
{
    return getFpReconnectContentProc->ParamByName("p_fa_pack_id")->AsString;
}

/* ���������� ID �������� ������� ������������ ������ */
String __fastcall TMainDataModule::getFpOverdueId() const
{
    return getFpOverdueContentProc->ParamByName("p_fa_pack_id")->AsString;
}


/* ������� ��� ���������� � ��������� ������
   ��������� dataset �������� ������ ���������� */
void __fastcall TMainDataModule::BeginProcessing(TDataSetFilter* filter)
{
    filter->LockDataSetPos();      // ���������� ������� � dataset  � ��������� ����������� ���������

    // ��������, �����, ������������ ��������� ������
    getCheckedFilter->clearAllValues();
    getCheckedFilter->setValue("checked", "param", "1"); //
    getCheckedFilter->DataSet = filter->DataSet;   // ������������ ������ � dataset
}

/* �������, ���������� ��� ���������� ��������� ������ */
void __fastcall TMainDataModule::EndProcessing(TDataSetFilter* filter)
{
    getCheckedFilter->DataSet = NULL;
    filter->UnlockDataSetPos();
}

/* �������� �������� */
bool __fastcall TMainDataModule::deleteFaPack()
{
    TDataSetFilter* filter = getFpStopListFilter;
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
            //MessageBoxStop("������ " + filter->DataSet->FieldByName("fa_pack_id")->AsString + " �� ��� ������, ��� ��� ��������� � ������� " + filter->DataSet->FieldByName("fa_pack_status_descr")->AsString);
            return false;
        }
        filter->DataSet->Next();
    }

    EndProcessing(filter);
    return true;
}

/**/
bool __fastcall TMainDataModule::setFaPackStatusIncomplete()
{
    TDataSetFilter* filter = getFpStopListFilter;
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

bool __fastcall TMainDataModule::setFaPackStatusFrozen()
{
    TDataSetFilter* filter = getFpStopListFilter;
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


/* ������ �������, ���������� ��� ������ � �� ��������� ���������� �� ������� �������� � ��������
   ������ ��� ������������� � ����������� �����������
*/
void __fastcall TMainDataModule::setOpenDataSetEvents(TNotifyEvent beforeOpenDataSet, TNotifyEvent afterOpenDataSet)
{
    _beforeOpenDataSet = beforeOpenDataSet;
    _afterOpenDataSet = afterOpenDataSet;
}

/* ������� ��� ��������� �������
   ������ ��� ������������� � ����������� �����������
*/
void __fastcall TMainDataModule::setOnChangeFilterMethod(TNotifyEvent onChangeFilterMethod)
{
    _onChangeFilterMethod = onChangeFilterMethod;
}

/* ��� ��������� �������
   ������ ��� ������������� � ����������� �����������
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
    // ������������ ����������
    /*if (!Application->Terminated)
    {
        ShowMessage("���������� ��������.");
    }*/
}
/**/
void __fastcall TMainDataModule::getFpReconnectList()
{
    getFpList(getFpReconnectListProc, getFpReconnectListFilter, getFpReconnectListRam, _acctOtdelen->AsString);

    /*if (_threadDataSet != NULL)
    {
        return;
    }

    _currentFilter  = getReconnectListFilter;

    if (!getReconnectListFilter->DataSet->Active
        || getReconnectListProc->ParamByName("p_acct_otdelen")->AsString != _acctOtdelen->AsString)
    {
        getReconnectListProc->ParamByName("p_acct_otdelen")->AsString = _acctOtdelen->AsString;
        _threadDataSet = new TThreadDataSet(false, getReconnectListProc, getReconnectListRam, &OnThreadEvent);
    }*/
}

String __fastcall TMainDataModule::getFaPackStats()
{
    TDateTime dt = getConfigProc->FieldByName("today")->AsDateTime;

    double start_month = StartOfTheMonth(dt);
    String result = "";

    // �� ������� ����
    getFaPackStatsProc->ParamByName("p_start_dt")->AsDateTime = dt;
    getFaPackStatsProc->ParamByName("p_end_dt")->AsDateTime = dt;//start_month-1;
    getFaPackStatsProc->Open();

    result += StrPadR("�� ������� ���� ", 120, "_") + "\n";
        /*+ FormatDateTime("dd.mm.yyyy", getFaPackStatsProc->ParamByName("p_start_dt")->AsDateTime )
        + " - "
        + FormatDateTime("dd.mm.yyyy", getFaPackStatsProc->ParamByName("p_end_dt")->AsDateTime )
        + ":\n"; */

    result += StrPadR("�������", 20, " ") + StrPadR("����. �����.", 20, " ") + StrPadR("����. �����", 20, " ") + StrPadR("�����.", 20, " ") + StrPadR("�����.", 20, " ") + StrPadR("������.", 20, " ") + "\n";
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


    // �� ������� �����
    getFaPackStatsProc->ParamByName("p_start_dt")->AsDateTime = start_month;
    getFaPackStatsProc->ParamByName("p_end_dt")->AsDateTime = dt;//start_month-1;
    getFaPackStatsProc->Open();

    result += StrPadR("�� ������ "
        + FormatDateTime("dd.mm.yyyy", getFaPackStatsProc->ParamByName("p_start_dt")->AsDateTime )
        + " - "
        + FormatDateTime("dd.mm.yyyy", getFaPackStatsProc->ParamByName("p_end_dt")->AsDateTime )
        , 120, "_") + "\n";

    result += StrPadR("�������", 20, " ") + StrPadR("����. �����.", 20, " ") + StrPadR("����. �����", 20, " ") + StrPadR("�����.", 20, " ") + StrPadR("�����.", 20, " ") + StrPadR("������.", 20, " ") + "\n";
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


    // �� ��� ��������� ������
    getFaPackStatsProc->ParamByName("p_start_dt")->AsDateTime = IncMonth(start_month,-1);
    getFaPackStatsProc->ParamByName("p_end_dt")->AsDateTime = dt;//start_month-1;
    getFaPackStatsProc->Open();

    result += StrPadR("�� ������ "
        + FormatDateTime("dd.mm.yyyy", getFaPackStatsProc->ParamByName("p_start_dt")->AsDateTime )
        + " - "
        + FormatDateTime("dd.mm.yyyy", getFaPackStatsProc->ParamByName("p_end_dt")->AsDateTime )
        , 120, "_") + "\n";

    result += StrPadR("�������", 20, " ") + StrPadR("����. �����.", 20, " ") + StrPadR("����. �����", 20, " ") + StrPadR("�����.", 20, " ") + StrPadR("�����.", 20, " ") + StrPadR("������.", 20, " ") + "\n";
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

/* ������ ������ �� ��������� */
bool __fastcall TMainDataModule::createFpCancelForce()
{
    TDataSetFilter* filter = getFpStopContentFilter;
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


    /*if (i > 1)
    {
        return true;
    }    */

    /*createFpCancelStopForceProc->ParamByName("p_fa_id_list")->ItemAsString[1] = "0000035604";
    createFpCancelStopForceProc->ParamByName("p_fa_id_list")->ItemAsString[2] = "0000035610";
    createFpCancelStopForceProc->Execute();
    */

}

bool __fastcall TMainDataModule::createFpOverdue()
{
    TDataSetFilter* filter = getPreOverdueListFilter;

    FillProcListParameter(getPreOverdueListFilter, "fa_id", createFpOverdueProc, "p_fa_id_list");    // ��������� ������

    //createFpStopProc->ParamByName("p_force_self")->AsString = forceSelf? 'Y': 'N';

    /*BeginProcessing(filter);    2017-08-09

    // ������� �������� ����������
    createFpStopProc->ParamByName("p_acct_id_list")->Length = 0;
    createFpStopProc->ParamByName("p_force_self")->AsString = forceSelf? 'Y': 'N';

    // ��������� �������� - ������ ���������
    int i = 0;
    while ( !filter->DataSet->Eof )
    {
        createFpStopProc->ParamByName("p_acct_id_list")->ItemAsString[++i] = filter->DataSet->FieldByName("acct_id")->AsString;
        filter->DataSet->Next();
    }

    EndProcessing(filter);   */

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

void __fastcall TMainDataModule::getFpList(TOraStoredProc* proc, TDataSetFilter* filter, TVirtualTable* vtable, const String& acctOtdelen)
{
    if (_threadDataSet != NULL)
    {   // ���� ����� ��� �������
        return;
    }

    //if (!getPackStopListQuery->Active || getPackStopListQuery->ParamByName("acct_otdelen")->Value != _acctOtdelen->Value)
    if (!filter->DataSet->Active || proc->ParamByName("p_acct_otdelen")->AsString != acctOtdelen)
    {
        proc->ParamByName("p_acct_otdelen")->AsString = acctOtdelen;
        _threadDataSet = new TThreadDataSet(false, proc, vtable, &OnThreadEvent);
    }

}

void __fastcall TMainDataModule::getFpOverdueList()
{
    getFpList(getFpOverdueListProc, getFpOverdueListFilter, getFpOverdueListRam, _acctOtdelen->AsString);
}



