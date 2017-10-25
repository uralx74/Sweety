//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "EditSaEndDtFormUnit.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TEditSaEndDtForm *EditSaEndDtForm;
//---------------------------------------------------------------------------
__fastcall TEditSaEndDtForm::TEditSaEndDtForm(TComponent* Owner)
    : TForm(Owner)
{
}
//---------------------------------------------------------------------------

/* Главная интерфейсная функция для отображения этого окна
*/
bool TEditSaEndDtForm::Execute(TDataSet* ds)
{
    _ds = ds;
    if (_ds->RecordCount == 0 || !_ds->FieldByName("sa_e_dt")->IsNull)
    {
        return false;
    }

    AcctIdLabel->Caption = ds->FieldByName("acct_id")->Value;
    FioLabel->Caption = ds->FieldByName("fio")->Value;

    SaEndDtDataTimeicker->Date = Now();

    ShowModal();

/*    
    RestoreDefaultValues();
    if (ds->RecordCount == 0)
    {
        return false;
    }

    AcctIdLabel->Caption = ds->FieldByName("acct_id")->Value;
    FioLabel->Caption = ds->FieldByName("fio")->Value;
    DeleteCcButton->Enabled = !_ds->FieldByName("cc_id")->IsNull;

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
    }*/
}

/**/
void __fastcall TEditSaEndDtForm::Button3Click(TObject *Sender)
{

    try
    {
        TDateTime saEndDt = SaEndDtDataTimeicker->Date;

        // Проверяем была ли уже отмена заявки, если была то выдаем предупреждение
        if ( !_ds->FieldByName("CANCEL_FA_PACK_ID")->IsNull )
        {
            if ( MessageBoxQuestion("По данному абоненту заявка уже отменена. Продолжить?")  != IDYES )
            {
                return;
            }

        }

        // Добавляем новый контакт или обновляем старый
        if ( _ds->FieldByName("sa_end_dt")->IsNull )
        {
            MainDataModule->setFaSaEndDt(
                _ds,
                _ds->FieldByName("fa_id")->AsString,
                saEndDt      // дата остановки РДО (дата отключения)
            );
            MessageBoxInf("Дата отключение добавлена!");
        }
    }
    catch(Exception &e)
    {
        ShowMessage(e.Message);
    }



}
//---------------------------------------------------------------------------


