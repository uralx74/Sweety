//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#pragma package(smart_init)

#include "ThreadDataSet.h"


__fastcall TThreadDataSet::TThreadDataSet(bool CreateSuspended, TOraQuery* query, TDataSet* destinationDataSet,  TThreadEvent ThreadEvent)
    : TThread(CreateSuspended)
{
    FreeOnTerminate = true;
    Suspended = true;


    //_notifyEvent = NotifyEvent;
    _threadEvent = ThreadEvent;

    _oraSession = new TOraSession(NULL);

    _dataSet = new TOraQuery(NULL);
    _dataSet->Assign(query);
    _dataSet->FetchAll = true;

    _oraSession->AssignConnect(query->Session);
    _dataSet->Session = _oraSession;

    if (destinationDataSet != NULL)
    {
        _destinationDataSet = destinationDataSet;
        destinationDataSet->Close();
    }


    if ( !CreateSuspended )
    {
        Resume();
    } 


    //WParamResultMessage = 0;
    //LParamResultMessage = 0;
    /*AppPath = ExtractFilePath(Application->ExeName);

    SetThreadOpt(threadopt);
    _threadIndex++;

    randomize();
    _threadId = random(9999999999);*/
}

/**/
/*
__fastcall TThreadDataSet::TThreadDataSet(bool CreateSuspended, TOraQuery* query, TDataSet* destinationDataSet,  TDataSetNotifyEvent NotifyEvent)
    : TThread(CreateSuspended)
{
    FreeOnTerminate = true;
    Suspended = true;


    _notifyEvent = NotifyEvent;

    _oraSession = new TOraSession(NULL);

    _dataSet = new TOraQuery(NULL);
    _dataSet->Assign(query);
    _dataSet->FetchAll = true;

    _oraSession->AssignConnect(query->Session);
    _dataSet->Session = _oraSession;

    _destinationDataSet = destinationDataSet;


    if ( !CreateSuspended )
    {
        Resume();
    } 


    //WParamResultMessage = 0;
    //LParamResultMessage = 0;
    /*AppPath = ExtractFilePath(Application->ExeName);

    SetThreadOpt(threadopt);
    _threadIndex++;

    randomize();
    _threadId = random(9999999999);*/  /*
} */

/**/
__fastcall TThreadDataSet::~TThreadDataSet()
{
    delete _dataSet;
    delete _oraSession;
}

/**/
void __fastcall TThreadDataSet::Execute()
{
    Synchronize(SyncBeginThread);

    try
    {
        if (_dataSet != NULL)
        {
            _dataSet->Open();
        }
    }
    catch(Exception &e)
    {   // Если произошла ошибка при открытии запроса
        _message = e.Message;
        Synchronize(SyncThreadError);
        return;
    }
    Synchronize(SyncEndThread);
}

/* Синхронизация - Поток запущен */
void __fastcall  TThreadDataSet::SyncBeginThread()
{
    try
    {
        if ( _threadEvent != NULL )
        {
            _threadEvent(TEM_THREAD_BEGIN, NULL);
        }
    } catch(...)
    {
    }
}

/* Синхронизация - поток завершен */
void __fastcall  TThreadDataSet::SyncEndThread()
{
    try
    {
        if ( _threadEvent != NULL )
        {
            _threadEvent(TEM_DATASET_COPY_BEGIN, NULL);
        }
        if (_destinationDataSet != NULL)
        {
            try {
                CopyDataSet(_dataSet, _destinationDataSet);
            }
            catch(Exception &e)
            {
                _message = "Произошла ошибка при извлечении данных.\n" + e.Message;
                throw Exception(_message);
            }
        }
        if ( _threadEvent != NULL )
        {
            _threadEvent(TEM_THREAD_END, _dataSet);
        }
    }
    catch(Exception &e)
    {
        _threadEvent(TEM_DATABASE_ERROR, (void*)&(e.Message)); // здесь может использовать e.Message
    }
}

/* Синхронизация - поток завершен */
void __fastcall  TThreadDataSet::SyncThreadError()
{
    try
    {
        if ( _threadEvent != NULL )
        {
            _threadEvent(TEM_DATABASE_ERROR, (void*)&_message);
        }
    }
    catch(...)
    {
    }
}


/* Копирует данные из источника в приемник */
void __fastcall TThreadDataSet::CopyDataSet(TDataSet* sourceDs, TDataSet* destinationDs)
{
    destinationDs->DisableControls();
    destinationDs->FieldDefs->Assign(sourceDs->FieldDefs);
    destinationDs->Open();
    destinationDs->Assign(sourceDs);
    destinationDs->EnableControls();
    //ShowMessage(MainDataModule->VirtualTable1->RecordCount);
    //DBGridAltGeneral->DataSource->DataSet = MainDataModule->VirtualTable1;
    //MainDataModule->VirtualTable1->Filtered = true;
}



