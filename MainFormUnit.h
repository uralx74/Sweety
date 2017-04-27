//---------------------------------------------------------------------------

#ifndef MainFormUnitH
#define MainFormUnitH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ActnList.hpp>
#include <Menus.hpp>

//
#include "FieldActivityFormUnit.h"
#include "MainDataModuleUnit.h"
#include <DBGrids.hpp>
#include <Grids.hpp>
#include "GridFrame.h"
#include "GridFrameUnit.h"
#include "DBGridAlt.h"

//---------------------------------------------------------------------------
class TMainForm : public TForm
{
__published:	// IDE-managed Components
    TMainMenu *MainMenu1;
    TMenuItem *s1;
    TMenuItem *N1;
    TActionList *ActionList1;
    TAction *ActionFieldActivity;
    void __fastcall ActionFieldActivityExecute(TObject *Sender);
    void __fastcall FormShow(TObject *Sender);
private:	// User declarations
public:		// User declarations
    __fastcall TMainForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TMainForm *MainForm;
//---------------------------------------------------------------------------
#endif
