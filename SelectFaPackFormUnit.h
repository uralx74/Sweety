//---------------------------------------------------------------------------

#ifndef SelectFaPackFormUnitH
#define SelectFaPackFormUnitH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "DBGridAlt.h"
#include <DBGrids.hpp>
#include <Grids.hpp>
#include "MainDataModuleUnit.h"
#include "FaTypes.h"
#include "OtdelenComboBoxFrameUnit.h"
#include <DBCtrls.hpp>
#include <ComCtrls.hpp>
#include <ActnList.hpp>
#include <StdActns.hpp>
#include "DBAccess.hpp"
#include "Ora.hpp"
#include <DB.hpp>
#include "ComboBoxAlt.h"

//---------------------------------------------------------------------------
class TSelectFaPackForm : public TForm
{
__published:	// IDE-managed Components
    TDBGridAlt *faListGrid;
    TButton *OkButton;
    TButton *CancelButton;
    TGroupBox *FilterGroupBox;
    TLabel *Label13;
    TButton *FilterResetButton;
    TComboBox *FaPackTypeCdFilterComboBox;
    TLabel *Label1;
    TGroupBox *SearchGroupBox;
    TLabel *Label4;
    TButton *FindButton;
    TEdit *FaIdFindEdit;
    TGroupBox *ParamsGroupBox;
    TLabel *Label5;
    TActionList *ActionList1;
    TButton *Button6;
    TAction *CloseWindowAction;
    TEdit *FaPackIdFilterEdit;
    TLabel *Label2;
    TComboBox *FaPackStatusFlgFilterComboBox;
    TLabel *Label3;
    TEdit *OwnerFilterEdit;
    TEdit *AcctIdFindEdit;
    TLabel *Label6;
    TButton *SearchResetButton;
    TComboBoxAlt *OtdelenComboBoxAlt;
    void __fastcall FormCreate(TObject *Sender);
    void __fastcall faListGridChangeCheck(TObject *Sender);
    void __fastcall FilterComboBoxTextChange(TObject *Sender);
    void __fastcall FilterComboBoxIndexChange(TObject *Sender);
    void __fastcall FilterEditTextChange(TObject *Sender);
    void __fastcall OtdelenComboBoxClick(TObject *Sender);
    void __fastcall CloseWindowActionExecute(TObject *Sender);
    void __fastcall FindButtonClick(TObject *Sender);
    void __fastcall SearchResetButtonClick(TObject *Sender);
    void __fastcall FilterResetButtonClick(TObject *Sender);
public:
    typedef enum {
        TM_UNDEFINED = 0,
        TM_NOTICES,
        TM_STOP,
        TM_OVERDUE
    } TMode;

private:
    TMode _mode;
    String _faPackId;
    TFaPackTypeCd _fpTypeCd;
    TDataSetFilter* _currentFilter; // Текущий фильтр
    void __fastcall FindPackList();     // Функция для поиска реестров
    void __fastcall ResetFindFilter();
    void __fastcall ResetFilter();


public:
    __fastcall TSelectFaPackForm(TComponent* Owner);
    bool __fastcall execute(String acctOtdelen, int mode/*String faPackTypeCd*/);
    FaPack getFaPack();
    String __fastcall getFaPackId();
    TFaPackTypeCd __fastcall getFaPackTypeCd();

};
//---------------------------------------------------------------------------
extern PACKAGE TSelectFaPackForm *SelectFaPackForm;
//---------------------------------------------------------------------------
#endif
