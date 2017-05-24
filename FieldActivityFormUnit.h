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
#include <set>
#include <algorithm>
#include "WaitFormUnit.h"
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
    MODE_STOP
} TMode;

typedef enum   {
    SHEET_TYPE_UNDEFINED = 0,
    SHEET_TYPE_MAIN_NOTICES,        // Главная вкладка (в наст. время она общая на все режимы)

    SHEET_TYPE_FULL_LIST,           // general
    SHEET_TYPE_DEBTORS,             // general
    SHEET_TYPE_NOTICES_PACK,        //PACK_MANUAL,
    SHEET_TYPE_APPROVE,

    SHEET_TYPE_POST_LIST,
    //SHEET_TYPE_POST_PACK,

    SHEET_TYPE_STOP,
    SHEET_TYPE_PACK_STOP_LIST,  // Список реестров на отключение
    SHEET_TYPE_STOP_PACK,
    SHEET_TYPE_CANCEL_STOP_LIST,
    SHEET_TYPE_RECONNECT_LIST
    //SHEET_TYPE_RELOAD
    //PACK_APPROVE_LIST
} TSheetType;


/* Класс для хранения расширеной обертки над TTabSheet */
class TSheetEx
{
private:
    std::vector<TAction*> _actions; // Список доступных действий

public:
    TSheetEx(TTabSheet* _sheet, bool _accessible);
    TTabSheet* sheet;   // Указатель на вкладку
    bool accessible;    // Признак доступности пользователю

    //void addAction(TAction* action);
    // std::vector<Action*> filters; // Список доступных фильтров
    void setColor(TColor color);
    TColor _color;
    TColor getColor();

    /* actions */
    void assignSheet(TTabSheet* sheet, bool accessible = false);
    void addAction(TAction* action, bool accessible = false);
    void showActions();

    TSheetType packModeId;    // Спорный вопрос, хранить здесь или нет!!!!!!!!!! Наверное да!
};

void TSheetEx::setColor(TColor color)
{
    _color = color;
}

TColor TSheetEx::getColor()
{
    return _color;
}

/* Конструктор */
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

/* Добавляет действие в список доступных дейсвия для листа*/
void TSheetEx::addAction(TAction* action, bool accessible)
{
    if ( action->Enabled )
    {
        _actions.push_back(action);
    }
}

/* Отображает доступные действия */
void TSheetEx::showActions()
{
    for (std::vector<TAction*>::iterator action = _actions.begin(); action != _actions.end(); action++)
    {
        (*action)->Visible = true;
    }
}

/* Класс для хранения элемента(раздела),
   представляющего режим работы программы */
class TModeItem
{
private:
    std::vector<TAction*> _actions; // Список всех действий (для того чтобы можно было скрыть все действия перед отображением листа)

public:
    TModeItem::TModeItem();
    String caption;     // Наименование режима
    //String modeType;    // Возможно что равно pack_type_cd
    TMode mode;
    std::vector<TSheetEx> sheets;   // Список вкладок(подразделов)
    std::vector<TSheetEx*> visibleSheets;   // Список вкладок(подразделов)

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

/* Добавляет действие в общий список */
void TModeItem::addAction(TAction* action)
{
    _actions.push_back(action);
}

/* Добавляет странцицу */
TSheetEx* TModeItem::addSheet(TTabSheet* _sheet, bool _accessible)
{
    sheets.push_back(TSheetEx(_sheet, _accessible));
    return &sheets.back();
}

/* Отображает доступные вкладки */
void TModeItem::showSheets()
{
    visibleSheets.clear();
    // Отображаем только вкладки активного режима и доступные текущему пользователю по его роли
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

/* Отображает доступные вкладки */
void TModeItem::hideSheets()
{
    // Отображаем только вкладки активного режима и доступные текущему пользователю по его роли
    for (std::vector<TSheetEx>::iterator sheet = sheets.begin(); sheet != sheets.end(); sheet++)
    {
        sheet->sheet->TabVisible = false;
    }
}

/* Получает страницу по типу */
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



/* Отображаем лист */
void TModeItem::setCurrentSheet(TSheetEx* sheetEx)
{
    if ( sheetEx->accessible )
    {
        //hideAllActions();

        currentSheet = sheetEx;
        if ( !currentSheet->sheet->Visible)
        {
            currentSheet->sheet->Show();
        }

        // Отображаем только доступные действия
        currentSheet->showActions();
    }
    else
    {
        throw Exception("The tab is not accessible." );
    }
}

/* Отображает страницу */
void TModeItem::setCurrentSheet(TSheetType type)
{
    TSheetEx* sheetEx = getSheetByType(type);
    if (sheetEx != NULL)
    {
        setCurrentSheet(sheetEx);
    }
    else
    {
        // если вкладка по типу не найдена
        throw Exception("Вкладка с указанным типом не найдена." );
    }
}

/* Отображает страницу по индексу */
void TModeItem::setCurrentSheet(int index)
{
    if (visibleSheets.size() > index )
    {
        setCurrentSheet(visibleSheets[index]);
    }
    else
    {
        // если вкладка недоступна
        //throw Exception("The tab is not accessible or not exists." );
        throw Exception("Вкладка недоступна или не существует." );
    }
}

// Тип списка режимов работы программы
//typedef std::vector<TModeItem> TModeList;
class TModeList
{

private:
    void hideAllActions();
    std::vector<TAction*> _actions; // Список всех действий (для того чтобы можно было скрыть все действия перед отображением листа)


public:
    std::vector<TModeItem*> _modeList;      // Список режимов
    TModeItem* _currentMode;    // Текущий режим

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
        _currentMode->setCurrentSheet(type);    // Отображает вкладку, если она доступна
    }
    else
    {
        throw Exception("Error occured: Current mode is not specified.");
    }
}


/* Задает текущий режим */
void TModeList::setMode(TModeItem* mode)
{
    // Сначала прячем вообще все вкладки
    for (std::vector<TModeItem*>::iterator it = _modeList.begin(); it != _modeList.end(); it++)
    {
        (*it)->hideSheets();
    }
    mode->showSheets(); // Отображаем вкладки выбранного режим
    _currentMode = mode;    // Сохраняем текущий режим
}


/* Добавляет действие в общий список */
void TModeList::addAction(TAction* action)
{
    _actions.push_back(action);
}

/* Прячет все действия в Action листах */
void TModeList::hideAllActions()
{
    for (std::vector<TAction*>::iterator action = _actions.begin(); action != _actions.end(); action++)
    {
        (*action)->Visible = false;
    }
}

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
    TAction *createFaPackAction;
    TAction *approveFaPackCcDttmAction;
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
    TAction *createFaPackPostAction;
    TMenuItem *N10;
    TAction *printFaNoticeEnvelopeAction;
    TMenuItem *N11;
    TAction *printDocumentFaNoticesListAction;
    TAction *printDocumentStopAction;
        TAction *createFaPackFree_old;
    TAction *updateCcAction;
    TPanel *LeftPanel;
    TGroupBox *GroupBox7;
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
    TAction *setFaPackStatusIncompleteAction;
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
    TDBGridAlt *StopPackGrid;
    TTabSheet *FaCancelStopListTabSheet;
    TDBGridAlt *CancelStopListGrid;
    TTabSheet *PackReconnectTabSheet;
    TTabSheet *PostListTabSheet;
    TTabSheet *FullListTabSheet;
    TDBGridAlt *FullListGrid;
    TPanel *Panel3;
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
    TButton *Button6;
    TDBLookupComboBox *DBLookupComboBox1;
    TLabel *Label8;
    TLabel *Label9;
    TDBLookupComboBox *DBLookupComboBox2;
    TComboBox *MrRteCdFilterComboBox;
    TAction *setFaPackCancelStopStatusCompleteAction;
    TPanel *FaPackStatusFilterPanel;
    TComboBox *FaPackStatusFilterComboBox;
    TMenuItem *N12;
    TPanel *Panel4;
    TDBLookupComboBox *OtdelenComboBox;
    TPanel *FaPackIdParamPanel;
    TEdit *ParamPackIdEdit;
    TBitBtn *BitBtn1;
    TRichEdit *RichEdit1;
    TDBGridAlt *ReconnectListGrid;
    TAction *printReconnectAction;
    TMenuItem *N18;
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
    void __fastcall createFaPackActionExecute(TObject *Sender);
    void __fastcall approveFaPackCcDttmActionExecute(TObject *Sender);
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
    void __fastcall createFaPackNoticeActionUpdate(TObject *Sender);
    void __fastcall PostListTabSheetShow(TObject *Sender);
    void __fastcall createFaPackPostActionExecute(TObject *Sender);
    void __fastcall printFaNoticeEnvelopeActionExecute(TObject *Sender);
    void __fastcall createFaPackFree_oldExecute(TObject *Sender);
    void __fastcall FullListTabSheetShow(TObject *Sender);
    void __fastcall updateCcActionExecute(TObject *Sender);
    void __fastcall deleteFaPackActionExecute(TObject *Sender);
    void __fastcall setFaPackStatusIncompleteActionExecute(
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
    void __fastcall Button6Click(TObject *Sender);
    void __fastcall setFaPackCancelStopStatusCompleteActionExecute(
          TObject *Sender);
    void __fastcall ReconnectTabSheetShow(TObject *Sender);
    void __fastcall FormCreate(TObject *Sender);
    void __fastcall printReconnectActionExecute(TObject *Sender);
private:	// User declarations
    //void __fastcall TFieldActivityForm::selectMode(int mode);
    void __fastcall OnQueryAfterExecute(TObject *Sender);
    void __fastcall setMode(int index);
    //void __fastcall changeSheet(TSheetType type);


    //TModeItem* _currentMode;

    //TModeList _modeList;    // Список доступных режимов работы со списками (например: Работа с уведомления или Работа с заявками на ограничение)
    TModeList modePageList;


    void __fastcall showMainTabSheet();
    void __fastcall showFullList();
    void __fastcall showPreDebtorList();
    void __fastcall showPrePostList();
    void __fastcall showFaPackNotices(const Variant faPackId);
    void __fastcall showFaPackStop(const Variant faPackId);
    void __fastcall showStopList();
    void __fastcall showApprovalList();


    void __fastcall showFaList();
    void __fastcall showPackStopList(/*const String& acctOtdelen*/); // Показать список реестров на ограничение
    void __fastcall showFaPostList();
    void __fastcall showFaInspectorList();
    void __fastcall showCancelList();
    void __fastcall showReconnectList();      // Список реестров реестров на отключение



    void __fastcall resetFilterControls();

    void __fastcall setCurPackMode();
    void __fastcall refreshCheckedCount();
    void __fastcall showPopupSubMenu(TWinControl *control, TPopupMenu* menu);   // Отображает Popup-меню в позиции по отношению к позиции control
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

    // Тест, если работает, то перенести в специальный модуль
    void __fastcall RealignControls(TWinControl *parent);

public:		// User declarations
    __fastcall TFieldActivityForm(TComponent* Owner);
};

//---------------------------------------------------------------------------
extern PACKAGE TFieldActivityForm *FieldActivityForm;
//---------------------------------------------------------------------------
#endif
