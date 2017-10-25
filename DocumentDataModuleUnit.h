//---------------------------------------------------------------------------
/*
   Модуль для формирования документов
*/

#ifndef DocumentDataModuleUnitH
#define DocumentDataModuleUnitH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "DataSetFilter.h"
#include "DocumentWriter.h"
#include "MainDataModuleUnit.h"
#include "NoticesDataModuleUnit.h"
#include "StopDataModuleUnit.h"
#include <DB.hpp>
#include <DBClient.hpp>
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include "OraSmart.hpp"
#include <Provider.hpp>
#include <Dialogs.hpp>



//---------------------------------------------------------------------------
class TDocumentDataModule : public TDataModule
{
__published:	// IDE-managed Components
    TClientDataSet *ClientDataSet1;
    TOraTable *mergeDataSet;
    TDataSetProvider *mergeDataSetProvider;
    TSaveDialog *SaveDialog1;
    TOpenDialog *OpenDialog1;
    TDataSetFilter *getCheckedFilter;
private:	// User declarations
    typedef enum {
        DT_NOTICES_MANUAL,      // Уведомления
        DT_NOTICES_LIST,        // Список уведомлений
        DT_NOTICES_LIST_FOR_POSTOFFICE,     // Список уведомлений для почтовой службы
        DT_STOP_REQUEST,                // Заявки на отключение
        DT_CANCEL_REQUEST,              // Заявки на отмену отключения
        DT_RECONNECT_REQUEST,           // Заявки на возобновление
        DT_OVERDUE_REQUEST              // Просроченные заявки на отключение
    } TDocTypeCd;

    TDocumentWriter* documentWriter;
    
    String __fastcall askExcelFileName(const String &defaultFileName = "");
    String __fastcall askWordFileName(const String &defaultFileName = "");

    void __fastcall BeginPrint(TDataSetFilter* dsFilter);
    void __fastcall EndPrint(TDataSetFilter* dsFilter);

    bool __fastcall getDocumentWord(TDataSetFilter* otdelenData, TDataSet* fpInfo, TDataSetFilter* faDataFilter, TDocTypeCd docTypeCd);
    bool __fastcall getDocument(TDataSetFilter* otdelenData, TDataSetFilter* fpListData, TOraStoredProc* faDataProc, TDocTypeCd docTypeCd);
    //bool __fastcall getDocumentExcel(TDataSetFilter* otdelenData, TDataSetFilter* fpListData, TOraStoredProc* faDataProc, TDocTypeCd docTypeCd);
    bool __fastcall getDocumentExcel(TDataSetFilter* otdelenData, TDataSet* fpInfo, TDataSetFilter* faDataFilter, TDocTypeCd docTypeCd);

public:		// User declarations
    __fastcall TDocumentDataModule(TComponent* Owner);
    __fastcall ~TDocumentDataModule();
    bool __fastcall getDocumentFaNoticesList();
    bool __fastcall getDocumentFaNotices();
    bool __fastcall getDocumentFaNoticesListForPostOffice();
    bool __fastcall getDocumentStopRequest();
    bool __fastcall getDocumentCancelRequest();
    bool __fastcall getDocumentReconnectRequest();
    bool __fastcall getDocumentOverdueRequest();

};
//---------------------------------------------------------------------------
extern PACKAGE TDocumentDataModule *DocumentDataModule;
//---------------------------------------------------------------------------
#endif
