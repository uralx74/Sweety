//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "EditCcFormUnit.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBGridAlt"
#pragma link "ComboBoxAlt"
#pragma resource "*.dfm"
TEditCcForm *EditCcForm;
//---------------------------------------------------------------------------
__fastcall TEditCcForm::TEditCcForm(TComponent* Owner)
    : TForm(Owner)
{
    //CcOpAreaCdComboBox->AddSource(MainDataModule->getOpAreaRam, "descr", "op_area_cd", true);
    CcOpAreaCdComboBox->AddItem("Неопределено", "", "", false);

    CcOpAreaCdComboBox->AddSource(MainDataModule->getOpAreaProc, "descr", "op_area_cd", true);

}
/**/
void __fastcall TEditCcForm::Button3Click(TObject *Sender)
{
    try
    {
        /**/
        TDateTime ccDttm;
        //TCcStatusFlg::Type ccStatusFlg;
        TCcTypeCd::Type ccTypeCd;

        String descrValue;      // Комментарий

        //String curCcId = MainDataModule->getFaPackQuery->FieldByName("cc_id")->AsString;
        String curFaId = faInfo->FieldByName("fa_id")->AsString;
        String curAcctId = faInfo->FieldByName("acct_id")->AsString;

        ccDttm = CcDttmDateTimePicker->Date;
        //ccStatusFlg = (int)CcStatusFlgComboBox->KeyValue;    // V_INT // OleAuto.h
        ccTypeCd = (int)CcTypeCdComboBox->KeyValue;
        descrValue = DescrEdit->Text;



        String agentId = "";
        String agentDescr = "";
        TAgentTypeCd::Type agentTypeCd = TAgentTypeCd::UNDEFINED;
        if ( ccTypeCd == TCcTypeCd::MANUAL )
        {
            agentId = CcOpAreaCdComboBox->Value;
            agentDescr = CcOpAreaCdComboBox->DisplayValue;
            agentTypeCd = TAgentTypeCd::OP_AREA_CD;
        }



        // Добавляем новый контакт или обновляем старый
        if ( faInfo->FieldByName("cc_id")->IsNull )
        {
            ccId = MainDataModule->addCc(
                faInfo,             // DataSet для оперативного обновления
                ccDttm,             // Дата контакта
                curAcctId,          // Лицевой счет
                descrValue,         // Комментарий
                curFaId,            // Уведомление
                agentTypeCd,        // Тип агента (контролера)
                agentId,            // Агент (контролер)
                agentDescr,         // Агент - описание(контролер)
                ccTypeCd,           // Тип контакта
                TCcSourceTypeCd::FA // Тип источника
            );
        }
        else
        {
            MainDataModule->updateCc(
                faInfo,             // DataSet для оперативного обновления
                faInfo->FieldByName("cc_id")->Value,
                ccDttm,             // Дата контакта
                descrValue,         // Комментарий
                agentTypeCd,        // Тип агента (контролера)
                agentId,            // Агент (контролер)
                agentDescr,         // Агент - описание(контролер)
                ccTypeCd            // Тип контакта
            );
        }
    }
    catch(Exception &e)
    {
        ShowMessage(e.Message);
    }

//    _modified = true;
}

/* Сохраняем значения по умолчанию */
void __fastcall TEditCcForm::SaveDefaultValues()
{
    if (LockCcDttmButton->Down)
    {
        ccDttmDefaultValue = CcDttmDateTimePicker->Date;
    }
    if (LockCcTypeCdButton->Down)
    {
        ccTypeCdDefaultValue = (int)CcTypeCdComboBox->KeyValue;
    }
    if (LockCcStatusFlgButton->Down)
    {
        ccStatusFlgDefaultValue = (int)CcStatusFlgComboBox->KeyValue;
    }
    if (LockDescrButton->Down)
    {
        descrDefaultValue = DescrEdit->Text;
    }

    if (LockCallerButton->Down)
    {
        agentIdDefaultValue = CcOpAreaCdComboBox->Value;
    }

    //callerDefaultValue;
    //descrDefaultValue;
}

/* Восстанавливаем значения на форме */
void __fastcall TEditCcForm::RestoreDefaultValues()
{
    TDataSet *ccInfo = NULL;
    if ( !faInfo->FieldByName("cc_id")->IsNull )    // Если контакт по уведомлению есть
    {
        ccInfo = MainDataModule->getCcInfo( faInfo->FieldByName("cc_id")->Value );      // Получаем информацию по контакту
    }



    // Дата контакта
    if ( LockCcDttmButton->Down /* && ccDttmDefaultValue */ )
    {
        CcDttmDateTimePicker->Date = ccDttmDefaultValue;
    }
    else
    {
        if ( ccInfo == NULL )
        {
            CcDttmDateTimePicker->Date = Now();
        }
        else
        {
            CcDttmDateTimePicker->DateTime = ccInfo->FieldByName("cc_dttm")->Value;
        }
    }


    // Тип контакта
    if ( LockCcTypeCdButton->Down )
    {
        CcTypeCdComboBox->KeyValue = ccTypeCdDefaultValue;
    }
    else
    {
        if ( ccInfo == NULL )
        {
             CcTypeCdComboBox->KeyValue = TCcTypeCd::MANUAL;
        }
        else
        {

             CcTypeCdComboBox->KeyValue = ccInfo->FieldByName("cc_type_cd")->Value;
        }
    }

    // Статус контакта
    if ( LockCcStatusFlgButton->Down )
    {
        CcStatusFlgComboBox->KeyValue = ccStatusFlgDefaultValue;
    }
    else
    {
        if ( ccInfo == NULL )
        {
            CcStatusFlgComboBox->KeyValue = TCcStatusFlg::SUCCESS;
        }
        else
        {
            CcStatusFlgComboBox->KeyValue = ccInfo->FieldByName("cc_status_flg")->Value;
        }
    }

    // Агент
    if ( LockCallerButton->Down )
    {
        //CallerEdit->Text = callerDefaultValue;      // УДАЛИТЬ
        CcOpAreaCdComboBox->Value = agentIdDefaultValue;
    }
    else
    {
        if ( ccInfo == NULL )           // Контакт отсутствует
        {
            //CallerEdit->Text = "";
            try
            {
                CcOpAreaCdComboBox->Value = faInfo->FieldByName("op_area_cd")->AsString;
            }
            catch(...)
            {
                CcOpAreaCdComboBox->Value = "";
            }
        }
        else
        {
            //CallerEdit->Text = ccInfo->FieldByName("caller")->AsString;    // УДАЛИТЬ
            try
            {
                CcOpAreaCdComboBox->Value = ccInfo->FieldByName("agent_id")->AsString;
            }
            catch(...)
            {
                CcOpAreaCdComboBox->Value = "";
            }
        }
    }

    if ( LockDescrButton->Down )
    {
            DescrEdit->Text = descrDefaultValue;
    }
    else
    {
        if ( ccInfo == NULL )
        {
            DescrEdit->Text = "";
        }
        else
        {
            DescrEdit->Text = ccInfo->FieldByName("descr")->AsString;
        }
    }
}

/*
*/
void __fastcall TEditCcForm::ResetDefaultValues()
{
}

/* Главная интерфейсная функция для отображения этого окна
*/
bool TEditCcForm::Execute(TDataSet* ds)
{
    faInfo = ds;
    if (ds->RecordCount == 0)
    {
        return false;
    }
    
    MainDataModule->getOpAreaList();
    CcOpAreaCdComboBox->RefreshItems();     // Обновляем список
    //int ppppp = MainDataModule->getOpAreaProc->RecordCount;


    RestoreDefaultValues();

    AcctIdLabel->Caption = faInfo->FieldByName("acct_id")->Value;
    FioLabel->Caption = faInfo->FieldByName("fio")->Value;
    DeleteCcButton->Enabled = !faInfo->FieldByName("cc_id")->IsNull;

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

    //TDataSet* ds1 = (TDataSet*)MainDataModule->getOpAreaList->;
    
    //CcOpAreaCdComboBox->AddSource(MainDataModule->getOpAreaProc,"descr","op_area_cd", true);
    //CcOpAreaCdComboBox->RefreshItems();
}

/*
*/
void __fastcall TEditCcForm::FormCreate(TObject *Sender)
{
    // Размещение изображений на кнопках
    FormSpecialModule->ButtonImageList->GetBitmap(0, LockCcDttmButton->Glyph);
    FormSpecialModule->ButtonImageList->GetBitmap(0, LockCcTypeCdButton->Glyph);
    FormSpecialModule->ButtonImageList->GetBitmap(0, LockCcStatusFlgButton->Glyph);
    FormSpecialModule->ButtonImageList->GetBitmap(0, LockCallerButton->Glyph);
    FormSpecialModule->ButtonImageList->GetBitmap(0, LockDescrButton->Glyph);
}

/*
*/
void __fastcall TEditCcForm::CloseWindowActionExecute(TObject *Sender)
{
    ModalResult = mrCancel;
}

/* Реакция на кнопку "Удалить" контакт
*/
void __fastcall TEditCcForm::DeleteCcButtonClick(TObject *Sender)
{
    if ( !faInfo->FieldByName("cc_id")->IsNull &&
        MessageBoxQuestion("Данные о контакте будут удалены.\nПродолжить?") == IDYES )
    {
        //
        try
        {
            MainDataModule->deleteCc(faInfo, faInfo->FieldByName("cc_id")->Value);
            ShowMessage("Контакт удален!");
            ModalResult = mrOk;
        }
        catch(Exception &e)
        {
            ShowMessage(e.Message);
        }
    }
}
/* Закрытие формы
*/
void __fastcall TEditCcForm::FormClose(TObject *Sender,
      TCloseAction &Action)
{
    SaveDefaultValues();
}



void __fastcall TEditCcForm::CcTypeCdComboBoxClick(TObject *Sender)
{
    OpAreaCdPanel->Enabled = CcTypeCdComboBox->KeyValue == 10;
    CcOpAreaCdComboBox->Enabled = OpAreaCdPanel->Enabled;
    LockCallerButton->Enabled = OpAreaCdPanel->Enabled;
}
//---------------------------------------------------------------------------



void __fastcall TEditCcForm::FormShow(TObject *Sender)
{
    CcTypeCdComboBoxClick(Sender);
}
//---------------------------------------------------------------------------

