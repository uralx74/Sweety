//---------------------------------------------------------------------------

#ifndef ThreadDataSetH
#define ThreadDataSetH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include "Ora.hpp"
#include "math.h"
#include <DB.hpp>
#include "MemDS.hpp"
#include "DBAccess.hpp"


/*typedef void (*TThreadEvent)(int, TDataSet*);
typedef void (*TThreadEvent1)();
typedef int (*t_somefunc)(int,int);*/

typedef enum _TThreadEventMessage
{
    TEM_ERROR = 0,              // Ошибка
    TEM_THREAD_BEGIN,           // Поток запущен
    TEM_THREAD_END,             // Поток завершен
    TEM_DATABASE_ERROR,             // Поток завершен
    TEM_DATASET_COPY_BEGIN      // Начало процесса копирования DataSet

} TThreadEventMessage;

//typedef void __fastcall (__closure *TThreadEvent)(TThreadEventMessage, TDataSet* DataSet);
typedef void __fastcall (__closure *TThreadEvent)(TThreadEventMessage, void* DataSet);



//---------------------------------------------------------------------------
class TThreadDataSet : public TThread
{
private:

    TOraQuery* _dataSet;
    TOraSession* _oraSession;

    TThreadEvent _threadEvent;
    String _message;
    //TDataSetNotifyEvent _notifyEvent;


    void __fastcall  SyncBeginThread();
    void __fastcall  SyncEndThread();
    void __fastcall  SyncThreadError();

    //TNotifyEvent FOnChangeCheck;
    //**TOnDataEvent fOnData;


public:
    //__fastcall ThreadSelect(bool CreateSuspended, THREADOPTIONS* threadopt, void (*f)(const String&, int));
    __fastcall TThreadDataSet(bool CreateSuspended, TOraQuery* query, TDataSet* destinationDataSet = NULL, TThreadEvent ThreadEvent = NULL);


    //__fastcall TThreadDataSet(bool CreateSuspended, TOraQuery* query, TDataSet* destinationDataSet = NULL, TDataSetNotifyEvent NotifyEvent = NULL);
    __fastcall ~TThreadDataSet();
    void __fastcall Execute();
    
    //TOraSession* __fastcall CreateOraSession(TOraSession* TemplateOraSession);
    //void __fastcall SyncThreadChangeStatus();

private:
    HWND ParentFormHandle;
    TDataSet* _destinationDataSet;
    void __fastcall CopyDataSet(TDataSet* sourceDs, TDataSet* destinationDs);


};
//---------------------------------------------------------------------------

#endif
