//---------------------------------------------------------------------------

#ifndef FieldActivityFormUnitH
#define FieldActivityFormUnitH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "..\AltCtrl\DBGridAlt.h"
#include <DBGrids.hpp>
#include <ExtCtrls.hpp>
#include <Grids.hpp>
#include "MainDataModuleUnit.h"
#include "NoticesDataModuleUnit.h"
#include "StopDataModuleUnit.h"
#include "DocumentDataModuleUnit.h"
#include "SelectFaPackFormUnit.h"
#include <Buttons.hpp>
#include <jpeg.hpp>
#include "OtdelenComboBoxFrameUnit.h"
#include "..\util\hack_ctrl.h"
#include "..\util\odacutils.h"
#include <ComCtrls.hpp>
#include <Menus.hpp>
#include "..\util\ColorList.h"
#include "EditAlt.h"
#include <DBCtrls.hpp>
#include "MemDS.hpp"
#include "VirtualTable.hpp"
#include <DB.hpp>
#include "EditCcFormUnit.h"
#include "..\util\Messages.h"
#include "DataSetFilter.h"
#include <ActnList.hpp>
#include "formlogin.h"
#include <ActnMan.hpp>
#include "ComboBoxAlt.h"
#include <set>
#include <algorithm>
#include "WaitFormUnit.h"
#include "EditSaEndDtFormUnit.h"
#include "appver.h"

enum PackMode {
    PACK_MODE_UNDEFINED = 0,
    PACK_GENERAL,
    PACK_MANUAL,
    PACK_POST,
    PACK_STOP,
    PACK_MANUAL_POST,
    PACK_APPROVE_LIST
};



typedef enum  {
    MODE_UNDEFINED = 0,
    MODE_NOTICES,
    MODE_STOP,
    MODE_OVERDUE
} TMode;

typedef enum {
    SHEET_TYPE_UNDEFINED = 0,
    SHEET_TYPE_MAIN_NOTICES,        // ������� ������� (� ����. ����� ��� ����� �� ��� ������)
    //SHEET_TYPE_MAIN_STOP,           // SHEET_TYPE_MAIN_NOTICES

    SHEET_TYPE_FULL_LIST,           // ������ ������ ���������
    SHEET_TYPE_PRE_NOTICES_LIST,    // ��������������� ������ �� �����������
    SHEET_TYPE_PRE_POST_LIST,       // ��������������� ������ ����������� �� �����
    SHEET_TYPE_FP_NOTICES_CONTENT,  // ���������� ������� �����������
    SHEET_TYPE_APPROVE_LIST,        // ������ �� �����������

    SHEET_TYPE_PRE_STOP_LIST,       // ��������������� ������ �� ���������

    SHEET_TYPE_FP_STOP_LIST,        // ������ �������� �� ����������
    SHEET_TYPE_FP_CANCEL_LIST,      // ������ �������� �� ������ ���������
    SHEET_TYPE_FP_RECONNECT_LIST,   // ������ �������� �� �������������

    SHEET_TYPE_FP_STOP_CONTENT,     // ���������� ������� �� ���������
    SHEET_TYPE_FP_CANCEL_CONTENT,   // ���������� ������� �� ������ ���������
    SHEET_TYPE_FP_RECONNECT_CONTENT, // ���������� ������� �� �������������

    SHEET_TYPE_PRE_OVERDUE_LIST,    // ������ ������������� ������
    SHEET_TYPE_FP_OVERDUE_LIST,     // ������ �� ��������� ����������
    SHEET_TYPE_FP_OVERDUE_CONTENT   // ���������� ������� �� ���������� ��������

} TSheetType;


/* ����� ��� �������� ���������� ������� ��� TTabSheet */
class TSheetEx
{
private:
    std::vector<TAction*> _actions; // ������ ��������� ��������

public:
    TSheetEx(TTabSheet* _sheet, bool _accessible);
    TTabSheet* sheet;   // ��������� �� �������
    bool accessible;    // ������� ����������� ������������

    //void addAction(TAction* action);
    // std::vector<Action*> filters; // ������ ��������� ��������
    void setColor(TColor color);
    TColor _color;
    TColor getColor();

    /* actions */
    void assignSheet(TTabSheet* sheet, bool accessible = false);
    void addAction(TAction* action, bool accessible = false);
    void hideActions();
    void showActions();

    TSheetType packModeId;    // ������� ������, ������� ����� ��� ���!!!!!!!!!! �������� ��!
};

void TSheetEx::setColor(TColor color)
{
    _color = color;
}

TColor TSheetEx::getColor()
{
    return _color;
}

/* ����������� */
TSheetEx::TSheetEx(TTabSheet* _sheet, bool _accessible):
    sheet(_sheet), accessible(_accessible)
{
}

/**/
void TSheetEx::assignSheet(TTabSheet* sheet, bool accessible)
{
    this->sheet = sheet;
    this->accessible = accessible;
}

/* ��������� �������� � ������ ��������� ������� ��� �����*/
void TSheetEx::addAction(TAction* action, bool accessible)
{
    if ( action->Enabled )
    {
        _actions.push_back(action);
    }
}

/* �������� ��������� �������� */
void TSheetEx::hideActions()
{
    for (std::vector<TAction*>::iterator action = _actions.begin(); action != _actions.end(); action++)
    {
        (*action)->Visible = false;
    }
}


/* ���������� ��������� �������� */
void TSheetEx::showActions()
{
    for (std::vector<TAction*>::iterator action = _actions.begin(); action != _actions.end(); action++)
    {
        (*action)->Visible = true;
    }
}

/* ����� ��� �������� ��������(�������),
   ��������������� ����� ������ ��������� */
class TModeItem
{
private:
    std::vector<TAction*> _actions; // ������ ���� �������� (��� ���� ����� ����� ���� ������ ��� �������� ����� ������������ �����)

public:
    TModeItem::TModeItem();
    String caption;     // ������������ ������
    //String modeType;    // �������� ��� ����� pack_type_cd
    TMode mode;
    std::vector<TSheetEx> sheets;   // ������ �������(�����������)
    std::vector<TSheetEx*> visibleSheets;   // ������ �������(�����������)

    void showSheets();
    void hideSheets();

    TSheetEx* addSheet(TTabSheet* _sheet, bool _accessible = true);

    void setCurrentSheet(TSheetEx* sheetEx);
    void setCurrentSheet(int index);
    void setCurrentSheet(TSheetType type);

    TSheetEx* currentSheet;

    TSheetEx* getSheetByType(TSheetType type);

    void addAction(TAction* action);

    TSheetEx* getSheetByIndex();

};

TModeItem::TModeItem()
{
    //currentSheet = sheets.begin()+1;
}

/* ��������� �������� � ����� ������ */
void TModeItem::addAction(TAction* action)
{
    _actions.push_back(action);
}

/* ��������� ��������� */
TSheetEx* TModeItem::addSheet(TTabSheet* _sheet, bool _accessible)
{
    sheets.push_back(TSheetEx(_sheet, _accessible));
    return &sheets.back();
}

/* ���������� ��������� ������� */
void TModeItem::showSheets()
{
    visibleSheets.clear();
    // ���������� ������ ������� ��������� ������ � ��������� �������� ������������ �� ��� ����
    for (std::vector<TSheetEx>::iterator sheet = sheets.begin(); sheet != sheets.end(); sheet++)
    {
        sheet->sheet->TabVisible = sheet->accessible;
        if ( sheet->accessible )
        {
            visibleSheets.push_back(sheet);
        }
    }

    if ( visibleSheets.size() > 0)
    {
        setCurrentSheet(visibleSheets[0]);
    }
}

/* ���������� ��������� ������� */
void TModeItem::hideSheets()
{
    // ���������� ������ ������� ��������� ������ � ��������� �������� ������������ �� ��� ����
    for (std::vector<TSheetEx>::iterator sheet = sheets.begin(); sheet != sheets.end(); sheet++)
    {
        sheet->sheet->TabVisible = false;
    }
}

/* �������� �������� �� ���� */
TSheetEx* TModeItem::getSheetByType(TSheetType type)
{
    for(std::vector<TSheetEx>::iterator sheet = sheets.begin(); sheet != sheets.end(); sheet++)
    {
        if ( sheet->packModeId == type )
        {
            return sheet;
        }
    }
    return NULL;
}



/* ���������� ���� */
void TModeItem::setCurrentSheet(TSheetEx* sheetEx)
{
    if ( sheetEx->accessible )
    {
        currentSheet = sheetEx;
        if ( !currentSheet->sheet->Visible)
        {
            currentSheet->sheet->Show();
        }

        // ���������� ������ ��������� ��������
        currentSheet->showActions();
    }
    else
    {
        throw Exception("The tab is not accessible." );
    }
}

/* ���������� �������� */
void TModeItem::setCurrentSheet(TSheetType type)
{
    TSheetEx* sheetEx = getSheetByType(type);
    if (sheetEx != NULL)
    {
        setCurrentSheet(sheetEx);
    }
    else
    {
        // ���� ������� �� ���� �� �������
        throw Exception("������� � ��������� ����� �� �������." );
    }
}

/* ���������� �������� �� ������� */
void TModeItem::setCurrentSheet(int index)
{
    if (visibleSheets.size() > index )
    {
        setCurrentSheet(visibleSheets[index]);
    }
    else
    {
        // ���� ������� ����������
        //throw Exception("The tab is not accessible or not exists." );
        throw Exception("������� ���������� ��� �� ����������." );
    }
}

// ��� ������ ������� ������ ���������
//typedef std::vector<TModeItem> TModeList;
class TModeList
{

private:
    void hideAllActions();
    std::vector<TAction*> _actions; // ������ ���� �������� (��� ���� ����� ����� ���� ������ ��� �������� ����� ������������ �����)


public:
    std::vector<TModeItem*> _modeList;      // ������ �������
    TModeItem* _currentMode;    // ������� �����

public:
    TModeList();

    void setMode(TModeItem* mode);

    TModeItem* addTab(const String& tabName, TMode mode);
    void addAction(TAction* action);
    void setCurrentSheet(TSheetType type);


};

TModeList::TModeList()
{
}

void TModeList::setCurrentSheet(TSheetType type)
{
    hideAllActions();
    if (_currentMode != NULL)
    {
        _currentMode->setCurrentSheet(type);    // ���������� �������, ���� ��� ��������
    }
    else
    {
        throw Exception("Error occured: Current mode is not specified.");
    }
}


/* ������ ������� ����� */
void TModeList::setMode(TModeItem* mode)
{
    hideAllActions();  // ������ ��� �������� 2017-08-29

    // ������� ������ ������ ��� �������
    for (std::vector<TModeItem*>::iterator it = _modeList.begin(); it != _modeList.end(); it++)
    {
        (*it)->hideSheets();
    }

    mode->showSheets(); // ���������� ������� ���������� �����
    _currentMode = mode;    // ��������� ������� �����
}


/* ��������� �������� � ����� ������ */
void TModeList::addAction(TAction* action)
{
    _actions.push_back(action);
}

/* ������ ��� �������� � Action ������ */
void TModeList::hideAllActions()
{
    for (std::vector<TAction*>::iterator action = _actions.begin(); action != _actions.end(); action++)
    {
        (*action)->Visible = false;
    }
}

/* ��������� ������� */
TModeItem* TModeList::addTab(const String& tabName, TMode mode)
{
    TModeItem* item = new TModeItem();
    item->caption = tabName;
    item->mode = mode;
    _modeList.push_back(item);
    return item;
}



//---------------------------------------------------------------------------
class TFieldActivityForm : public TForm
{
__published:	// IDE-managed Components
    TPopupMenu *DocumentsPopupMenu;
    TMenuItem *N4;
    TGroupBox *GroupBox3;
    TLabel *Label20;
    TMenuItem *N5;
    TMenuItem *DocumentStopMenuItem;
    TMenuItem *N7;
    TMenuItem *N8;
    TActionList *ActionList1;
    TAction *printDocumentFaNoticesAction;
    TAction *printCancelStopAction;
    TAction *printDocumentStopListAction;
    TAction *createFpNoticesAction;
    TAction *setCcStatusApproveAction;
    TPopupMenu *ActionsPopupMenu;
    TMenuItem *MenuItem1;
    TMenuItem *MenuItem2;
    TAction *checkAllAction;
    TAction *checkNoneAction;
    TAction *checkWithoutCcAction;
    TAction *checkWithCcLess3MonthAction;
    TMenuItem *N6;
    TAction *createFaPackStopAction;
    TMenuItem *N9;
    TActionList *ActionList2;
    TAction *Action11;
    TAction *Action12;
    TAction *Action13;
    TAction *Action14;
    TPanel *MainPanel;
    TPopupMenu *SelectAcctPopupMenu;
    TMenuItem *N1;
    TMenuItem *N2;
    TMenuItem *N3;
    TMenuItem *N31;
    TAction *createFpPostAction;
    TMenuItem *N10;
    TAction *printFaNoticeEnvelopeAction;
    TMenuItem *N11;
    TAction *printDocumentFaNoticesListAction;
    TAction *printDocumentStopAction;
    TAction *updateCcAction;
    TPanel *LeftPanel;
    TGroupBox *ParametersGroupBox;
    TComboBox *SelectModeComboBox;
    TGroupBox *FilterGroupBox;
    TPanel *AcctIdFilterPanel;
    TEditAlt *AcctIdComboBox;
    TPanel *CityFilterPanel;
    TComboBox *CityComboBox;
    TPanel *AddressFilterPanel;
    TComboBox *AddressComboBox;
    TPanel *FioFilterPanel;
    TEdit *FioComboBox;
    TPanel *SaldoFilterPanel;
    TEditAlt *SaldoFilterEdit;
    TPanel *ServiceCompanyFilterPanel;
    TComboBox *ServiceCompanyFilterComboBox;
    TPanel *FaPackIdFilterPanel;
    TEditAlt *FaPackIdFilterEdit;
    TPanel *OpAreaDescrFilterPanel;
    TComboBox *OpAreaDescrFilterComboBox;
    TPanel *CcDttmExistsFilterPanel;
    TPanel *MrRteCdFilterPanel;
    TPanel *ccDttmIsApprovedFilterPanel;
    TPanel *RstButtonFilterPanel;
    TBitBtn *ResetFiltersButton;
    TPanel *FilterSplitterPanel;
    TPanel *FaPackTypeFilterPanel;
    TPanel *PremTypeFilterPanel;
    TComboBox *PremTypeComboBox;
    TAction *deleteFaPackAction;
    TMenuItem *N13;
    TAction *setFpStopStatusCancelAction;
    TMenuItem *N14;
    TAction *setFaPackStatusFrozenAction;
    TMenuItem *N15;
    TComboBox *FaPackTypeFilterComboBox;
    TPanel *Panel1;
    TPanel *Panel2;
    TPanel *SelectAcctPopupMenuPanel;
    TBitBtn *ShowSelectAcctMenuButton;
    TCheckBox *SelectAllCheckBox;
    TBitBtn *ShowActionsMenuButton;
    TBitBtn *ShowDocumentsMenuButton;
    TPageControl *PackPageControl;
    TTabSheet *MainTabSheet;
    TGroupBox *GroupBox2;
    TTabSheet *DebtorsTabSheet;
    TDBGridAlt *DBGridAltGeneral;
    TTabSheet *PackManualTabSheet;
    TDBGridAlt *DBGridAltManual;
    TTabSheet *ApprovalListTabSheet;
    TDBGridAlt *ApproveListGrid;
    TTabSheet *StopListTabSheet;
    TDBGridAlt *StopListGrid;
    TTabSheet *PackStopListTabSheet;
    TDBGridAlt *PackStopListGrid;
    TTabSheet *PackStopTabSheet;
    TDBGridAlt *FpStopContentGrid;
    TTabSheet *FaCancelStopListTabSheet;
    TDBGridAlt *CancelStopListGrid;
    TTabSheet *PackReconnectTabSheet;
    TTabSheet *PostListTabSheet;
    TTabSheet *FullListTabSheet;
    TDBGridAlt *FullListGrid;
    TPanel *SummaryPanel;
    TGroupBox *SummaryInfoGroupBox;
    TLabel *Label16;
    TLabel *Label15;
    TLabel *Label14;
    TLabel *CheckedCountStatLabel;
    TLabel *TotalStatLabel;
    TLabel *FilteredStatLabel;
    TComboBox *ApprovedStatusComboBox;
    TComboBox *CcDttmStatusComboBox;
    TLabel *Label4;
    TPanel *ccDttmPeriodPanel;
    TDateTimePicker *DateTimePicker2;
    TLabel *Label1;
    TDateTimePicker *DateTimePicker1;
    TLabel *Label7;
    TAction *createFaPackStopToControlAction;
    TMenuItem *N16;
    TMemo *Memo1;
    TAction *printDocumentFaNoticesListForPostOfficeAction;
    TMenuItem *N17;
    TLabel *Label5;
    TLabel *CheckedFilteredCountLabel;
    TSplitter *Splitter1;
    TDBGridAlt *PostListGrid;
    TButton *TestButton1;
    TComboBox *MrRteCdFilterComboBox;
    TAction *setCcStatusRefuseAction;
    TPanel *FaPackStatusFilterPanel;
    TComboBox *FaPackStatusFilterComboBox;
    TMenuItem *N12;
    TPanel *Panel4;
    TPanel *FaPackIdParamPanel;
    TEdit *ParamPackIdEdit;
    TBitBtn *BitBtn1;
    TRichEdit *RichEdit1;
    TDBGridAlt *ReconnectListGrid;
    TAction *printReconnectAction;
    TMenuItem *N18;
    TAction *createFpCancelAction;
    TMenuItem *N19;
    TAction *editSaEndDtAction;
    TTabSheet *FpCancelContentTabSheet;
    TTabSheet *FpReconnectContentTabSheet;
    TDBGridAlt *FpCancelContentGrid;
    TDBGridAlt *FpReconnectContentGrid;
    TPanel *FaIdFilterPanel;
    TEditAlt *FaIdFilterEdit;
    TTabSheet *PreOverdueListTabSheet;
    TTabSheet *FpOverdueListTabSheet;
    TDBGridAlt *PreOverdueListGrid;
    TAction *createFpOverdueAction;
    TMenuItem *createFpOverdueAction1;
    TTabSheet *FpOverdueContentTabSheet;
    TDBGridAlt *FpOverdueContentGrid;
    TDBGridAlt *FpOverdueListGrid;
    TAction *printOverdueRequestAction;
    TMenuItem *N20;
    TAction *setFpCancelStatusCancelAction;
    TAction *setFpReconnectStatusCancelAction;
    TMenuItem *N21;
    TMenuItem *N22;
    TAction *setFpOverdueStatusCancelAction;
    TMenuItem *N23;
    TAction *resetConnectionAction;
    TMenuItem *TESTER1;
    TPanel *CcCallerFilterPanel;
    TEdit *CcCallerFilterEdit;
    TComboBoxAlt *OtdelenComboBoxAlt;
    void __fastcall FormShow(TObject *Sender);
    void __fastcall FilterComboBoxTextChange(TObject *Sender);
    void __fastcall ParamPackIdEditClick(TObject *Sender);
    void __fastcall OtdelenBoxChange(TObject *Sender);
    void __fastcall ParamPackIdEditKeyPress(TObject *Sender, char &Key);
    void __fastcall FilterCcDttmChange(TObject *Sender);
    void __fastcall ShowSelectAcctMenuButtonKeyPress(TObject *Sender,
          char &Key);
    void __fastcall ShowSelectAcctMenuButtonMouseDown(TObject *Sender,
          TMouseButton Button, TShiftState Shift, int X, int Y);
    void __fastcall PackPageControlDrawTab(TCustomTabControl *Control,
          int TabIndex, const TRect &Rect, bool Active);
    void __fastcall FilterEditTextChange(TObject *Sender);
    void __fastcall DebtorsTabSheetShow(TObject *Sender);
    void __fastcall PackManualTabSheetShow(TObject *Sender);
    void __fastcall ApprovalListTabSheetShow(TObject *Sender);
    void __fastcall ShowDocumentsMenuButtonMouseDown(TObject *Sender, TMouseButton Button,
          TShiftState Shift, int X, int Y);
    void __fastcall ResetFiltersButtonClick(TObject *Sender);
    void __fastcall StopListTabSheetShow(TObject *Sender);
    void __fastcall OtdelenComboBoxClick(TObject *Sender);
    void __fastcall printDocumentFaNoticesActionExecute(TObject *Sender);
    void __fastcall printDocumentFaNoticesListActionExecute(TObject *Sender);
    void __fastcall createFpNoticesActionExecute(TObject *Sender);
    void __fastcall setCcStatusApproveActionExecute(TObject *Sender);
    void __fastcall ShowActionsMenuButtonMouseDown(TObject *Sender, TMouseButton Button,
          TShiftState Shift, int X, int Y);
    void __fastcall checkWithCcLess3MonthActionExecute(TObject *Sender);
    void __fastcall checkWithoutCcActionExecute(TObject *Sender);
    void __fastcall checkAllActionExecute(TObject *Sender);
    void __fastcall FilterCheckBoxChange(TObject *Sender);
    void __fastcall DBGridAltManualCellClick(TColumn *Column);
    void __fastcall printDocumentStopActionExecute(TObject *Sender);
    void __fastcall SelectModeComboBoxChange(TObject *Sender);
    void __fastcall checkNoneActionExecute(TObject *Sender);
    void __fastcall createFaPackStopActionExecute(TObject *Sender);
    void __fastcall PackStopTabSheetShow(TObject *Sender);
    void __fastcall FaCancelStopListTabSheetShow(TObject *Sender);
    void __fastcall SelectAllCheckBoxClick(TObject *Sender);
    void __fastcall PackStopListTabSheetShow(TObject *Sender);
    void __fastcall checkAllActionUpdate(TObject *Sender);
    void __fastcall updateIfCheckedItems(TObject *Sender);
    void __fastcall PostListTabSheetShow(TObject *Sender);
    void __fastcall createFpPostActionExecute(TObject *Sender);
    void __fastcall printFaNoticeEnvelopeActionExecute(TObject *Sender);
    void __fastcall FullListTabSheetShow(TObject *Sender);
    void __fastcall updateCcActionExecute(TObject *Sender);
    void __fastcall deleteFaPackActionExecute(TObject *Sender);
    void __fastcall setFpStopStatusCancelActionExecute(
          TObject *Sender);
    void __fastcall setFaPackStatusFrozenActionExecute(TObject *Sender);
    void __fastcall MainTabSheetShow(TObject *Sender);
    void __fastcall FilterComboBoxIndexChange(TObject *Sender);
    void __fastcall CcDttmStatusComboBoxChange(TObject *Sender);
    void __fastcall printDocumentFaNoticesListForPostOfficeActionExecute(
          TObject *Sender);
    void __fastcall printCancelStopActionExecute(
          TObject *Sender);
    void __fastcall OnChangeCheck(TObject *Sender);
    void __fastcall TestButton1Click(TObject *Sender);
    void __fastcall setCcStatusRefuseActionExecute(
          TObject *Sender);
    void __fastcall ReconnectTabSheetShow(TObject *Sender);
    void __fastcall FormCreate(TObject *Sender);
    void __fastcall printReconnectActionExecute(TObject *Sender);
    void __fastcall createFpCancelActionExecute(TObject *Sender);
    void __fastcall FpStopContentGridCellClick(TColumn *Column);
    void __fastcall editSaEndDtActionExecute(TObject *Sender);
    void __fastcall FpCancelContentTabSheetShow(TObject *Sender);
    void __fastcall FpReconnectContentTabSheetShow(TObject *Sender);
    void __fastcall PreOverdueListTabSheetShow(TObject *Sender);
    void __fastcall createFpOverdueActionExecute(TObject *Sender);
    void __fastcall FpOverdueListTabSheetShow(TObject *Sender);
    void __fastcall printOverdueRequestActionExecute(TObject *Sender);
    void __fastcall FpOverdueContentTabSheetShow(TObject *Sender);
    void __fastcall setFpCancelStatusCancelActionExecute(TObject *Sender);
    void __fastcall setFpReconnectStatusCancelActionExecute(TObject *Sender);
    void __fastcall setFpOverdueStatusCancelActionExecute(TObject *Sender);
    void __fastcall resetConnectionActionExecute(TObject *Sender);
private:	// User declarations
    //void __fastcall TFieldActivityForm::selectMode(int mode);
    void __fastcall OnQueryAfterExecute(TObject *Sender);
    void __fastcall setMode(int index);
    //void __fastcall changeSheet(TSheetType type);


    //TModeItem* _currentMode;

    //TModeList _modeList;    // ������ ��������� ������� ������ �� �������� (��������: ������ � ����������� ��� ������ � �������� �� �����������)
    TModeList modePageList;


    void __fastcall showMainTabSheet();
    void __fastcall showFullList();
    void __fastcall showPreDebtorList();
    void __fastcall showPrePostList();
    void __fastcall showFpNoticesContent(const String& fpId);
    void __fastcall showFpStopContent(const String& fpId);
    void __fastcall showFpCancelContent(const String& fpId);
    void __fastcall showFpReconnectContent(const String& fpId);
    void __fastcall showStopList();
    void __fastcall showApprovalList();
    void __fastcall showPreOverdueList();
    void __fastcall showFpOverdueContent(const String& fpId);


    void __fastcall showFaList();
    void __fastcall showFpStopList(/*const String& acctOtdelen*/); // �������� ������ �������� �� �����������
    void __fastcall showFaPostList();
    void __fastcall showFaInspectorList();
    void __fastcall showCancelList();
    void __fastcall showReconnectList();    // ������ �������� �������� �� ����������
    void __fastcall showFpOverdueList();    // ������ �������� ������������ ������






    void __fastcall resetFilterControls();

    void __fastcall setCurPackMode();
    void __fastcall refreshCheckedCount();
    void __fastcall showPopupSubMenu(TWinControl *control, TPopupMenu* menu);   // ���������� Popup-���� � ������� �� ��������� � ������� control
    void __fastcall refreshParametersControls();
    void __fastcall refreshFilterControls();
    void __fastcall refreshActionsStates();
    void __fastcall refreshPopupMenu();



    ColorList _colorList;
    TDBGridAlt* _currentDbGrid;
    TDataSetFilter* _currentFilter;


    bool _packPageControlChangedSelf;
    void __fastcall OnThreadEnd(TObject *Sender);
    void __fastcall OnThreadBegin(TObject *Sender);
    void __fastcall OnChangeFilter(TObject *Sender);


    TThreadDataSet* tds;


    int _checkedCount;
    int _recordCount;

    //void __fastcall setCurPackId(const String& faPackId);
    //void __fastcall setCurOtdelen(const String& otdelen, bool resetPack = true);
    //void __fastcall setFilter(const String& filterName, const String& filterValue);
    //bool _packPageControlChangedSelf;

    // ����, ���� ��������, �� ��������� � ����������� ������
    //void __fastcall RealignControls(TWinControl *parent);

public:		// User declarations
    __fastcall TFieldActivityForm(TComponent* Owner);
};

//---------------------------------------------------------------------------
extern PACKAGE TFieldActivityForm *FieldActivityForm;
//---------------------------------------------------------------------------
#endif
