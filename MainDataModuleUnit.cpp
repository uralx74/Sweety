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

    getDebtorsDataSource->DataSet = getDebtorsRam;
    getFullListDataSource->DataSet = getFullListRam;
    getApprovalListDataSource->DataSet = getApprovalListRam;
    getFaPackDataSource->DataSet =  getFaPackRam;
    getPostListDataSource->DataSet = getPostListRam;

    getStopListDataSource->DataSet = getStopListRam;         // ������ �� �����������
    getFaPackStopDataSource->DataSet = getFaPackStopRam;    // ������
    getPackListStopDataSource->DataSet = getPackListStopRam;  // ������ ��������
    getCancelStopListDataSource->DataSet = getCancelStopListRam;

    getFaPackListNoticesDataSource->DataSet = getFaPackListNoticesRam;

    findFaPackListNoticesDS->DataSet = findFaPackListNoticesRam;
    findFaPackListStopDS->DataSet = findFaPackListStopRam;

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
    if (getConfigProc->FieldByName("allowed")->AsInteger != 1)
    {
        Application->Terminate();
        Application->ProcessMessages();
        MessageBoxStop("������ ����� ��������� ��������. \n���������� ���������� ������ ���������: " +
            getConfigProc->FieldByName("min_app_ver")->AsString);
        return;
    }

    // ��� ����� �� ���� ������
    String beginDt = DateToStr(IncMonth(Now(), -3));
    String endDt = DateToStr(Now());



    /* ����������� � ����� ������ */
    //connectEsale();

    /* �������� ������ �������� */
    getOtdelenListQuery->ParamByName("app_path")->AsString = appPath;
    getOtdelenListQuery->Open();

    
    if ( getOtdelenListQuery->RecordCount == 0 )
    { // ���� ��� ������������ ��� ��������� ��������
        Application->Terminate();
        Application->ProcessMessages();
        MessageBoxStop("�� �� ������ ��������� ��������.\n��������� ����� �������.");
        return;
    }


    /* ������ ������� ��������� */
    setAcctOtdelen(getOtdelenListQuery->FieldByName("ACCT_OTDELEN")->AsString);


    /* �������� �������� */
    // ������ ��� ������ � ����������� ��������
    getCheckedFilter->add("checked", "check_data = :param"); // ����������
    getCheckedFilter->add("group", "grp_data = :param"); // � ������������ (��������, ��� ������������ ������ �� ����������
                                                    // ��������������� �� ������� � ��������� �����)
    //getCheckedFilter->setValue("checked", "", " ");

    /* ������ ��� ������� ������ ��������� */
    getFullListFilter->DisableControls();
    getFullListFilter->add("AcctIdComboBox", "acct_id like '%:param%'");
    getFullListFilter->add("AddressComboBox", "address like '%:param%'");
    getFullListFilter->add("CityComboBox", "city like '%:param%'");
    getFullListFilter->add("FioComboBox", "fio like '%:param%'");
    getFullListFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");
    getFullListFilter->add("ServiceCompanyFilterComboBox", "service_org like '%:param%'");
    getFullListFilter->add("SaldoFilterEdit", "saldo_uch > :param");
    getFullListFilter->add("OpAreaDescrFilterComboBox", "op_area_descr like '%:param%'");
    //getFullListFilter->add("cc_dttm", "(:param)");
    getFullListFilter->add("CcDttmStatusComboBox", "(:param = 0 or (:param=1 and cc_dttm is not null) or (:param=2 and cc_dttm is null) or (:param=3 and cc_dttm >= ':begin_dt' and cc_dttm < ':end_dt') )");
    getFullListFilter->setDefaultValue("CcDttmStatusComboBox", "param", "0");
    getFullListFilter->setDefaultValue("CcDttmStatusComboBox", "begin_dt", beginDt);
    getFullListFilter->setDefaultValue("CcDttmStatusComboBox", "end_dt", endDt);


    // ������� ��� ������� (�� ��������� � ��������� ������?)
    getFullListFilter->add("cc_dttm_is", "cc_dttm is :param");
    getFullListFilter->add("cc_dttm_more", "(cc_dttm < ':param' or cc_dttm is null)");

    getFullListFilter->EnableControls();


    /* ������ ��� ������ ��������� */
    //DBGridAltGeneral->Filtered = true;
    getDebtorsFilter->DisableControls();
    getDebtorsFilter->add("AcctIdComboBox", "acct_id like '%:param%'");
    getDebtorsFilter->add("AddressComboBox", "address like '%:param%'");
    getDebtorsFilter->add("CityComboBox", "city like '%:param%'");
    getDebtorsFilter->add("FioComboBox", "fio like '%:param%'");
    getDebtorsFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");
    getDebtorsFilter->add("ServiceCompanyFilterComboBox", "service_org like '%:param%'");
    getDebtorsFilter->add("SaldoFilterEdit", "saldo_uch > :param");
    getDebtorsFilter->add("OpAreaDescrFilterComboBox", "op_area_descr like '%:param%'");
    //getDebtorsFilter->add("cc_dttm", "(:param)");
    getDebtorsFilter->add("CcDttmStatusComboBox", "(:param = 0 or (:param=1 and cc_dttm is not null) or (:param=2 and cc_dttm is null) or (:param=3 and cc_dttm >= ':begin_dt' and cc_dttm < ':end_dt') )");
    getDebtorsFilter->setDefaultValue("CcDttmStatusComboBox", "param", "0");
    getDebtorsFilter->setDefaultValue("CcDttmStatusComboBox", "begin_dt", beginDt);
    getDebtorsFilter->setDefaultValue("CcDttmStatusComboBox", "end_dt", endDt);


    // ������� ��� ������� (�� ��������� � ��������� ������?)
    getDebtorsFilter->add("cc_dttm_is", "cc_dttm is :param");
    getDebtorsFilter->add("cc_dttm_more", "(cc_dttm < ':param' or cc_dttm is null)");

    // ������ ��� ���������
    //getDebtorsFilter->add("vcl_ctrl", "");
    //getDebtorsFilter->setValue("vcl_ctrl", "begin_dt", beginDt);
    //getDebtorsFilter->setValue("vcl_ctrl", "end_dt", endDt);

    getDebtorsFilter->EnableControls();



    /* ������ ��� ������ ����������� */
    //DBGridAltManual->Filtered = true;
    getFaPackNoticesFilter->DisableControls();
    getFaPackNoticesFilter->add("AcctIdComboBox", "acct_id like '%:param%'");
    getFaPackNoticesFilter->add("AddressComboBox", "address like '%:param%'");
    getFaPackNoticesFilter->add("FioComboBox", "fio like '%:param%'");
    getFaPackNoticesFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");
    getFaPackNoticesFilter->add("ServiceCompanyFilterComboBox", "service_org like '%:param%'");
    getFaPackNoticesFilter->add("SaldoFilterEdit", "saldo_uch > :param");
    getFaPackNoticesFilter->add("CityComboBox", "city like '%:param%'");
    getFaPackNoticesFilter->add("OpAreaDescrFilterComboBox", "op_area_descr like '%:param%'");
    //getFaPackFilter->add("cc_dttm", "(:param)");

    getFaPackNoticesFilter->add("CcDttmStatusComboBox", "(:param = 0 or (:param=1 and cc_dttm is not null) or (:param=2 and cc_dttm is null) or (:param=3 and cc_dttm >= ':begin_dt' and cc_dttm < ':end_dt') )");
    getFaPackNoticesFilter->setDefaultValue("CcDttmStatusComboBox", "param", "0");
    getFaPackNoticesFilter->setDefaultValue("CcDttmStatusComboBox", "begin_dt", beginDt);
    getFaPackNoticesFilter->setDefaultValue("CcDttmStatusComboBox", "end_dt", endDt);

    // ������� ��� �������
    getFaPackNoticesFilter->add("cc_dttm_is", "cc_dttm is :param");
    getFaPackNoticesFilter->add("cc_dttm_more", "(cc_dttm < ':param' or cc_dttm is null)");

    getFaPackNoticesFilter->EnableControls();



    /* ������ ��� ������ ����������� */
    //DBGridAltManual->Filtered = true;
    getPostListFilter->DisableControls();
    getPostListFilter->add("AcctIdComboBox", "acct_id like '%:param%'");
    getPostListFilter->add("AddressComboBox", "address like '%:param%'");
    getPostListFilter->add("FioComboBox", "fio like '%:param%'");
    getPostListFilter->add("ServiceCompanyFilterComboBox", "service_org like '%:param%'");
    getPostListFilter->add("SaldoFilterEdit", "saldo_uch > :param");
    getPostListFilter->add("CityComboBox", "city like '%:param%'");
    getPostListFilter->add("OpAreaDescrFilterComboBox", "op_area_descr like '%:param%'");
    //getPostListFilter->add("CcDttmStatusComboBox", "(:param = 0 or (:param=1 and cc_dttm is not null) or (:param=2 and cc_dttm is null) )");
    /*getPostListFilter->add("CcDttmStatusComboBox", "(:param = 0 or (:param=1 and cc_dttm is not null) or (:param=2 and cc_dttm is null) or (:param=3 and cc_dttm >= ':begin_dt' and cc_dttm < ':end_dt') )");
    getPostListFilter->setDefaultValue("CcDttmStatusComboBox", "param", "0");
    getPostListFilter->setDefaultValue("CcDttmStatusComboBox", "begin_dt", beginDt);
    getPostListFilter->setDefaultValue("CcDttmStatusComboBox", "end_dt", endDt);*/



    getPostListFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");

    // ������� ��� �������
    //getPostListFilter->add("cc_dttm_is", "cc_dttm is :param");
    //getPostListFilter->add("cc_dttm_more", "(cc_dttm < ':param' or cc_dttm is null)");
    getPostListFilter->EnableControls();



    /* ������ ��� ����������� */
    //ApproveListGrid->Filtered = true;
    getApprovalListFilter->DisableControls();
    getApprovalListFilter->add("AcctIdComboBox", "acct_id like '%:param%'");
    getApprovalListFilter->add("AddressComboBox", "address like '%:param%'");
    getApprovalListFilter->add("FioComboBox", "fio like '%:param%'");
    //getApprovalListFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");
    getApprovalListFilter->add("ServiceCompanyFilterComboBox", "service_org like '%:param%'");
    getApprovalListFilter->add("SaldoFilterEdit", "saldo_uch > :param");
    getApprovalListFilter->add("CityComboBox", "city like '%:param%'");
    //getApprovalListFilter->add("cc_dttm", "(:param)");
    //getApprovalListFilter->add("ccDttmIsApprovedCheckBox", "approval_dttm is not null :param");
    //getApprovalListFilter->add("ApprovedStatusComboBox", "approval_dttm is :param null"); // is [not] null
    getApprovalListFilter->add("ApprovedStatusComboBox", "(:param = 0 or (:param=1 and approval_dttm is not null) or (:param=2 and approval_dttm is null) )"); // is [not] null
    //getApprovalListFilter->setValue("ApprovedStatusComboBox", "param", "2");
    getApprovalListFilter->setDefaultValue("ApprovedStatusComboBox", "param", "2");

    /*getApprovalListFilter->add("ApprovedStatusComboBox"
        , "(:param = 0 or (:param=1 and approval_dttm is null) or (:param=2 and approval_dttm is not null) )" ); // is [not] null    */

    // ������� ��� �������
    getApprovalListFilter->add("cc_dttm_is", "cc_dttm is :param");
    getApprovalListFilter->add("cc_dttm_more", "(cc_dttm < ':param' or cc_dttm is null)");
    getApprovalListFilter->EnableControls();




    /* ������ ��� ������ �� ����������� */
    getStopListFilter->DisableControls();
    getStopListFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");
    getStopListFilter->add("AcctIdComboBox", "acct_id like '%:param%'");
    getStopListFilter->add("AddressComboBox", "address like '%:param%'");
    getStopListFilter->add("FioComboBox", "fio like '%:param%'");
    getStopListFilter->add("ServiceCompanyFilterComboBox", "spr_descr like '%:param%'");
    getStopListFilter->add("PremTypeComboBox", "prem_type_descr like '%:param%'");
    getStopListFilter->add("FaPackTypeFilterComboBox", "fa_pack_type_descr like '%:param%'");
    getStopListFilter->EnableControls();

    /* ������ ��� ������ �������� �� ����������� */
    getPackListStopFilter->DisableControls();
    getPackListStopFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");
    getPackListStopFilter->add("ServiceCompanyFilterComboBox", "spr_descr like '%:param%'");
    //getPackStopListFilter->add("AddressComboBox", "address like '%:param%'");
    //getPackStopListFilter->add("FioComboBox", "fio like '%:param%'");
    getPackListStopFilter->EnableControls();



    /* ������ ��� ������� �� ����������� */
    //DBGridAltManual->Filtered = true;
    getFaPackStopFilter->DisableControls();
    getFaPackStopFilter->add("AcctIdComboBox", "acct_id like '%:param%'");
    getFaPackStopFilter->add("AddressComboBox", "address like '%:param%'");
    getFaPackStopFilter->add("FioComboBox", "fio like '%:param%'");
    getFaPackStopFilter->EnableControls();



    /* ������� ��� ������ ������� ����������� */
    findFaPackListNoticesFilter->DisableControls();
    findFaPackListNoticesFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");
    findFaPackListNoticesFilter->add("FaPackTypeDescrFilterComboBox", "fa_pack_type_descr like '%:param%'");
    findFaPackListNoticesFilter->add("FaPackStatusFlgFilterComboBox", "(:param = 0 or (:param=1 and fa_pack_status_flg = '50') or (:param=2 and fa_pack_status_flg = '20') or (:param=3 and fa_pack_status_flg = '60'))");
    findFaPackListNoticesFilter->setDefaultValue("FaPackStatusFlgFilterComboBox", "param", "0");
    findFaPackListNoticesFilter->add("OwnerFilterEdit", "owner like '%:param%'");
    findFaPackListNoticesFilter->EnableControls();

    /* ������� ��� ������ ������� ������ �� ���������� */
    findFaPackListStopFilter->DisableControls();
    findFaPackListStopFilter->add("FaPackIdFilterEdit", "fa_pack_id like '%:param%'");
    findFaPackListStopFilter->add("FaPackTypeDescrFilterComboBox", "fa_pack_type_descr like '%:param%'");
    findFaPackListStopFilter->add("FaPackStatusFlgFilterComboBox", "(:param = 0 or (:param=1 and fa_pack_status_flg = '50') or (:param=2 and fa_pack_status_flg = '20') or (:param=3 and fa_pack_status_flg = '60'))");
    findFaPackListStopFilter->setDefaultValue("FaPackStatusFlgFilterComboBox", "param", "0");
    findFaPackListStopFilter->add("OwnerFilterEdit", "owner like '%:param%'");
    findFaPackListStopFilter->EnableControls();





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


    getCcStatusFlgListQuery->Open();
    getCcTypeCdQuery->Open();

    // ��������� ���������
    getConfigQuery->ParamByName("app_path")->AsString = appPath;
    getConfigQuery->ParamByName("username")->AsString = EsaleSession->Username;
    getConfigQuery->Open();

    // ������ ��������� � ������ ����� ����������
    getOtdelenListQuery->ParamByName("app_path")->AsString = appPath;

    //getOtdelenListQuery->ParamByName("username")->AsString = EsaleSession->Username;

    getOtdelenListQuery->Open();

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



    _acctOtdelen = getOtdelenListQuery->FieldByName("acct_otdelen");
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
    TCcTypeCd::Type ccTypeCd,
    TCcStatusFlg::Type ccStatusFlg
)
{
    try
    {
        updateCcProc->ParamByName("p_cc_id")->Value = ccId;
        updateCcProc->ParamByName("p_cc_dttm")->Value = ccDttm;
        updateCcProc->ParamByName("p_cc_type_cd")->Value = FormatFloat("00", ccTypeCd);//IntToStr(statusFlg);
        updateCcProc->ParamByName("p_cc_status_flg")->Value = FormatFloat("00", ccStatusFlg);//IntToStr(statusFlg);
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
    TCcStatusFlg::Type ccStatusFlg,
    TCcSourceTypeCd::Type ccSourceTypeCd
)
{
    try {

        addCcProc->ParamByName("p_cc_dttm")->Value = ccDttm;
        addCcProc->ParamByName("p_cc_type_cd")->Value = FormatFloat("00", ccTypeCd);//IntToStr(statusFlg);
        addCcProc->ParamByName("p_cc_status_flg")->Value = FormatFloat("00", ccStatusFlg);//IntToStr(statusFlg);
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
            ds->FieldByName("cc_status_flg")->Value = addCcProc->ParamByName("p_cc_status_flg")->Value;
            //ds->FieldByName("cc_dttm")->RefreshLookupList();
            //ds->FieldByName("cc_dttm")->Value = ccDttm;
            ds->Post();
            ds->EnableControls();
        }
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

/*
*/
void TMainDataModule::setCcApproval()
{
    TDataSetFilter* approvalList = getApprovalListFilter;

    approvalList->LockDataSetPos();

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


/* ������� ��������� ��������
   ��������� �����������
   ������������, ��������, ��� �������� ������ �� ����������� � ������ ������� ��������
*/
String __fastcall TMainDataModule::createPackMulti(TDataSetFilter* filter, TFaPackTypeCd faPackTypeCd, const String& acctOtdelen)
{
    int grp = 1;
    getCheckedFilter->setValue("checked", "param", "1");
    getCheckedFilter->setValue("group", "param", IntToStr(grp++)); //
    while ( !getFaPackStopFilter->DataSet->Eof )
    {
        createPackNotice(faPackTypeCd);
        //setPackCharDttm("ST-P-DT", getConfigQuery->FieldByName("sysdate")->Value)
        getCheckedFilter->setValue("group", "param", IntToStr(grp++)); //
    }
}



/* ������� ������
   ��� ������ ������������� ����������� ��������� ��������� ������ �� ����������
*/
std::vector<Variant> __fastcall TMainDataModule::createPackStop(bool useGrpFilter)
{
    //_currentDbGrid->DataSource->DataSet->DisableControls();
    TDataSetFilter* filter = getStopListFilter;
    filter->LockDataSetPos();

    getCheckedFilter->setValue("checked", "param", "1");
    //String k = getCheckedFilter->getFilterString();
    getCheckedFilter->DataSet = filter->DataSet;

    std::vector<Variant> result;

    if ( !filter->DataSet->Eof )  // ���� ���� ���������� ������
    {
        // ������ ��������� ������
        CreateFaPackProc->ParamByName("p_fa_pack_type_cd")->Value = FPT_STOP;
        CreateFaPackProc->ParamByName("p_acct_otdelen")->Value = _acctOtdelen->Value;

        int grp_data_max = getCheckedFilter->DataSet->FieldByName("grp_data_max")->AsInteger;
        for (int i = 1; i <= grp_data_max; i++ )
        {
            if ( useGrpFilter )
            {
                getCheckedFilter->setValue("group", "param", IntToStr(i));   // ��������� �� ������ (�� ������� ������������� �����������)
            }

            if ( filter->DataSet->Eof )
            {
                continue;
            }
            
            // ������� ����� �����
            CreateFaPackProc->ExecProc();

            Variant faPackId = CreateFaPackProc->ParamByName("result")->Value;
            result.push_back(faPackId);

            // ��������� � ����� ����� ���������� ������� �����
            while ( !filter->DataSet->Eof )
            {
                createFaStopProc->ParamByName("p_acct_id")->AsString = filter->DataSet->FieldByName("acct_id")->AsString;
                createFaStopProc->ParamByName("p_fa_pack_id")->AsString = faPackId;
                createFaStopProc->ExecProc();

                filter->DataSet->Next();
            }

            if ( useGrpFilter )
            {
                // ��������� �������� ���� �������� ������ �� ���������� ��������
                updateFaPackCharRecipientProc->ParamByName("p_fa_pack_id")->AsString = faPackId;
                updateFaPackCharRecipientProc->ExecProc();
            }
            else
            {
                // �������� ����� ����� ���������� � �������, ����� ������� ������ ������ ��� ����
            }

            // ���������� (���������) ������
            setFaPackStatusFlgFrozenProc->ParamByName("p_fa_pack_id")->AsString = faPackId;
            setFaPackStatusFlgFrozenProc->ExecProc();

            //CreateFaPackProc->CommitUpdates();

            if ( !useGrpFilter )     // ���� �� ���������� �����������, �� ������� �� �����
            {
                break;
            }

        }

        getCheckedFilter->DataSet = NULL;
        filter->UnlockDataSetPos();


        //return AddFaToPackStopProc->ParamByName("p_fa_pack_id")->AsString;
   }
   
   // ���������� ������ ID ����� ��������
   return result;

}

/* ������� ������ �����������
*/
Variant __fastcall TMainDataModule::createFaPackFree(TFaPackTypeCd faPackTypeCd)
{
    try
    {
        CreateFaPackProc->ParamByName("p_fa_pack_type_cd")->Value = faPackTypeCd;
        CreateFaPackProc->ParamByName("p_acct_otdelen")->Value = _acctOtdelen->Value;
        CreateFaPackProc->ExecProc();
        Variant faPackId = CreateFaPackProc->ParamByName("Result")->Value;
        return faPackId;
    }
    catch(Exception &e)
    {
        ShowMessage(e.Message);
    }
}

/* ������� ������ �����������
*/
Variant __fastcall TMainDataModule::createPackNotice(TFaPackTypeCd faPackTypeCd)
{
    // ���� �� ���������� �������
    // �� ������ ������ �� ������� ������� ��������� �����, �����, ��������
    // � ������������� � ������
    // ���������� ������ ��������� � ������ Excel,
    // ����� �������� ����������� ��� ��������� ������ �� ������ � �����������
    //_currentDbGrid->DataSource->DataSet->DisableControls();

    //TDataSetFilter* filter = getDebtorsFilter;

    _currentFilter->LockDataSetPos();

    getCheckedFilter->setValue("checked", "param", "1");
    //String k = getCheckedFilter->getFilterString();
    getCheckedFilter->DataSet = _currentFilter->DataSet;

    if (!_currentFilter->DataSet->Eof)  // ���� ���� ���������� ������
    {
        // ������� ����� �����
        CreateFaPackProc->ParamByName("p_fa_pack_type_cd")->Value = faPackTypeCd;
        CreateFaPackProc->ParamByName("p_acct_otdelen")->Value = _acctOtdelen->Value;
        CreateFaPackProc->ExecProc();
        Variant faPackId = CreateFaPackProc->ParamByName("Result")->Value;

        // ����
        while ( !_currentFilter->DataSet->Eof )
        {
            CreateFaProc->ParamByName("p_acct_id")->Value = _currentFilter->DataSet->FieldByName("acct_id")->AsString;
            CreateFaProc->ParamByName("p_fa_pack_id")->Value = faPackId;
            CreateFaProc->ExecProc();
            _currentFilter->DataSet->Next();

            // ����� ������� ����� ���������� �������
            Application->ProcessMessages();
        }
        //MainDataModule->EsaleSession->Commit();

        // ���������� (���������) ������
        setFaPackStatusFlgFrozenProc->ParamByName("p_fa_pack_id")->Value = faPackId;
        setFaPackStatusFlgFrozenProc->ExecProc();

        getCheckedFilter->DataSet = NULL;
        _currentFilter->UnlockDataSetPos();

        return faPackId;
    }
    else
    {
        return "";
    }
}

/* ������������, ���� ���������� �������� ����������*/
void __fastcall TMainDataModule::closeDebtorsQuery()
{
    // ����� ��� �������� "���� ���������" ����� �������� ������ ������� ��������� ����������
    //getDebtors->ParamByName("acct_otdelen")->AsString = "";
    getDebtorListProc->ParamByName("p_acct_otdelen")->AsString = "";
    getDebtorsRam->Close();
}

/* ��������� DataSet
   ������������, ���� ���������� �������� ������ �������� �� �����������
   */
void __fastcall TMainDataModule::closePackStopList()
{
    //getFaPackStopFilter->DataSet->ParamByName("acct_otdelen")->Value = "";
    getPackListStopFilter->DataSet->Close();
}

void __fastcall TMainDataModule::closeStopList()
{
    getStopListFilter->DataSet->Close();
}

void __fastcall TMainDataModule::closeCcApprovalList()
{
    getApprovalListFilter->DataSet->Close();
}

void __fastcall TMainDataModule::closeFaPackNoticesList()
{
    getFaPackNoticesFilter->DataSet->Close();
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

    if (!getApprovalListFilter->DataSet->Active || getApprovalListProc->ParamByName("p_acct_otdelen")->Value != _acctOtdelen->Value)
    {
        getApprovalListProc->ParamByName("p_acct_otdelen")->Value = _acctOtdelen->Value;
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

    if (!getStopListFilter->DataSet->Active || getStopListProc->ParamByName("p_acct_otdelen")->Value != _acctOtdelen->Value)
    {
        getStopListProc->ParamByName("p_acct_otdelen")->Value = _acctOtdelen->Value;
        _threadDataSet = new TThreadDataSet(false, getStopListProc, getStopListRam, &OnThreadEvent);
    }
}

/* ���������� ������ �������� �� �����������
   �� ���������� ������� */
void __fastcall TMainDataModule::getPackStopList()
{
    if (_threadDataSet != NULL)
    {   // ���� ����� ��� �������
        return;
    }

    //if (!getPackStopListQuery->Active || getPackStopListQuery->ParamByName("acct_otdelen")->Value != _acctOtdelen->Value)
    if (!getPackListStopFilter->DataSet->Active || getFaPackListStopProc->ParamByName("p_acct_otdelen")->Value != _acctOtdelen->Value)
    {
        getFaPackListStopProc->ParamByName("p_acct_otdelen")->Value = _acctOtdelen->Value;
        _threadDataSet = new TThreadDataSet(false, getFaPackListStopProc, getPackListStopRam, &OnThreadEvent);
    }
}


/* ���������� ������ ��������
   �� ���������� ������� */
void __fastcall TMainDataModule::findFaPackListNotices(const String& acctOtdelen)
{
    if (_threadDataSet != NULL)
    {   // ���� ����� ��� �������
        return;
    }

    //if (!getPackStopListQuery->Active || getPackStopListQuery->ParamByName("acct_otdelen")->Value != _acctOtdelen->Value)
   if (!findFaPackListNoticesFilter->DataSet->Active || findFaPackListNoticesProc->ParamByName("p_acct_otdelen")->Value != _acctOtdelen->Value)
    {
        findFaPackListNoticesProc->ParamByName("p_acct_otdelen")->Value = acctOtdelen;
        findFaPackListNoticesProc->Open();
        CopyDataSet(findFaPackListNoticesProc, findFaPackListNoticesFilter->DataSet);
        findFaPackListNoticesProc->Close();

        // ��� ������, ������ ��� ����� ��������� ����� � ������ Modal
        //_threadDataSet = new TThreadDataSet(false, findFaPackListNoticesProc, findFaPackListNoticesRam, &OnThreadEvent);

    }
}

void __fastcall TMainDataModule::findFaPackListStop(const String& acctOtdelen)
{
    if (_threadDataSet != NULL)
    {   // ���� ����� ��� �������
        return;
    }

    //if (!getPackStopListQuery->Active || getPackStopListQuery->ParamByName("acct_otdelen")->Value != _acctOtdelen->Value)
    if (!findFaPackListStopFilter->DataSet->Active || findFaPackListStopProc->ParamByName("p_acct_otdelen")->Value != _acctOtdelen->Value)
    {
        findFaPackListStopProc->ParamByName("p_acct_otdelen")->Value = acctOtdelen;
        findFaPackListStopProc->Open();
        CopyDataSet(findFaPackListStopProc, findFaPackListStopFilter->DataSet);
        findFaPackListStopProc->Close();
        // ��� ������, ������ ��� ����� ��������� ����� � ������ Modal
        //_threadDataSet = new TThreadDataSet(false, findFaPackListStopProc, findFaPackListStopRam, &OnThreadEvent);
    }
}


    /* ��� ������� �������� ����� ������,
    ��� ��� �� �������������� ��������, ���� ��������� �������� ������ ������� */
//    if (selectFaPackQuery->ParamByName("acct_otdelen")->Value != _acctOtdelen->Value ||
//      selectFaPackQuery->ParamByName("fa_pack_type_cd")->Value != faPackTypeCd)
//    {
 /*       getFaPackNoticesListProc->ParamByName("p_acct_otdelen")->Value = acctOtdelen;


        //getFaPackNoticesList->ParamByName("app_mode")->Value = mode;



        //selectFaPackQuery->ParamByName("fa_pack_type_cd")->Value = faPackTypeCd;
        getFaPackNoticesListProc->ExecProc();
        //openOrRefresh(getFaPackNoticesList);
//    }
    getFaPackNoticesListProc->First();   */
//}

/* ���������� ������
   �� ���������� ID ������� */
//void __fastcall TMainDataModule::getFaPack(const String& faPackId/*, String& acctOtdelen*/)
//{
   // if (getFaPackQuery->ParamByName("p_fa_pack_id")->Value != faPackId)
//    {
  //      getFaPackQuery->ParamByName("p_fa_pack_id")->AsString = faPackId;
 //       openOrRefresh(MainDataModule->getFaPackQuery);
        //acctOtdelen = getFaPackQuery->FieldByName("acct_otdelen")->AsString;
 //   }
//}




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
    }
}

/* ���������� ������ ������ ���������
   �� ���������� ������� */
void __fastcall TMainDataModule::getFullList()
{
    if (_threadDataSet != NULL)
    {
        return;
    }

    _currentFilter = getFullListFilter;

    if (getFullListQuery->ParamByName("acct_otdelen")->AsString != _acctOtdelen->AsString)
    {
        /*if (_beforeOpenDataSet != NULL)
        {
            _beforeOpenDataSet(this);
        }*/

        getFullListQuery->ParamByName("acct_otdelen")->Value = _acctOtdelen->Value;

        _threadDataSet = new TThreadDataSet(false, getFullListQuery, getFullListRam, &OnThreadEvent);

        //-------_threadDataSet = new TThreadDataSet(false, getFullListQuery, getFullListRam, &OnShowDebtorsThreadEnd);

        //openOrRefresh(MainDataModule->getDebtors);
    }
}

/* ���������� ������ ���������
   �� ���������� ������� */
void __fastcall TMainDataModule::getDebtorList()
{
    if (_threadDataSet != NULL)
    {
        return;
    }

    _currentFilter = getDebtorsFilter;
    //TThreadDataSet(false, MainDataModule->getDebtors, &OnShowDebtorsThreadEnd);

    if (getDebtorListProc->ParamByName("p_acct_otdelen")->AsString != _acctOtdelen->AsString)
    {
        if (_beforeOpenDataSet != NULL)
        {
            _beforeOpenDataSet(this);
        }
        //getDebtorListProc->ParamByName("p_acct_otdelen")->Value = _acctOtdelen->Value;
        getDebtorListProc->ParamByName("p_acct_otdelen")->Value = _acctOtdelen->Value;
        //_threadDataSet = new TThreadDataSet(false, getDebtorListProc, getDebtorsRam, &OnThreadEvent);

        _threadDataSet = new TThreadDataSet(false, getDebtorListProc, getDebtorsRam, &OnThreadEvent);

        //openOrRefresh(MainDataModule->getDebtors);
    }
}

/* ���������� ������ �� �����
   �� ���������� ������� */
void __fastcall TMainDataModule::getPostList()
{
    if (_threadDataSet != NULL)
    {
        return;
    }

    _currentFilter  = getPostListFilter;

    if (getPostListProc->ParamByName("p_acct_otdelen")->Value != _acctOtdelen->Value)
    {
        getPostListProc->ParamByName("p_acct_otdelen")->Value = _acctOtdelen->Value;
        _threadDataSet = new TThreadDataSet(false, getPostListProc, getPostListRam, &OnThreadEvent);
    }
}

/* ���������� ������ �� ������ ����������� */
void __fastcall TMainDataModule::getFaCancelStopList()
{
    if (_threadDataSet != NULL)
    {
        return;
    }

    _currentFilter  = getPostListFilter;

    if (getCancelStopListProc->ParamByName("p_acct_otdelen")->Value != _acctOtdelen->Value)
    {
        getCancelStopListProc->ParamByName("p_acct_otdelen")->Value = _acctOtdelen->Value;
        _threadDataSet = new TThreadDataSet(false, getCancelStopListProc, getCancelStopListRam, &OnThreadEvent);
    }
}

/* ������ ������� ���������
   updateOnly = true �� �������� ������ �������� _currentAcctOtdelen
*/
void __fastcall TMainDataModule::setAcctOtdelen(const Variant acctOtdelen, bool updateOnly)
{
    static Variant oldAcctOtdelen = "";
    if (oldAcctOtdelen != acctOtdelen)
    {
        oldAcctOtdelen = acctOtdelen;

        // ������� �������� ������� getOtdelenListQuery � ���������� acctOtdelen
        // ��� ������� �� ��������������� ������
        // � ������ DBGridComboBox ������ �� ������

        if (updateOnly == false)
        {
            /*getDebtorsRam->Close();
            getFullListRam->Close();
            getApprovalListRam->Close();
            getPostListRam->Close();
            getStopListRam->Close(); */

            //getFaPackQuery->Close();    // 2017-05-03

            getFaPackInfProc->Close();
            //getApprovalListQuery->Close(); // 2017-05-03
            //getPackStopListQuery->Close();    // 2017-05-03
            //getFaPackStopQuery->Close();     // 2017-05-03
            //getStopListQuery->Close();  // 2017-05-03
            //Application->ProcessMessages();

            getStopListProc->ParamByName("p_acct_otdelen")->Clear();
            getFaPackNoticesProc->ParamByName("p_fa_pack_id")->Clear();
            getFaPackStopProc->ParamByName("p_fa_pack_id")->Clear();


            // �������� getStopListProc->ParamByName("p_acct_otdelen")->Clear();    // 2017-05-03



            //getFaPackStopQuery->Params->Clear();
            /*getStopListQuery->Params->Clear();
            getApprovalListQuery->Params->Clear();
            getPackStopListQuery->Params->Clear();*/
            //getFaPackInfo->Params->Clear();     // �� �������!   ��� ��� �������� app_path
  

            // ��������������� ������ �����������
            //OraStoredTEST->ParamByName("p_acct_otdelen")->Value = acctOtdelen;
            //OraStoredTEST->ExecProc();

        }
    }
}

void __fastcall TMainDataModule::setFaPack(const Variant faPackId)
{
    /* ������ ��� �������� ������� ���������� �� ������ */
    static Variant oldFaPackId = "";

    // ����� �������� ������� �������� �� ������� ��� ��������� ������� getFaPackInfo
    //if (oldFaPackId )

    getFaPackInfProc->ParamByName("p_fa_pack_id")->Value = faPackId;
    openOrRefresh(getFaPackInfProc);

    setAcctOtdelen(getFaPackInfProc->FieldByName("acct_otdelen")->Value, true);
}


/* ������ ������� ��������� �� faPackId
   updateOnly = true �� �������� ������ �������� _currentAcctOtdelen
*/

/*String __fastcall TMainDataModule::getAcctOtdelenByFaPackId(const String& faPackId)
{
    getFaPackInfo->ParamByName("fa_pack_id")->Value = faPackId;
    openOrRefresh(getFaPackInfo);
    return getFaPackInfo->FieldByName("acct_otdelen")->AsString;
} */


/* ������ ������� �����
*/
void __fastcall TMainDataModule::setFaPackId_Notice(const String& faPackId)
{

// ����� ������� ��� ��� �������� ��� ������������ �������
//  getFaPack ����� ���� ������������� � openFaPack.....
    if (_threadDataSet != NULL)
    {   // ���� ����� ��� �������
        return;
    }

    /*if ( VarIsClear(faPackId) ||
        || (getFaPackInfProc->Active &&  faPackId == getFaPackInfProc->FieldByName("fa_pack_id")->Value))      */

    if ( !getFaPackNoticesFilter->DataSet->Active
        || getFaPackNoticesProc->ParamByName("p_fa_pack_id")->AsString != faPackId)
        //|| getFaPackNoticesProc->ParamByName("p_fa_pack_id")->AsString != getFaPackInfProc->FieldByName("fa_pack_id")->AsString)
    {
        _currentFilter  = getFaPackNoticesFilter;

        /* ������ ��� ������*/
        getFaPackNoticesProc->ParamByName("p_fa_pack_id")->Value = faPackId;

        //openOrRefresh(getFaPackQuery);
        _threadDataSet = new TThreadDataSet(false, getFaPackNoticesProc, getFaPackRam, &OnThreadEvent);


        /* ������ ��� �������� ������� ���������� �� ������ */
        setFaPack(faPackId);
    }

}

/* ������ ������� �����
*/
void __fastcall TMainDataModule::setFaPackId_Stop(const String& faPackId)
{
    if (_threadDataSet != NULL)
    {   // ���� ����� ��� �������
        return;
    }

    //if ( !getFaPackInfProc->Active  faPackId == getFaPackInfProc->FieldByName("fa_pack_id")->Value))
    if ( !getFaPackNoticesFilter->DataSet->Active
        //getFaPackInfProc->FieldByName("fa_pack_id")->Value != faPackId)
        || getFaPackStopProc->ParamByName("p_fa_pack_id")->Value != faPackId)
    {
        _currentFilter  = getPackListStopFilter;

        /* ������ ��� ������*/
        getFaPackStopProc->ParamByName("p_fa_pack_id")->Value = faPackId;
        _threadDataSet = new TThreadDataSet(false, getFaPackStopProc, getFaPackStopRam, &OnThreadEvent);

        /* ������ ��� �������� ������� ���������� �� ������ */
        setFaPack(faPackId);
    }

}

/* ���������� ID �������� �������
*/
Variant __fastcall TMainDataModule::getAcctOtdelen()
{
    return getOtdelenListQuery->FieldByName("acct_otdelen")->Value;
}

/* ���������� ID ������� ������� ����������� */
String __fastcall TMainDataModule::getFaPackId_Notice() const
{
    return getFaPackNoticesProc->ParamByName("p_fa_pack_id")->AsString;
}

/* ���������� ID �������� ������� �� ���������� */
String __fastcall TMainDataModule::getFaPackId_Stop() const
{
    return getFaPackStopProc->ParamByName("p_fa_pack_id")->AsString;
}

/* ������� ��� ���������� � ��������� ������
   ��������� dataset �������� ������ ���������� */
void __fastcall TMainDataModule::BeginProcessing(TDataSetFilter* filter)
{
    filter->LockDataSetPos();      // ���������� ������� � dataset  � ��������� ����������� ���������
    //filter->DisableControls();     // ��������� ����������� ��������� dataset

    // ��������, �����, ������������ ��������� ������
    //MainDataModule->getCheckedFilter->setValue("group", "param", ""); //
    getCheckedFilter->setValue("checked", "param", "1"); //
    getCheckedFilter->DataSet = filter->DataSet;   // ������������ ������ � dataset
    //filter->DataSet->First();
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
    TDataSetFilter* filter = getPackListStopFilter;
    BeginProcessing(filter);
    //ShowMessage(filter->DataSet->RecordCount);

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
        }
        filter->DataSet->Next();

        //String s2 = filter->DataSet->FieldByName("fa_pack_id")->AsString;
        //filter->DataSet->Next();
        //String s3 = filter->DataSet->FieldByName("fa_pack_id")->AsString;
    }

    EndProcessing(filter);

    //getFaPackStopFilter->DataSet->Close();
}


bool __fastcall TMainDataModule::setFaPackStatusIncomplete()
{
    TDataSetFilter* filter = getPackListStopFilter;
    BeginProcessing(filter);

    while ( !filter->DataSet->Eof )
    {
        try
        {
            setFaPackStatusFlgCancelProc->ParamByName("p_fa_pack_id")->Value =  filter->DataSet->FieldByName("fa_pack_id")->AsString;
            setFaPackStatusFlgCancelProc->ExecProc();
        }
        catch(Exception& e)
        {
            MessageBoxStop(e.Message);
        }
        filter->DataSet->Next();
    }

    EndProcessing(filter);
}

bool __fastcall TMainDataModule::setFaPackStatusFrozen()
{
    TDataSetFilter* filter = getPackListStopFilter;
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
        }
        filter->DataSet->Next();
    }

    EndProcessing(filter);
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
//---------------------------------------------------------------------------
void __fastcall TMainDataModule::TestGetRefCursor()
{
    //OraStoredProc1->ParamByName("sqlselect")->AsString = "select * from nasel_ccb_prem";
    //getDebtorListProc->ParamByName("p_acct_otdelen")->AsString = "02-61FL";
    //getDebtorListProc->Open();
}


