//---------------------------------------------------------------------------

#ifndef MainFormH
#define MainFormH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ActnList.hpp>
#include <Menus.hpp>
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
    TMainMenu *MainMenu1;
    TMenuItem *s1;
    TMenuItem *N1;
    TActionList *ActionList1;
    TAction *ActionFieldActivity;
    void __fastcall ActionFieldActivityExecute(TObject *Sender);
private:	// User declarations
public:		// User declarations
    __fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
