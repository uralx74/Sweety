//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "EditCcFormUnit.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBGridAlt"
#pragma resource "*.dfm"
TEditCcForm *EditCcForm;
//---------------------------------------------------------------------------
__fastcall TEditCcForm::TEditCcForm(TComponent* Owner)
    : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TEditCcForm::Button3Click(TObject *Sender)
{
    try
    {
        //String curCcId = MainDataModule->getFaPackQuery->FieldByName("cc_id")->AsString;
        String curFaId = _ds->FieldByName("fa_id")->AsString;
        String curAcctId = _ds->FieldByName("acct_id")->AsString;
        ccDttm = CcDttmDateTimePicker->Date;
        ccStatusFlg = (int)CcStatusFlgComboBox->KeyValue;    // V_INT // OleAuto.h
        ccTypeCd = (int)CcTypeCdComboBox->KeyValue;
        descrValue = DescrEdit->Text;
        callerValue = CallerEdit->Text;

        //TCcTypeCd::Type ccTypeCd;
        //TCcStatusFlg::Type ccStatusFlg;

        // Добавляем новый контакт или обновляем старый
        if ( _ds->FieldByName("cc_id")->IsNull )
        {
            ccId = MainDataModule->addCc(
                _ds,
                ccDttm,      // дата контакта
                curAcctId,       // лицевой
                descrValue,          // описание
                curFaId,                 //
                callerValue,      // вызывающий
                ccTypeCd,          // тип контакта
                ccStatusFlg,    // статус
                TCcSourceTypeCd::FA // тип источника
            );
        }
        else
        {
            MainDataModule->updateCc(
                _ds,
                _ds->FieldByName("cc_id")->Value,
                ccDttm,      // дата контакта
                descrValue,          // описание
                callerValue,      // вызывающий
            ccTypeCd,          // тип контакта
                ccStatusFlg    // статус
            );
        }
    }
    catch(Exception &e)
    {
        ShowMessage(e.Message);
    }

    SaveDefaultValues();

//    _modified = true;
}

/* Сохраняем значения по умолчанию */
void __fastcall TEditCcForm::SaveDefaultValues()
{
    if (LockCcDttmButton->Down)
    {
        ccDttmDefaultValue = ccDttm;
    }
    if (LockCcTypeCdButton->Down)
    {
        ccTypeCdDefaultValue = ccTypeCd;
    }
    if (LockCcStatusFlgButton->Down)
    {
        ccStatusFlgDefaultValue = ccStatusFlg;
    }
    if (LockDescrButton->Down)
    {
        descrDefaultValue = descrValue;
    }

    //callerDefaultValue;
    //descrDefaultValue;
}

/* Восстанавливаем значения на форме */
void __fastcall TEditCcForm::RestoreDefaultValues()
{
    TFields *fields;
    if ( !_ds->FieldByName("cc_id")->IsNull )
    {
        fields = MainDataModule->getCcInfo( _ds->FieldByName("cc_id")->Value );
    }

    //
    if ( LockCcDttmButton->Down )
    {
            CcDttmDateTimePicker->Date = ccDttmDefaultValue;
    }
    else
    {
        if ( _ds->FieldByName("cc_id")->IsNull )
        {
            CcDttmDateTimePicker->Date = Now();
        }
        else
        {
            CcDttmDateTimePicker->DateTime = fields->FieldByName("cc_dttm")->Value;
        }
    }


    if ( LockCcTypeCdButton->Down )
    {
        CcTypeCdComboBox->KeyValue = ccTypeCd;
    }
    else
    {
        if ( _ds->FieldByName("cc_id")->IsNull )
        {
             CcTypeCdComboBox->KeyValue = TCcTypeCd::MANUAL;
        }
        else
        {

             CcTypeCdComboBox->KeyValue = fields->FieldByName("cc_type_cd")->Value;
        }
    }

    if ( LockCcStatusFlgButton->Down )
    {
        CcStatusFlgComboBox->KeyValue = ccStatusFlgDefaultValue;
    }
    else
    {
        if ( _ds->FieldByName("cc_id")->IsNull )
        {
            CcStatusFlgComboBox->KeyValue = TCcStatusFlg::SUCCESS;
        }
        else
        {
            CcStatusFlgComboBox->KeyValue = fields->FieldByName("cc_status_flg")->Value;
        }
    }

    if ( LockCallerButton->Down )
    {
        CallerEdit->Text = callerDefaultValue;
    }
    else
    {
        if ( _ds->FieldByName("cc_id")->IsNull )
        {
            CallerEdit->Text = "";
        }
        else
        {
            CallerEdit->Text = fields->FieldByName("caller")->AsString;
        }
    }

    if ( LockDescrButton->Down )
    {
            DescrEdit->Text = descrDefaultValue;
    }
    else
    {
        if ( _ds->FieldByName("cc_id")->IsNull )
        {
            DescrEdit->Text = "";
        }
        else
        {
            DescrEdit->Text = fields->FieldByName("descr")->AsString;
        }
    }
}

void __fastcall TEditCcForm::ResetDefaultValues()
{
}

/**/
bool TEditCcForm::Execute(TDataSet* ds)
{
    //ccDttmDefaultValue = Now();
    //CcDttmDateTimePicker = Now();

    _ds = ds;
    RestoreDefaultValues();
    if (ds->RecordCount == 0)
    {
        return false;
    }

    AcctIdLabel->Caption = ds->FieldByName("acct_id")->Value;
    FioLabel->Caption = ds->FieldByName("fio")->Value;
    DeleteCcButton->Enabled = !_ds->FieldByName("cc_id")->IsNull;

    /*if (MainDataModule->getFaPackFilter->DataSet == ds)
    {
        ShowMessage("Eq");
    }  */

    switch (ShowModal())
    {
    case mrOk:
    {
        //ShowMessage("Ок");
        return true;
    }
    case mrCancel:
    {
        //ShowMessage("Canceled");
        return false;
    }
    }
}

//---------------------------------------------------------------------------

void __fastcall TEditCcForm::FormCreate(TObject *Sender)
{
    FormSpecialModule->ButtonImageList->GetBitmap(0, LockCcDttmButton->Glyph);
    FormSpecialModule->ButtonImageList->GetBitmap(0, LockCcTypeCdButton->Glyph);
    FormSpecialModule->ButtonImageList->GetBitmap(0, LockCcStatusFlgButton->Glyph);
    FormSpecialModule->ButtonImageList->GetBitmap(0, LockCallerButton->Glyph);
    FormSpecialModule->ButtonImageList->GetBitmap(0, LockDescrButton->Glyph);

}
//---------------------------------------------------------------------------

void __fastcall TEditCcForm::CloseWindowActionExecute(TObject *Sender)
{
    ModalResult = mrCancel;
  
}
//---------------------------------------------------------------------------


void __fastcall TEditCcForm::DeleteCcButtonClick(TObject *Sender)
{
    if ( !_ds->FieldByName("cc_id")->IsNull &&
        MessageBoxQuestion("Данные о контакте будут удалены.\nПродолжить?") == IDYES )
    {
        //
        try
        {
            MainDataModule->deleteCc(_ds, _ds->FieldByName("cc_id")->Value);
        }
        catch(Exception &e)
        {
            ShowMessage(e.Message);
        }
        ModalResult = mrOk;
    }
}
//---------------------------------------------------------------------------

