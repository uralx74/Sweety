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
    PHONE_CALL = 30,
    RECALCULATION = 60,
    HANDED_EARLIER= 70
};
}

namespace TAgentTypeCd
{
enum Type
{
    UNDEFINED = 10,
    OP_AREA_CD = 20
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
    FPT_STOP = 40,
    FPT_CANCEL = 45,
    FPT_RECONNECT = 50

} TFaPackTypeCd;

//---------------------------------------------------------------------------
class TMainDataModule : public TDataModule
{
__published:	// IDE-managed Components
    TOraSession *EsaleSession;
    TOraStoredProc *CreateFaProc;
    TOraStoredProc *CreateFaPackProc;
    TOraStoredProc *addCcProc;
    TOraStoredProc *setCcStatusFlgProc;
    TOraStoredProc *setCcApprovalProc;
    TDataSetFilter *getCheckedFilter;
    TOraQuery *getCcStatusFlgListQuery;
    TOraDataSource *getCcStatusFlgListDataSource;
    TOraQuery *getCcTypeCdQuery;
    TOraDataSource *getCcTypeCdDataSource;
    TStringField *getCcStatusFlgListQueryDESCR;
    TStringField *getCcStatusFlgListQueryFIELD_VALUE;
    TStringField *getCcTypeCdQueryDESCR;
    TStringField *getCcTypeCdQueryFIELD_VALUE;
    TOraDataSource *getOtdelenListDataSource;
    TOraQuery *getConfigQuery;
    TDateTimeField *getConfigQuerySYSDATE;
    TStringField *getConfigQueryAPP_PATH;
    TStringField *getConfigQueryVISA_PATH;
    TStringField *getConfigQueryREPORT_PATH;
    TStringField *getConfigQueryUSERNAME;
    TOraStoredProc *updateCcProc;
    TOraStoredProc *deleteCcProc;
    TOraStoredProc *setFaPackStatusFlgFrozenProc;
    TOraStoredProc *deleteFaPackProc;
    TOraStoredProc *setFpStatusFlgCancelProc;
    TDataSetFilter *getOtdelenListFilter;
    TDataSetFilter *getFaPackInfoFilter;
    TOraDataSource *MainDataSource;
    TOraDataSource *findFaPackListNoticesDS;
    TDataSetFilter *findFaPackListNoticesFilter;
    TOraStoredProc *findFaPackListNoticesProc;
    TVirtualTable *findFaPackListNoticesRam;
    TOraDataSource *findFaPackListStopDS;
    TDataSetFilter *findFpStopListFilter;
    TOraStoredProc *findFpStopListProc;
    TVirtualTable *findFpStopListRam;
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
    TFloatField *findFpStopListProcROWNUM;
    TFloatField *findFpStopListProcCHECK_DATA;
    TStringField *findFpStopListProcFA_PACK_ID;
    TDateTimeField *findFpStopListProcCRE_DTTM;
    TStringField *findFpStopListProcFA_PACK_STATUS_FLG;
    TStringField *findFpStopListProcOWNER;
    TStringField *findFpStopListProcFA_PACK_STATUS_DESCR;
    TFloatField *findFpStopListProcFA_CNT;
    TStringField *findFpStopListProcFA_PACK_TYPE_DESCR;
    TOraStoredProc *getOtdelenListProc;
    TOraStoredProc *getOpAreaProc;
    TOraStoredProc *getConfigProc;
    TDateTimeField *getConfigProcSYSDATE;
    TStringField *getConfigProcAPP_PATH;
    TStringField *getConfigProcREPORT_PATH;
    TStringField *getConfigProcVISA_PATH;
    TStringField *getConfigProcUSERNAME;
    TFloatField *getConfigProcMIN_APP_VER;
    TFloatField *getConfigProcMAX_APP_VER;
    TFloatField *getConfigProcALLOWED;
    TStringField *getOpAreaProcOP_AREA_CD;
    TStringField *getOpAreaProcACCT_OTDELEN;
    TOraStoredProc *getFaPackTypeListProc;
    TOraStoredProc *getFaPackInfProc;
    TOraStoredProc *getCcInfProc;
    TStringField *getFaPackTypeListProcFA_PACK_TYPE_CD;
    TStringField *getFaPackTypeListProcDESCR;
    TDateTimeField *getFaPackInfProcCRE_DTTM;
    TStringField *getFaPackInfProcACCT_OTDELEN;
    TStringField *getFaPackInfProcFA_PACK_ID;
    TFloatField *getFaPackInfProcFA_COUNT;
    TFloatField *findFaPackListNoticesProcFA_CNT;
    TOraStoredProc *setFaPackStatSentPerformerProc;
    TOraStoredProc *getFaPackStatsProc;
    TStringField *getFaPackStatsProcACCT_OTDELEN;
    TStringField *getFaPackStatsProcACCT_OTDELEN_DESCR;
    TFloatField *getFaPackStatsProcFA_NOTICES_SELF;
    TFloatField *getFaPackStatsProcFA_NOTICES_POST;
    TFloatField *getFaPackStatsProcFA_PACK_STOP;
    TFloatField *getFaPackStatsProcFA_PACK_CANCEL;
    TDateTimeField *getConfigProcTODAY;
    TFloatField *getFaPackStatsProcFA_PACK_RECONNECT;
    TStringField *getConfigProcSTOP_ALLERT;
    TStringField *getOtdelenListProcACCT_OTDELEN;
    TStringField *getOtdelenListProcDESCR;
    TStringField *getOtdelenListProcMAILING_ADDRESS;
    TStringField *getOtdelenListProcACTING_NAME;
    TStringField *getOtdelenListProcACTING_POST;
    TStringField *getOtdelenListProcDESCR_L_GENITIVE;
    TStringField *getOtdelenListProcPHONE;
    TStringField *getOtdelenListProcDESCR_L;
    TStringField *getOtdelenListProcADDRESS;
    TOraStoredProc *createFpCancelForceProc;
    TOraStoredProc *createFpStopProc;
    TStringField *findFpStopListProcRT_TYPE;
    TOraStoredProc *createFpNoticeProc;
    TOraStoredProc *setFaSaEndDtProc;
    TStringField *findFpStopListProcFA_PACK_TYPE_CD;
    TFloatField *findFaPackListNoticesProcCNT;
    TStringField *getConfigProcAPP_VER;
    TStringField *getConfigProcSERVICE_STOP_ALLERT;
    TStringField *getConfigProcNEEDS_APP_UPDATE;
    TStringField *getConfigProcUPDATE_FAILURE;
    TStringField *getConfigProcOTHER_STOP_REASON;
    TOraStoredProc *setCcStatusRefuseProc;
    TOraDataSource *getPreOverdueListDataSource;
    TDataSetFilter *getPreOverdueListFilter;
    TVirtualTable *getPreOverdueListRam;
    TOraStoredProc *getPreOverdueListProc;
    TFloatField *getPreOverdueListProcROWNUM;
    TFloatField *getPreOverdueListProcCHECK_DATA;
    TStringField *getPreOverdueListProcFA_ID;
    TStringField *getPreOverdueListProcACCT_ID;
    TDateTimeField *getPreOverdueListProcST_P_DT;
    TDateTimeField *getPreOverdueListProcSA_E_DT;
    TStringField *getPreOverdueListProcRT_TYPE;
    TStringField *getPreOverdueListProcFA_PACK_ID;
    TOraStoredProc *createFpOverdueProc;
    TOraDataSource *getFpOverdueContentDataSource;
    TDataSetFilter *getFpOverdueContentFilter;
    TVirtualTable *getFpOverdueContentRam;
    TOraStoredProc *getFpOverdueContentProc;
    TFloatField *getFpOverdueContentProcROWNUM;
    TFloatField *getFpOverdueContentProcCHECK_DATA;
    TStringField *getFpOverdueContentProcFA_ID;
    TStringField *getFpOverdueContentProcACCT_ID;
    TStringField *getFpOverdueContentProcFIO;
    TStringField *getFpOverdueContentProcSTOP_FA_ID;
    TStringField *getFpOverdueContentProcSTOP_FA_PACK_ID;
    TDateTimeField *getFpOverdueContentProcSTOP_CRE_DTTM;
    TStringField *getFpOverdueContentProcNOTICE_FA_ID;
    TStringField *getFpOverdueContentProcNOTICE_FA_PACK_ID;
    TDateTimeField *getFpOverdueContentProcNOTICE_CRE_DTTM;
    TDateTimeField *getFpOverdueContentProcST_P_DT;
    TStringField *getFpOverdueContentProcPHONES;
    TStringField *getFpOverdueContentProcCITY;
    TStringField *getFpOverdueContentProcADDRESS;
    TStringField *getFpOverdueContentProcPREM_TYPE_DESCR;
    TStringField *findFpStopListProcRT_CD;
    TStringField *findFpStopListProcRT_DESCR;
    TStringField *findFpStopListProcRT_ADDR;
    TStringField *findFpStopListProcRT_POST;
    TStringField *findFpStopListProcRT_NAME;
    TStringField *getPreOverdueListProcRT_CD;
    TStringField *getPreOverdueListProcRT_DESCR;
    TOraDataSource *getFpOverdueListDataSource;
    TDataSetFilter *getFpOverdueListFilter;
    TVirtualTable *getFpOverdueListRam;
    TOraStoredProc *getFpOverdueListProc;
    TFloatField *FloatField7;
    TFloatField *FloatField8;
    TStringField *StringField28;
    TDateTimeField *DateTimeField12;
    TDateTimeField *DateTimeField13;
    TStringField *StringField29;
    TStringField *StringField30;
    TFloatField *FloatField9;
    TStringField *StringField31;
    TStringField *StringField32;
    TStringField *StringField33;
    TStringField *StringField34;
    TStringField *StringField35;
    TStringField *StringField36;
    TStringField *StringField37;
    TStringField *StringField38;
    TStringField *StringField39;
    TStringField *StringField40;
    TStringField *StringField41;
    TStringField *StringField42;
    TStringField *getPreOverdueListProcACCT_OTDELEN;
    TStringField *getPreOverdueListProcRT_ADDR;
    TStringField *getPreOverdueListProcRT_NAME;
    TStringField *getPreOverdueListProcRT_POST;
    TStringField *getPreOverdueListProcCITY;
    TStringField *getPreOverdueListProcADDRESS;
    TStringField *getPreOverdueListProcFIO;
    TDateTimeField *getFpOverdueContentProcCC_DTTM;
    TOraDataSource *findFpOverdueListDataSource;
    TDataSetFilter *findFpOverdueListFilter;
    TOraStoredProc *findFpOverdueListProc;
    TVirtualTable *findFpOverdueListRam;
    TFloatField *findFpOverdueListProcROWNUM;
    TFloatField *findFpOverdueListProcCHECK_DATA;
    TStringField *findFpOverdueListProcFA_PACK_ID;
    TStringField *findFpOverdueListProcRT_CD;
    TStringField *findFpOverdueListProcRT_TYPE;
    TStringField *findFpOverdueListProcRT_DESCR;
    TStringField *findFpOverdueListProcRT_ADDR;
    TStringField *findFpOverdueListProcRT_POST;
    TStringField *findFpOverdueListProcRT_NAME;
    TStringField *findFpOverdueListProcSIGNER_NAME;
    TStringField *findFpOverdueListProcSIGNER_POST;
    TDateTimeField *findFpOverdueListProcCRE_DTTM;
    TStringField *findFpOverdueListProcFA_PACK_STATUS_FLG;
    TStringField *findFpOverdueListProcSGNR_NAME;
    TStringField *findFpOverdueListProcSGNR_POST;
    TStringField *findFpOverdueListProcOWNER;
    TStringField *findFpOverdueListProcFA_PACK_STATUS_DESCR;
    TStringField *findFpOverdueListProcFA_PACK_TYPE_DESCR;
    TFloatField *findFpOverdueListProcFA_CNT;
    TStringField *findFpOverdueListProcFA_PACK_TYPE_CD;
    TStringField *getPreOverdueListProcPREM_TYPE_CD;
    TStringField *getPreOverdueListProcPREM_TYPE_DESCR;
    TStringField *getOpAreaProcDESCR;
    TOraStoredProc *getFpOverdueInfoProc;
    TDateTimeField *DateTimeField15;
    TStringField *StringField45;
    TStringField *StringField46;
    TFloatField *FloatField11;
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

    void __fastcall FillProcListParameter(TDataSetFilter* dsFilter, const String& filterParamName, TOraStoredProc* procedure, const String& procParamName);
    void __fastcall CopyDataSet(TDataSet* sourceDs, TDataSet* destinationDs);
    void openOrRefresh(TDataSet* query);
    void __fastcall resetSession();


    //void __fastcall setAfterOpenEvent(TNotifyEvent event);
    void __fastcall setOpenDataSetEvents(TNotifyEvent beforeOpenDataSet, TNotifyEvent afterOpenDataSet);
    void __fastcall setOnChangeFilterMethod(TNotifyEvent onChangeFilterMethod);

    /* Для последующего обновления */
    void __fastcall closePreDebtorList();   // Список абонентов на уведомление
    void __fastcall closeFpStopList();      // Список реестров на ограничение
    void __fastcall closePreStopList();     // Список абонентов на ограничение

    void __fastcall closeFpCancelList();
    void __fastcall closeFpReconnectList();

    void __fastcall closePreOverdueList();
    void __fastcall closeFpOverdueList();


    void __fastcall closeFpStopContent();
    void __fastcall closeCcApprovalList();  // Список на утверждение;
    void __fastcall closeFaPackNoticesList();



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
        TAgentTypeCd::Type agentTypeCd,
        const String& agentId,
        const String& agentDescr,
        TCcTypeCd::Type ccTypeCd,
        TCcSourceTypeCd::Type ccSourceTypeCd
    );

    void updateCc(
        TDataSet* ds,
        Variant ccId,
        TDateTime ccDttm,
        const String& descr,
        TAgentTypeCd::Type agentTypeCd,
        const String& agentId,
        const String& agentDescr,
        TCcTypeCd::Type ccTypeCd
    );

    // недоделано 2017-03-14
    TDataSet* getCcInfo(const String& ccId);

    void __fastcall setCcStatusApproval();
    bool __fastcall setCcStatusRefuse();


    String __fastcall createFpNotice(TFaPackTypeCd faPackTypeCd = FPT_UNDEFINED);
    bool __fastcall createPackStop(bool forceSelf = false);
    //String __fastcall createFaPackFree(TFaPackTypeCd faPackTypeCd = FPT_UNDEFINED);
    bool __fastcall createFpCancelForce();
    bool __fastcall createFpOverdue();



    /* Data exchange with view */
    //void __fastcall setFilter(const String& filterName, const String& filterValue);
    void __fastcall setFilterParamValue(TDataSetFilter* filter, const String& filterName, const String& paramName, Variant paramValue);

    void __fastcall selectCcDttmIsNull(TDataSetFilter* filter);
    void __fastcall selectCcDttmMoreThanThree(TDataSetFilter* filter);
    void __fastcall setCheckAll(TDataSet* dataSet, bool value);


    String __fastcall getFpNoticesId() const;
    String __fastcall getFpStopId() const;
    String __fastcall getFpCancelId() const;
    String __fastcall getFpReconnectId() const;
    String __fastcall getFpOverdueId() const;

    /* Отображаемы списки */
    void __fastcall getAcctFullList();
    void __fastcall getPreDebtorList();
    void __fastcall getPrePostList();
    void __fastcall getPreOverdueList();

    void __fastcall getApprovalList();
    void __fastcall getStopList();
    void __fastcall getFpStopList();
    void __fastcall getFpCancelList();
    void __fastcall getFpReconnectList();
    void __fastcall getOpAreaList();



    /* Списки реестров */
    void __fastcall getFpList(TOraStoredProc* proc, TDataSetFilter* filter, TVirtualTable* vtable, const String& acctOtdelen);
    void __fastcall getFpOverdueList();



    /* Вспомогательные запросы */


    /* Для окна выбора реестра */
    void __fastcall findFaPackListNotices(const String& acctOtdelen, const String& faId = "", const String& acctId = "");
    void __fastcall findFaPackListStop(const String& acctOtdelen, const String& faId = "", const String& acctId = "");
    void __fastcall findFpOverdueList(const String& acctOtdelen, const String& faId = "", const String& acctId = "");

    /**/
    void __fastcall setAcctOtdelen(const String& acctOtdelen, bool updateOnly = false);
    Variant __fastcall getAcctOtdelen();


    /* Устанавливает текущий выбранный реестр для отображения */
    //void __fastcall setCurrentFp(const String& faPackId);
    void __fastcall setCurrentFp(TOraStoredProc* proc, TDataSetFilter* filter, TVirtualTable* vtable, TOraStoredProc* faPackInfProc, const String& faPackId);
    void __fastcall setCurrentFpNoticesId(const String& faPackId);
    void __fastcall setCurrentFpStopId(const String& faPackId);
    void __fastcall setCurrentFpCancel(const String& faPackId);
    void __fastcall setCurrentFpReconnect(const String& faPackId);
    void __fastcall setCurrentFpOverdue(const String& faPackId);



    bool __fastcall setFpStopStatusCancel();
    bool __fastcall setFpCancelStatusCancel();
    bool __fastcall setFpReconnectStatusCancel();
    bool __fastcall setFpOverdueStatusCancel();

    bool __fastcall deleteFaPack();
    bool __fastcall setFpStatusCancel(TDataSetFilter* filter);
    bool __fastcall setFaPackStatusFrozen();
    //bool __fastcall setFaPackCancelStopStatusComplete();
    void __fastcall setFaSaEndDt(TDataSet* ds, const String& faPackid,  TDateTime ccDttm);



    String __fastcall getFaPackStats();




    //String _currentFaPackTypeCd;      // Тип текущего реестр
    String _currentFaPackId;      // Текущий реестр
    //String _currentAcctOtdelen;     // Текущий участок

};
//---------------------------------------------------------------------------
extern PACKAGE TMainDataModule *MainDataModule;
//---------------------------------------------------------------------------
#endif
