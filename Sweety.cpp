#include <vcl.h>
#pragma hdrstop

//#define DEBUG

USEFORM("MainFormUnit.cpp", MainForm);
USEFORM("FieldActivityFormUnit.cpp", FieldActivityForm);
USEFORM("MainDataModuleUnit.cpp", MainDataModule); /* TDataModule: File Type */
USEFORM("GridFrameUnit.cpp", GridFrame); /* TFrame: File Type */
USEFORM("SelectFaPackFormUnit.cpp", SelectFaPackForm);
USEFORM("EditCcFormUnit.cpp", EditCcForm);
USEFORM("FormSpecialModuleUnit.cpp", FormSpecialModule); /* TDataModule: File Type */
USEFORM("DocumentDataModuleUnit.cpp", DocumentDataModule); /* TDataModule: File Type */
USEFORM("..\util\FormLogin\formlogin.cpp", LoginForm);
USEFORM("WaitFormUnit.cpp", WaitForm);
USEFORM("SelectAcctOtdelenFormUnit.cpp", SelectAcctOtdelenForm);
USEFORM("EditSaEndDtFormUnit.cpp", EditSaEndDtForm);

//---------------------------------------------------------------------------
/*

    При создании MainDataModule у пользователя запрашивается Login/Password
    В случае неуспешной попытки входа приложению поступает сигнал на завершение

    Фрагмент кода для анализа и выхода из программы при неуспешной попытке входа:

         if (Application->Terminated)
         {
            return 0;
         }
*/

WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
    try
    {
        Application->Initialize();
        Application->Title = "ARES";
        Application->CreateForm(__classid(TMainDataModule), &MainDataModule);
        if (Application->Terminated)
        {
            Application->Run();
            return 0;
        } 
        Application->CreateForm(__classid(TFormSpecialModule), &FormSpecialModule);
        Application->CreateForm(__classid(TDocumentDataModule), &DocumentDataModule);
        Application->CreateForm(__classid(TFieldActivityForm), &FieldActivityForm);
        Application->CreateForm(__classid(TSelectFaPackForm), &SelectFaPackForm);
        Application->CreateForm(__classid(TSelectAcctOtdelenForm), &SelectAcctOtdelenForm);
        Application->CreateForm(__classid(TEditCcForm), &EditCcForm);
        Application->CreateForm(__classid(TMainForm), &MainForm);
        Application->CreateForm(__classid(TEditSaEndDtForm), &EditSaEndDtForm);
        Application->Run();
    }
    catch (Exception &exception)
    {
         Application->ShowException(&exception);
    }
    return 0;
}
//---------------------------------------------------------------------------

