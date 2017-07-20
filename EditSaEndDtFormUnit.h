//---------------------------------------------------------------------------

#ifndef EditSaEndDtFormUnitH
#define EditSaEndDtFormUnitH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <DBCtrls.hpp>
#include "MainDataModuleUnit.h"
#include "messages.h"
//---------------------------------------------------------------------------
class TEditSaEndDtForm : public TForm
{
__published:	// IDE-managed Components
    TGroupBox *GroupBox1;
    TLabel *Label1;
    TLabel *AcctIdLabel;
    TLabel *Label3;
    TLabel *FioLabel;
    TGroupBox *GroupBox2;
    TLabel *Label24;
    TSpeedButton *LockCcDttmButton;
    TDateTimePicker *SaEndDtDataTimeicker;
    TButton *Button2;
    TButton *Button3;
    void __fastcall Button3Click(TObject *Sender);
private:	// User declarations
    TDataSet* _ds;

public:		// User declarations
    __fastcall TEditSaEndDtForm(TComponent* Owner);
    bool Execute(TDataSet* ds);

};
//---------------------------------------------------------------------------
extern PACKAGE TEditSaEndDtForm *EditSaEndDtForm;
//---------------------------------------------------------------------------
#endif
