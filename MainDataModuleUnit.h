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
    TOraDataSource *getDebtorsDataSource;
    TOraStoredProc *CreateFaProc;
    TOraStoredProc *CreateFaPackProc;
    TOraDataSource *getFaPackListNoticesDataSource;
    TOraQuery *getOtdelenList_old;
    TOraQuery *OraQuery2;
    TFloatField *OraQuery2ROWNUM;
    TStringField *OraQuery2ACCT_ID;
    TStringField *OraQuery2FIO;
    TStringField *OraQuery2CITY;
    TStringField *OraQuery2ADDRESS;
    TFloatField *OraQuery2SALDO_UCH;
    TFloatField *OraQuery2SALDO_M3;
    TDateTimeField *OraQuery2CC_DTTM;
    TStringField *OraQuery2FA_ID;
    TStringField *OraQuery2FA_PACK_ID;
    TDateTimeField *OraQuery2CRE_DTTM;
    TStringField *OraQuery2ACCT_OTDELEN;
    TStringField *OraQuery2SERVICE_ORG;
    TOraDataSource *getFaPackDataSource;
    TOraStoredProc *addCcProc;
    TOraStoredProc *setCcStatusFlgProc;
    TOraDataSource *getApprovalListDataSource;
    TOraStoredProc *setCcApprovalProc;
    TDataSetFilter *getFaPackNoticesFilter;
    TDataSetFilter *getFaPackListNoticesFilter;
    TDataSetFilter *getApprovalListFilter;
    TDataSetFilter *getDebtorsFilter;
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
    TOraQuery *OraQuery3_old;
    TFloatField *FloatField4;
    TStringField *StringField5;
    TStringField *StringField6;
    TStringField *StringField7;
    TStringField *StringField8;
    TFloatField *FloatField5;
    TFloatField *FloatField6;
    TDateTimeField *DateTimeField2;
    TStringField *StringField9;
    TStringField *StringField10;
    TDateTimeField *DateTimeField3;
    TStringField *StringField11;
    TStringField *StringField12;
    TFloatField *FloatField7;
    TOraQuery *getOtdelenListQuery;
    TOraQuery *getApprovalListQuery_old;
    TFloatField *FloatField8;
    TFloatField *FloatField9;
    TStringField *StringField13;
    TStringField *StringField14;
    TStringField *StringField15;
    TStringField *StringField16;
    TFloatField *FloatField10;
    TDateTimeField *DateTimeField4;
    TStringField *StringField17;
    TStringField *StringField18;
    TDateTimeField *DateTimeField5;
    TStringField *StringField19;
    TStringField *StringField20;
    TOraQuery *getConfigQuery;
    TOraQuery *OraQuery33333333333333;
    TFloatField *FloatField3;
    TStringField *StringField27;
    TStringField *StringField28;
    TStringField *StringField29;
    TStringField *StringField30;
    TFloatField *FloatField11;
    TFloatField *FloatField12;
    TDateTimeField *DateTimeField6;
    TStringField *StringField31;
    TStringField *StringField32;
    TDateTimeField *DateTimeField7;
    TStringField *StringField33;
    TStringField *StringField34;
    TFloatField *FloatField13;
    TStringField *StringField35;
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
    TOraStoredProc *AddFaToPackStopProc_;
    TDateTimeField *getConfigQuerySYSDATE;
    TStringField *getConfigQueryAPP_PATH;
    TStringField *getConfigQueryVISA_PATH;
    TStringField *getConfigQueryREPORT_PATH;
    TStringField *getConfigQueryUSERNAME;
    TVirtualTable *getDebtorsRam;
    TStringField *getOtdelenListQueryOTDELEN_DESCR;
    TStringField *getOtdelenListQueryADDRESS;
    TStringField *getOtdelenListQueryNACHALNIK;
    TStringField *getOtdelenListQueryPHONE;
    TStringField *getOtdelenListQueryCCB_ACCT_CHAR_VAL;
    TStringField *getOtdelenListQueryVISA;
    TStringField *getOtdelenListQueryPOST;
    TDataSetFilter *getPostListFilter;
    TOraStoredProc *updateCcProc;
    TOraStoredProc *deleteCcProc;
    TOraStoredProc *setFaPackStatusFlgFrozenProc;
    TOraQuery *getFullListQuery;
    TFloatField *FloatField19;
    TFloatField *FloatField20;
    TStringField *StringField50;
    TStringField *StringField51;
    TStringField *StringField52;
    TStringField *StringField53;
    TFloatField *FloatField21;
    TFloatField *FloatField22;
    TDateTimeField *DateTimeField10;
    TStringField *StringField54;
    TStringField *StringField55;
    TDateTimeField *DateTimeField11;
    TStringField *StringField56;
    TStringField *StringField57;
    TStringField *StringField58;
    TStringField *StringField59;
    TDataSetFilter *getFullListFilter;
    TVirtualTable *getFullListRam;
    TVirtualTable *getStopListRam;
    TVirtualTable *getApprovalListRam;
    TVirtualTable *getFaPackRam;
    TFloatField *getFullListQueryDEBTOR_FLG;
    TVirtualTable *getFaPackStopRam;
    TVirtualTable *getPackListStopRam;
    TStringField *getOtdelenListQueryACCT_OTDELEN;
    TOraDataSource *getCancelStopListDataSource;
    TDataSetFilter *getFaPackListCancelStopFilter;
    TVirtualTable *getCancelStopListRam;
    TOraStoredProc *deleteFaPackProc;
    TOraStoredProc *setFaPackStatusFlgCancelProc;
    TOraStoredProc *updateFaPackCharRecipientProc;
    TStringField *getOtdelenListQueryDESCR_L;
    TDataSetFilter *getOtdelenListFilter;
    TDataSetFilter *getFaPackInfoFilter;
    TOraStoredProc *getDebtorListProc;
    TOraDataSource *OraDataSource1;
    TVirtualTable *VirtualTable1;
    TOraDataSource *getPostListDataSource;
    TVirtualTable *getPostListRam;
    TOraStoredProc *getPostListProc;
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
    TFloatField *getDebtorListProcROWNUM;
    TFloatField *getDebtorListProcCHECK_DATA;
    TStringField *getDebtorListProcACCT_ID;
    TStringField *getDebtorListProcFIO;
    TStringField *getDebtorListProcCITY;
    TStringField *getDebtorListProcADDRESS;
    TStringField *getDebtorListProcPREM_TYPE_DESCR;
    TFloatField *getDebtorListProcSALDO_UCH;
    TFloatField *getDebtorListProcSALDO_M3;
    TDateTimeField *getDebtorListProcCC_DTTM;
    TStringField *getDebtorListProcFA_ID;
    TStringField *getDebtorListProcFA_PACK_ID;
    TDateTimeField *getDebtorListProcCRE_DTTM;
    TStringField *getDebtorListProcACCT_OTDELEN;
    TStringField *getDebtorListProcSERVICE_ORG;
    TStringField *getDebtorListProcOP_AREA_DESCR;
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
    TOraStoredProc *getCancelStopListProc;
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
    TFloatField *getCancelStopListProcROWNUM;
    TFloatField *getCancelStopListProcCHECK_DATA;
    TStringField *getCancelStopListProcFA_PACK_ID;
    TDateTimeField *getCancelStopListProcCRE_DTTM;
    TStringField *getCancelStopListProcFA_PACK_STATUS_FLG;
    TStringField *getCancelStopListProcPRNT_FA_ID;
    TStringField *getCancelStopListProcFA_ID;
    TStringField *getCancelStopListProcRT_SPR;
    TStringField *getCancelStopListProcRT_ADDR;
    TStringField *getCancelStopListProcRT_POST;
    TStringField *getCancelStopListProcRT_NAME;
    TFloatField *getCancelStopListProcACCT_ID_CNT;
    TStringField *getCancelStopListProcOWNER;
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
    TOraDataSource *getFullListDataSource;
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
    TOraStoredProc *getFaPackCancelStopProc;
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
    TFloatField *findFaPackListNoticesProcCNT;
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
    TStringField *getFaPackCancelStopProcACCT_ID;
    TStringField *getFaPackCancelStopProcFIO;
    TStringField *getFaPackCancelStopProcSTOP_FA_ID;
    TStringField *getFaPackCancelStopProcSTOP_PACK_ID;
    TDateTimeField *getFaPackCancelStopProcSTOP_CRE_DTTM;
    TStringField *getFaPackCancelStopProcNOTICE_FA_ID;
    TStringField *getFaPackCancelStopProcNOTICE_PACK_ID;
    TDateTimeField *getFaPackCancelStopProcNOTICE_CRE_DTTM;
    TDateTimeField *getFaPackCancelStopProcST_P_DT;
    TStringField *getFaPackCancelStopProcCITY;
    TStringField *getFaPackCancelStopProcADDRESS;
    TStringField *getFaPackCancelStopProcPREM_TYPE_DESCR;
    TOraStoredProc *getOtdelenListProc;
    TStringField *getOtdelenListProcOTDELEN_DESCR;
    TStringField *getOtdelenListProcACCT_OTDELEN;
    TStringField *getOtdelenListProcADDRESS;
    TStringField *getOtdelenListProcNACHALNIK;
    TStringField *getOtdelenListProcPHONE;
    TStringField *getOtdelenListProcCCB_ACCT_CHAR_VAL;
    TStringField *getOtdelenListProcPOST;
    TStringField *getOtdelenListProcDESCR_L;
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
    void __fastcall DataModuleCreate(TObject *Sender);
    void __fastcall OnFilterChange(TDataSetFilter *Sender,
          AnsiString filterName);
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
    void __fastcall closeDebtorsQuery();    // Список абонентов на уведомление
    void __fastcall closePackStopList();    // Список реестров на ограничение
    void __fastcall closeStopList();        // Список абонентов на ограничение
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



    //String setCcApprovalDttm(String ccId, bool cancelApproval = false);
    void setCcApproval();

    Variant __fastcall createPackNotice(TFaPackTypeCd faPackTypeCd = FPT_UNDEFINED);
    std::vector<Variant> __fastcall createPackStop(bool useGrpFilter = true);
    Variant __fastcall createFaPackFree(TFaPackTypeCd faPackTypeCd = FPT_UNDEFINED);


    String __fastcall createPackMulti(TDataSetFilter* filter, TFaPackTypeCd faPackTypeCd, const String& acctOtdelen);
    //String __fastcall createPack(TPackTypeCd::Type packTypeCd);

    /* Connect with form */
    //void __fastcall setFilter(const String& filterName, const String& filterValue);
    void __fastcall setFilterParamValue(TDataSetFilter* filter, const String& filterName, const String& paramName, Variant paramValue);

    void __fastcall selectCcDttmIsNull(TDataSetFilter* filter);
    void __fastcall selectCcDttmMoreThanThree(TDataSetFilter* filter);
    void __fastcall setCheckAll(TDataSet* dataSet, bool value);

    /* Отображаемы списки */
    void __fastcall getFullList();
    void __fastcall getDebtorList();
    void __fastcall getPostList();
    void __fastcall getApprovalList();
    void __fastcall getStopList();
    void __fastcall getPackStopList();
    void __fastcall getFaCancelStopList();

    /* Вспомогательные запросы */
    //void __fastcall getFaPack(const String& faPackId, String& acctOtdelen);
   // void __fastcall getFaPack(const String& faPackId);


    /* Для окна выбора реестра */
    void __fastcall findFaPackListNotices(const String& acctOtdelen);
    void __fastcall findFaPackListStop(const String& acctOtdelen);
    //void __fastcall getFaPackNoticesList(const String& acctOtdelen,  int mode /*const String& faPackTypeCd*/);

    //void __fastcall clearAllFilters();

    /**/
    void __fastcall setAcctOtdelen(const Variant acctOtdelen, bool updateOnly = false);
    //String __fastcall getAcctOtdelenByFaPackId(const String& faPackId);
    Variant __fastcall getAcctOtdelen();

    void __fastcall setFaPack(const Variant faPackId);


    void __fastcall setFaPackId_Notice(const String& faPackId);
    void __fastcall setFaPackId_Stop(const String& faPackId);
    String __fastcall getFaPackId_Notice() const;
    String __fastcall getFaPackId_Stop() const;
    bool __fastcall deleteFaPack();
    bool __fastcall setFaPackStatusIncomplete();
    bool __fastcall setFaPackStatusFrozen();



    void __fastcall TestGetRefCursor();
    //String _currentFaPackTypeCd;      // Тип текущего реестр
    //String _currentFaPackId;      // Текущий реестр
    //String _currentAcctOtdelen;     // Текущий участок

};
//---------------------------------------------------------------------------
extern PACKAGE TMainDataModule *MainDataModule;
//---------------------------------------------------------------------------
#endif
