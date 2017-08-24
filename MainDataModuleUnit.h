//---------------------------------------------------------------------------
/*
   ������ ��� ������ � ����� ������
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
    USER_BASE = 12, // ������� ������������
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
    TOraDataSource *getPreDebtorListDataSource;
    TOraStoredProc *CreateFaProc;
    TOraStoredProc *CreateFaPackProc;
    TOraDataSource *getFpNoticesContentDataSource;
    TOraStoredProc *addCcProc;
    TOraStoredProc *setCcStatusFlgProc;
    TOraDataSource *getApprovalListDataSource;
    TOraStoredProc *setCcApprovalProc;
    TDataSetFilter *getFpNoticesContentFilter;
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
    TOraDataSource *getPreStopListDataSource;
    TDataSetFilter *getPreStopListFilter;
    TOraDataSource *getOtdelenListDataSource;
    TOraQuery *getConfigQuery;
    TOraDataSource *getFpStopContentDataSource;
    TDataSetFilter *getFpStopContentFilter;
    TOraQuery *getFaPackStopInfoQuery;
    TFloatField *getFaPackStopInfoQueryROWNUM;
    TDateTimeField *getFaPackStopInfoQuerySYSDATE;
    TDateTimeField *getFaPackStopInfoQueryCRE_DTTM;
    TStringField *getFaPackStopInfoQueryACCT_OTDELEN;
    TStringField *getFaPackStopInfoQueryFA_PACK_ID;
    TOraDataSource *getFpStopListDataSource;
    TDataSetFilter *getFpStopListFilter;
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
    TVirtualTable *getPreStopListRam;
    TVirtualTable *getApprovalListRam;
    TVirtualTable *getFpNoticesContentRam;
    TVirtualTable *getFpStopContentRam;
    TVirtualTable *getFpStopListRam;
    TOraDataSource *getFpCancelListDataSource;
    TDataSetFilter *getFpCancelListFilter;
    TVirtualTable *getFpCancelStopRam;
    TOraStoredProc *deleteFaPackProc;
    TOraStoredProc *setFpStatusFlgCancelProc;
    TDataSetFilter *getOtdelenListFilter;
    TDataSetFilter *getFaPackInfoFilter;
    TOraStoredProc *getPreDebtorListProc;
    TOraDataSource *getPrePostListDataSource;
    TVirtualTable *getPrePostListRam;
    TOraStoredProc *getPrePostListProc;
    TOraStoredProc *getFpNoticesContentProc;
    TOraStoredProc *getApprovalListProc;
    TFloatField *getFpNoticesContentProcROWNUM;
    TFloatField *getFpNoticesContentProcCHECK_DATA;
    TStringField *getFpNoticesContentProcFA_ID;
    TStringField *getFpNoticesContentProcACCT_ID;
    TStringField *getFpNoticesContentProcADDRESS;
    TStringField *getFpNoticesContentProcCITY;
    TStringField *getFpNoticesContentProcFIO;
    TStringField *getFpNoticesContentProcPOSTAL;
    TDateTimeField *getFpNoticesContentProcCC_DTTM;
    TStringField *getFpNoticesContentProcSRC_TYPE_CD;
    TStringField *getFpNoticesContentProcSERVICE_ORG;
    TStringField *getFpNoticesContentProcPHONES;
    TStringField *getFpNoticesContentProcPHONE;
    TFloatField *getFpNoticesContentProcEND_REG_READING_SZ1;
    TFloatField *getFpNoticesContentProcEND_REG_READING1;
    TFloatField *getFpNoticesContentProcEND_REG_READING2;
    TFloatField *getFpNoticesContentProcSALDO_UCH;
    TStringField *getFpNoticesContentProcMTR_SERIAL_NBR;
    TStringField *getFpNoticesContentProcFA_PACK_ID;
    TStringField *getFpNoticesContentProcACCT_OTDELEN;
    TDateTimeField *getFpNoticesContentProcCRE_DTTM;
    TStringField *getFpNoticesContentProcOP_AREA_DESCR;
    TStringField *getFpNoticesContentProcFA_PACK_TYPE_CD;
    TFloatField *getFpNoticesContentProcCONT_QTY_SZ;
    TStringField *getFpNoticesContentProcCC_ID;
    TStringField *getFpNoticesContentProcCC_STATUS_FLG;
    TStringField *getFpNoticesContentProcCC_TYPE_CD;
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
    TOraStoredProc *getPreStopListProc;
    TFloatField *getPreStopListProcROWNUM;
    TFloatField *getPreStopListProcCHECK_DATA;
    TStringField *getPreStopListProcACCT_ID;
    TDateTimeField *getPreStopListProcAPPROVAL_DTTM;
    TDateTimeField *getPreStopListProcCC_DTTM;
    TStringField *getPreStopListProcFIO;
    TStringField *getPreStopListProcPOSTAL;
    TStringField *getPreStopListProcCITY;
    TStringField *getPreStopListProcADDRESS;
    TStringField *getPreStopListProcPREM_TYPE_DESCR;
    TFloatField *getPreStopListProcSALDO_UCH;
    TStringField *getPreStopListProcSPR_DESCR;
    TStringField *getPreStopListProcFA_PACK_ID;
    TStringField *getPreStopListProcFA_PACK_TYPE_DESCR;
    TOraStoredProc *getFpStopContentProc;
    TFloatField *getFpStopContentProcROWNUM;
    TFloatField *getFpStopContentProcCHECK_DATA;
    TStringField *getFpStopContentProcFA_ID;
    TStringField *getFpStopContentProcACCT_ID;
    TStringField *getFpStopContentProcADDRESS;
    TStringField *getFpStopContentProcCITY;
    TStringField *getFpStopContentProcFIO;
    TStringField *getFpStopContentProcPOSTAL;
    TDateTimeField *getFpStopContentProcCC_DTTM;
    TStringField *getFpStopContentProcSRC_TYPE_CD;
    TStringField *getFpStopContentProcSPR_DESCR;
    TStringField *getFpStopContentProcPHONES;
    TStringField *getFpStopContentProcPHONE;
    TFloatField *getFpStopContentProcEND_REG_READING1;
    TFloatField *getFpStopContentProcEND_REG_READING2;
    TFloatField *getFpStopContentProcSALDO_UCH;
    TStringField *getFpStopContentProcMTR_SERIAL_NBR;
    TStringField *getFpStopContentProcFA_PACK_ID;
    TStringField *getFpStopContentProcACCT_OTDELEN;
    TDateTimeField *getFpStopContentProcCRE_DTTM;
    TStringField *getFpStopContentProcOP_AREA_DESCR;
    TStringField *getFpStopContentProcFA_PACK_TYPE_CD;
    TFloatField *getFpStopContentProcGRP;
    TStringField *getFpStopContentProcPREM_TYPE_DESCR;
    TDateTimeField *getFpStopContentProcST_P_DT;
    TDateTimeField *getFpStopContentProcSA_END_DT;
    TOraStoredProc *getFpStopListProc;
    TOraStoredProc *getFpCancelListProc;
    TStringField *getFpNoticesContentProcOWNER;
    TFloatField *getFpStopListProcROWNUM;
    TFloatField *getFpStopListProcCHECK_DATA;
    TStringField *getFpStopListProcFA_PACK_ID;
    TDateTimeField *getFpStopListProcCRE_DTTM;
    TDateTimeField *getFpStopListProcST_P_DT;
    TStringField *getFpStopListProcOWNER;
    TStringField *getFpStopListProcFA_PACK_STATUS_DESCR;
    TFloatField *getFpCancelListProcROWNUM;
    TFloatField *getFpCancelListProcCHECK_DATA;
    TStringField *getFpCancelListProcFA_PACK_ID;
    TDateTimeField *getFpCancelListProcCRE_DTTM;
    TStringField *getFpCancelListProcFA_PACK_STATUS_FLG;
    TStringField *getFpCancelListProcPRNT_FA_ID;
    TStringField *getFpCancelListProcFA_ID;
    TStringField *getFpCancelListProcRT_ADDR;
    TStringField *getFpCancelListProcRT_POST;
    TStringField *getFpCancelListProcRT_NAME;
    TFloatField *getFpCancelListProcACCT_ID_CNT;
    TStringField *getFpCancelListProcOWNER;
    TOraDataSource *getAcctFullListDataSource;
    TOraDataSource *MainDataSource;
    TOraDataSource *findFaPackListNoticesDS;
    TDataSetFilter *findFaPackListNoticesFilter;
    TOraStoredProc *findFaPackListNoticesProc;
    TVirtualTable *findFaPackListNoticesRam;
    TOraDataSource *findFaPackListStopDS;
    TDataSetFilter *findFpStopListFilter;
    TOraStoredProc *findFpStopListProc;
    TVirtualTable *findFpStopListRam;
    TFloatField *getFpStopListProcFA_CNT;
    TOraStoredProc *getFpCancelContentTmpProc;
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
    TDateTimeField *getFpNoticesContentProcAPPROVAL_DTTM;
    TFloatField *findFaPackListNoticesProcFA_CNT;
    TStringField *getFpStopListProcFA_PACK_STATUS_FLG;
    TStringField *getFpStopListProcFA_PACK_TYPE_DESCR;
    TStringField *getPreDebtorListProcMR_RTE_CD;
    TStringField *getFpNoticesContentProcMR_RTE_CD;
    TOraStoredProc *setFaPackStatSentPerformerProc;
    TStringField *getFpCancelListProcFA_PACK_STATUS_DESCR;
    TStringField *getFpStopContentProcNOTICE_FA_ID;
    TDateTimeField *getFpStopContentProcNOTICE_CRE_DTTM;
    TStringField *getFpCancelContentTmpProcACCT_ID;
    TStringField *getFpCancelContentTmpProcFIO;
    TStringField *getFpCancelContentTmpProcSTOP_FA_ID;
    TStringField *getFpCancelContentTmpProcSTOP_FA_PACK_ID;
    TDateTimeField *getFpCancelContentTmpProcSTOP_CRE_DTTM;
    TStringField *getFpCancelContentTmpProcNOTICE_FA_ID;
    TStringField *getFpCancelContentTmpProcNOTICE_FA_PACK_ID;
    TDateTimeField *getFpCancelContentTmpProcNOTICE_CRE_DTTM;
    TDateTimeField *getFpCancelContentTmpProcST_P_DT;
    TStringField *getFpCancelContentTmpProcCITY;
    TStringField *getFpCancelContentTmpProcADDRESS;
    TStringField *getFpCancelContentTmpProcPREM_TYPE_DESCR;
    TOraStoredProc *getFaPackStatsProc;
    TStringField *getFaPackStatsProcACCT_OTDELEN;
    TStringField *getFaPackStatsProcACCT_OTDELEN_DESCR;
    TFloatField *getFaPackStatsProcFA_NOTICES_SELF;
    TFloatField *getFaPackStatsProcFA_NOTICES_POST;
    TFloatField *getFaPackStatsProcFA_PACK_STOP;
    TFloatField *getFaPackStatsProcFA_PACK_CANCEL;
    TDateTimeField *getConfigProcTODAY;
    TOraDataSource *getFpReconnectListDataSource;
    TDataSetFilter *getFpReconnectListFilter;
    TVirtualTable *getFpReconnectListRam;
    TOraStoredProc *getFpReconnectListProc;
    TFloatField *getFpReconnectListProcROWNUM;
    TFloatField *getFpReconnectListProcCHECK_DATA;
    TStringField *getFpReconnectListProcFA_PACK_ID;
    TDateTimeField *getFpReconnectListProcCRE_DTTM;
    TStringField *getFpReconnectListProcFA_PACK_STATUS_FLG;
    TStringField *getFpReconnectListProcPRNT_FA_ID;
    TStringField *getFpReconnectListProcRT_ADDR;
    TStringField *getFpReconnectListProcRT_POST;
    TStringField *getFpReconnectListProcRT_NAME;
    TStringField *getFpReconnectListProcFA_PACK_STATUS_DESCR;
    TFloatField *getFpReconnectListProcACCT_ID_CNT;
    TStringField *getFpReconnectListProcOWNER;
    TOraStoredProc *getFpReconnectContentTmpProc;
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
    TStringField *getFpReconnectContentTmpProcPHONES;
    TStringField *getConfigProcSTOP_ALLERT;
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
    TStringField *getFpStopListProcRT_TYPE;
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
    TFloatField *getFpCancelContentTmpProcSTOP_SALDO_UCH;
    TStringField *findFpStopListProcRT_TYPE;
    TDateTimeField *getFpStopContentProcST_P_DT_END;
    TDateTimeField *getFpStopContentProcCANCEL_FA_PACK_CRE_DTTM;
    TStringField *getFpStopContentProcCANCEL_FA_PACK_ID;
    TStringField *getPreStopListProcCTR_DESCR;
    TOraStoredProc *createFpNoticeProc;
    TOraStoredProc *setFaSaEndDtProc;
    TDateTimeField *getFpStopContentProcSA_E_DT;
    TVirtualTable *getFpCancelContentRam;
    TDataSetFilter *getFpCancelContentFilter;
    TOraStoredProc *getFpCancelContentProc;
    TFloatField *FloatField1;
    TFloatField *FloatField2;
    TStringField *StringField5;
    TStringField *StringField6;
    TStringField *StringField7;
    TStringField *StringField8;
    TStringField *StringField9;
    TStringField *StringField10;
    TDateTimeField *DateTimeField2;
    TStringField *StringField11;
    TStringField *StringField12;
    TStringField *StringField13;
    TStringField *StringField14;
    TFloatField *FloatField3;
    TFloatField *FloatField4;
    TFloatField *FloatField5;
    TStringField *StringField15;
    TStringField *StringField16;
    TStringField *StringField17;
    TDateTimeField *DateTimeField3;
    TStringField *StringField18;
    TStringField *StringField19;
    TFloatField *FloatField6;
    TStringField *StringField20;
    TDateTimeField *DateTimeField4;
    TDateTimeField *DateTimeField5;
    TStringField *StringField26;
    TDateTimeField *DateTimeField6;
    TDateTimeField *DateTimeField7;
    TDateTimeField *DateTimeField10;
    TStringField *StringField27;
    TDateTimeField *DateTimeField11;
    TOraDataSource *getFpCancelContentDataSource;
    TVirtualTable *getFpReconnectContentRam;
    TDataSetFilter *getFpReconnectContentFilter;
    TOraStoredProc *getFpReconnectContentProc;
    TOraDataSource *getFpReconnectContentDataSource;
    TStringField *findFpStopListProcFA_PACK_TYPE_CD;
    TFloatField *findFaPackListNoticesProcCNT;
    TStringField *getFpReconnectListProcSGNR_NAME;
    TStringField *getFpReconnectListProcSGNR_POST;
    TFloatField *getFpCancelContentTmpProcROWNUM;
    TFloatField *getFpCancelContentTmpProcCHECK_DATA;
    TDateTimeField *getFpCancelContentTmpProcCC_DTTM;
    TStringField *getConfigProcAPP_VER;
    TStringField *getConfigProcSERVICE_STOP_ALLERT;
    TStringField *getConfigProcNEEDS_APP_UPDATE;
    TStringField *getConfigProcUPDATE_FAILURE;
    TStringField *getConfigProcOTHER_STOP_REASON;
    TStringField *getFpCancelListProcSIGNER_NAME;
    TStringField *getFpCancelListProcSIGNER_POST;
    TStringField *getFpStopListProcSIGNER_NAME;
    TStringField *getFpStopListProcSIGNER_POST;
    TFloatField *getFpStopContentProcNOTICE_SALDO_UCH;
    TFloatField *getFpStopContentProcNOTICE_END_REG_READING1;
    TFloatField *getFpStopContentProcNOTICE_END_REG_READING2;
    TStringField *getFpCancelContentProcSTOP_FA_ID;
    TStringField *getFpCancelContentProcSTOP_FA_PACK_ID;
    TFloatField *getFpCancelContentProcSTOP_SALDO_UCH;
    TDateTimeField *getFpCancelContentProcSTOP_CRE_DTTM;
    TStringField *getFpCancelContentProcNOTICE_FA_PACK_ID;
    TFloatField *getFpReconnectContentProcROWNUM;
    TFloatField *getFpReconnectContentProcCHECK_DATA;
    TStringField *getFpReconnectContentProcACCT_ID;
    TStringField *getFpReconnectContentProcFIO;
    TStringField *getFpReconnectContentProcSTOP_FA_ID;
    TStringField *getFpReconnectContentProcSTOP_FA_PACK_ID;
    TDateTimeField *getFpReconnectContentProcSTOP_CRE_DTTM;
    TStringField *getFpReconnectContentProcNOTICE_FA_ID;
    TStringField *getFpReconnectContentProcNOTICE_FA_PACK_ID;
    TDateTimeField *getFpReconnectContentProcNOTICE_CRE_DTTM;
    TDateTimeField *getFpReconnectContentProcST_P_DT;
    TStringField *getFpReconnectContentProcPHONES;
    TStringField *getFpReconnectContentProcCITY;
    TStringField *getFpReconnectContentProcADDRESS;
    TStringField *getFpReconnectContentProcPREM_TYPE_DESCR;
    TStringField *getFpReconnectContentProcFA_ID;
    TOraStoredProc *setCcStatusRefuseProc;
    TStringField *getApprovalListProcCC_STATUS_FLG;
    TStringField *getApprovalListProcCC_STATUS_DESCR;
    TStringField *getApprovalListProcAPPROVAL_USER;
    TStringField *getApprovalListProcCC_TYPE_CD;
    TStringField *getApprovalListProcCC_TYPE_DESCR;
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
    TStringField *getFpStopListProcRT_CD;
    TStringField *getFpStopListProcRT_DESCR;
    TStringField *getFpStopListProcRT_ADDR;
    TStringField *getFpStopListProcRT_POST;
    TStringField *getFpStopListProcRT_NAME;
    TStringField *getFpStopListProcSGNR_NAME;
    TStringField *getFpStopListProcSGNR_POST;
    TStringField *getFpCancelListProcRT_DESCR;
    TStringField *getFpCancelListProcSGNR_NAME;
    TStringField *getFpCancelListProcSGNR_POST;
    TStringField *getFpCancelContentTmpProcFA_ID;
    TDateTimeField *getFpCancelContentTmpProcST_P_DT_END;
    TStringField *getFpReconnectListProcRT_DESCR;
    TFloatField *getFpReconnectContentTmpProcROWNUM;
    TFloatField *getFpReconnectContentTmpProcCHECK_DATA;
    TStringField *getFpReconnectContentTmpProcFA_ID;
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
    TThreadDataSet* _threadDataSet; // ����� ��� �������� ��������

    /* ������������� � ����������� ����������� */
    TNotifyEvent _afterOpenDataSet;
    TNotifyEvent _beforeOpenDataSet;
    TNotifyEvent _onChangeFilterMethod;

    TField* _acctOtdelen;           // ������� ���������
    TDataSetFilter* _currentFilter; // ������� ������



public:		// User declarations
    __fastcall TMainDataModule(TComponent* Owner);
    void __fastcall connectEsale();

    void __fastcall FillProcListParameter(TDataSetFilter* dsFilter, const String& filterParamName, TOraStoredProc* procedure, const String& procParamName);
    void __fastcall CopyDataSet(TDataSet* sourceDs, TDataSet* destinationDs);
    void openOrRefresh(TDataSet* query);

    //void __fastcall setAfterOpenEvent(TNotifyEvent event);
    void __fastcall setOpenDataSetEvents(TNotifyEvent beforeOpenDataSet, TNotifyEvent afterOpenDataSet);
    void __fastcall setOnChangeFilterMethod(TNotifyEvent onChangeFilterMethod);

    /* ��� ������������ ���������� */
    void __fastcall closePreDebtorList();   // ������ ��������� �� �����������
    void __fastcall closeFpStopList();      // ������ �������� �� �����������
    void __fastcall closePreStopList();     // ������ ��������� �� �����������

    void __fastcall closeFpCancelStopList();
    void __fastcall closeFpReconnectList();

    void __fastcall closePreOverdueList();
    void __fastcall closeFpOverdueList();


    void __fastcall closeFpStopContent();
    void __fastcall closeCcApprovalList();  // ������ �� �����������;
    void __fastcall closeFaPackNoticesList();



    TUserRole::TRoleTypes userRole; // ���� ����������
    String username;    // ��� ������������

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
        //TCcStatusFlg::Type ccStatusFlg,
        TCcSourceTypeCd::Type ccSourceTypeCd
    );

    void updateCc(
        TDataSet* ds,
        Variant ccId,
        TDateTime ccDttm,
        const String& descr,
        const String& caller,
        TCcTypeCd::Type ccTypeCd/*,
        TCcStatusFlg::Type ccStatusFlg */
    );

    // ���������� 2017-03-14
    TFields* getCcInfo(const String& ccId);

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

    /* ����������� ������ */
    void __fastcall getAcctFullList();
    void __fastcall getPreDebtorList();
    void __fastcall getPrePostList();
    void __fastcall getPreOverdueList();

    void __fastcall getApprovalList();
    void __fastcall getStopList();
    void __fastcall getFpStopList();
    void __fastcall getFpCancelList();
    void __fastcall getFpReconnectList();



    /* ������ �������� */
    void __fastcall getFpList(TOraStoredProc* proc, TDataSetFilter* filter, TVirtualTable* vtable, const String& acctOtdelen);
    void __fastcall getFpOverdueList();



    /* ��������������� ������� */


    /* ��� ���� ������ ������� */
    void __fastcall findFaPackListNotices(const String& acctOtdelen, const String& faId = "", const String& acctId = "");
    void __fastcall findFaPackListStop(const String& acctOtdelen, const String& faId = "", const String& acctId = "");
    void __fastcall findFpOverdueList(const String& acctOtdelen, const String& faId = "", const String& acctId = "");

    /**/
    void __fastcall setAcctOtdelen(const String& acctOtdelen, bool updateOnly = false);
    Variant __fastcall getAcctOtdelen();


    /* ������������� ������� ��������� ������ ��� ����������� */
    void __fastcall setCurrentFp(const String& faPackId);
    void __fastcall setCurrentFp(TOraStoredProc* proc, TDataSetFilter* filter, TVirtualTable* vtable, const String& faPackId);
    void __fastcall setCurrentFpNoticesId(const String& faPackId);
    void __fastcall setCurrentFpStopId(const String& faPackId);
    void __fastcall setCurrentFpCancel(const String& faPackId);
    void __fastcall setCurrentFpReconnect(const String& faPackId);
    void __fastcall setCurrentFpOverdue(const String& faPackId);




    bool __fastcall deleteFaPack();
    bool __fastcall setFaPackStatusIncomplete();
    bool __fastcall setFaPackStatusFrozen();
    //bool __fastcall setFaPackCancelStopStatusComplete();
    void __fastcall setFaSaEndDt(TDataSet* ds, const String& faPackid,  TDateTime ccDttm);



    String __fastcall getFaPackStats();




    //String _currentFaPackTypeCd;      // ��� �������� ������
    //String _currentFaPackId;      // ������� ������
    //String _currentAcctOtdelen;     // ������� �������

};
//---------------------------------------------------------------------------
extern PACKAGE TMainDataModule *MainDataModule;
//---------------------------------------------------------------------------
#endif
