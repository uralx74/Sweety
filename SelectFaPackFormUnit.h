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

//---------------------------------------------------------------------------
class TSelectFaPackForm : public TForm
{
__published:	// IDE-managed Components
    TDBGridAlt *faListGrid;
    TButton *Button1;
    TButton *Button2;
    TGroupBox *GroupBox1;
    TLabel *Label13;
    TButton *Button3;
    TComboBox *FaPackTypeCdFilterComboBox;
    TLabel *Label1;
    TGroupBox *GroupBox2;
    TLabel *Label4;
    TButton *Button4;
    TEdit *FaIdFindEdit;
    TGroupBox *GroupBox3;
    TLabel *Label5;
    TDBLookupComboBox *OtdelenComboBox;
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
    TButton *Button5;
    void __fastcall FormCreate(TObject *Sender);
    void __fastcall faListGridChangeCheck(TObject *Sender);
    void __fastcall FilterComboBoxTextChange(TObject *Sender);
    void __fastcall FilterComboBoxIndexChange(TObject *Sender);
    void __fastcall FilterEditTextChange(TObject *Sender);
    void __fastcall OtdelenComboBoxClick(TObject *Sender);
    void __fastcall CloseWindowActionExecute(TObject *Sender);
    void __fastcall Button4Click(TObject *Sender);
    void __fastcall Button5Click(TObject *Sender);
    void __fastcall Button3Click(TObject *Sender);
public:
    typedef enum {TM_NOTICES, TM_STOP} TMode;

private:
    TMode _mode;
    String _faPackId;
    TFaPackTypeCd _fpTypeCd;
    TDataSetFilter* _currentFilter; // ������� ������
    void __fastcall FindPackList();     // ������� ��� ������ ��������
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
