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
    Caption = "ДолжникиФ (" + AppVer::FullVersion + "a) - " + MainDataModule->getConfigQuery->FieldByName("username")->AsString;
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

    // Реестр на ограничение
    TUserRole::TRoleTypes AccessPackStopTabSheet;
    AccessPackStopTabSheet.insert(TUserRole::OPERATOR);
    AccessPackStopTabSheet.insert(TUserRole::ADMINISTRATOR);
    AccessPackStopTabSheet.insert(TUserRole::VIEWER);
    AccessPackStopTabSheet.insert(TUserRole::TESTER);


    // Реестр на отзыв ограничения
    TUserRole::TRoleTypes AccessPackRefuseStopTabSheet;
    AccessPackRefuseStopTabSheet.insert(TUserRole::OPERATOR);
    AccessPackRefuseStopTabSheet.insert(TUserRole::ADMINISTRATOR);
    AccessPackRefuseStopTabSheet.insert(TUserRole::VIEWER);
    AccessPackRefuseStopTabSheet.insert(TUserRole::TESTER);

    // Реестр на возобновление
    TUserRole::TRoleTypes AccessPackReloadTabSheet;
    AccessPackReloadTabSheet.insert(TUserRole::OPERATOR);
    AccessPackReloadTabSheet.insert(TUserRole::ADMINISTRATOR);
    AccessPackReloadTabSheet.insert(TUserRole::VIEWER);
    AccessPackReloadTabSheet.insert(TUserRole::TESTER);

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

    /*
    item.addAction(checkAllAction);
    item.addAction(checkNoneAction);
    item.addAction(checkWithoutCcAction);
    item.addAction(checkWithCcLess3MonthAction);
    item.addAction(createFaPackAction);
    item.addAction(printDocumentFaNoticesAction);
    item.addAction(printDocumentFaNoticesListAction);
    item.addAction(printDocumentStopAction);
    item.addAction(printDocumentStopListAction);
    item.addAction(printDocumentStopActionRefuseAction);
    item.addAction(approveFaPackCcDttmAction);
    item.addAction(createFaPackStopAction);*/

    bool bRoleAdministrator = MainDataModule->userRole.find(TUserRole::ADMINISTRATOR) != MainDataModule->userRole.end();
    bool bRoleOperator = MainDataModule->userRole.find(TUserRole::OPERATOR) != MainDataModule->userRole.end();
    bool bRoleApprover = MainDataModule->userRole.find(TUserRole::APPROVER) != MainDataModule->userRole.end();
    bool bRoleTester = MainDataModule->userRole.find(TUserRole::TESTER) != MainDataModule->userRole.end();


    /* Назначаем группы доступа на действия */
    printFaNoticeEnvelopeAction->Enabled = bRoleAdministrator || bRoleOperator;
    printDocumentFaNoticesAction->Enabled = bRoleAdministrator || bRoleOperator;
    printDocumentFaNoticesListAction->Enabled = bRoleAdministrator || bRoleOperator;
    printDocumentStopAction->Enabled = bRoleAdministrator || bRoleOperator || bRoleTester;
    printDocumentStopListAction->Enabled =  bRoleAdministrator || bRoleOperator;
    printDocumentStopActionRefuseAction->Enabled =  bRoleAdministrator || bRoleOperator;

    createFaPackAction->Enabled = bRoleAdministrator || bRoleOperator;
    createFaPackPostAction->Enabled  = bRoleAdministrator || bRoleOperator;
    createFaPackStopAction->Enabled = bRoleAdministrator || bRoleOperator;
    createFaCancelPackAction->Enabled = false;  // временное значение
    approveFaPackCcDttmAction->Enabled = bRoleAdministrator || bRoleApprover;
    updateCcAction->Enabled = bRoleAdministrator || bRoleOperator;
    createFaCancelPackAction->Enabled = bRoleAdministrator || bRoleTester;     // Отмена заявки на ограничение
    deleteFaPackAction->Enabled = bRoleAdministrator || bRoleTester;  // временное значение
    setFaPackStatusIncompleteAction->Enabled = bRoleAdministrator || bRoleTester;  // временное значение
    setFaPackStatusFrozenAction->Enabled = bRoleAdministrator || bRoleTester;



    // Главная вкладка в разделе Уведомления
    sheetTemp = item->addSheet(MainTabSheet);
    sheetTemp->accessible = isRoleAllowed(Access_MainTabSheet_Notices, MainDataModule->userRole);
    sheetTemp->packModeId = SHEET_TYPE_MAIN_NOTICES;


    // Вкладка списка должников
    sheetTemp = item->addSheet(DebtorsTabSheet);
    sheetTemp->setColor(RGB(255,255,255));
    sheetTemp->accessible = isRoleAllowed(Access_DebtorsTabSheet, MainDataModule->userRole);
    sheetTemp->packModeId = SHEET_TYPE_DEBTORS;
    sheetTemp->addAction(createFaPackAction);
    sheetTemp->addAction(checkAllAction);
    sheetTemp->addAction(checkNoneAction);
    sheetTemp->addAction(checkWithoutCcAction);
    sheetTemp->addAction(checkWithCcLess3MonthAction);


    // Вкладка реестра должников
    sheetTemp = item->addSheet(PackManualTabSheet);
    sheetTemp->accessible = isRoleAllowed(Access_PackManualTabSheet, MainDataModule->userRole);
    sheetTemp->packModeId = SHEET_TYPE_NOTICES_PACK;
    sheetTemp->addAction(printDocumentFaNoticesAction);
    sheetTemp->addAction(printDocumentFaNoticesListAction);
    sheetTemp->addAction(checkAllAction);
    sheetTemp->addAction(checkNoneAction);
    sheetTemp->addAction(checkWithoutCcAction);
    sheetTemp->addAction(checkWithCcLess3MonthAction);
    

    // Вкладка утверждения вручения уведомления
    sheetTemp = item->addSheet(ApprovalListTabSheet);
    sheetTemp->accessible = isRoleAllowed(Access_ApprovalListTabSheet, MainDataModule->userRole);
    sheetTemp->packModeId = SHEET_TYPE_APPROVE;
    sheetTemp->addAction(checkAllAction);
    sheetTemp->addAction(checkNoneAction);
    sheetTemp->addAction(checkWithoutCcAction);
    sheetTemp->addAction(checkWithCcLess3MonthAction);
    sheetTemp->addAction(approveFaPackCcDttmAction);

    // Вкладка списка уведомлений на почту
    sheetTemp = item->addSheet(PostListTabSheet);
    sheetTemp->accessible = isRoleAllowed(Access_PostListTabSheet, MainDataModule->userRole);
    sheetTemp->packModeId = SHEET_TYPE_POST_LIST;
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
    sheetTemp->packModeId = SHEET_TYPE_STOP;
    sheetTemp->addAction(checkAllAction);
    sheetTemp->addAction(checkNoneAction);
    sheetTemp->addAction(checkWithoutCcAction);
    sheetTemp->addAction(checkWithCcLess3MonthAction);
    sheetTemp->addAction(createFaPackStopAction);

    // Список реестров на ограничение
    sheetTemp = item->addSheet(PackStopListTabSheet);
    sheetTemp->accessible = isRoleAllowed(AccessPackStopListTabSheet, MainDataModule->userRole);
    sheetTemp->packModeId = SHEET_TYPE_PACK_STOP_LIST;
    sheetTemp->addAction(checkAllAction);
    sheetTemp->addAction(checkNoneAction);
    sheetTemp->addAction(checkWithoutCcAction);
    sheetTemp->addAction(checkWithCcLess3MonthAction);
    sheetTemp->addAction(printDocumentStopAction);
    sheetTemp->addAction(printDocumentStopListAction);
    sheetTemp->addAction(deleteFaPackAction);
    sheetTemp->addAction(setFaPackStatusIncompleteAction);
    sheetTemp->addAction(setFaPackStatusFrozenAction);



    // Реестр на ограничение
    sheetTemp = item->addSheet(PackStopTabSheet);
    sheetTemp->accessible = isRoleAllowed(AccessPackStopTabSheet, MainDataModule->userRole);
    sheetTemp->packModeId = SHEET_TYPE_STOP_PACK;
    sheetTemp->addAction(checkAllAction);
    sheetTemp->addAction(checkNoneAction);
    sheetTemp->addAction(checkWithoutCcAction);
    sheetTemp->addAction(checkWithCcLess3MonthAction);

    // Список на отзыв заявки на ограничение
    sheetTemp = item->addSheet(FaCancelListTabSheet);
    sheetTemp->accessible = isRoleAllowed(AccessPackRefuseStopTabSheet, MainDataModule->userRole);
    sheetTemp->packModeId = SHEET_TYPE_FA_CANCEL_LIST;
    sheetTemp->addAction(checkAllAction);
    sheetTemp->addAction(checkNoneAction);
    sheetTemp->addAction(checkWithoutCcAction);
    sheetTemp->addAction(checkWithCcLess3MonthAction);
    sheetTemp->addAction(printDocumentStopActionRefuseAction);
    sheetTemp->addAction(createFaCancelPackAction);


    //
    sheetTemp = item->addSheet(PackReloadTabSheet);
    sheetTemp->accessible = isRoleAllowed(AccessPackReloadTabSheet, MainDataModule->userRole);
    sheetTemp->packModeId = SHEET_TYPE_RELOAD;
    sheetTemp->addAction(checkAllAction);
    sheetTemp->addAction(checkNoneAction);
    sheetTemp->addAction(checkWithoutCcAction);
    sheetTemp->addAction(checkWithCcLess3MonthAction);



    /*item.sheets.push_back( TSheetEx(StopListTabSheet, !(AccessStopListTabSheet * MainDataModule->userRole).Empty()) );
    item.sheets.push_back( TSheetEx(PackStopTabSheet, !(AccessPackStopTabSheet * MainDataModule->userRole).Empty()) );
    item.sheets.push_back( TSheetEx(PackRefuseStopTabSheet, !(AccessPackRefuseStopTabSheet * MainDataModule->userRole).Empty()) );
    item.sheets.push_back( TSheetEx(PackReloadTabSheet, !(AccessPackReloadTabSheet * MainDataModule->userRole).Empty()) );
    */
    
    //_modeList.push_back(item);


    //SelectModeComboBox->Items->AddObject(item->caption, (TObject*)item);
    //SelectModeComboBox->Items->AddObject(item.caption, (TObject*)item);

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

      
    SelectModeComboBox->ItemIndex = 0;

    refreshParametersControls();

    setMode(0);     // Активируем первый доступный режим работы
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

    /*if (PackPageControl->Top != 40)
    {
        PackPageControl->Align = alNone;
        PackPageControl->Top = 40;
    }*/
}

/* Отображает список должников
   Возможно следует удалить эту функцию
*/
void __fastcall TFieldActivityForm::showFullList()
{
    MainDataModule->getFullList();
    modePageList.setCurrentSheet(SHEET_TYPE_FULL_LIST);
    setCurPackMode();
}

/* Отображает список должников
   Возможно следует удалить эту функцию
*/
void __fastcall TFieldActivityForm::showDebtorList()
{
    MainDataModule->getDebtorList();
    modePageList.setCurrentSheet(SHEET_TYPE_DEBTORS);
    setCurPackMode();
}

void __fastcall TFieldActivityForm::showPostList()
{
    MainDataModule->getPostList();
    modePageList.setCurrentSheet(SHEET_TYPE_POST_LIST);
    setCurPackMode();
}


/* Меняем отображаемую страницу */
/*void __fastcall TFieldActivityForm::changeSheet(TSheetType type)
{
    _currentMode->setCurrentSheet(type);  // Отображаем требуемую страницу, одновременно с этим отображаем доступные действия
} */

/* Смена режима работы программы */
void __fastcall TFieldActivityForm::SelectModeComboBoxChange(
      TObject *Sender)
{
    setMode(SelectModeComboBox->ItemIndex);
}

/* Отображает реестр по ID
*/
void __fastcall TFieldActivityForm::showFaPack(const Variant faPackId)
{

    // Здесь нужно переделать
    // так как уже есть два реестра Manual и Stop

    switch (modePageList._currentMode->mode)
    {
    case MODE_NOTICES:
    {
        MainDataModule->setFaPackId_Notice(faPackId);
        modePageList.setCurrentSheet(SHEET_TYPE_NOTICES_PACK);
        break;
    }
    case MODE_STOP:
    {
        MainDataModule->setFaPackId_Stop(faPackId);
        modePageList.setCurrentSheet(SHEET_TYPE_STOP_PACK);
        break;
    }
    }

    refreshParametersControls();

    //_currentMode->showSheet(1);
    setCurPackMode();
}

void __fastcall TFieldActivityForm::showFaPackStop(const Variant faPackId)
{
    MainDataModule->setFaPackId_Stop(faPackId);
    modePageList.setCurrentSheet(SHEET_TYPE_STOP_PACK);

    refreshParametersControls();

    setCurPackMode();
}

/* Отобразить список абонентов-кандидатов на ограничение*/
void __fastcall TFieldActivityForm::showStopList()
{
    MainDataModule->getStopList();
    modePageList.setCurrentSheet(SHEET_TYPE_STOP);

    setCurPackMode();
}

/* Отобразить список реестров на ограничение */
void __fastcall TFieldActivityForm::showPackStopList()
{
    MainDataModule->getPackStopList();
    modePageList.setCurrentSheet(SHEET_TYPE_PACK_STOP_LIST);

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
    modePageList.setCurrentSheet(SHEET_TYPE_APPROVE);
    setCurPackMode();
}

/*
*/
void __fastcall TFieldActivityForm::showFaInspectorList()
{
}

/* Отображает список на отмену ограничения
*/
void __fastcall TFieldActivityForm::showFaCancelList()
{
    MainDataModule->getFaCancelList();
    modePageList.setCurrentSheet(SHEET_TYPE_FA_CANCEL_LIST);
    setCurPackMode();

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
    ParamPackIdEdit->Text = "";
    _currentFilter = NULL;
    _currentDbGrid = NULL;

    switch(modePageList._currentMode->currentSheet->packModeId)
    {
    default:
    {
        break;
    }
    case SHEET_TYPE_MAIN_NOTICES:
    {
        _currentFilter = NULL;
        _currentDbGrid = NULL;
        break;
    }
    case SHEET_TYPE_FULL_LIST:
    {

        _currentFilter = MainDataModule->getFullListFilter;
        _currentDbGrid = FullListGrid;

        break;
    }

    case SHEET_TYPE_DEBTORS:
    {
        ParamPackIdEdit->Text = "";

        _currentFilter = MainDataModule->getDebtorsFilter;//&_filterPackGeneral;
        _currentDbGrid = DBGridAltGeneral;

        break;
    }
    case SHEET_TYPE_NOTICES_PACK:    // Реестр уведомлений
    {
        ParamPackIdEdit->Text = MainDataModule->getFaPackId_Notice();//_curPackId;

        _currentFilter = MainDataModule->getFaPackFilter;
        _currentDbGrid = DBGridAltManual;

        break;
    }
    case SHEET_TYPE_APPROVE:
    {
        ParamPackIdEdit->Text = "";

        _currentFilter = MainDataModule->getApprovalListFilter;
        _currentDbGrid = ApproveListGrid;

        break;
    }
    case SHEET_TYPE_POST_LIST:
    {                        // Список на почту
        ParamPackIdEdit->Text = "";

        _currentFilter = MainDataModule->getPostListFilter;
        _currentDbGrid = PostListGrid;

        break;
    }
    case SHEET_TYPE_STOP:
    {
        ParamPackIdEdit->Text = "";

        _currentFilter = MainDataModule->getStopListFilter;
        _currentDbGrid = StopListGrid;

        break;
    }
    case SHEET_TYPE_STOP_PACK:
    {
        ParamPackIdEdit->Text = MainDataModule->getFaPackId_Stop();
        _currentFilter = MainDataModule->getFaPackStopFilter;
        _currentDbGrid = StopPackGrid;

        break;
    }
    case SHEET_TYPE_FA_CANCEL_LIST:
    {
        ParamPackIdEdit->Text = "";

        _currentFilter = MainDataModule->getFaCancelListFilter;
        _currentDbGrid = FaCancelListGrid;
        break;
    }
    case SHEET_TYPE_PACK_STOP_LIST:
    {
        ParamPackIdEdit->Text = "";

        _currentFilter = MainDataModule->getPackStopListFilter;
        _currentDbGrid = PackStopListGrid;
        break;
    }
    }

    refreshFilterControls();    // Обновляем состояние элементов управления для фильтров

    refreshCheckedCount();      //
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


/*
*/
/*void __fastcall TFieldActivityForm::setFilter(const String& filterName, const String& filterValue)
{
    _currentFilter->setValue(filterName, ":param", filterValue);
    //_currentDbGrid->refreshFilter();
} */


/* Сложный фильтр с датами контакта
*/
void __fastcall TFieldActivityForm::CcDttmStatusComboBoxChange(
      TObject *Sender)
{
    TComboBox* comboBox = static_cast<TComboBox*>(Sender);
    MainDataModule->setFilterParamValue(_currentFilter, comboBox->Name, "param", IntToStr(comboBox->ItemIndex));

    ccDttmPeriodPanel->Visible = comboBox->ItemIndex == 3;
}

/* Сложный фильтр с датами контакта
*/
void __fastcall TFieldActivityForm::FilterCcDttmChange(TObject *Sender)
{

    String beginDt = DateToStr(DateTimePicker1->Date);
    String endDt = DateToStr(DateTimePicker2->Date);
    _currentFilter->setValue("CcDttmStatusComboBox", "begin_dt", beginDt);
    _currentFilter->setValue("CcDttmStatusComboBox", "end_dt", endDt);
}




/*
//---------------------------------------------------------------------------
// Заполняем строку итогов
void __fastcall TZadanie_Form::FillTotalBar()
{
    DM->ListZadanie->DisableControls();
    DM->ListZadanie->First();
    int myArr[5] = {0,0,0,0,0};
    for (;!DM->ListZadanie->Eof;DM->ListZadanie->Next()) {
        myArr[0] += DM->ListZadanie->FieldByName("kol_all")->AsInteger;
        myArr[1] += DM->ListZadanie->FieldByName("kol1")->AsInteger;
        myArr[2] += DM->ListZadanie->FieldByName("kol2")->AsInteger;
        myArr[3] += DM->ListZadanie->FieldByName("kol3")->AsInteger;
        myArr[4] += DM->ListZadanie->FieldByName("kol4")->AsInteger;
    }
    for (int i = 0; i < 5; i++) {
        HeaderControl1->Sections->Items[i]->Text = IntToStr(myArr[i]);
    }
    DM->ListZadanie->First();
    DM->ListZadanie->EnableControls();
}*/

//---------------------------------------------------------------------------
//
void __fastcall TFieldActivityForm::DBGridAltGeneralChangeCheck(TObject *Sender)
{
    //int checkedCount = _currentDbGrid->getSum("", "CHECK_DATA = 1", false).first;
    refreshCheckedCount();
}

/* Обновляет статистику по выделенным элементам в dbgrid */
void __fastcall TFieldActivityForm::refreshCheckedCount()
{
    if ( _currentDbGrid != NULL )
    {
        SummaryInfoGroupBox->Visible = true;

        TSumResult checkedResult = _currentDbGrid->getSum("", "CHECK_DATA = 1", false);
        TSumResult recordResult = _currentDbGrid->getSum("", "", false);
        TSumResult recordFilteredResult = _currentDbGrid->getSum("", "", true);

        _checkedCount = checkedResult.first;
        _recordCount = recordResult.first;

        SelectedStatLabel->Caption = IntToStr(checkedResult.first);
        FilteredStatLabel->Caption = IntToStr(recordFilteredResult.first);
        TotalStatLabel->Caption = IntToStr(recordResult.first);


        // Состояние CheckBox для выделения записей
        TNotifyEvent old_OnClick = SelectAllCheckBox->OnClick;
        SelectAllCheckBox->OnClick = NULL;
        if (_recordCount > 0)
        {
            if (_checkedCount == _recordCount)
            {
                SelectAllCheckBox->State = cbChecked;
            }
            else if (_checkedCount > 0)
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


        /*Label8->Caption = IntToStr(checkedResult.first)  + "/" +IntToStr(recordResult.first);
        /*Label9->Caption = FloatToStr(DBGridAlt1->getSum("saldo", false, false));
        Label10->Caption = FloatToStr(DBGridAlt1->getSum("saldo", false, true));
        Label11->Caption = FloatToStr(DBGridAlt1->getSum("saldo", true, false));
        Label12->Caption = FloatToStr(DBGridAlt1->getSum("saldo", true, true));
        */
    }
    else
    {
        SummaryInfoGroupBox->Visible = false;
    }
}

/*
*/
void __fastcall TFieldActivityForm::DBGridAltGeneralChangeFilter(TObject *Sender)
{
    //DBGridAltGeneralChangeCheck(Sender);
    refreshCheckedCount();
}

/* Отображает форму для выбора реестра
*/
void __fastcall TFieldActivityForm::ParamPackIdEditClick(TObject *Sender)
{
    //String faPackTypeCd = "";
    int mode;
    switch(modePageList._currentMode->mode)
    {
    case MODE_NOTICES:
    {
        //faPackTypeCd = "20";
        mode = 0;
        break;
    }
    case MODE_STOP:
    {
        //faPackTypeCd = "40";
        mode = 1;
        break;
    }
    }

    if ( SelectFaPackForm->execute(MainDataModule->getAcctOtdelen(), mode) )
    {
        //FaPack faPack = SelectFaPackForm->getFaPack();
        //setCurPackId( SelectFaPackForm->getFaPackId() );
        //setCurPackMode( SelectFaPackForm->getFaPackTypeId() );

        switch(modePageList._currentMode->mode)
        {
        case MODE_NOTICES:
        {
            showFaPack( SelectFaPackForm->getFaPackId() );

            break;
        }
        case MODE_STOP:
        {
            showFaPackStop( SelectFaPackForm->getFaPackId() );
            break;
        }
        }
    }
}

/* Прячет все действия в Action листах */
/*void __fastcall TFieldActivityForm::HideAllActions()
{
    for (int i = 0; i < ActionList1->ActionCount; i++)
    {
        ((TAction*)ActionList1->Actions[i])->Visible = false;
    }
}*/

/*
*/
void __fastcall TFieldActivityForm::Button6Click(TObject *Sender)
{
    //MainPanel->Align = alNone;
  /*  ShowMessage(String(MainPanel->Top) + " " +  String(MainPanel->Left) + " " +  String(MainPanel->Height) + " " +  String(MainPanel->Width) +
        "\n" + String(PackPageControl->Top) + " " +  String(PackPageControl->Left) );
    //PackPageControl->Align = alNone;




   ShowMessage(String(GroupBox1->Top) + " " +  String(GroupBox1->Left) + " " +  String(GroupBox1->Height) + " " +  String(GroupBox1->Width));
 */
    //PackPageControl->Top = 40;

    //refreshCheckedCount();
    //Application->CreateForm(__classid(TWaitForm), &WaitForm);
    //ShowMessage(MainDataModule->getFullListQuery->RecordCount);

 /*   if (ResetFiltersButton->Showing == true)
    {
        ShowMessage( "true" );

        ResetFiltersButton->Hide();
    }
    else
    {
        ShowMessage( "false" );
    }
    this->Refresh();
    refreshFilterControls(); */
}

/*
*/
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


/**/
int PageIndexFromTabIndex(TPageControl* pageControl, int tabIndex)
{
    /*int visiblePageIndex = 0;
    while (tabIndex > 0 )
    {
        if (pageControl->Pages[i]->Showing)
        {
            tabIndex--;
        }
    } */

    int visiblePageCount = 0;
    for (int i = 0; i <= pageControl->PageCount; i++)
    {
        if ( pageControl->Pages[i]->TabVisible )
        {
            visiblePageCount++;
        }
        if (visiblePageCount > tabIndex)
        {
            return i;
        }
    }
    return -1;
}

/**/
void __fastcall TFieldActivityForm::PackPageControlDrawTab(
      TCustomTabControl *Control, int TabIndex, const TRect &Rect,
      bool Active)
{
    //TPageControl *pageControl = static_cast <TTabControl *> (Control);
    TCanvas *canvas = Control->Canvas;
    // Текст, который будем выводить на вкладке

    int pageIndex = PageIndexFromTabIndex(((TPageControl*)Control), TabIndex);

    AnsiString tabCaption = ((TPageControl*)Control)->Pages[pageIndex]->Caption;

    // РИСОВАНИЕ
    canvas->Lock();    // Блокирум канвас перед рисованием
    //canvas->TextRect(Rect, Rect.Left+3, Rect.Top+3, tabCaption);
    canvas->Brush->Color = _colorList.getColorByIndex(pageIndex);
    canvas->FillRect(TRect(Rect.Left, Rect.Top + Rect.Height()-3, Rect.Left + Rect.Width(), Rect.Top + Rect.Height()));

    canvas->Brush->Color = clBtnFace;
    canvas->Font->Color = static_cast<TColor>(RGB(0,0,0));    // Цвет шрифта
    canvas->TextOutA(Rect.Left+3, Rect.Top+3, tabCaption);
    canvas->Unlock();
}



/**/
void __fastcall TFieldActivityForm::ResetFiltersButtonClick(
      TObject *Sender)
{
    //String test1 = _currentFilter->getValue(ApprovedStatusComboBox->Name, "param");
    //_currentFilter->clearValue(ApprovedStatusComboBox->Name, "param");
    //String test2 = _currentFilter->getValue(ApprovedStatusComboBox->Name, "param");
    _currentFilter->clearAllValues();
    refreshFilterControls();
}

void __fastcall TFieldActivityForm::refreshParametersControls()
{
    OtdelenComboBox->KeyValue = MainDataModule->getAcctOtdelen();
}

void __fastcall TFieldActivityForm::refreshActionsStates()
{

}

/**/
void __fastcall TFieldActivityForm::refreshFilterControls()
{
    /*ccDttmIsApprovedFilterPanel->Visible = true;
    CcDttmPerodFilterPanel->Visible = true;
    CcDttmExistsFilterPanel->Visible = true;
    FaPackIdFilterPanel->Visible = true;
    OpAreaDescrFilterPanel->Visible = true;
    SaldoFilterPanel->Visible = true;
    ServiceCompanyFilterPanel->Visible = true;
    FioFilterPanel->Visible = true;
    AddressFilterPanel->Visible = true;
    CityFilterPanel->Visible = true;
    AcctIdFilterPanel->Visible = true;
    Panel3->Visible = true;
    //Button1->Visible = true;
    //Button1->BringToFront();
    //RstButtonFilterPanel->Visible = false;
    return;   */

    //if (_currentFilter == NULL)

    /*std::vector<TObject*> v;
    v.push_back(ccDttmIsApprovedFilterPanel);
    v.push_back(CcDttmPerodFilterPanel);
    v.push_back(CcDttmExistsFilterPanel);
    v.push_back(FaPackIdFilterPanel);
    v.push_back(OpAreaDescrFilterPanel);
    v.push_back(SaldoFilterPanel);
    v.push_back(ServiceCompanyFilterPanel);
    v.push_back(FioFilterPanel);
    v.push_back(AddressFilterPanel);
    v.push_back(CityFilterPanel);
    v.push_back(AcctIdFilterPanel);
    v.push_back(PremTypeFilterPanel);
    v.push_back(FaPackTypeFilterPanel);

    for(std::vector<TObject*>::iterator it; it = v.begin(); it != v.end())
    {
        (*v)->Visible =
    }  */


    __try {
        //Perform(WM_SETREDRAW, 0, 0);
        //SendMessage(FilterGroupBox->Handle, WM_SETREDRAW, 0, 0);
        SendMessage(this->Handle, WM_SETREDRAW, 0, 0);

        // Видимость
        if ( _currentFilter != NULL)
        {
            ccDttmIsApprovedFilterPanel->Visible = _currentFilter->isFilterExists(ApprovedStatusComboBox->Name);

            TemporaryUnusedFilterPanel->Visible = false;
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
        }
        else
        {
            ccDttmIsApprovedFilterPanel->Visible = false;
            TemporaryUnusedFilterPanel->Visible = false;
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
        }

        // Порядок панелей
        FilterGroupBox->Height = 800;
        RealignControls(FilterGroupBox);
        if (RstButtonFilterPanel->Top == 15)
        {
            RstButtonFilterPanel->Caption = "В данном режиме фильтр не предусмотрен";
            ResetFiltersButton->Visible = false;
        }
        else
        {
            RstButtonFilterPanel->Caption = "";
            ResetFiltersButton->Visible = true;
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

        //FilterGroupBox->Perform(WM_SETREDRAW, 1, 0);

        //SendMessage(FilterGroupBox->Handle, WM_SETREDRAW, 1, 0);
        //RedrawWindow(FilterGroupBox->Handle, NULL, 0, RDW_ALLCHILDREN + RDW_INVALIDATE + RDW_FRAME + RDW_ERASE);

        //FilterGroupBox->Refresh();
    }

}

/* Реакция на выбор учатка из списка ComboBox */
void __fastcall TFieldActivityForm::OtdelenComboBoxClick(TObject *Sender)
{
    MainDataModule->setAcctOtdelen(OtdelenComboBox->KeyValue);  // Задаем текущий филиал (участок)
    switch(modePageList._currentMode->currentSheet->packModeId)
    {
    case SHEET_TYPE_DEBTORS:
    {
        showDebtorList();
        break;
    }
    case SHEET_TYPE_STOP:
    {
        showStopList();
        break;
    }
    case SHEET_TYPE_PACK_STOP_LIST:
    {
        showPackStopList();
        break;
    }
    default:
    {
        //MainDataModule->
        showMainTabSheet();
        /*switch(modePageList._currentMode->mode)
        {
        case MODE_NOTICES:
        {
            showDebtorList();
            break;
        }

        case MODE_STOP:
        {
            showStopList();
            break;
        }
        } */
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
    DocumentDataModule->getDocumentFaNotices(_currentFilter);
    MessageBoxInf("Уведомления сформированы.");
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

    String faPackId = MainDataModule->createPackNotice(FPT_MANUAL);
    if (faPackId != "" )
    {
        WaitForm->Execute(2);
        //String faPackId = MainDataModule->createPack(_currentFilter, TPackTypeCd::PACK_MANUAL, MainDataModule->getAcctOtdelen());
        showFaPack(faPackId);
        MainDataModule->closeDebtorsQuery();
        //MessageBoxInf("Создан реестр с номером " + faPackId + ".\nНе забудьте ввести даты контактов.");
        WaitForm->StopWait();
    }
    else
    {
        MessageBoxStop("Не удалось создать реестр!\nОбратитесь к системному администратору.");
    }
}

/**/
void __fastcall TFieldActivityForm::approveFaPackCcDttmActionExecute(TObject *Sender)
{
    if (MessageBoxQuestion("Отмечено " + IntToStr(ApproveListGrid->recordCountChecked) + " записей."
        "\nУже утвержденные контакты будут пропущены."
        "\nПродолжить?") != IDNO )
    {
        MainDataModule->setCcApprovalDttmSelected();
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
    _currentDbGrid->setCheckFiltered(true);
//    SelectAllCheckBox->Checked = true;
}

/* Снять пометки */
void __fastcall TFieldActivityForm::checkNoneActionExecute(TObject *Sender)
{
    _currentDbGrid->setCheckFiltered(false);
//    SelectAllCheckBox->Checked = false;
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

/* Печать заявок на ограничение */
void __fastcall TFieldActivityForm::printDocumentStopActionExecute(
      TObject *Sender)
{
    DocumentDataModule->getDocumentStopService();
    MessageBoxInf("Заявки на ограничение сформированы.");
}

/* Задает текущий режим работы программы */
void __fastcall TFieldActivityForm::setMode(int index)
{
    //SendMessage(this->Handle, WM_SETREDRAW, 0, 0);
    PackPageControl->Visible = false; // В будущем попробовать с отключением OnChange


    // Отображаем только вкладки активного режима и доступные текущему пользователю по его роли
    //_currentMode = (TModeItem*)SelectModeComboBox->Items->Objects[index];
    modePageList.setMode((TModeItem*)SelectModeComboBox->Items->Objects[index]);


    PackPageControl->Visible = true;
    //SendMessage(this->Handle, WM_SETREDRAW, 1, 0);
    //RedrawWindow(this->Handle, NULL, 0, RDW_ALLCHILDREN + RDW_INVALIDATE + RDW_FRAME + RDW_ERASE);


    //Classes::TWndMethod OldWindowProc;
    //OldWindowProc = PackPageControl->WindowProc;
    //PackPageControl->WindowProc = NULL;
    //PackPageControl->OwnerDraw = true;
    //PackPageControl->WindowProc = OldWindowProc;
    //PackPageControl->Refresh();
    //Application->ProcessMessages();
}

/* Создать реестр заявок на ограничение*/
void __fastcall TFieldActivityForm::createFaPackStopActionExecute(
      TObject *Sender)
{
    //String faPackId =
    if ( Sender ==  createFaPackStopAction)
    {
        MainDataModule->createPackStop(true);   // Использовать признак группировки (может быть создано несколько реестров)
    }
    else
    {
        MainDataModule->createPackStop(false);   // Без использования признака группировки по разным реестрам (будет создан один реестр)
    }

    MainDataModule->closePackStopList();    // Так как необходимо обновить список реестров
    MainDataModule->closeStopList();        // Так как необходимо обновить список на ограничение

    //String faPackId = MainDataModule->createPack(_currentFilter, TPackTypeCd::PACK_STOP, MainDataModule->getAcctOtdelen());
    //showFaPack(faPackId);
    showPackStopList();

}

//
void __fastcall TFieldActivityForm::PackStopTabSheetShow(
      TObject *Sender)
{
    showFaPackStop(MainDataModule->getFaPackId_Stop());
}

/* Список на отмену ограничения*/
void __fastcall TFieldActivityForm::FaCancelListTabSheetShow(
      TObject *Sender)
{
    //showFaPack(MainDataModule->getFaPackId_Stop());
    showFaCancelList();

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
//---------------------------------------------------------------------------

void __fastcall TFieldActivityForm::PackStopListTabSheetShow(
      TObject *Sender)
{
    // возможно переделать на show...
    showPackStopList();

}
//---------------------------------------------------------------------------

void __fastcall TFieldActivityForm::OnQueryAfterExecute(TObject *Sender)
{
    //WaitForm->Close();
}

/**/
void __fastcall TFieldActivityForm::checkAllActionUpdate(TObject *Sender)
{
    static_cast<TAction*>(Sender)->Enabled = _recordCount > 0;
}

/**/
void __fastcall TFieldActivityForm::createFaPackNoticeActionUpdate(
      TObject *Sender)
{
    static_cast<TAction*>(Sender)->Enabled = _checkedCount > 0;
}
//---------------------------------------------------------------------------
/**/
void __fastcall TFieldActivityForm::OnChangeFilter(TObject *Sender)
{
    refreshCheckedCount();
}


/**/
void __fastcall TFieldActivityForm::createFaPackPostActionExecute(
      TObject *Sender)
{
    Variant faPackId = MainDataModule->createPackNotice(FPT_POST);
    if ( !VarIsClear(faPackId) )
    {
        WaitForm->Execute(2);
        showFaPack(faPackId);
        MainDataModule->closeDebtorsQuery();
        //MessageBoxInf("Создан реестр с номером " + faPackId + ".\nНе забудьте ввести даты контактов.");
        WaitForm->StopWait();
    }
    else
    {
        MessageBoxStop("Не удалось создать реестр!\nОбратитесь к системному администратору.");
    }

}
//---------------------------------------------------------------------------

void __fastcall TFieldActivityForm::printFaNoticeEnvelopeActionExecute(
      TObject *Sender)
{
    //    
}
//---------------------------------------------------------------------------


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
//---------------------------------------------------------------------------

void __fastcall TFieldActivityForm::FullListTabSheetShow(TObject *Sender)
{
//
    showFullList();
}
//---------------------------------------------------------------------------

/* Должники */
void __fastcall TFieldActivityForm::DebtorsTabSheetShow(TObject *Sender)
{
    showDebtorList();
}

void __fastcall TFieldActivityForm::PostListTabSheetShow(TObject *Sender)
{
//
    showPostList();
}


/* Переключили на вкладку Уведомления */
void __fastcall TFieldActivityForm::PackManualTabSheetShow(TObject *Sender)
{
    // возможно переделать на show...
    showFaPack(MainDataModule->getFaPackId_Notice());
}

/**/
void __fastcall TFieldActivityForm::StopListTabSheetShow(TObject *Sender)
{
    // возможно переделать на show...
    showStopList();
}

/* Переключили на вкладку Утверждения */
void __fastcall TFieldActivityForm::ApprovalListTabSheetShow(
      TObject *Sender)
{
    //setCurPackMode(PACK_APPROVE_LIST);
    // возможно переделать на show...
    showApprovalList();
}


/* Выравнивает элеметы управления в правильном порядке */
void __fastcall TFieldActivityForm::RealignControls(TWinControl *parent)
{
    TControl *c;
    TAlign align;
    for(int i=0; i < parent->ControlCount; i++)
    {
        c = parent->Controls[i];
        align = c->Align;
        switch(align)
        {
        case alLeft:
        {
            c->Left = parent->Width;
            break;
        }
        case alRight:
        {
            c->Left = 0;
            break;
        }
        case alTop:
        {
            c->Top = parent->Height;
            break;
        }
        case alBottom:
        {
            c->Top = 0;
            break;
        }
        }
        c->Align = align;
    }
}



void __fastcall TFieldActivityForm::updateCcActionExecute(TObject *Sender)
{
    //if ( updateCcAction->Enabled )
    EditCcForm->Execute(_currentDbGrid->DataSource->DataSet);
    _currentDbGrid->SelectedIndex = -1;
    
    //Column->Grid->SelectedIndex = -1;
    //DBGridAltManual->SelectedIndex = -1;
}



/* Удалить отмеченные реестры */
void __fastcall TFieldActivityForm::deleteFaPackActionExecute(TObject *Sender)
{
    MainDataModule->deleteFaPack();

    MainDataModule->closeStopList();
    MainDataModule->closePackStopList();    // Так как необходимо обновить список реестров
    MainDataModule->getPackStopList();
}

/*void TFieldActivityForm::Refresh()
{
    _currentFilter->DataSet->Close();
}   */

/* Перевести реестр в статус Не завершен */
void __fastcall TFieldActivityForm::setFaPackStatusIncompleteActionExecute(
      TObject *Sender)
{
    MainDataModule->setFaPackStatusIncomplete();

    MainDataModule->closePackStopList();    // Так как необходимо обновить список реестров
    MainDataModule->getPackStopList();
}
//---------------------------------------------------------------------------
/* Перевести реестр в статус Утвержден */
void __fastcall TFieldActivityForm::setFaPackStatusFrozenActionExecute(
      TObject *Sender)
{
    MainDataModule->setFaPackStatusFrozen();

    MainDataModule->closePackStopList();    // Так как необходимо обновить список реестров
    MainDataModule->getPackStopList();
}
//---------------------------------------------------------------------------
//
void __fastcall TFieldActivityForm::showMainTabSheet()
{
    modePageList.setCurrentSheet(SHEET_TYPE_MAIN_NOTICES);
    setCurPackMode();
}

//
void __fastcall TFieldActivityForm::MainTabSheetShow(
      TObject *Sender)
{
    showMainTabSheet();
}
//---------------------------------------------------------------------------



/* Создать реестр заявок на ограничение*/


