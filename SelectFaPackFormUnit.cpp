//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "SelectFaPackFormUnit.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBGridAlt"
#pragma link "OtdelenComboBoxFrameUnit"
#pragma link "DBAccess"
#pragma link "Ora"
#pragma link "ComboBoxAlt"
#pragma resource "*.dfm"
TSelectFaPackForm *SelectFaPackForm;
//---------------------------------------------------------------------------
__fastcall TSelectFaPackForm::TSelectFaPackForm(TComponent* Owner)
    : TForm(Owner)
{
}

//---------------------------------------------------------------------------
void __fastcall TSelectFaPackForm::FormCreate(TObject *Sender)
{
    // ���� ����� ������������ ������ � ComboBox
    //MainDataModule->otdelenList.assignTo(ComboBox1);
    OtdelenComboBoxAlt->AddSource(MainDataModule->getOtdelenListProc, "DESCR", "ACCT_OTDELEN", true);
    //OtdelenComboBoxAlt->ItemIndex = 0;
}

/* ����� ������*/
void __fastcall TSelectFaPackForm::faListGridChangeCheck(TObject *Sender)
{
    if (!_currentFilter->DataSet->FieldByName("fa_pack_id")->IsNull)
    {
        _faPackId = _currentFilter->DataSet->FieldByName("fa_pack_id")->AsString;
        _fpTypeCd = _currentFilter->DataSet->FieldByName("fa_pack_type_cd")->AsInteger;
        ////_faPack.setFaPackId(MainDataModule->selectFaPackQuery->FieldByName("fa_pack_id")->AsString);
        ////_faPack.setFaPackType(MainDataModule->selectFaPackQuery->FieldByName("fa_pack_type_cd")->AsInteger);
    }
    _currentFilter->DataSet->Close();
    this->ModalResult = mrOk;
}

/* ������� ���������� ������� */
bool __fastcall TSelectFaPackForm::execute(String acctOtdelen, int mode)
{
    if (mode == TM_UNDEFINED)
    {
        this->ModalResult = mrCancel;
        return false;
    }
    _mode = mode;

    OtdelenComboBoxAlt->Value = acctOtdelen;


    FindPackList(); // �����

    ResetFilter();
    ResetFindFilter();
    
    return this->ShowModal() == mrOk;
}

/* �������� ������� ��� ������ */
void __fastcall TSelectFaPackForm::FindPackList()
{
    switch (_mode)
    {
    case TM_NOTICES:
    {
        MainDataModule->findFaPackListNotices(OtdelenComboBoxAlt->Value, FaIdFindEdit->Text, AcctIdFindEdit->Text);
        faListGrid->DataSource = MainDataModule->findFaPackListNoticesDS;
        _currentFilter = MainDataModule->findFaPackListNoticesFilter;
        break;
    }
    case TM_STOP:
    {
        MainDataModule->findFaPackListStop(OtdelenComboBoxAlt->Value, FaIdFindEdit->Text, AcctIdFindEdit->Text);
        faListGrid->DataSource = MainDataModule->findFaPackListStopDS;
        _currentFilter = MainDataModule->findFpStopListFilter;
        break;
    }
    case TM_OVERDUE:
    {
        MainDataModule->findFpOverdueList(OtdelenComboBoxAlt->Value, FaIdFindEdit->Text, AcctIdFindEdit->Text);
        faListGrid->DataSource = MainDataModule->findFpOverdueListDataSource;
        _currentFilter = MainDataModule->findFpOverdueListFilter;
        break;
    }
    }
}


/* ���������� pack_id ���������� ������� */
String __fastcall TSelectFaPackForm::getFaPackId()
{
    return _faPackId;
}

/* ���������� pack_id ���������� ������� */
TFaPackTypeCd __fastcall TSelectFaPackForm::getFaPackTypeCd()
{
    return _fpTypeCd;
}



/* ��������� �������� ���� ������� */
void __fastcall TSelectFaPackForm::FilterComboBoxTextChange(TObject *Sender)
{
    TComboBox* comboBox = static_cast<TComboBox*>(Sender);
    MainDataModule->setFilterParamValue(_currentFilter, comboBox->Name, "param", comboBox->Text);
}

void __fastcall TSelectFaPackForm::FilterEditTextChange(TObject *Sender)
{
    TEdit* editBox = static_cast<TEdit*>(Sender);
    MainDataModule->setFilterParamValue(_currentFilter, editBox->Name, "param", editBox->Text);
}
/* ������������� ������ ��� TComboBox �� ItemIndex */
void __fastcall TSelectFaPackForm::FilterComboBoxIndexChange(
      TObject *Sender)
{
    TComboBox* comboBox = static_cast<TComboBox*>(Sender);
    MainDataModule->setFilterParamValue(_currentFilter, comboBox->Name, "param", IntToStr(comboBox->ItemIndex)); 
}


/**/
void __fastcall TSelectFaPackForm::OtdelenComboBoxClick(TObject *Sender)
{
    switch (_mode)
    {
    case TM_NOTICES:
    {
        MainDataModule->findFaPackListNotices(OtdelenComboBoxAlt->Value/*, _mode*/);
        break;
    }
    case TM_STOP:
    {
        MainDataModule->findFaPackListStop(OtdelenComboBoxAlt->Value/*, _mode*/);
        break;
    }
    case TM_OVERDUE:
    {
        MainDataModule->findFpOverdueList(OtdelenComboBoxAlt->Value/*, _mode*/);
        break;
    }
    }
}

/**/
void __fastcall TSelectFaPackForm::CloseWindowActionExecute(TObject *Sender)
{
    ModalResult = mrCancel;
}
//---------------------------------------------------------------------------

/* ���������� ��� ���������� ������� */
/*FaTypes::PackTypeId __fastcall TSelectFaPackForm::getFaPackTypeId()
{
    return _faPack.getFaPackTypeId();
}*/
/**/
/*void  __fastcall TSelectFaPackForm::setCurOtdelen(const String& otdelen)
{
    //OtdelenComboBox2->KeyValue = otdelen;
}*/
void __fastcall TSelectFaPackForm::FindButtonClick(TObject *Sender)
{
    FindPackList();
    //MainDataModule->findFaPackListNoticesProc->ParamByName("p_acct_otdelen")->Value = acctOtdelen;
    //MainDataModule->findFaPackListNotices(OtdelenComboBox->KeyValue, FaIdFindEdit->Text, AcctIdFindEdit->Text);

    /*MainDataModule->findFaPackListNoticesProc->ParamByName("p_fa_id")->Value = Edit1->Text;
    MainDataModule->findFaPackListNoticesProc->ParamByName("p_acct_id")->Value = Edit2->Text;
    MainDataModule->findFaPackListNoticesProc->Open();
    MainDataModule->CopyDataSet(MainDataModule->findFaPackListNoticesProc, MainDataModule->findFaPackListNoticesFilter->DataSet);
    MainDataModule->findFaPackListNoticesProc->Close(); */
    //
    //MainDataModule->
}

/**/
void __fastcall TSelectFaPackForm::SearchResetButtonClick(TObject *Sender)
{
    ResetFindFilter();
    FindPackList();
}

/**/
void __fastcall TSelectFaPackForm::ResetFindFilter()
{
    FaIdFindEdit->Text = "";
    AcctIdFindEdit->Text = "";
}

/* ������� �������� - ������*/
void __fastcall TSelectFaPackForm::FilterResetButtonClick(TObject *Sender)
{
    ResetFilter();
}

/* ������� �������� */
void __fastcall TSelectFaPackForm::ResetFilter()
{
    _currentFilter->clearAllValues();
    FaPackIdFilterEdit->Text = _currentFilter->getValue(FaPackIdFilterEdit->Name, "param");
    OwnerFilterEdit->Text = _currentFilter->getValue(OwnerFilterEdit->Name, "param");
    FaPackStatusFlgFilterComboBox->ItemIndex = StrToInt( _currentFilter->getValue(FaPackStatusFlgFilterComboBox->Name, "param") );
    FaPackTypeCdFilterComboBox->ItemIndex = StrToInt( _currentFilter->getValue(FaPackTypeCdFilterComboBox->Name, "param") );


    //FaPackIdFilterEdit->Text = "";
    //FaPackTypeCdFilterComboBox->ItemIndex = 0;
    //FaPackStatusFlgFilterComboBox->ItemIndex = 0;
    //OwnerFilterEdit->Text = "";
}
//---------------------------------------------------------------------------

