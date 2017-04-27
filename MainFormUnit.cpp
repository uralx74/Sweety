//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "MainFormUnit.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "GridFrame"
#pragma link "GridFrameUnit"
#pragma link "DBGridAlt"
#pragma resource "*.dfm"
TMainForm *MainForm;
//---------------------------------------------------------------------------
__fastcall TMainForm::TMainForm(TComponent* Owner)
    : TForm(Owner)
{
}

//---------------------------------------------------------------------------
//
void __fastcall TMainForm::ActionFieldActivityExecute(TObject *Sender)
{
//
//
    FieldActivityForm->ShowModal();
}

//---------------------------------------------------------------------------
//
void __fastcall TMainForm::FormShow(TObject *Sender)
{
    FieldActivityForm->ShowModal();
    Close();    
}
//---------------------------------------------------------------------------

