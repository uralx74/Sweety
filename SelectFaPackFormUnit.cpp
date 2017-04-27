//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "SelectFaPackFormUnit.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBGridAlt"
#pragma link "OtdelenComboBoxFrameUnit"
#pragma resource "*.dfm"
TSelectFaPackForm *SelectFaPackForm;
//---------------------------------------------------------------------------
__fastcall TSelectFaPackForm::TSelectFaPackForm(TComponent* Owner)
    : TForm(Owner)
{
    //faListGrid->Filtered = true;
    //faListGrid->assignFilter(&_filter);
    //_filter.add(ComboBox9->Name, "acct_id like '%:param%'");

}
//---------------------------------------------------------------------------
void __fastcall TSelectFaPackForm::FormCreate(TObject *Sender)
{

    /*Создание фильтра*/
    MainDataModule->selectFaPackFilter->DisableControls();
    //MainDataModule->selectFaPackFilter->add(OtdelenComboBox->Name, "otdelen like '%:param%'");
    MainDataModule->selectFaPackFilter->add(FaPackTypeCdComboBox->Name, "fa_pack_type_cd like '%:param%'");
    MainDataModule->selectFaPackFilter->add(FaPackIdComboBox->Name, "fa_pack_id like '%:param%'");
    MainDataModule->selectFaPackFilter->EnableControls();



    //
    // Если нужно присоединить список к ComboBox
    //MainDataModule->otdelenList.assignTo(ComboBox1);


    /*MainDataModule->selectFaPackFilter->add(CityComboBox->Name, "city like '%:param%'");
    MainDataModule->selectFaPackFilter->add(FioComboBox->Name, "fio like '%:param%'");
    MainDataModule->selectFaPackFilter->add(PackIdFilterComboBox->Name, "fa_pack_id like '%:param%'");
    MainDataModule->selectFaPackFilter->add(ServiceCompanyFilterComboBox->Name, "service_org like '%:param%'");
    MainDataModule->selectFaPackFilter->add(SaldoFilterEdit->Name, "saldo_uch > :param");

    //_filter.add("cc_dttm", "cc_dttm >= ':begin_cc_dttm' and cc_dttm <= ':end_cc_dttm'");
    TDataSetFilterItem* filterItem = MainDataModule->selectFaPackFilter->add("cc_dttm", "((cc_dttm >= ':begin_cc_dttm' and cc_dttm <= ':end_cc_dttm') :or_cc_dttm_is_null)");
    filterItem->addParameter(":begin_cc_dttm");
    filterItem->addParameter(":end_cc_dttm");
    filterItem->addParameter(":or_cc_dttm_is_null");

    // Фильтры для пометок
    MainDataModule->selectFaPackFilter->add("cc_dttm_is", "cc_dttm is :param");
    MainDataModule->selectFaPackFilter->add("cc_dttm_more", "(cc_dttm < ':param' or cc_dttm is null)");
    */


}

/* Выбор строки*/
void __fastcall TSelectFaPackForm::faListGridChangeCheck(TObject *Sender)
{
    if (!MainDataModule->selectFaPackQuery->FieldByName("fa_pack_id")->IsNull)
    {
        _faPackId = MainDataModule->selectFaPackQuery->FieldByName("fa_pack_id")->AsString;
        ////_faPack.setFaPackId(MainDataModule->selectFaPackQuery->FieldByName("fa_pack_id")->AsString);
        ////_faPack.setFaPackType(MainDataModule->selectFaPackQuery->FieldByName("fa_pack_type_cd")->AsInteger);
    }
    this->ModalResult = mrOk;
}

/* Главная вызываемая функция */
bool __fastcall TSelectFaPackForm::execute(String acctOtdelen, int mode)
{
    //OtdelenComboBox2->KeyValue = MainDataModule->getAcctOtdelen();
    OtdelenComboBox->KeyValue = acctOtdelen;
    _mode = mode;
    MainDataModule->getFaPackList(OtdelenComboBox->KeyValue, _mode /*faPackTypeCd */);

    //_faPack.clear();
    return this->ShowModal() == mrOk;
}

/**/
/*void  __fastcall TSelectFaPackForm::setCurOtdelen(const String& otdelen)
{
    //OtdelenComboBox2->KeyValue = otdelen;
}*/

/* Возвращает pack_id выбранного реестра */
String __fastcall TSelectFaPackForm::getFaPackId()
{
    return _faPackId;
}

/* Возвращает тип выбранного реестра */
/*FaTypes::PackTypeId __fastcall TSelectFaPackForm::getFaPackTypeId()
{
    return _faPack.getFaPackTypeId();
}*/

/* Изменение значения поля фильтра */
void __fastcall TSelectFaPackForm::FilterComboBoxChange(TObject *Sender)
{
    TComboBox* comboBox = static_cast<TComboBox*>(Sender);
    MainDataModule->setFilterParamValue(MainDataModule->selectFaPackFilter, comboBox->Name, "param", comboBox->Text);
}

/**/
void __fastcall TSelectFaPackForm::OtdelenComboBoxClick(TObject *Sender)
{
    MainDataModule->getFaPackList(OtdelenComboBox->KeyValue, _mode);
    //
    //MainDataModule->selectFaPackQuery->ParamByName("acct_otdelen")->Value = OtdelenComboBox2->KeyValue;
    //MainDataModule->openOrRefresh(MainDataModule->selectFaPackQuery);
}

/**/
void __fastcall TSelectFaPackForm::CloseWindowActionExecute(TObject *Sender)
{
    ModalResult = mrCancel;
}
//---------------------------------------------------------------------------

