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



class TOraUniObject
{
public:    //virtual void CopyDataSet();
    //virtual TOraUniObject();
    virtual TDataSet* getDataSet() {};
    virtual void Open() {};
    virtual ~TOraUniObject() {};

};

class TOraObjectQuery: public TOraUniObject
{
public:
    TOraObjectQuery(TOraQuery* query)
    {
        oraQuery = new TOraQuery(NULL);
    };
    virtual ~TOraObjectQuery()
    {
        delete oraQuery;
    };
    TOraQuery* oraQuery;

    virtual TDataSet* getDataSet()
    {
        return oraQuery;
    }
    virtual void Open()
    {
        oraQuery->Open();
    };

};

class TOraObjectProc: public TOraUniObject
{
public:
    TOraObjectProc(TOraStoredProc* proc)
    {
        oraProc = new TOraStoredProc(NULL);
    };
    virtual ~TOraObjectProc()
    {
        delete oraProc;
    };
    TOraStoredProc* oraProc;

    virtual TDataSet* getDataSet()
    {
        return oraProc;
    }
    virtual void Open()
    {
        oraProc->Open();
    };

};



//---------------------------------------------------------------------------
class TThreadDataSet : public TThread
{
private:

    TOraQuery* _dataSet;
    TOraUniObject* _uniObject;
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
    __fastcall TThreadDataSet(bool CreateSuspended, TOraStoredProc* proc, TDataSet* destinationDataSet = NULL, TThreadEvent ThreadEvent = NULL);

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
