//---------------------------------------------------------------------------
/*
  Модуль для хранения визуальных элементов
*/
#include <vcl.h>
#pragma hdrstop

#include "FormSpecialModuleUnit.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TFormSpecialModule *FormSpecialModule;
//---------------------------------------------------------------------------
__fastcall TFormSpecialModule::TFormSpecialModule(TComponent* Owner)
    : TDataModule(Owner)
{
}
//---------------------------------------------------------------------------
