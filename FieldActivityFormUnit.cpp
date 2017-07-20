//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "FieldActivityFormUnit.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBGridAlt"
#pragma link "OtdelenComboBoxFrameUnit"
#pragma link "EditAlt"
#pragma link "MemDS"
#pragma link "VirtualTable"
#pragma link "DataSetFilter"
#pragma resource "*.dfm"
TFieldActivityForm *FieldActivityForm;

using namespace strtools;

bool isRoleAllowed(TUserRole::TRoleTypes s1, TUserRole::TRoleTypes s2)
{

    set<int> intersect;

    set_intersection(s1.begin(),s1.end(),s2.begin(),s2.end(),
                  std::inserter(intersect,intersect.begin()));

    //int test = intersect.size();

    return intersect.size() > 0;

}

//---------------------------------------------------------------------------
__fastcall TFieldActivityForm::TFieldActivityForm(TComponent* Owner)
    : TForm(Owner)/*,
    _curPackMode(PACK_MODE_UNDEFINED)  */
{
    Caption = "ДолжникиФ (" + AppVer::FullVersion + "a) - " + MainDataModule->getConfigProc->FieldByName("username")->AsString;
    //MainDataModule->otdelenList.assignTo(OtdelenComboBox);

    // Задаем функции для связи модуля данных с графическим интерфейсом
    MainDataModule->setOpenDataSetEvents(OnThreadBegin, OnThreadEnd);
    MainDataModule->setOnChangeFilterMethod(OnChangeFilter);

    // Окно ожидания выполнения запроса
    WaitForm = new TWaitForm(this);
    WaitForm->SetMessage("\nЗАГРУЗКА ДАННЫХ...");

    _colorList.clear();
    _colorList.addColor(static_cast<TColor>(RGB(90,225,255)));  // blue
    _colorList.addColor(static_cast<TColor>(RGB(120,230,90)));  // green
    _colorList.addColor(static_cast<TColor>(RGB(245,220,00)));  // yellow
    _colorList.addColor(static_cast<TColor>(RGB(255,180,50)));  // orange
    _colorList.addColor(static_cast<TColor>(RGB(255,130,170))); // rose
    _colorList.addColor(static_cast<TColor>(RGB(255,100,0))); // red

    //_colorList.addColor(static_cast<TColor>(RGB(180,255,20)));
    //_colorList.addColor(static_cast<TColor>(RGB(255,255,0)));
    //_colorList.addColor(static_cast<TColor>(RGB(255,255,255)));

    /* Формирование списков доступа к вкладкам */
    /* Раздел Уведомления*/
    // Главная вкладка
    TUserRole::TRoleTypes Access_MainTabSheet_Notices;
    Access_MainTabSheet_Notices.insert(TUserRole::USER_BASE);
    Access_MainTabSheet_Notices.insert(TUserRole::OPERATOR);
    Access_MainTabSheet_Notices.insert(TUserRole::ADMINISTRATOR);
    Access_MainTabSheet_Notices.insert(TUserRole::VIEWER);

    // Полный список абонентов
    TUserRole::TRoleTypes Access_FullListTabSheet;
    //Access_FullListTabSheet<<TUserRole::OPERATOR;
    //Access_FullListTabSheet<<TUserRole::ADMINISTRATOR;
    Access_FullListTabSheet.insert(TUserRole::OPERATOR);
    Access_FullListTabSheet.insert(TUserRole::ADMINISTRATOR);
    Access_FullListTabSheet.insert(TUserRole::VIEWER);


    // Список должников
    TUserRole::TRoleTypes Access_DebtorsTabSheet;
    Access_DebtorsTabSheet.insert(TUserRole::OPERATOR);
    Access_DebtorsTabSheet.insert(TUserRole::ADMINISTRATOR);
    Access_DebtorsTabSheet.insert(TUserRole::VIEWER);

    // Реестр уведомлений
    TUserRole::TRoleTypes Access_PackManualTabSheet;
    Access_PackManualTabSheet.insert(TUserRole::OPERATOR);
    Access_PackManualTabSheet.insert(TUserRole::ADMINISTRATOR);
    Access_PackManualTabSheet.insert(TUserRole::VIEWER);

    // Список на утверждение
    TUserRole::TRoleTypes Access_ApprovalListTabSheet;
    Access_ApprovalListTabSheet.insert(TUserRole::OPERATOR);
    Access_ApprovalListTabSheet.insert(TUserRole::ADMINISTRATOR);
    Access_ApprovalListTabSheet.insert(TUserRole::VIEWER);
    Access_ApprovalListTabSheet.insert(TUserRole::APPROVER);

    // Список на почту
    TUserRole::TRoleTypes Access_PostListTabSheet;
    Access_PostListTabSheet.insert(TUserRole::OPERATOR);
    Access_PostListTabSheet.insert(TUserRole::ADMINISTRATOR);
    Access_PostListTabSheet.insert(TUserRole::VIEWER);

    /* Раздел на ограничение */
    // Главная вкладка
    TUserRole::TRoleTypes Access_MainTabSheet_Stop;
    Access_MainTabSheet_Stop.insert(TUserRole::OPERATOR);
    Access_MainTabSheet_Stop.insert(TUserRole::ADMINISTRATOR);
    Access_MainTabSheet_Stop.insert(TUserRole::VIEWER);
    Access_MainTabSheet_Stop.insert(TUserRole::TESTER);


    // Список на ограничение
    TUserRole::TRoleTypes AccessStopListTabSheet;
    AccessStopListTabSheet.insert(TUserRole::OPERATOR);
    AccessStopListTabSheet.insert(TUserRole::ADMINISTRATOR);
    AccessStopListTabSheet.insert(TUserRole::VIEWER);
    AccessStopListTabSheet.insert(TUserRole::TESTER);

    // Список реестров на ограничение
    TUserRole::TRoleTypes AccessPackStopListTabSheet;
    AccessPackStopListTabSheet.insert(TUserRole::OPERATOR);
    AccessPackStopListTabSheet.insert(TUserRole::ADMINISTRATOR);
    AccessPackStopListTabSheet.insert(TUserRole::VIEWER);
    AccessPackStopListTabSheet.insert(TUserRole::TESTER);

    // Реестр на ограничение содержимое
    TUserRole::TRoleTypes AccessPackStopTabSheet;
    AccessPackStopTabSheet.insert(TUserRole::OPERATOR);
    AccessPackStopTabSheet.insert(TUserRole::ADMINISTRATOR);
    AccessPackStopTabSheet.insert(TUserRole::VIEWER);
    AccessPackStopTabSheet.insert(TUserRole::TESTER);

    // Реестр на отмену содержимое
    TUserRole::TRoleTypes AccessFpCancelContentTabSheet;
    AccessFpCancelContentTabSheet.insert(TUserRole::OPERATOR);
    AccessFpCancelContentTabSheet.insert(TUserRole::ADMINISTRATOR);
    AccessFpCancelContentTabSheet.insert(TUserRole::VIEWER);
    AccessFpCancelContentTabSheet.insert(TUserRole::TESTER);

    // Реестр на возобновление содержимое
    TUserRole::TRoleTypes AccessFpReconnectContentTabSheet;
    AccessFpReconnectContentTabSheet.insert(TUserRole::OPERATOR);
    AccessFpReconnectContentTabSheet.insert(TUserRole::ADMINISTRATOR);
    AccessFpReconnectContentTabSheet.insert(TUserRole::VIEWER);
    AccessFpReconnectContentTabSheet.insert(TUserRole::TESTER);

    // Реестр на отзыв ограничения
    TUserRole::TRoleTypes AccessPackRefuseStopTabSheet;
    AccessPackRefuseStopTabSheet.insert(TUserRole::OPERATOR);
    AccessPackRefuseStopTabSheet.insert(TUserRole::ADMINISTRATOR);
    AccessPackRefuseStopTabSheet.insert(TUserRole::VIEWER);
    AccessPackRefuseStopTabSheet.insert(TUserRole::TESTER);

    // Реестр на возобновление
    TUserRole::TRoleTypes AccessReconnectTabSheet;
    AccessReconnectTabSheet.insert(TUserRole::OPERATOR);
    AccessReconnectTabSheet.insert(TUserRole::ADMINISTRATOR);
    AccessReconnectTabSheet.insert(TUserRole::VIEWER);
    AccessReconnectTabSheet.insert(TUserRole::TESTER);

    //AccessPackReloadTabSheet<<TUserRole::APPROVER;
    //TUserRole::TRoleTypes AccessPackRefuseStopTabSheet;
    //AccessPackRefuseStopTabSheet<<TUserRole::OPERATOR;
    //AccessPackRefuseStopTabSheet<<TUserRole::ADMINISTRATOR;


    // Доступ к действиям
    //updateCcAction


    /* Присоединяем вкладки к списку режимов работы */
    TSheetEx* sheetTemp;

    /* Уведомления */
    TModeItem* item = modePageList.addTab("Уведомления" , MODE_NOTICES);

    /* Добавляем действия в общий список (для возможности скрыть все действия) */
    for (int i = 0; i < ActionList1->ActionCount; i++)
    {
        modePageList.addAction((TAction*)ActionList1->Actions[i]);
    }

    bool bRoleAdministrator = MainDataModule->userRole.find(TUserRole::ADMINISTRATOR) != MainDataModule->userRole.end();
    bool bRoleOperator = MainDataModule->userRole.find(TUserRole::OPERATOR) != MainDataModule->userRole.end();
    bool bRoleApprover = MainDataModule->userRole.find(TUserRole::APPROVER) != MainDataModule->userRole.end();
    bool bRoleTester = MainDataModule->userRole.find(TUserRole::TESTER) != MainDataModule->userRole.end();


    /* Настраиваем некоторые визуальные элементы */
    TestButton1->Visible = bRoleTester;

    /* Назначаем группы доступа на действия */
    printFaNoticeEnvelopeAction->Enabled = bRoleAdministrator || bRoleOperator;
    printDocumentFaNoticesAction->Enabled = bRoleAdministrator || bRoleOperator;
    printDocumentFaNoticesListAction->Enabled = bRoleAdministrator || bRoleOperator;
    printDocumentStopAction->Enabled = bRoleAdministrator || bRoleOperator || bRoleTester;
    printDocumentStopListAction->Enabled =  bRoleAdministrator || bRoleOperator;
    printDocumentFaNoticesListForPostOfficeAction->Enabled =  bRoleAdministrator || bRoleOperator;
    printCancelStopAction->Enabled =  bRoleAdministrator || bRoleOperator;
    printReconnectAction->Enabled =  bRoleAdministrator || bRoleOperator;

    createFaPackAction->Enabled = bRoleAdministrator || bRoleOperator;
    createFaPackPostAction->Enabled  = bRoleAdministrator || bRoleOperator;
    createFaPackStopAction->Enabled = bRoleAdministrator || bRoleOperator;
    createFaPackStopToControlAction->Enabled = bRoleAdministrator || bRoleOperator;
    createFpCancelStopAction->Enabled = bRoleAdministrator || bRoleOperator;    // Отмена заявки на ост. (вручную)
    approveFaPackCcDttmAction->Enabled = bRoleAdministrator || bRoleApprover;
    updateCcAction->Enabled = bRoleAdministrator || bRoleOperator;
    deleteFaPackAction->Enabled = bRoleAdministrator || bRoleTester;  // временное значение
    setFaPackStatusIncompleteAction->Enabled = bRoleAdministrator || bRoleTester;  // временное значение
    setFaPackStatusFrozenAction->Enabled = bRoleAdministrator || bRoleTester;
    setFaPackCancelStopStatusCompleteAction->Enabled = bRoleAdministrator || bRoleTester;


    // Главная вкладка в разделе Уведомления
    sheetTemp = item->addSheet(MainTabSheet);
    sheetTemp->accessible = isRoleAllowed(Access_MainTabSheet_Notices, MainDataModule->userRole);
    sheetTemp->packModeId = SHEET_TYPE_MAIN_NOTICES;


    // Вкладка списка должников
    sheetTemp = item->addSheet(DebtorsTabSheet);
    sheetTemp->setColor(RGB(255,255,255));
    sheetTemp->accessible = isRoleAllowed(Access_DebtorsTabSheet, MainDataModule->userRole);
    sheetTemp->packModeId = SHEET_TYPE_PRE_NOTICES_LIST;
    sheetTemp->addAction(createFaPackAction);
    sheetTemp->addAction(checkAllAction);
    sheetTemp->addAction(checkNoneAction);
    sheetTemp->addAction(checkWithoutCcAction);
    sheetTemp->addAction(checkWithCcLess3MonthAction);


    // Вкладка реестра должников
    sheetTemp = item->addSheet(PackManualTabSheet);
    sheetTemp->accessible = isRoleAllowed(Access_PackManualTabSheet, MainDataModule->userRole);
    sheetTemp->packModeId = SHEET_TYPE_FP_NOTICES_CONTENT;
    sheetTemp->addAction(printDocumentFaNoticesAction);
    sheetTemp->addAction(printDocumentFaNoticesListAction);
    sheetTemp->addAction(printDocumentFaNoticesListForPostOfficeAction);
    sheetTemp->addAction(checkAllAction);
    sheetTemp->addAction(checkNoneAction);
    sheetTemp->addAction(checkWithoutCcAction);
    sheetTemp->addAction(checkWithCcLess3MonthAction);


    // Вкладка утверждения вручения уведомления
    sheetTemp = item->addSheet(ApprovalListTabSheet);
    sheetTemp->accessible = isRoleAllowed(Access_ApprovalListTabSheet, MainDataModule->userRole);
    sheetTemp->packModeId = SHEET_TYPE_APPROVE_LIST;
    sheetTemp->addAction(checkAllAction);
    sheetTemp->addAction(checkNoneAction);
    sheetTemp->addAction(checkWithoutCcAction);
    sheetTemp->addAction(checkWithCcLess3MonthAction);
    sheetTemp->addAction(approveFaPackCcDttmAction);

    // Вкладка списка уведомлений на почту
    sheetTemp = item->addSheet(PostListTabSheet);
    sheetTemp->accessible = isRoleAllowed(Access_PostListTabSheet, MainDataModule->userRole);
    sheetTemp->packModeId = SHEET_TYPE_PRE_POST_LIST;
    //sheetTemp->addAction(createFaPackAction);
    sheetTemp->addAction(createFaPackPostAction);
    sheetTemp->addAction(checkAllAction);
    sheetTemp->addAction(checkNoneAction);
    sheetTemp->addAction(checkWithoutCcAction);
    sheetTemp->addAction(checkWithCcLess3MonthAction);
    sheetTemp->addAction(printFaNoticeEnvelopeAction);

    // Вкладка списка Все абоненты
    sheetTemp = item->addSheet(FullListTabSheet);
    sheetTemp->accessible = isRoleAllowed(Access_FullListTabSheet, MainDataModule->userRole);
    sheetTemp->packModeId = SHEET_TYPE_FULL_LIST;
    //sheetTemp->addAction(createFaPackAction);
    sheetTemp->addAction(checkAllAction);
    sheetTemp->addAction(checkNoneAction);
    sheetTemp->addAction(checkWithoutCcAction);
    sheetTemp->addAction(checkWithCcLess3MonthAction);
    //sheetTemp->addAction(createFaPackFree);

    
    /* Заявки на отключение */
    item = modePageList.addTab("Заявки на отключение", MODE_STOP);
    //item.sheets.clear();
    //item.caption = "Заявки на отключение";
    //item.mode = MODE_STOP;

    // Главная вкладка в разделе Уведомления
    sheetTemp = item->addSheet(MainTabSheet);
    sheetTemp->accessible = isRoleAllowed(Access_MainTabSheet_Stop, MainDataModule->userRole);
    sheetTemp->packModeId = SHEET_TYPE_MAIN_NOTICES;

    // Список кандидатов на ограничение
    sheetTemp = item->addSheet(StopListTabSheet);
    sheetTemp->accessible = isRoleAllowed(AccessStopListTabSheet, MainDataModule->userRole);
    sheetTemp->packModeId = SHEET_TYPE_PRE_STOP_LIST;
    sheetTemp->addAction(checkAllAction);
    sheetTemp->addAction(checkNoneAction);
    sheetTemp->addAction(checkWithoutCcAction);
    sheetTemp->addAction(checkWithCcLess3MonthAction);
    sheetTemp->addAction(createFaPackStopAction);
    sheetTemp->addAction(createFaPackStopToControlAction);

    // Список реестров на ограничение
    sheetTemp = item->addSheet(PackStopListTabSheet);
    sheetTemp->accessible = isRoleAllowed(AccessPackStopListTabSheet, MainDataModule->userRole);
    sheetTemp->packModeId = SHEET_TYPE_FP_STOP_LIST;
    sheetTemp->addAction(checkAllAction);
    sheetTemp->addAction(checkNoneAction);
    sheetTemp->addAction(checkWithoutCcAction);
    sheetTemp->addAction(checkWithCcLess3MonthAction);
    sheetTemp->addAction(printDocumentStopAction);
    sheetTemp->addAction(printDocumentStopListAction);
    sheetTemp->addAction(deleteFaPackAction);
    sheetTemp->addAction(setFaPackStatusIncompleteAction);
    sheetTemp->addAction(setFaPackStatusFrozenAction);


    // Содержимое реестра на ограничение
    sheetTemp = item->addSheet(PackStopTabSheet);
    sheetTemp->accessible = isRoleAllowed(AccessPackStopTabSheet, MainDataModule->userRole);
    sheetTemp->packModeId = SHEET_TYPE_FP_STOP_CONTENT;
    sheetTemp->addAction(checkAllAction);
    sheetTemp->addAction(checkNoneAction);
    sheetTemp->addAction(checkWithoutCcAction);
    sheetTemp->addAction(checkWithCcLess3MonthAction);
    sheetTemp->addAction(createFpCancelStopAction);

    // Содержимое реестра на отмену
    sheetTemp = item->addSheet(FpCancelContentTabSheet);
    sheetTemp->accessible = isRoleAllowed(AccessFpCancelContentTabSheet, MainDataModule->userRole);
    sheetTemp->packModeId = SHEET_TYPE_FP_CANCEL_CONTENT;
    sheetTemp->addAction(checkAllAction);
    sheetTemp->addAction(checkNoneAction);
    sheetTemp->addAction(checkWithoutCcAction);
    sheetTemp->addAction(checkWithCcLess3MonthAction);

    // Содержимое реестра на возобновление
    sheetTemp = item->addSheet(FpReconnectContentTabSheet);
    sheetTemp->accessible = isRoleAllowed(AccessFpReconnectContentTabSheet, MainDataModule->userRole);
    sheetTemp->packModeId = SHEET_TYPE_FP_RECONNECT_CONTENT;
    sheetTemp->addAction(checkAllAction);
    sheetTemp->addAction(checkNoneAction);
    sheetTemp->addAction(checkWithoutCcAction);
    sheetTemp->addAction(checkWithCcLess3MonthAction);



    // Реестр на отмену
    /*sheetTemp = item->addSheet(FpCancelContentTabSheet);
    sheetTemp->accessible = isRoleAllowed(AccessFpCancelContentTabSheet, MainDataModule->userRole);
    sheetTemp->packModeId = SHEET_TYPE_FP_STOP_CONTENT;
    sheetTemp->addAction(checkAllAction);
    sheetTemp->addAction(checkNoneAction);
    sheetTemp->addAction(checkWithoutCcAction);
    sheetTemp->addAction(checkWithCcLess3MonthAction);
    //sheetTemp->addAction(createFpCancelStopAction);



    // Реестр на возобновление
    sheetTemp = item->addSheet(FpReconnectContentTabSheet);
    sheetTemp->accessible = isRoleAllowed(AccessFpReconnectContentTabSheet, MainDataModule->userRole);
    sheetTemp->packModeId = SHEET_TYPE_FP_RECONNECT_CONTENT;
    sheetTemp->addAction(checkAllAction);
    sheetTemp->addAction(checkNoneAction);
    sheetTemp->addAction(checkWithoutCcAction);
    sheetTemp->addAction(checkWithCcLess3MonthAction); */
    //sheetTemp->addAction(createFpCancelStopAction);







    // Список на отзыв заявки на ограничение
    sheetTemp = item->addSheet(FaCancelStopListTabSheet);
    sheetTemp->accessible = isRoleAllowed(AccessPackRefuseStopTabSheet, MainDataModule->userRole);
    sheetTemp->packModeId = SHEET_TYPE_FP_CANCEL_LIST;
    sheetTemp->addAction(checkAllAction);
    sheetTemp->addAction(checkNoneAction);
    sheetTemp->addAction(printCancelStopAction);
    sheetTemp->addAction(setFaPackCancelStopStatusCompleteAction); // Установить статус Отправлен исполнителю

    // Список на возобновление
    sheetTemp = item->addSheet(PackReconnectTabSheet);
    sheetTemp->accessible = isRoleAllowed(AccessReconnectTabSheet, MainDataModule->userRole);
    sheetTemp->packModeId = SHEET_TYPE_FP_RECONNECT_LIST;
    sheetTemp->addAction(checkAllAction);
    sheetTemp->addAction(checkNoneAction);
    sheetTemp->addAction(printReconnectAction);
    //sheetTemp->addAction(setFaPackReconnectCompleteAction); // Установить статус Отправлен исполнителю

    //sheetTemp->addAction(checkWithoutCcAction);
    //sheetTemp->addAction(checkWithCcLess3MonthAction);



    /*item.sheets.push_back( TSheetEx(StopListTabSheet, !(AccessStopListTabSheet * MainDataModule->userRole).Empty()) );
    item.sheets.push_back( TSheetEx(PackStopTabSheet, !(AccessPackStopTabSheet * MainDataModule->userRole).Empty()) );
    item.sheets.push_back( TSheetEx(PackRefuseStopTabSheet, !(AccessPackRefuseStopTabSheet * MainDataModule->userRole).Empty()) );
    item.sheets.push_back( TSheetEx(PackReloadTabSheet, !(AccessPackReloadTabSheet * MainDataModule->userRole).Empty()) );
    */

    //_modeList.push_back(item);


    //SelectModeComboBox->Items->AddObject(item->caption, (TObject*)item);
    //SelectModeComboBox->Items->AddObject(item.caption, (TObject*)item);

    // modePageList - список всех режимов
    // _modeList - список вкладок, присоединенных к режиму
    /*TSheetEx* s1 = modePageList._modeList[0]->getSheetByType(SHEET_TYPE_NOTICES_PACK);
    TSheetEx* s2 = modePageList._modeList[0]->getSheetByType(SHEET_TYPE_MAIN_NOTICES);
    bool b1 = s1->accessible;
    bool b2 = s2->accessible;*/
    //SHEET_TYPE_NOTICES_PACK

    // Заполняем контрол со списком режимов
    for (std::vector<TModeItem*>::iterator it = modePageList._modeList.begin(); it != modePageList._modeList.end(); it++ )
    {
        for (std::vector<TSheetEx>::iterator sheet= (*it)->sheets.begin(); sheet != (*it)->sheets.end(); sheet++)
        {
            if ( sheet->accessible )
            {
                SelectModeComboBox->Items->AddObject((*it)->caption, (TObject*)(*it));
                break;
            }

        }
    }
}

/**/
void __fastcall TFieldActivityForm::PackPageControlDrawTab(
      TCustomTabControl *Control, int TabIndex, const TRect &Rect,
      bool Active)
{
    //TPageControl *pageControl = static_cast <TTabControl *> (Control);
    TCanvas *canvas = Control->Canvas;
    // Текст, который будем выводить на вкладке

    int pageIndex = HackCtrl::PageIndexFromTabIndex(((TPageControl*)Control), TabIndex);

    AnsiString tabCaption = ((TPageControl*)Control)->Pages[pageIndex]->Caption;

    // РИСОВАНИЕ
    canvas->Lock();    // Блокирум канвас перед рисованием
    //canvas->TextRect(Rect, Rect.Left+3, Rect.Top+3, tabCaption);

    //if (PackPageControl->ActivePage->TabIndex == TabIndex)
    {
        canvas->Brush->Color = _colorList.getColorByIndex(pageIndex);
        canvas->FillRect(TRect(Rect.Left, Rect.Top + Rect.Height()-3, Rect.Left + Rect.Width(), Rect.Top + Rect.Height()));
    }

    canvas->Brush->Color = clBtnFace;
    canvas->Font->Color = static_cast<TColor>(RGB(0,0,0));    // Цвет шрифта
    canvas->TextOutA(Rect.Left+3, Rect.Top+3, tabCaption);
    canvas->Unlock();
}

/* Отображение формы */
void __fastcall TFieldActivityForm::FormShow(TObject *Sender)
{
    this->WindowState = wsMaximized;
    this->UpdateWindowState();
    refreshFilterControls();

    // Добавлено после выявления некорректности отображения формы
    // при увеличенном масштабе текста
    PackPageControl->Align = alNone;
    PackPageControl->Align = alClient;


    RichEdit1->Text = MainDataModule->getFaPackStats();
}


/* Выполняется при завешении процедуры получения данных */
void __fastcall TFieldActivityForm::OnThreadEnd(TObject *Sender)
{
    WaitForm->StopWait();
    refreshCheckedCount();
}

/* Выполняется в начале процедуры получения данных */
void __fastcall TFieldActivityForm::OnThreadBegin(TObject *Sender)
{
    WaitForm->Execute();
}

/* Отображает список должников
   Возможно следует удалить эту функцию
*/
void __fastcall TFieldActivityForm::showFullList()
{
    MainDataModule->getAcctFullList();
    modePageList.setCurrentSheet(SHEET_TYPE_FULL_LIST);
    setCurPackMode();
}

/* Смена режима работы программы */
void __fastcall TFieldActivityForm::SelectModeComboBoxChange(
      TObject *Sender)
{
    setMode(SelectModeComboBox->ItemIndex);
}

/* Задает текущее отделение
*/
/*void __fastcall TFieldActivityForm::setCurOtdelen(const String& otdelen, bool resetPack)
{
    MainDataModule->setAcctOtdelen(otdelen);
    //_curPackId = "";
}  */


/* Задает текущее Pack_id
*/
/*void __fastcall TFieldActivityForm::setCurPackId(const String& faPackId)
{
    //_curPackId = faPackId;
}  */


/* Задает текущий режим
*/
void __fastcall TFieldActivityForm::setCurPackMode()
{
    // Устанавливаем нулевые значения
    ParamPackIdEdit->Text = "";
    _currentFilter = NULL;
    _currentDbGrid = NULL;

    // Устанавливаем значения в зависимости от выбранного режима
    switch(modePageList._currentMode->currentSheet->packModeId)
    {
    default:
    {
        break;
    }
    case SHEET_TYPE_MAIN_NOTICES:
    {
        break;
    }
    case SHEET_TYPE_FULL_LIST:
    {

        _currentFilter = MainDataModule->getAcctFullListFilter;
        _currentDbGrid = FullListGrid;

        break;
    }

    case SHEET_TYPE_PRE_NOTICES_LIST:
    {

        _currentFilter = MainDataModule->getPreDebtorListFilter;
        _currentDbGrid = DBGridAltGeneral;

        break;
    }
    case SHEET_TYPE_FP_NOTICES_CONTENT:    // Реестр уведомлений
    {
        ParamPackIdEdit->Text = MainDataModule->getFpNoticesId();

        _currentFilter = MainDataModule->getFpNoticesContentFilter;
        _currentDbGrid = DBGridAltManual;

        break;
    }
    case SHEET_TYPE_APPROVE_LIST:
    {
        _currentFilter = MainDataModule->getApprovalListFilter;
        _currentDbGrid = ApproveListGrid;

        break;
    }
    case SHEET_TYPE_PRE_POST_LIST:
    {                        // Список на почту
        _currentFilter = MainDataModule->getPrePostListFilter;
        _currentDbGrid = PostListGrid;

        break;
    }
    case SHEET_TYPE_PRE_STOP_LIST:
    {
        _currentFilter = MainDataModule->getPreStopListFilter;
        _currentDbGrid = StopListGrid;

        break;
    }
    case SHEET_TYPE_FP_STOP_CONTENT:
    {
        ParamPackIdEdit->Text = MainDataModule->getFpStopId();
        _currentFilter = MainDataModule->getFpStopContentFilter;
        _currentDbGrid = FpStopContentGrid;

        break;
    }
    case SHEET_TYPE_FP_CANCEL_CONTENT:
    {
        ParamPackIdEdit->Text = MainDataModule->getFpCancelId();
        _currentFilter = MainDataModule->getFpCancelContentFilter;
        _currentDbGrid = FpCancelContentGrid;

        break;
    }
    case SHEET_TYPE_FP_RECONNECT_CONTENT:
    {
        ParamPackIdEdit->Text = MainDataModule->getFpReconnectId();
        _currentFilter = MainDataModule->getFpReconnectContentFilter;
        _currentDbGrid = FpReconnectContentGrid;

        break;
    }
    case SHEET_TYPE_FP_STOP_LIST:         // Реестр на остановку
    {
        _currentFilter = MainDataModule->getFpStopListFilter;
        _currentDbGrid = PackStopListGrid;
        break;
    }
    case SHEET_TYPE_FP_CANCEL_LIST:   // Список реестров на отмену остановки
    {
        _currentFilter = MainDataModule->getFpCancelListFilter;
        _currentDbGrid = CancelStopListGrid;
        break;
    }
    case SHEET_TYPE_FP_RECONNECT_LIST:   // Список реестров на возобновление
    {
        _currentFilter = MainDataModule->getReconnectListFilter;
        _currentDbGrid = ReconnectListGrid;
        break;
    }
    }

    refreshFilterControls();    // Обновляем состояние элементов управления для фильтров

    refreshCheckedCount();      // Обновляем статистику по выбранным элементам

    refreshPopupMenu();
}

/* Универсальный фильтр для TComboBox
*/
void __fastcall TFieldActivityForm::FilterComboBoxTextChange(TObject *Sender)
{
    TComboBox* comboBox = static_cast<TComboBox*>(Sender);
    MainDataModule->setFilterParamValue(_currentFilter, comboBox->Name, "param", comboBox->Text);
}

/* Универсальный фильтр для TEdit
*/
void __fastcall TFieldActivityForm::FilterEditTextChange(TObject *Sender)
{
    TEdit* editBox = static_cast<TEdit*>(Sender);
    MainDataModule->setFilterParamValue(_currentFilter, editBox->Name, "param", editBox->Text);
}

/* Универсальный фильтр для TCheckBox
*/
void __fastcall TFieldActivityForm::FilterCheckBoxChange(
      TObject *Sender)
{
    //
    TCheckBox* checkBox = static_cast<TCheckBox*>(Sender);
    MainDataModule->setFilterParamValue(_currentFilter, checkBox->Name, "param", checkBox->Checked? " " : "");
}

/* Универсальный фильтр для TComboBox по ItemIndex */
void __fastcall TFieldActivityForm::FilterComboBoxIndexChange(
      TObject *Sender)
{
    TComboBox* comboBox = static_cast<TComboBox*>(Sender);
    MainDataModule->setFilterParamValue(_currentFilter, comboBox->Name, "param", IntToStr(comboBox->ItemIndex)); 
}

/* Сложный фильтр с датами контакта ComboBox */
void __fastcall TFieldActivityForm::CcDttmStatusComboBoxChange(
      TObject *Sender)
{
    TComboBox* comboBox = static_cast<TComboBox*>(Sender);
    MainDataModule->setFilterParamValue(_currentFilter, comboBox->Name, "param", IntToStr(comboBox->ItemIndex));

    ccDttmPeriodPanel->Visible = comboBox->ItemIndex == 3;
}

/* Сложный фильтр с датами контакта DateTimePicker */
void __fastcall TFieldActivityForm::FilterCcDttmChange(TObject *Sender)
{

    String beginDt = DateToStr(DateTimePicker1->Date);
    String endDt = DateToStr(DateTimePicker2->Date);
    _currentFilter->setValue("CcDttmStatusComboBox", "begin_dt", beginDt);
    _currentFilter->setValue("CcDttmStatusComboBox", "end_dt", endDt);
}

/* Обновляет статистику по выделенным элементам в dbgrid */
void __fastcall TFieldActivityForm::refreshCheckedCount()
{
    if ( _currentDbGrid != NULL )
    {
        SelectAllCheckBox->Enabled = true;
        ShowSelectAcctMenuButton->Enabled = true;
        SummaryInfoGroupBox->Visible = true;

        TSumResult checkedResult = _currentDbGrid->getSum("", "CHECK_DATA = 1", false);         // Без учета фильтра
        TSumResult recordResult = _currentDbGrid->getSum("", "", false);                        // Без учета фильтра
        TSumResult recordFilteredResult = _currentDbGrid->getSum("", "", true);                 // С учетом фильтра
        TSumResult checkedFilteredResult = _currentDbGrid->getSum("", "CHECK_DATA = 1", true);  // С учетом фильтра

        _checkedCount = checkedResult.first;
        _recordCount = recordResult.first;

        int checkedFilteredCount = checkedFilteredResult.first;
        int recordFilteredCount = recordFilteredResult.first;

        CheckedCountStatLabel->Caption = IntToStr(_checkedCount);
        CheckedFilteredCountLabel->Caption = IntToStr(checkedFilteredCount);
        FilteredStatLabel->Caption = IntToStr(recordFilteredResult.first);
        TotalStatLabel->Caption = IntToStr(recordResult.first);


        // Состояние CheckBox для выделения записей
        TNotifyEvent old_OnClick = SelectAllCheckBox->OnClick;
        SelectAllCheckBox->OnClick = NULL;
        if (recordFilteredCount > 0)
        {
            if (checkedFilteredCount == recordFilteredCount)
            {
                SelectAllCheckBox->State = cbChecked;
            }
            else if (checkedFilteredCount > 0)
            {
                SelectAllCheckBox->State = cbGrayed;
            }
            else
            {
                SelectAllCheckBox->State = cbUnchecked;
            }
        }
        else
        {
            SelectAllCheckBox->State = cbUnchecked;
        }
        SelectAllCheckBox->OnClick = old_OnClick;
    }
    else
    {
        ShowSelectAcctMenuButton->Enabled = false;
        SelectAllCheckBox->Enabled = false;
        SelectAllCheckBox->State = cbUnchecked;
        SummaryInfoGroupBox->Visible = false;
    }
}

/* Отображает форму для выбора реестра  */
void __fastcall TFieldActivityForm::ParamPackIdEditClick(TObject *Sender)
{
    TSelectFaPackForm::TMode mode;

    switch(modePageList._currentMode->mode)
    {
    case MODE_NOTICES:
    {
        if (!modePageList._currentMode->getSheetByType(SHEET_TYPE_FP_NOTICES_CONTENT)->accessible)    // ДОДЕЛАТЬ. ПЕРЕНЕСТИ ЭТОТ КОД В ОБНОВЛЕНИЕ ИНТЕРФЕЙСА П
        {
            return;
        }

        mode = TSelectFaPackForm::TM_NOTICES;
        break;
    }
    case MODE_STOP:
    {
        if (!modePageList._currentMode->getSheetByType(SHEET_TYPE_FP_STOP_CONTENT)->accessible)
        {
            return;
        }
        mode = TSelectFaPackForm::TM_STOP;
        break;
    }
    }

    if ( SelectFaPackForm->execute(MainDataModule->getAcctOtdelen(), mode) )
    {

        String faPackId = SelectFaPackForm->getFaPackId();
        TFaPackTypeCd faPackTypeCd = SelectFaPackForm->getFaPackTypeCd();
        switch(modePageList._currentMode->mode)
        {
        case MODE_NOTICES:
        {
            showFaPackNotices(faPackId);
            break;
        }
        case MODE_STOP:
        {
            switch (faPackTypeCd)
            {
            case FPT_STOP:
            {
                showFpStopContent(faPackId);
                break;
            }
            case FPT_CANCEL:
            {
                showFpCancelContent(faPackId);
                break;
            }
            case FPT_RECONNECT:
            {
                showFpReconnectContent(faPackId);
                break;
            }
            }

            break;
        }
        }
    }
}

/*  */
void __fastcall TFieldActivityForm::ParamPackIdEditKeyPress(
      TObject *Sender, char &Key)
{
    Key = '\0';
    ParamPackIdEditClick(Sender);
}

/* Отображает Popup-меню в позиции по отношению к позиции control
   В будущем перенести функцию в отдельную библиотеку
*/
void __fastcall TFieldActivityForm::showPopupSubMenu(TWinControl *control, TPopupMenu* menu)
{
    TPoint p = control->ClientOrigin;
    menu->Popup(p.x, p.y + control->Height);
}

/* Отображает меню выбора пунктов - нажатие клавиши (на клавиатуре)*/
void __fastcall TFieldActivityForm::ShowSelectAcctMenuButtonKeyPress(
      TObject *Sender, char &Key)
{
    showPopupSubMenu(dynamic_cast<TWinControl*>(SelectAcctPopupMenuPanel), SelectAcctPopupMenu);
}

/* Отображает меню выбора пунктов - нажатие кнопки (на форме) */
void __fastcall TFieldActivityForm::ShowSelectAcctMenuButtonMouseDown(
      TObject *Sender, TMouseButton Button, TShiftState Shift, int X,
      int Y)
{
    showPopupSubMenu(dynamic_cast<TWinControl*>(SelectAcctPopupMenuPanel), SelectAcctPopupMenu);
}

/* Отображает меню выбора документа - нажатие кнопки (на форме) */
void __fastcall TFieldActivityForm::ShowDocumentsMenuButtonMouseDown(TObject *Sender,
      TMouseButton Button, TShiftState Shift, int X, int Y)
{
    showPopupSubMenu(dynamic_cast<TWinControl*>(Sender), DocumentsPopupMenu);
}

/* Отображает меню выбора действия - нажатие кнопки (на форме) */
void __fastcall TFieldActivityForm::ShowActionsMenuButtonMouseDown(TObject *Sender,
      TMouseButton Button, TShiftState Shift, int X, int Y)
{
    showPopupSubMenu(dynamic_cast<TWinControl*>(Sender), ActionsPopupMenu);
}

/* Сбрасывает значение фильтра на значение по умолчанию */
void __fastcall TFieldActivityForm::ResetFiltersButtonClick(
      TObject *Sender)
{
    _currentFilter->clearAllValues();
    refreshFilterControls();
}

/* Обновляет состояние элементов управления, связанных с выбором текущего участка, реестра и тп. */
void __fastcall TFieldActivityForm::refreshParametersControls()
{
    OtdelenComboBox->KeyValue = MainDataModule->getAcctOtdelen();

    switch(modePageList._currentMode->mode)
    {
    case MODE_NOTICES:
    {
        FaPackIdParamPanel->Visible = modePageList._currentMode->getSheetByType(SHEET_TYPE_FP_NOTICES_CONTENT)->accessible;
        /*if (!modePageList._currentMode->getSheetByType(SHEET_TYPE_NOTICES_PACK)->accessible)    // ДОДЕЛАТЬ. ПЕРЕНЕСТИ ЭТОТ КОД В ОБНОВЛЕНИЕ ИНТЕРФЕЙСА П
        {
            return;
        } */
        break;
    }
    case MODE_STOP:
    {
        ParamPackIdEdit->Visible = modePageList._currentMode->getSheetByType(SHEET_TYPE_FP_STOP_CONTENT)->accessible;
        /*if (!modePageList._currentMode->getSheetByType(SHEET_TYPE_STOP_PACK)->accessible)
        {
            return;
        }
        mode = TSelectFaPackForm::TM_STOP;  */
        break;
    }
    }



}

void __fastcall TFieldActivityForm::refreshActionsStates()
{
    //
}

/**/
void __fastcall TFieldActivityForm::refreshFilterControls()
{
    __try
    {
        //Perform(WM_SETREDRAW, 0, 0);
        //SendMessage(FilterGroupBox->Handle, WM_SETREDRAW, 0, 0);
        SendMessage(this->Handle, WM_SETREDRAW, 0, 0);

        // Видимость
        if ( _currentFilter != NULL)
        {
            ccDttmIsApprovedFilterPanel->Visible = _currentFilter->isFilterExists(ApprovedStatusComboBox->Name);
            CcDttmExistsFilterPanel->Visible = _currentFilter->isFilterExists(CcDttmStatusComboBox->Name);
            FaPackIdFilterPanel->Visible = _currentFilter->isFilterExists(FaPackIdFilterEdit->Name);
            OpAreaDescrFilterPanel->Visible = _currentFilter->isFilterExists(OpAreaDescrFilterComboBox->Name);
            SaldoFilterPanel->Visible = _currentFilter->isFilterExists(SaldoFilterEdit->Name);
            ServiceCompanyFilterPanel->Visible = _currentFilter->isFilterExists(ServiceCompanyFilterComboBox->Name);
            FioFilterPanel->Visible = _currentFilter->isFilterExists(FioComboBox->Name);
            AddressFilterPanel->Visible = _currentFilter->isFilterExists(AddressComboBox->Name);
            CityFilterPanel->Visible = _currentFilter->isFilterExists(CityComboBox->Name);
            AcctIdFilterPanel->Visible = _currentFilter->isFilterExists(AcctIdComboBox->Name);
            PremTypeFilterPanel->Visible = _currentFilter->isFilterExists(PremTypeComboBox->Name);
            FaPackTypeFilterPanel->Visible = _currentFilter->isFilterExists(FaPackTypeFilterComboBox->Name);
            MrRteCdFilterPanel->Visible = _currentFilter->isFilterExists(MrRteCdFilterComboBox->Name);
            FaPackStatusFilterPanel->Visible = _currentFilter->isFilterExists(FaPackStatusFilterComboBox->Name);
        }
        else
        {
            ccDttmIsApprovedFilterPanel->Visible = false;
            CcDttmExistsFilterPanel->Visible = false;
            FaPackIdFilterPanel->Visible = false;
            OpAreaDescrFilterPanel->Visible = false;
            SaldoFilterPanel->Visible = false;
            ServiceCompanyFilterPanel->Visible = false;
            FioFilterPanel->Visible = false;
            AddressFilterPanel->Visible = false;
            CityFilterPanel->Visible = false;
            AcctIdFilterPanel->Visible = false;
            PremTypeFilterPanel->Visible = false;
            FaPackTypeFilterPanel->Visible = false;
            MrRteCdFilterPanel->Visible = false;
            FaPackStatusFilterPanel->Visible = false;
        }

        // Порядок панелей
        FilterGroupBox->Height = 800;
        HackCtrl::RealignControls(FilterGroupBox);
        if (RstButtonFilterPanel->Top == 15)
        {
            FilterGroupBox->Visible = false;
            //RstButtonFilterPanel->Caption = "В данном режиме фильтр не предусмотрен";
            //ResetFiltersButton->Visible = false;
        }
        else
        {
            FilterGroupBox->Visible = true;
            //RstButtonFilterPanel->Caption = "";
            //ResetFiltersButton->Visible = true;
        }
        FilterGroupBox->Height = RstButtonFilterPanel->Top + RstButtonFilterPanel->Height + 2;


        // Восстановление значений
        if (_currentFilter != NULL)
        {
            AcctIdComboBox->Text = _currentFilter->getValue(AcctIdComboBox->Name, "param");
            CityComboBox->Text = _currentFilter->getValue(CityComboBox->Name, "param");
            AddressComboBox->Text = _currentFilter->getValue(AddressComboBox->Name, "param");
            FioComboBox->Text = _currentFilter->getValue(FioComboBox->Name, "param");
            FaPackIdFilterEdit->Text = _currentFilter->getValue(FaPackIdFilterEdit->Name, "param");
            ServiceCompanyFilterComboBox->Text = _currentFilter->getValue(ServiceCompanyFilterComboBox->Name, "param");
            SaldoFilterEdit->Text = _currentFilter->getValue(SaldoFilterEdit->Name, "param");
            OpAreaDescrFilterComboBox->Text = _currentFilter->getValue(OpAreaDescrFilterComboBox->Name, "param");


            // Фильтр по дате утверждения
            if (_currentFilter->isFilterExists(ApprovedStatusComboBox->Name))
            {
                ApprovedStatusComboBox->ItemIndex = StrToInt( _currentFilter->getValue(ApprovedStatusComboBox->Name, "param") );
            }

            // Фильтр по типу реестра
            if (_currentFilter->isFilterExists(FaPackStatusFilterComboBox->Name))
            {
                FaPackStatusFilterComboBox->ItemIndex = StrToInt( _currentFilter->getValue(FaPackStatusFilterComboBox->Name, "param") );
            }

            // Фильтр по дате контакта
            if ( _currentFilter->isFilterExists(CcDttmStatusComboBox->Name) )
            {
                // Восстановление значений сложного фильтра с датами
                CcDttmStatusComboBox->ItemIndex = StrToInt( _currentFilter->getValue(CcDttmStatusComboBox->Name, "param") );
                DateTimePicker1->Date = _currentFilter->getValue(CcDttmStatusComboBox->Name, "begin_dt");
                DateTimePicker2->Date = _currentFilter->getValue(CcDttmStatusComboBox->Name, "end_dt");
                // Отображение/скрытие контролов для установки диапазона
                ccDttmPeriodPanel->Visible = CcDttmStatusComboBox->ItemIndex == 3;        
            }
        }
    }
    __finally
    {
        SendMessage(this->Handle, WM_SETREDRAW, 1, 0);
        RedrawWindow(this->Handle, NULL, 0, RDW_ALLCHILDREN + RDW_INVALIDATE + RDW_FRAME + RDW_ERASE);
    }
}

/* Обновляет состояние элементов управления связанных с меню */
void __fastcall TFieldActivityForm::refreshPopupMenu()
{
    ShowActionsMenuButton->Enabled = popupmenutools::PopupMenuVisibleConsists(ActionsPopupMenu);
    ShowDocumentsMenuButton->Enabled = popupmenutools::PopupMenuVisibleConsists(DocumentsPopupMenu);
    
}

/* Реакция на выбор учатка из списка ComboBox */
void __fastcall TFieldActivityForm::OtdelenComboBoxClick(TObject *Sender)
{
    switch(modePageList._currentMode->currentSheet->packModeId)
    {
    case SHEET_TYPE_PRE_NOTICES_LIST:
    {
        showPreDebtorList();
        break;
    }
    case SHEET_TYPE_PRE_STOP_LIST:
    {
        showStopList();
        break;
    }
    case SHEET_TYPE_FP_STOP_LIST:
    {
        showPackStopList();
        break;
    }
    default:
    {
        showMainTabSheet();
    }
    }
}

/**/
void __fastcall TFieldActivityForm::OtdelenBoxChange(TObject *Sender)
{
    //MainDataModule->getAcctOtdelen()
    //_curOtdelen = MainDataModule->otdelenList.getValue(OtdelenComboBox);
    //refreshData();
}

/**/
void __fastcall TFieldActivityForm::printDocumentFaNoticesActionExecute(
      TObject *Sender)
{
    //DocumentDataModule->getDocumentFaNotices(_currentFilter);
    if (DocumentDataModule->getDocumentFaNotices(MainDataModule->getOtdelenListFilter, MainDataModule->getFaPackInfoFilter, MainDataModule->getFpNoticesContentFilter) )
    {
        MessageBoxInf("Уведомления сформированы.");
    }
}


/**/
void __fastcall TFieldActivityForm::printDocumentFaNoticesListActionExecute(TObject *Sender)
{
    DocumentDataModule->getDocumentFaNoticesList(_currentFilter);
    MessageBoxInf("Список уведомлений сформирован.");
}

/* Создать реестр уведомлений контролеру */
void __fastcall TFieldActivityForm::createFaPackActionExecute(TObject *Sender)
{

    String faPackId = MainDataModule->createFpNotice(FPT_MANUAL);
    if (faPackId != "" )
    {
        WaitForm->Execute(2);
        //String faPackId = MainDataModule->createPack(_currentFilter, TPackTypeCd::PACK_MANUAL, MainDataModule->getAcctOtdelen());
        showFaPackNotices(faPackId);
        MainDataModule->closePreDebtorList();
        //MessageBoxInf("Создан реестр с номером " + faPackId + ".\nНе забудьте ввести даты контактов.");
        WaitForm->StopWait();
    }
    else
    {
        MessageBoxStop("Не удалось создать реестр!\nОбратитесь к системному администратору.");
    }
}

/* Выделить с датой контакта более 3 месяцев*/
void __fastcall TFieldActivityForm::checkWithCcLess3MonthActionExecute(
      TObject *Sender)
{
    MainDataModule->selectCcDttmMoreThanThree(_currentFilter);
}

/* Выделить без даты контакта*/
void __fastcall TFieldActivityForm::checkWithoutCcActionExecute(
      TObject *Sender)
{
    MainDataModule->selectCcDttmIsNull(_currentFilter);
}

/* Пометить отфильтрованные */
void __fastcall TFieldActivityForm::checkAllActionExecute(TObject *Sender)
{
    if (_currentDbGrid != NULL)
    {
        _currentDbGrid->setCheckFiltered(true);
    }
}

/* Снять пометки */
void __fastcall TFieldActivityForm::checkNoneActionExecute(TObject *Sender)
{
    if (_currentDbGrid != NULL)
    {
        _currentDbGrid->setCheckFiltered(false);
    }
}

/* Отображает окно создания/редактирования контакта */
void __fastcall TFieldActivityForm::DBGridAltManualCellClick(
      TColumn *Column)
{
    if (Column->FieldName == "CC_DTTM")
    {
        updateCcAction->Execute();
    }
}

/* Задает текущий режим работы программы */
void __fastcall TFieldActivityForm::setMode(int index)
{
    PackPageControl->Visible = false; // В будущем попробовать с отключением OnChange

    // Отображаем только вкладки активного режима и доступные текущему пользователю по его роли

    if (index < SelectModeComboBox->Items->Count )
    {
        modePageList.setMode((TModeItem*)SelectModeComboBox->Items->Objects[index]);
    }
    else
    {
        throw Exception("Out of index");
    }

    PackPageControl->Visible = true;
}

/* Создать реестр заявок на ограничение*/
void __fastcall TFieldActivityForm::createFaPackStopActionExecute(
      TObject *Sender)
{
    bool result = false;
    if (MessageBoxQuestion("Будут созданы новые реестры. Продолжить?") == IDYES)
    {
        result = MainDataModule->createPackStop(Sender != createFaPackStopAction);   // Использовать признак группировки (может быть создано несколько реестров)
    }

    /*if ( Sender == createFaPackStopAction)
    {
        result = MainDataModule->createPackStop(false);   // Использовать признак группировки (может быть создано несколько реестров)
    }
    else
    {
        result = MainDataModule->createPackStop(true);   // Без использования признака группировки по разным реестрам (будет создан один реестр)
    }*/

    if (result)
    {
        MainDataModule->closeFaPackStopList();    // Так как необходимо обновить список реестров
        MainDataModule->closeStopList();        // Так как необходимо обновить список на ограничение

        showPackStopList();
    }
}

/* Выделение элементов с помощью CheckBox */
void __fastcall TFieldActivityForm::SelectAllCheckBoxClick(TObject *Sender)
{
    switch( ((TCheckBox*)Sender)->State )
    {
    case cbChecked:
    case cbGrayed:
    {
        checkAllAction->Execute();
        break;
    }
    case cbUnchecked:
    {
        checkNoneAction->Execute();
        break;
    }
    }
}

/**/
void __fastcall TFieldActivityForm::OnQueryAfterExecute(TObject *Sender)
{
    //
}

/**/
void __fastcall TFieldActivityForm::checkAllActionUpdate(TObject *Sender)
{
    static_cast<TAction*>(Sender)->Enabled = _recordCount > 0;
}

/* Универсальная функция отображения/скрытия пукнта меню */
void __fastcall TFieldActivityForm::createFaPackNoticeActionUpdate(
      TObject *Sender)
{
    static_cast<TAction*>(Sender)->Enabled = _checkedCount > 0;
}

/* Событие изменения фильтра*/
void __fastcall TFieldActivityForm::OnChangeFilter(TObject *Sender)
{
    refreshCheckedCount();
}

/* Событие при изменении кол-ва выделенных элементов в гриде*/
void __fastcall TFieldActivityForm::OnChangeCheck(
      TObject *Sender)
{
    refreshCheckedCount();
}


/* Отображает реестр по ID
*/
void __fastcall TFieldActivityForm::showFaPackNotices(const Variant faPackId)
{
    static bool mutex_ = false;  // Защита от двойного вызова
    if ( mutex_ )
    {
        return;
    }
    mutex_ = true;


    // Здесь нужно переделать
    // так как уже есть два реестра Manual и Stop

    switch (modePageList._currentMode->mode)
    {
    case MODE_NOTICES:
    {
        try
        {
            modePageList.setCurrentSheet(SHEET_TYPE_FP_NOTICES_CONTENT);
            MainDataModule->setCurrentFpNoticesId(faPackId);
        }
        catch (Exception &e)
        {
            MessageBoxStop("" + e.Message);
        }

        break;
    }
    case MODE_STOP:
    {
        try
        {
            modePageList.setCurrentSheet(SHEET_TYPE_FP_STOP_CONTENT);
            MainDataModule->setCurrentFpStopId(faPackId);
        }
        catch (Exception &e)
        {
            MessageBoxStop("" + e.Message);
        }
        break;
    }
    }


    //_currentMode->showSheet(1);
    setCurPackMode();

    refreshParametersControls();
    refreshPopupMenu(); // Обновляем элементы, связанные с меню // переименовать и возможно перенести

    mutex_ = false;
}

/* Отображает список должников
   Возможно следует удалить эту функцию
*/
void __fastcall TFieldActivityForm::showPreDebtorList()
{
    MainDataModule->getPreDebtorList();
    modePageList.setCurrentSheet(SHEET_TYPE_PRE_NOTICES_LIST);
    setCurPackMode();
}

/* Отображает список на почту*/
void __fastcall TFieldActivityForm::showPrePostList()
{
    MainDataModule->getPrePostList();
    modePageList.setCurrentSheet(SHEET_TYPE_PRE_POST_LIST);
    setCurPackMode();
}

/* Отображает содержимое реестра на остановку */
void __fastcall TFieldActivityForm::showFpStopContent(const Variant faPackId)
{
    MainDataModule->setCurrentFpStopId(faPackId);
    modePageList.setCurrentSheet(SHEET_TYPE_FP_STOP_CONTENT);

    setCurPackMode();

    refreshParametersControls();
}

/* Отображает содержимое реестра на отмену остановки */
void __fastcall TFieldActivityForm::showFpCancelContent(const String& faPackId)
{
    MainDataModule->setCurrentFpCancel(faPackId);
    modePageList.setCurrentSheet(SHEET_TYPE_FP_CANCEL_CONTENT);

    setCurPackMode();

    refreshParametersControls();
}

/* Отображает содержимое реестра на возобновление*/
void __fastcall TFieldActivityForm::showFpReconnectContent(const String& faPackId)
{
    MainDataModule->setCurrentFpReconnect(faPackId);
    modePageList.setCurrentSheet(SHEET_TYPE_FP_RECONNECT_CONTENT);

    setCurPackMode();

    refreshParametersControls();
}


/* Отобразить список абонентов-кандидатов на ограничение*/
void __fastcall TFieldActivityForm::showStopList()
{
    MainDataModule->getStopList();
    modePageList.setCurrentSheet(SHEET_TYPE_PRE_STOP_LIST);

    setCurPackMode();
}

/* Отобразить список реестров на ограничение */
void __fastcall TFieldActivityForm::showPackStopList()
{
    MainDataModule->getFaPackStopList();
    modePageList.setCurrentSheet(SHEET_TYPE_FP_STOP_LIST);

    setCurPackMode();
}

/* Отобразить список реестров на переподключение (возобновление) */
void __fastcall TFieldActivityForm::showReconnectList()
{
    MainDataModule->getReconnectList();
    modePageList.setCurrentSheet(SHEET_TYPE_FP_RECONNECT_LIST);

    setCurPackMode();
}

/*
*/
void __fastcall TFieldActivityForm::showFaList()
{
    /*MainDataModule->GeneralFaList->Open();
    MainDataModule->GridFaDataSource->DataSet = MainDataModule->GeneralFaList;
    _currentDbGrid->refreshFilter();

    setCurPackMode(PACK_GENERAL); */
}

/*
*/
void __fastcall TFieldActivityForm::showApprovalList()
{
    MainDataModule->getApprovalList();
    modePageList.setCurrentSheet(SHEET_TYPE_APPROVE_LIST);
    setCurPackMode();
}

/*
*/
void __fastcall TFieldActivityForm::showFaInspectorList()
{
}

/* Отображает список на отмену ограничения
*/
void __fastcall TFieldActivityForm::showCancelList()
{
    MainDataModule->getCancelStopList();
    modePageList.setCurrentSheet(SHEET_TYPE_FP_CANCEL_LIST);
    setCurPackMode();

}
/* Создать реестр на почту*/
void __fastcall TFieldActivityForm::createFaPackPostActionExecute(
      TObject *Sender)
{
    Variant faPackId = MainDataModule->createFpNotice(FPT_POST);
    if ( !VarIsClear(faPackId) )
    {
        WaitForm->Execute(2);
        showFaPackNotices(faPackId);
        MainDataModule->closePreDebtorList();
        //MessageBoxInf("Создан реестр с номером " + faPackId + ".\nНе забудьте ввести даты контактов.");
        WaitForm->StopWait();
    }
    else
    {
        MessageBoxStop("Не удалось создать реестр!\nОбратитесь к системному администратору.");
    }

}

/* Действие утвердить контакты */
void __fastcall TFieldActivityForm::approveFaPackCcDttmActionExecute(TObject *Sender)
{
    if (MessageBoxQuestion("Отмечено " + IntToStr(ApproveListGrid->recordCountChecked) + " записей."
        "\nУже утвержденные контакты будут пропущены."
        "\nПродолжить?") != IDNO )
    {
        MainDataModule->setCcApproval();
        MainDataModule->closeCcApprovalList();
        MainDataModule->closeFaPackNoticesList();
        showApprovalList();
    }
}


/* Создание незакрытого пустого реестра (решено пока отказаться) */
void __fastcall TFieldActivityForm::createFaPackFree_oldExecute(
      TObject *Sender)
{
//
   /* Variant faPackId = MainDataModule->createFaPackFree(FPT_POST);
    if ( !VarIsClear(faPackId) )
    {
        showFaPack(faPackId);
    }    */
}

/* Полный список абонентов (Все абоненты) */
void __fastcall TFieldActivityForm::FullListTabSheetShow(TObject *Sender)
{
    showFullList();
}

/* Отображает список должников */
void __fastcall TFieldActivityForm::DebtorsTabSheetShow(TObject *Sender)
{
    showPreDebtorList();
}

/* Отображает список на почту */
void __fastcall TFieldActivityForm::PostListTabSheetShow(TObject *Sender)
{
    showPrePostList();
}

/* Отображает реестр уведомлений */
void __fastcall TFieldActivityForm::PackManualTabSheetShow(TObject *Sender)
{
    showFaPackNotices(MainDataModule->getFpNoticesId());
}

/* Отображает Список на введение ограничения */
void __fastcall TFieldActivityForm::StopListTabSheetShow(TObject *Sender)
{
    showStopList();
}

/* Отображает список реестров на ограничение */
void __fastcall TFieldActivityForm::PackStopListTabSheetShow(
      TObject *Sender)
{
    showPackStopList();
}

/* Отображает содержимое реестра на ограничение*/
void __fastcall TFieldActivityForm::PackStopTabSheetShow(
      TObject *Sender)
{
    showFpStopContent(MainDataModule->getFpStopId());
}

/* Отображает Список на отмену ограничения*/
void __fastcall TFieldActivityForm::FaCancelStopListTabSheetShow(
      TObject *Sender)
{
    showCancelList();
}

/* Отображает список на Утверждение */
void __fastcall TFieldActivityForm::ApprovalListTabSheetShow(
      TObject *Sender)
{
    showApprovalList();
}

/**/
void __fastcall TFieldActivityForm::updateCcActionExecute(TObject *Sender)
{
    //if ( updateCcAction->Enabled )
    EditCcForm->Execute(_currentDbGrid->DataSource->DataSet);
    _currentDbGrid->SelectedIndex = -1;
}

/* Удалить отмеченные реестры */
void __fastcall TFieldActivityForm::deleteFaPackActionExecute(TObject *Sender)
{
    MainDataModule->deleteFaPack();

    MessageBoxInf("Выполнено.");

    MainDataModule->closeStopList();
    MainDataModule->closeFaPackStopList();    // Так как необходимо обновить список реестров
    MainDataModule->getFaPackStopList();
}

/* Перевести реестр в статус Не завершен */
void __fastcall TFieldActivityForm::setFaPackStatusIncompleteActionExecute(
      TObject *Sender)
{
    if ( MainDataModule->setFaPackStatusIncomplete() )
    {
        MessageBoxInf("Выполнено.");
    }

    MainDataModule->closeFaPackStopList();    // Так как необходимо обновить список реестров
    MainDataModule->getFaPackStopList();
}

/* Перевести реестр в статус Утвержден */
void __fastcall TFieldActivityForm::setFaPackStatusFrozenActionExecute(
      TObject *Sender)
{
    if (MainDataModule->setFaPackStatusFrozen())
    {
        MessageBoxInf("Выполнено.");
    }
    MainDataModule->closeFaPackStopList();    // Так как необходимо обновить список реестров
    MainDataModule->getFaPackStopList();
}

/* Отображает главную вкладку */
void __fastcall TFieldActivityForm::showMainTabSheet()
{
    //if ( modePageList.
    modePageList.setCurrentSheet(SHEET_TYPE_MAIN_NOTICES);
    setCurPackMode();
}

/* */
void __fastcall TFieldActivityForm::MainTabSheetShow(
      TObject *Sender)
{
    showMainTabSheet();
}

/* Печать конвертов */
void __fastcall TFieldActivityForm::printFaNoticeEnvelopeActionExecute(
      TObject *Sender)
{
    //    
}

/* Создать реестр уведомлений на почту*/
void __fastcall TFieldActivityForm::printDocumentFaNoticesListForPostOfficeActionExecute(
      TObject *Sender)
{
    if (DocumentDataModule->getDocumentFaNoticesListForPostOffice(MainDataModule->getOtdelenListFilter, MainDataModule->getFaPackInfoFilter, MainDataModule->getFpNoticesContentFilter))
    {
        MessageBoxInf("Список уведомлений сформирован.");
    }
}

/* Печать заявок на ограничение */
void __fastcall TFieldActivityForm::printDocumentStopActionExecute(
      TObject *Sender)
{
    if ( DocumentDataModule->getDocumentStopRequest(MainDataModule->getOtdelenListFilter, MainDataModule->getFpStopListFilter, MainDataModule->getFpStopContentProc))
    {
        MessageBoxInf("Заявки на ограничение сформированы.");
    }
}

/* Печать заявок на отмену ограничения */
void __fastcall TFieldActivityForm::printCancelStopActionExecute(
      TObject *Sender)
{
    if (DocumentDataModule->getDocumentCancelStopRequest(MainDataModule->getOtdelenListFilter, MainDataModule->getFpCancelListFilter, MainDataModule->getFpCancelContentTmpProc))  // Здесь доделать, вставить параметры всех датасетов. Это кажется удобно
    {
        MessageBoxInf("Заявки на отмену ограничений сформированы.");
    }
}


/**/
void __fastcall TFieldActivityForm::TestButton1Click(TObject *Sender)
{
    //MainDataModule->createPackStop(true);
    //MainDataModule->createFpCancelStopForce();
}

/* Задает статус для реестра на отмену ограничения [Отправлен исполнителю]*/
void __fastcall TFieldActivityForm::setFaPackCancelStopStatusCompleteActionExecute(
      TObject *Sender)
{
    //
    if ( MainDataModule->setFaPackCancelStopStatusComplete() )
    {
        MessageBoxInf("Выполнено.");
    }
    //MainDataModule->closePackStopList();    // Так как необходимо обновить список реестров
    //MainDataModule->getPackStopList();
    //MainDataModule->getFaCancelStopList();
    MainDataModule->closeFpCancelStopList();
    showCancelList();

}
//---------------------------------------------------------------------------

void __fastcall TFieldActivityForm::ReconnectTabSheetShow(
      TObject *Sender)
{
    showReconnectList();
}
//---------------------------------------------------------------------------

void __fastcall TFieldActivityForm::FormCreate(TObject *Sender)
{
    /*if (SelectModeComboBox->Items->Count <= 0)
    {
        this->Close();
        this->Visible = false;
        PackPageControl->Visible = false;
        Application->Terminate();
        return;
    } */

    //MainTabSheet->Show();   // На всякий случай
    SelectModeComboBox->ItemIndex = 0;
    setMode(0);     // Активируем первый доступный режим работы
    refreshParametersControls();

}
//---------------------------------------------------------------------------

void __fastcall TFieldActivityForm::printReconnectActionExecute(
      TObject *Sender)
{
    if (DocumentDataModule->getDocumentReconnectRequest(MainDataModule->getOtdelenListFilter, MainDataModule->getReconnectListFilter, MainDataModule->getFpReconnectContentTmpProc))  // Здесь доделать, вставить параметры всех датасетов. Это кажется удобно
    {
        MessageBoxInf("Заявки на возобновление созданы.");
    }
}
//---------------------------------------------------------------------------


void __fastcall TFieldActivityForm::createFpCancelStopActionExecute(
      TObject *Sender)
{
    if (MessageBoxQuestion("Будут созданы заявки на отмену заявок на отключение. Продолжить?") != IDYES)
    {
        return;
    }

    //
    if (MainDataModule->createFpCancelStopForce())
    {
        MessageBoxInf("Заявки на отмену заявки созданы.");

        //MainDataModule->closeFaPackStopList();    // Так как необходимо обновить список реестров
        //MainDataModule->closeStopList();        // Так как необходимо обновить список на ограничение

        MainDataModule->closeFpStopContent();
        MainDataModule->closeFpCancelStopList();
        showFpStopContent(MainDataModule->getFpStopId());
    }
    else
    {
        MessageBoxStop("Заявки на отмену заявки не были созданы.");
    }
}
//---------------------------------------------------------------------------



void __fastcall TFieldActivityForm::FpStopContentGridCellClick(
      TColumn *Column)
{
    //
    if (Column->FieldName == "SA_E_DT")
    {
        editSaEndDtAction->Execute();
    }
}
//---------------------------------------------------------------------------

void __fastcall TFieldActivityForm::editSaEndDtActionExecute(
      TObject *Sender)
{
    //if ( updateCcAction->Enabled )
    EditSaEndDtForm->Execute(_currentDbGrid->DataSource->DataSet);
    _currentDbGrid->SelectedIndex = -1;
}
//---------------------------------------------------------------------------


void __fastcall TFieldActivityForm::FpCancelContentTabSheetShow(
      TObject *Sender)
{
    showFpCancelContent(MainDataModule->getFpCancelId());

}
//---------------------------------------------------------------------------

void __fastcall TFieldActivityForm::FpReconnectContentTabSheetShow(
      TObject *Sender)
{
    showFpReconnectContent(MainDataModule->getFpReconnectId());

}
//---------------------------------------------------------------------------

