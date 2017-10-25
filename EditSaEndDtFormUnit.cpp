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

/* ������� ������������ ������� ��� ����������� ����� ����
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
        //ShowMessage("��");
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

        // ��������� ���� �� ��� ������ ������, ���� ���� �� ������ ��������������
        if ( !_ds->FieldByName("CANCEL_FA_PACK_ID")->IsNull )
        {
            if ( MessageBoxQuestion("�� ������� �������� ������ ��� ��������. ����������?")  != IDYES )
            {
                return;
            }

        }

        // ��������� ����� ������� ��� ��������� ������
        if ( _ds->FieldByName("sa_end_dt")->IsNull )
        {
            MainDataModule->setFaSaEndDt(
                _ds,
                _ds->FieldByName("fa_id")->AsString,
                saEndDt      // ���� ��������� ��� (���� ����������)
            );
            MessageBoxInf("���� ���������� ���������!");
        }
    }
    catch(Exception &e)
    {
        ShowMessage(e.Message);
    }



}
//---------------------------------------------------------------------------


