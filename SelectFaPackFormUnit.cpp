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
    // Если нужно присоединить список к ComboBox
    //MainDataModule->otdelenList.assignTo(ComboBox1);
}

/* Выбор строки*/
void __fastcall TSelectFaPackForm::faListGridChangeCheck(TObject *Sender)
{
    if (!_currentFilter->DataSet->FieldByName("fa_pack_id")->IsNull)
    {
        _faPackId = _currentFilter->DataSet->FieldByName("fa_pack_id")->AsString;
        ////_faPack.setFaPackId(MainDataModule->selectFaPackQuery->FieldByName("fa_pack_id")->AsString);
        ////_faPack.setFaPackType(MainDataModule->selectFaPackQuery->FieldByName("fa_pack_type_cd")->AsInteger);
    }
    _currentFilter->DataSet->Close();
    this->ModalResult = mrOk;
}

/* Главная вызываемая функция */
bool __fastcall TSelectFaPackForm::execute(String acctOtdelen, int mode)
{
    OtdelenComboBox->KeyValue = acctOtdelen;
    _mode = mode;

    switch (mode)
    {
    case 0:
    {

        MainDataModule->findFaPackListNotices(OtdelenComboBox->KeyValue);
        faListGrid->DataSource = MainDataModule->findFaPackListNoticesDS;
        _currentFilter = MainDataModule->findFaPackListNoticesFilter;
        break;
    }
    case 1:
    {
        MainDataModule->findFaPackListStop(OtdelenComboBox->KeyValue);
        faListGrid->DataSource = MainDataModule->findFaPackListStopDS;
        _currentFilter = MainDataModule->findFaPackListStopFilter;
        break;
    }
    }

    return this->ShowModal() == mrOk;
}


/* Возвращает pack_id выбранного реестра */
String __fastcall TSelectFaPackForm::getFaPackId()
{
    return _faPackId;
}


/* Изменение значения поля фильтра */
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
/* Универсальный фильтр для TComboBox по ItemIndex */
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
    case 0:
    {
        MainDataModule->findFaPackListNotices(OtdelenComboBox->KeyValue/*, _mode*/);
        break;
    }
    case 1:
    {
        MainDataModule->findFaPackListStop(OtdelenComboBox->KeyValue/*, _mode*/);
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

/* Возвращает тип выбранного реестра */
/*FaTypes::PackTypeId __fastcall TSelectFaPackForm::getFaPackTypeId()
{
    return _faPack.getFaPackTypeId();
}*/
/**/
/*void  __fastcall TSelectFaPackForm::setCurOtdelen(const String& otdelen)
{
    //OtdelenComboBox2->KeyValue = otdelen;
}*/
