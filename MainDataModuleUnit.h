//---------------------------------------------------------------------------
/*
   Модуль для работы с базой данных
*/
#ifndef MainDataModuleUnitH
#define MainDataModuleUnitH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "DBAccess.hpp"
#include "Ora.hpp"
#include <Dialogs.hpp>
#include <ImgList.hpp>
#include <DB.hpp>
#include "MemDS.hpp"
#include "OtdelenComboBoxFrameUnit.h"
#include "VirtualTable.hpp"
#include "DataSetFilter.h"
#include "formlogin.h"
#include "ThreadDataSet.h"
#include <DBClient.hpp>
#include "OraSmart.hpp"
#include <Provider.hpp>
#include "OraSmart.hpp"
#include "Messages.h"
#include <set>
#include "appver.h"
#include "taskutils.h"
#include "DateUtils.hpp"

namespace TCheckTypes
{
enum Type
{
    CT_UNDEFINED = 0,
    CT_CHECKED,
    CT_UNCHECKED
};
};

class DualList
{
private:
    TStringList* _descrList;
    TStringList* _valueList;
    TOraQuery* _sourceQuery;
    void setUsed();
    bool _used;

public:
    DualList();
    ~DualList();
    void add(const String& descr, const String& value);
    void addFromQuery(TOraQuery* listQuery);
    void setSourceQuery(TOraQuery* query);
    String getValue(int index);
    String getValue(TComboBox* comboBox);
    void assignTo(TComboBox* comboBox);
};


namespace TUserRole
{
enum TRoleType
{
    UNDEFINED = 10,
    TESTER = 11,
    USER_BASE = 12, // Базовый пользователь
    VIEWER = 15,
    OPERATOR = 20,
    APPROVER = 30,
    ADMINISTRATOR = 40

};

typedef std::set <TRoleType> TRoleTypes;
//typedef Set <TRoleType, UNDEFINED, ADMINISTRATOR> TRoleTypes;
}



namespace TCcTypeCd
{
enum Type
{
    MANUAL = 10,
    LETTER = 20,
    PHONE_CALL = 30
};
}

namespace TCcStatusFlg
{
enum Type
{
    UNDEFINED = 10,
    SUCCESS = 20,
    FAILED = 30
};
}

namespace TCcSourceTypeCd
{
enum Type
{
    FA = 10,
    OTHER = 20
};
}    

/*
namespace TPackTypeCd
{
enum Type
{
    PACK_NULL = 10,
    PACK_MANUAL = 20,
    PACK_POST = 30,
    PACK_STOP = 40
};
}  */

typedef enum _TFaPackTypeCd
{
    FPT_UNDEFINED = 0,
    FPT_MANUAL = 10,
    FPT_POST = 20,
    FPT_STOP = 40

} TFaPackTypeCd;

//---------------------------------------------------------------------------
class TMainDataModule : public TDataModule
{
__published:	// IDE-managed Components
    TOraSession *EsaleSession;
    TOraDataSource *getPreDebtorListDataSource;
    TOraStoredProc *CreateFaProc;
    TOraStoredProc *CreateFaPackProc;
    TOraDataSource *getFaPackListNoticesDataSource;
    TOraDataSource *getFaPackDataSource;
    TOraStoredProc *addCcProc;
    TOraStoredProc *setCcStatusFlgProc;
    TOraDataSource *getApprovalListDataSource;
    TOraStoredProc *setCcApprovalProc;
    TDataSetFilter *getFaPackNoticesFilter;
    TDataSetFilter *getFaPackListNoticesFilter;
    TDataSetFilter *getApprovalListFilter;
    TDataSetFilter *getPreDebtorListFilter;
    TDataSetFilter *getCheckedFilter;
    TOraQuery *getCcStatusFlgListQuery;
    TOraDataSource *getCcStatusFlgListDataSource;
    TOraQuery *getCcTypeCdQuery;
    TOraDataSource *getCcTypeCdDataSource;
    TStringField *getCcStatusFlgListQueryDESCR;
    TStringField *getCcStatusFlgListQueryFIELD_VALUE;
    TStringField *getCcTypeCdQueryDESCR;
    TStringField *getCcTypeCdQueryFIELD_VALUE;
    TOraDataSource *getStopListDataSource;
    TDataSetFilter *getStopListFilter;
    TOraDataSource *getOtdelenListDataSource;
    TOraQuery *getConfigQuery;
    TOraDataSource *getFaPackStopDataSource;
    TDataSetFilter *getFaPackStopFilter;
    TOraQuery *getFaPackStopInfoQuery;
    TFloatField *getFaPackStopInfoQueryROWNUM;
    TDateTimeField *getFaPackStopInfoQuerySYSDATE;
    TDateTimeField *getFaPackStopInfoQueryCRE_DTTM;
    TStringField *getFaPackStopInfoQueryACCT_OTDELEN;
    TStringField *getFaPackStopInfoQueryFA_PACK_ID;
    TOraDataSource *getPackListStopDataSource;
    TDataSetFilter *getPackListStopFilter;
    TDateTimeField *getConfigQuerySYSDATE;
    TStringField *getConfigQueryAPP_PATH;
    TStringField *getConfigQueryVISA_PATH;
    TStringField *getConfigQueryREPORT_PATH;
    TStringField *getConfigQueryUSERNAME;
    TVirtualTable *getPreDebtorListRam;
    TDataSetFilter *getPrePostListFilter;
    TOraStoredProc *updateCcProc;
    TOraStoredProc *deleteCcProc;
    TOraStoredProc *setFaPackStatusFlgFrozenProc;
    TDataSetFilter *getAcctFullListFilter;
    TVirtualTable *getAcctFullListRam;
    TVirtualTable *getStopListRam;
    TVirtualTable *getApprovalListRam;
    TVirtualTable *getFaPackRam;
    TVirtualTable *getFaPackStopRam;
    TVirtualTable *getPackListStopRam;
    TOraDataSource *getCancelStopListDataSource;
    TDataSetFilter *getFaPackListCancelStopFilter;
    TVirtualTable *getCancelStopListRam;
    TOraStoredProc *deleteFaPackProc;
    TOraStoredProc *setFaPackStatusFlgCancelProc;
    TOraStoredProc *updateFaPackCharRecipientProc;
    TDataSetFilter *getOtdelenListFilter;
    TDataSetFilter *getFaPackInfoFilter;
    TOraStoredProc *getPreDebtorListProc;
    TOraDataSource *getPrePostListDataSource;
    TVirtualTable *getPrePostListRam;
    TOraStoredProc *getPrePostListProc;
    TOraStoredProc *getFaPackNoticesProc;
    TOraStoredProc *getApprovalListProc;
    TFloatField *getFaPackNoticesProcROWNUM;
    TFloatField *getFaPackNoticesProcCHECK_DATA;
    TStringField *getFaPackNoticesProcFA_ID;
    TStringField *getFaPackNoticesProcACCT_ID;
    TStringField *getFaPackNoticesProcADDRESS;
    TStringField *getFaPackNoticesProcCITY;
    TStringField *getFaPackNoticesProcFIO;
    TStringField *getFaPackNoticesProcPOSTAL;
    TDateTimeField *getFaPackNoticesProcCC_DTTM;
    TStringField *getFaPackNoticesProcSRC_TYPE_CD;
    TStringField *getFaPackNoticesProcSERVICE_ORG;
    TStringField *getFaPackNoticesProcPHONES;
    TStringField *getFaPackNoticesProcPHONE;
    TFloatField *getFaPackNoticesProcEND_REG_READING_SZ1;
    TFloatField *getFaPackNoticesProcEND_REG_READING1;
    TFloatField *getFaPackNoticesProcEND_REG_READING2;
    TFloatField *getFaPackNoticesProcSALDO_UCH;
    TStringField *getFaPackNoticesProcMTR_SERIAL_NBR;
    TStringField *getFaPackNoticesProcFA_PACK_ID;
    TStringField *getFaPackNoticesProcACCT_OTDELEN;
    TDateTimeField *getFaPackNoticesProcCRE_DTTM;
    TStringField *getFaPackNoticesProcOP_AREA_DESCR;
    TStringField *getFaPackNoticesProcFA_PACK_TYPE_CD;
    TFloatField *getFaPackNoticesProcCONT_QTY_SZ;
    TStringField *getFaPackNoticesProcCC_ID;
    TStringField *getFaPackNoticesProcCC_STATUS_FLG;
    TStringField *getFaPackNoticesProcCC_TYPE_CD;
    TFloatField *getPreDebtorListProcROWNUM;
    TFloatField *getPreDebtorListProcCHECK_DATA;
    TStringField *getPreDebtorListProcACCT_ID;
    TStringField *getPreDebtorListProcFIO;
    TStringField *getPreDebtorListProcCITY;
    TStringField *getPreDebtorListProcADDRESS;
    TStringField *getPreDebtorListProcPREM_TYPE_DESCR;
    TFloatField *getPreDebtorListProcSALDO_UCH;
    TFloatField *getPreDebtorListProcSALDO_M3;
    TDateTimeField *getPreDebtorListProcCC_DTTM;
    TStringField *getPreDebtorListProcFA_ID;
    TStringField *getPreDebtorListProcFA_PACK_ID;
    TDateTimeField *getPreDebtorListProcCRE_DTTM;
    TStringField *getPreDebtorListProcACCT_OTDELEN;
    TStringField *getPreDebtorListProcSERVICE_ORG;
    TStringField *getPreDebtorListProcOP_AREA_DESCR;
    TFloatField *getApprovalListProcROWNUM;
    TFloatField *getApprovalListProcCHECK_DATA;
    TStringField *getApprovalListProcACCT_ID;
    TStringField *getApprovalListProcFA_ID;
    TFloatField *getApprovalListProcSALDO_UCH;
    TStringField *getApprovalListProcADDRESS;
    TStringField *getApprovalListProcCITY;
    TStringField *getApprovalListProcFIO;
    TStringField *getApprovalListProcSERVICE_ORG;
    TStringField *getApprovalListProcCC_ID;
    TDateTimeField *getApprovalListProcCC_DTTM;
    TStringField *getApprovalListProcSRC_TYPE_CD;
    TDateTimeField *getApprovalListProcAPPROVAL_DTTM;
    TFloatField *getApprovalListProcN;
    TOraStoredProc *getStopListProc;
    TFloatField *getStopListProcROWNUM;
    TFloatField *getStopListProcCHECK_DATA;
    TFloatField *getStopListProcGRP_DATA;
    TStringField *getStopListProcACCT_ID;
    TDateTimeField *getStopListProcAPPROVAL_DTTM;
    TDateTimeField *getStopListProcCC_DTTM;
    TStringField *getStopListProcFIO;
    TStringField *getStopListProcPOSTAL;
    TStringField *getStopListProcCITY;
    TStringField *getStopListProcADDRESS;
    TStringField *getStopListProcPREM_TYPE_DESCR;
    TFloatField *getStopListProcSALDO_UCH;
    TStringField *getStopListProcSPR_DESCR;
    TStringField *getStopListProcFA_PACK_ID;
    TStringField *getStopListProcFA_PACK_TYPE_DESCR;
    TFloatField *getStopListProcGRP_DATA_MAX;
    TOraStoredProc *getFaPackStopProc;
    TFloatField *getFaPackStopProcROWNUM;
    TFloatField *getFaPackStopProcCHECK_DATA;
    TStringField *getFaPackStopProcFA_ID;
    TStringField *getFaPackStopProcACCT_ID;
    TStringField *getFaPackStopProcADDRESS;
    TStringField *getFaPackStopProcCITY;
    TStringField *getFaPackStopProcFIO;
    TStringField *getFaPackStopProcPOSTAL;
    TDateTimeField *getFaPackStopProcCC_DTTM;
    TStringField *getFaPackStopProcSRC_TYPE_CD;
    TStringField *getFaPackStopProcSPR_DESCR;
    TStringField *getFaPackStopProcPHONES;
    TStringField *getFaPackStopProcPHONE;
    TFloatField *getFaPackStopProcEND_REG_READING1;
    TFloatField *getFaPackStopProcEND_REG_READING2;
    TFloatField *getFaPackStopProcSALDO_UCH;
    TStringField *getFaPackStopProcMTR_SERIAL_NBR;
    TStringField *getFaPackStopProcFA_PACK_ID;
    TStringField *getFaPackStopProcACCT_OTDELEN;
    TDateTimeField *getFaPackStopProcCRE_DTTM;
    TStringField *getFaPackStopProcOP_AREA_DESCR;
    TStringField *getFaPackStopProcFA_PACK_TYPE_CD;
    TFloatField *getFaPackStopProcGRP;
    TStringField *getFaPackStopProcPREM_TYPE_DESCR;
    TDateTimeField *getFaPackStopProcST_P_DT;
    TDateTimeField *getFaPackStopProcSA_END_DT;
    TOraStoredProc *getFaPackListStopProc;
    TOraStoredProc *getFaPackListCancelStopProc;
    TStringField *getFaPackNoticesProcOWNER;
    TFloatField *getFaPackListStopProcROWNUM;
    TFloatField *getFaPackListStopProcCHECK_DATA;
    TStringField *getFaPackListStopProcFA_PACK_ID;
    TStringField *getFaPackListStopProcRECIPIENT_SPR_DESCR;
    TStringField *getFaPackListStopProcRECIPIENT_ADDRESS;
    TStringField *getFaPackListStopProcRECIPIENT_OFFICIAL_POST;
    TStringField *getFaPackListStopProcRECIPIENT_OFFICIAL_NAME;
    TDateTimeField *getFaPackListStopProcCRE_DTTM;
    TDateTimeField *getFaPackListStopProcST_P_DT;
    TStringField *getFaPackListStopProcOWNER;
    TStringField *getFaPackListStopProcFA_PACK_STATUS_DESCR;
    TFloatField *getFaPackListCancelStopProcROWNUM;
    TFloatField *getFaPackListCancelStopProcCHECK_DATA;
    TStringField *getFaPackListCancelStopProcFA_PACK_ID;
    TDateTimeField *getFaPackListCancelStopProcCRE_DTTM;
    TStringField *getFaPackListCancelStopProcFA_PACK_STATUS_FLG;
    TStringField *getFaPackListCancelStopProcPRNT_FA_ID;
    TStringField *getFaPackListCancelStopProcFA_ID;
    TStringField *getFaPackListCancelStopProcRT_SPR;
    TStringField *getFaPackListCancelStopProcRT_ADDR;
    TStringField *getFaPackListCancelStopProcRT_POST;
    TStringField *getFaPackListCancelStopProcRT_NAME;
    TFloatField *getFaPackListCancelStopProcACCT_ID_CNT;
    TStringField *getFaPackListCancelStopProcOWNER;
    TOraStoredProc *getFaPackListNoticesProc;
    TFloatField *getFaPackListNoticesProcROWNUM;
    TFloatField *getFaPackListNoticesProcCHECK_DATA;
    TDateTimeField *getFaPackListNoticesProcCRE_DTTM;
    TStringField *getFaPackListNoticesProcACCT_OTDELEN;
    TStringField *getFaPackListNoticesProcFA_PACK_ID;
    TStringField *getFaPackListNoticesProcFA_PACK_TYPE_CD;
    TFloatField *getFaPackListNoticesProcFA_CNT;
    TStringField *getFaPackListNoticesProcFA_PACK_TYPE_DESCR;
    TStringField *getFaPackListNoticesProcFA_PACK_STATUS_DESCR;
    TVirtualTable *getFaPackListNoticesRam;
    TOraDataSource *getAcctFullListDataSource;
    TOraDataSource *MainDataSource;
    TOraDataSource *findFaPackListNoticesDS;
    TDataSetFilter *findFaPackListNoticesFilter;
    TOraStoredProc *findFaPackListNoticesProc;
    TVirtualTable *findFaPackListNoticesRam;
    TOraDataSource *findFaPackListStopDS;
    TDataSetFilter *findFaPackListStopFilter;
    TOraStoredProc *findFaPackListStopProc;
    TVirtualTable *findFaPackListStopRam;
    TFloatField *getFaPackListStopProcFA_CNT;
    TOraStoredProc *getFpCancelStopContentProc;
    TOraStoredProc *createFaStopProc;
    TFloatField *findFaPackListNoticesProcROWNUM;
    TFloatField *findFaPackListNoticesProcCHECK_DATA;
    TStringField *findFaPackListNoticesProcFA_PACK_ID;
    TStringField *findFaPackListNoticesProcFA_PACK_TYPE_CD;
    TDateTimeField *findFaPackListNoticesProcCRE_DTTM;
    TStringField *findFaPackListNoticesProcPRNT_FA_PACK_ID;
    TStringField *findFaPackListNoticesProcACCT_OTDELEN;
    TStringField *findFaPackListNoticesProcFA_PACK_STATUS_FLG;
    TStringField *findFaPackListNoticesProcUSER_ID;
    TStringField *findFaPackListNoticesProcFA_PACK_STATUS_DESCR;
    TStringField *findFaPackListNoticesProcFA_PACK_TYPE_DESCR;
    TStringField *findFaPackListNoticesProcOWNER;
    TFloatField *findFaPackListStopProcROWNUM;
    TFloatField *findFaPackListStopProcCHECK_DATA;
    TStringField *findFaPackListStopProcFA_PACK_ID;
    TStringField *findFaPackListStopProcRECIPIENT_SPR_DESCR;
    TStringField *findFaPackListStopProcRECIPIENT_ADDRESS;
    TStringField *findFaPackListStopProcRECIPIENT_OFFICIAL_POST;
    TStringField *findFaPackListStopProcRECIPIENT_OFFICIAL_NAME;
    TDateTimeField *findFaPackListStopProcCRE_DTTM;
    TStringField *findFaPackListStopProcFA_PACK_STATUS_FLG;
    TDateTimeField *findFaPackListStopProcST_P_DT;
    TStringField *findFaPackListStopProcOWNER;
    TStringField *findFaPackListStopProcFA_PACK_STATUS_DESCR;
    TFloatField *findFaPackListStopProcFA_CNT;
    TStringField *findFaPackListStopProcFA_PACK_TYPE_DESCR;
    TOraStoredProc *getOtdelenListProc;
    TOraStoredProc *getOpAreaCdProc;
    TOraStoredProc *getConfigProc;
    TDateTimeField *getConfigProcSYSDATE;
    TStringField *getConfigProcAPP_PATH;
    TStringField *getConfigProcREPORT_PATH;
    TStringField *getConfigProcVISA_PATH;
    TStringField *getConfigProcUSERNAME;
    TFloatField *getConfigProcMIN_APP_VER;
    TFloatField *getConfigProcMAX_APP_VER;
    TFloatField *getConfigProcALLOWED;
    TStringField *getOpAreaCdProcOP_AREA_CD;
    TStringField *getOpAreaCdProcOP_AREA_DESCR;
    TStringField *getOpAreaCdProcACCT_OTDELEN;
    TOraStoredProc *getFaPackTypeListProc;
    TOraStoredProc *getFaPackInfProc;
    TOraStoredProc *getCcInfProc;
    TStringField *getFaPackTypeListProcFA_PACK_TYPE_CD;
    TStringField *getFaPackTypeListProcDESCR;
    TDateTimeField *getFaPackInfProcCRE_DTTM;
    TStringField *getFaPackInfProcACCT_OTDELEN;
    TStringField *getFaPackInfProcFA_PACK_ID;
    TFloatField *getFaPackInfProcFA_COUNT;
    TDateTimeField *getFaPackNoticesProcAPPROVAL_DTTM;
    TFloatField *findFaPackListNoticesProcFA_CNT;
    TStringField *getFaPackListStopProcFA_PACK_STATUS_FLG;
    TStringField *getFaPackListStopProcFA_PACK_TYPE_DESCR;
    TStringField *getPreDebtorListProcMR_RTE_CD;
    TStringField *getFaPackNoticesProcMR_RTE_CD;
    TOraStoredProc *setFaPackStatSentPerformerProc;
    TStringField *getFaPackListCancelStopProcFA_PACK_STATUS_DESCR;
    TStringField *getFaPackStopProcNOTICE_FA_ID;
    TDateTimeField *getFaPackStopProcNOTICE_CRE_DTTM;
    TStringField *getFpCancelStopContentProcACCT_ID;
    TStringField *getFpCancelStopContentProcFIO;
    TStringField *getFpCancelStopContentProcSTOP_FA_ID;
    TStringField *getFpCancelStopContentProcSTOP_FA_PACK_ID;
    TDateTimeField *getFpCancelStopContentProcSTOP_CRE_DTTM;
    TStringField *getFpCancelStopContentProcNOTICE_FA_ID;
    TStringField *getFpCancelStopContentProcNOTICE_FA_PACK_ID;
    TDateTimeField *getFpCancelStopContentProcNOTICE_CRE_DTTM;
    TDateTimeField *getFpCancelStopContentProcST_P_DT;
    TStringField *getFpCancelStopContentProcCITY;
    TStringField *getFpCancelStopContentProcADDRESS;
    TStringField *getFpCancelStopContentProcPREM_TYPE_DESCR;
    TOraStoredProc *getFaPackStatsProc;
    TStringField *getFaPackStatsProcACCT_OTDELEN;
    TStringField *getFaPackStatsProcACCT_OTDELEN_DESCR;
    TFloatField *getFaPackStatsProcFA_NOTICES_SELF;
    TFloatField *getFaPackStatsProcFA_NOTICES_POST;
    TFloatField *getFaPackStatsProcFA_PACK_STOP;
    TFloatField *getFaPackStatsProcFA_PACK_CANCEL;
    TDateTimeField *getConfigProcTODAY;
    TOraDataSource *getReconnectListDataSource;
    TDataSetFilter *getReconnectListFilter;
    TVirtualTable *getReconnectListRam;
    TOraStoredProc *getReconnectListProc;
    TFloatField *getReconnectListProcROWNUM;
    TFloatField *getReconnectListProcCHECK_DATA;
    TStringField *getReconnectListProcFA_PACK_ID;
    TDateTimeField *getReconnectListProcCRE_DTTM;
    TStringField *getReconnectListProcFA_PACK_STATUS_FLG;
    TStringField *getReconnectListProcPRNT_FA_ID;
    TStringField *getReconnectListProcRT_SPR;
    TStringField *getReconnectListProcRT_ADDR;
    TStringField *getReconnectListProcRT_POST;
    TStringField *getReconnectListProcRT_NAME;
    TStringField *getReconnectListProcFA_PACK_STATUS_DESCR;
    TFloatField *getReconnectListProcACCT_ID_CNT;
    TStringField *getReconnectListProcOWNER;
    TOraStoredProc *getFpReconnectContentProc;
    TStringField *StringField1;
    TStringField *StringField2;
    TStringField *StringField3;
    TStringField *StringField4;
    TDateTimeField *DateTimeField1;
    TStringField *StringField21;
    TStringField *StringField22;
    TDateTimeField *DateTimeField8;
    TDateTimeField *DateTimeField9;
    TStringField *StringField23;
    TStringField *StringField24;
    TStringField *StringField25;
    TFloatField *getFaPackStatsProcFA_PACK_RECONNECT;
    TStringField *getFpReconnectContentProcPHONES;
    TStringField *getConfigProcSTOP_ALLERT;
    TStringField *getFaPackListStopProcRT_SPR_CD;
    TOraStoredProc *getAcctFullListProc;
    TFloatField *getAcctFullListProcROWNUM;
    TFloatField *getAcctFullListProcCHECK_DATA;
    TStringField *getAcctFullListProcACCT_ID;
    TStringField *getAcctFullListProcFIO;
    TStringField *getAcctFullListProcCITY;
    TStringField *getAcctFullListProcADDRESS;
    TStringField *getAcctFullListProcPREM_TYPE_DESCR;
    TFloatField *getAcctFullListProcSALDO_UCH;
    TFloatField *getAcctFullListProcSALDO_M3;
    TDateTimeField *getAcctFullListProcCC_DTTM;
    TStringField *getAcctFullListProcFA_ID;
    TStringField *getAcctFullListProcFA_PACK_ID;
    TDateTimeField *getAcctFullListProcCRE_DTTM;
    TStringField *getAcctFullListProcACCT_OTDELEN;
    TStringField *getAcctFullListProcSERVICE_ORG;
    TStringField *getAcctFullListProcOP_AREA_DESCR;
    TStringField *getAcctFullListProcMR_RTE_CD;
    TStringField *getFaPackListStopProcRT_TYPE;
    TStringField *getOtdelenListProcACCT_OTDELEN;
    TStringField *getOtdelenListProcDESCR;
    TStringField *getOtdelenListProcMAILING_ADDRESS;
    TStringField *getOtdelenListProcACTING_NAME;
    TStringField *getOtdelenListProcACTING_POST;
    TStringField *getOtdelenListProcDESCR_L_GENITIVE;
    TStringField *getOtdelenListProcPHONE;
    TStringField *getOtdelenListProcDESCR_L;
    TStringField *getOtdelenListProcADDRESS;
    void __fastcall DataModuleCreate(TObject *Sender);
    void __fastcall OnFilterChange(TDataSetFilter *Sender,
          AnsiString filterName);
    void __fastcall EsaleSessionAfterDisconnect(TObject *Sender);
private:	// User declarations
    bool __fastcall Auth();
    void __fastcall BeginProcessing(TDataSetFilter* filter);
    void __fastcall EndProcessing(TDataSetFilter* filter);



    //void OnThreadEvent1();
    //void __fastcall OnThreadEvent(TThreadEventMessage Message, TDataSet* ds);
    void __fastcall OnThreadEvent(TThreadEventMessage Message, void* ds);
    //void __fastcall OnShowDebtorsThreadEnd(TDataSet* ds);
    TThreadDataSet* _threadDataSet; // Поток для открытия запросов

    /* Синхронизация с графическим интерфейсом */
    TNotifyEvent _afterOpenDataSet;
    TNotifyEvent _beforeOpenDataSet;
    TNotifyEvent _onChangeFilterMethod;

    TField* _acctOtdelen;           // Текущее отделение
    TDataSetFilter* _currentFilter; // Текущий фильтр



public:		// User declarations
    __fastcall TMainDataModule(TComponent* Owner);
    void __fastcall connectEsale();


    void __fastcall CopyDataSet(TDataSet* sourceDs, TDataSet* destinationDs);
    void openOrRefresh(TDataSet* query);

    //void __fastcall setAfterOpenEvent(TNotifyEvent event);
    void __fastcall setOpenDataSetEvents(TNotifyEvent beforeOpenDataSet, TNotifyEvent afterOpenDataSet);
    void __fastcall setOnChangeFilterMethod(TNotifyEvent onChangeFilterMethod);

    /* Для последующего обновления */
    void __fastcall closePreDebtorList();    // Список абонентов на уведомление
    void __fastcall closeFaPackStopList();    // Список реестров на ограничение
    void __fastcall closeStopList();        // Список абонентов на ограничение
    void __fastcall closeCcApprovalList();  // Список на утверждение;
    void __fastcall closeFaPackNoticesList();
    void __fastcall closeFaPackListCancelStop();


    TUserRole::TRoleTypes userRole; // Роль пользоваля
    String username;    // Имя пользователя

    //DualList otdelenList;
    //DualList faTypesList;
    //DualList faTypesAndDebtorList;

    void TMainDataModule::deleteCc(
        TDataSet* ds,
        Variant ccId
    );


    String addCc(
        TDataSet* ds,
        TDateTime ccDttm,
        const String& acct_id,
        const String& descr,
        const String& srcId,
        const String& caller,
        TCcTypeCd::Type ccTypeCd,
        TCcStatusFlg::Type ccStatusFlg,
        TCcSourceTypeCd::Type ccSourceTypeCd
    );

    void updateCc(
        TDataSet* ds,
        Variant ccId,
        TDateTime ccDttm,
        const String& descr,
        const String& caller,
        TCcTypeCd::Type ccTypeCd,
        TCcStatusFlg::Type ccStatusFlg
    );

    // недоделано 2017-03-14
    TFields* getCcInfo(const String& ccId);

    void setCcApproval();

    Variant __fastcall createPackNotice(TFaPackTypeCd faPackTypeCd = FPT_UNDEFINED);
    std::vector<Variant> __fastcall createPackStop(bool useGrpFilter = true);
    Variant __fastcall createFaPackFree(TFaPackTypeCd faPackTypeCd = FPT_UNDEFINED);
    String __fastcall createPackMulti(TDataSetFilter* filter, TFaPackTypeCd faPackTypeCd, const String& acctOtdelen);

    /* Data exchange with view */
    //void __fastcall setFilter(const String& filterName, const String& filterValue);
    void __fastcall setFilterParamValue(TDataSetFilter* filter, const String& filterName, const String& paramName, Variant paramValue);

    void __fastcall selectCcDttmIsNull(TDataSetFilter* filter);
    void __fastcall selectCcDttmMoreThanThree(TDataSetFilter* filter);
    void __fastcall setCheckAll(TDataSet* dataSet, bool value);

    /* Отображаемы списки */
    void __fastcall getAcctFullList();
    void __fastcall getPreDebtorList();
    void __fastcall getPrePostList();
    void __fastcall getApprovalList();
    void __fastcall getStopList();
    void __fastcall getFaPackStopList();
    void __fastcall getCancelStopList();
    void __fastcall getReconnectList();


    /* Вспомогательные запросы */


    /* Для окна выбора реестра */
    void __fastcall findFaPackListNotices(const String& acctOtdelen, const String& faId = "", const String& acctId = "");
    void __fastcall findFaPackListStop(const String& acctOtdelen, const String& faId = "", const String& acctId = "");

    /**/
    void __fastcall setAcctOtdelen(const String& acctOtdelen, bool updateOnly = false);
    Variant __fastcall getAcctOtdelen();

    void __fastcall setFaPack(const String& faPackId);


    void __fastcall setFaPackId_Notice(const String& faPackId);
    void __fastcall setFaPackId_Stop(const String& faPackId);
    String __fastcall getFaPackId_Notice() const;
    String __fastcall getFaPackId_Stop() const;
    bool __fastcall deleteFaPack();
    bool __fastcall setFaPackStatusIncomplete();
    bool __fastcall setFaPackStatusFrozen();
    bool __fastcall setFaPackCancelStopStatusComplete();

    String __fastcall getFaPackStats();




    //String _currentFaPackTypeCd;      // Тип текущего реестр
    //String _currentFaPackId;      // Текущий реестр
    //String _currentAcctOtdelen;     // Текущий участок

};
//---------------------------------------------------------------------------
extern PACKAGE TMainDataModule *MainDataModule;
//---------------------------------------------------------------------------
#endif
