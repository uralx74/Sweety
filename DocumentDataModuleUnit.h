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
    TDocumentWriter* documentWriter;
    
    String __fastcall askExcelFileName();
    String __fastcall askWordFileName(const String &defaultFileName = "");

    void __fastcall BeginPrint(TDataSetFilter* dsFilter);
    void __fastcall EndPrint(TDataSetFilter* dsFilter);


public:		// User declarations
    __fastcall TDocumentDataModule(TComponent* Owner);
    __fastcall ~TDocumentDataModule();
    void __fastcall getDocumentFaNoticesList(TDataSetFilter *mergeFields);
    bool __fastcall getDocumentFaNotices(TDataSetFilter* otdelenData, TDataSetFilter* faPackData, TDataSetFilter* faData);
    bool __fastcall getDocumentFaNoticesListForPostOffice(TDataSetFilter* otdelenDsF, TDataSetFilter* recDsF, TDataSetFilter* tableDsF);
    bool __fastcall getDocumentStopRequest(TDataSetFilter* otdelenData, TDataSetFilter* fpListData, TOraStoredProc* fpContentProc);
    bool __fastcall getDocumentCancelStopRequest(TDataSetFilter* otdelenData, TDataSetFilter* faPackListData, TOraStoredProc* faDataProc);
    bool __fastcall getDocumentReconnectRequest(TDataSetFilter* otdelenData, TDataSetFilter* faPackListData, TOraStoredProc* faDataProc);

};
//---------------------------------------------------------------------------
extern PACKAGE TDocumentDataModule *DocumentDataModule;
//---------------------------------------------------------------------------
#endif
