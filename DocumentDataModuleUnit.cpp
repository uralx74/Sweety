//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "DocumentDataModuleUnit.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DataSetFilter"
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma link "OraSmart"
#pragma resource "*.dfm"
TDocumentDataModule *DocumentDataModule;
//---------------------------------------------------------------------------
__fastcall TDocumentDataModule::TDocumentDataModule(TComponent* Owner)
    : TDataModule(Owner)
{
    documentWriter = new TDocumentWriter();

    // Фильтр для выбора выделенных строк
    // аналог getCheckedFilter из MainDataModule
    getCheckedFilter->add("checked", "check_data = :param"); // Отмеченные

}

__fastcall TDocumentDataModule::~TDocumentDataModule()
{
    delete documentWriter;
}

/* Функция для подготовки к выводу данных
   Фильтрует dataset оставляя только отмеченные */
void __fastcall TDocumentDataModule::BeginPrint(TDataSetFilter* dsFilter)
{
    dsFilter->LockDataSetPos();      // Запоминаем позицию в dataset
    //mergeFields->DisableControls();     // Блокируем отображение изменений dataset

    // Внимание, здесь, использовать локальный фильтр
    //MainDataModule->getCheckedFilter->setValue("group", "param", ""); //
    getCheckedFilter->setValue("checked", "param", "1"); //
    getCheckedFilter->DataSet = dsFilter->DataSet;   // Присоединяем фильтр к dataset
    dsFilter->DataSet->First(); // На всякий случай 2017-08-24
}

/* Функция, вызываемая при завершении вывода данных */
void __fastcall TDocumentDataModule::EndPrint(TDataSetFilter* dsFilter)
{
    getCheckedFilter->DataSet = NULL;

    //mergeFields->EnableControls();
    dsFilter->UnlockDataSetPos();
}


/* Открытие окна с вопросом пути сохранения Excel */
String __fastcall TDocumentDataModule::askExcelFileName()
{
    // Опции окна сохранения результов
    SaveDialog1->Options.Clear();
    SaveDialog1->Options << ofFileMustExist;
    SaveDialog1->Filter = "MS Excel файлы (*.xlsx)|*.xlsx|Все файлы (*.*)|*.*";
    SaveDialog1->FilterIndex = 1;
    SaveDialog1->DefaultExt = "xlsx";

    //AnsiString filename;
    if ( SaveDialog1->Execute() )
    {
        return SaveDialog1->FileName;
    }
}

/* Открытие окна с вопросом пути сохранения Word */
String __fastcall TDocumentDataModule::askWordFileName(const String &defaultFileName)
{
    /*#ifndef NDEBUG
    return "c:\\test_" + FormatDateTime("yyyy.mm.dd_hh.MM.ss", Now()) + "_";
    #endif */


    SaveDialog1->Options.Clear();
    SaveDialog1->Options << ofFileMustExist;
    SaveDialog1->Filter = "MS Word файлы (*.doc)|*.doc|Все файлы (*.*)|*.*";
    SaveDialog1->FilterIndex = 1;
    SaveDialog1->DefaultExt = "";
    SaveDialog1->FileName = defaultFileName;

    if ( SaveDialog1->Execute() )
    {
        return ChangeFileExt(SaveDialog1->FileName, "");
    }
}


/* Печать заявок. Универсальная функция.
   При появлении нового типа шаблона, добавить сюда имя файла шаблона
   Тип 1 - Выбрано содержимое, документ формируется с помощь слияния
*/
bool __fastcall TDocumentDataModule::getDocument(TDataSetFilter* otdelenData, TDataSetFilter* fpListData, TDataSetFilter* faDataFilter, TDocTypeCd docTypeCd)
{
    bool result = false;
    String resultFilename = askWordFileName();
    if (resultFilename == "")
    {
        return result;
    }

    TWordExportParams wordExportParams;     // Параметры документа
    wordExportParams.pagePerDocument = 500;

    String fileName = "";

    // Переделать. Сделать таблицу в БД.
    switch (docTypeCd)
    {
    case DT_NOTICES_MANUAL:
    {
        fileName = "notice_manual.dotx";
        wordExportParams.addMergeDataSet(faDataFilter->DataSet);   // Информация по абонентам
        break;
    }
    case DT_NOTICES_LIST_FOR_POSTOFFICE:
    {
        fileName = "notice_pack_post.dotx";
        wordExportParams.addTableDataSet(faDataFilter->DataSet, 1, "table_");                  // Информация для таблицы
        break;
    }
    };

    wordExportParams.templateFilename = MainDataModule->getConfigQuery->FieldByName("report_path")->AsString + fileName;

    /* Присоединяем источники данных */
    wordExportParams.addSingleTextDataSet(MainDataModule->getConfigProc, "sysrec_");    // Служебная информация
    wordExportParams.addSingleTextDataSet(otdelenData->DataSet, "otdelen_");    // Общая информация по участку
    wordExportParams.addSingleTextDataSet(fpListData->DataSet, "rec_");         // Информация по реестру


    // Далее фильтруем выделенные и формируем документы
    BeginPrint(faDataFilter);


    if ( !faDataFilter->DataSet->Eof )
    {
        wordExportParams.resultFilename = ExtractFilePath(resultFilename) + ExtractFileName(resultFilename) +
            fpListData->DataSet->FieldByName("fa_pack_id")->AsString;

        documentWriter->ExportToWordTemplate(&wordExportParams);
        result = true;
    }


    EndPrint(faDataFilter);

    return result;
}

/* Печать заявок. Универсальная функция.
   При появлении нового типа шаблона, добавить сюда имя файла шаблона
   Тип 2 - Выбран список
*/
bool __fastcall TDocumentDataModule::getDocument(TDataSetFilter* otdelenData, TDataSetFilter* fpListData, TOraStoredProc* faDataProc, TDocTypeCd docTypeCd)
{
    bool result = false;
    String resultFilename = askWordFileName();
    if (resultFilename == "")
    {
        return result;
    }

    TWordExportParams wordExportParams;     // Параметры документа
    wordExportParams.pagePerDocument = 500;

    String fileName = "";
    int mode = 0;

    // Переделать. Сделать таблицу в БД.
    switch (docTypeCd)
    {
    case DT_STOP_REQUEST:
    {
        // Задаем имя файла шаблона в зависимости от того, куда предназначена заявка
        if ( fpListData->DataSet->FieldByName("rt_type")->AsString == "OTDELEN" ||
            (fpListData->DataSet->FieldByName("rt_type")->IsNull && fpListData->DataSet->FieldByName("rt_cd")->IsNull) )
        {
            // Распоряжение участку
            fileName = "stop_request_self.dotx";
        }
        else
        {
            // Заявка поставщику услуг
            fileName = "stop_request.dotx";
        }
        wordExportParams.addTableDataSet(faDataProc, 3, "table_");                  // Информация для таблицы  // !!!!!!!!!!! Сделать универсальную функцию без указания индекса таблицы
        break;
    }
    case DT_CANCEL_REQUEST:
    {
        fileName = "cancel_request.dotx";
        wordExportParams.addTableDataSet(faDataProc, 3, "table_");                  // Информация для таблицы  // !!!!!!!!!!! Сделать универсальную функцию без указания индекса таблицы
        break;
    }
    case DT_RECONNECT_REQUEST:
    {
        fileName = "reconnect_request.dotx";
        wordExportParams.addTableDataSet(faDataProc, 3, "table_");                  // Информация для таблицы  // !!!!!!!!!!! Сделать универсальную функцию без указания индекса таблицы
        break;
    }
    case DT_OVERDUE_REQUEST:
    {
        fileName = "overdue_request.dotx";
        wordExportParams.addTableDataSet(faDataProc, 3, "table_");                  // Информация для таблицы  // !!!!!!!!!!! Сделать универсальную функцию без указания индекса таблицы
        break;
    }
    };

    wordExportParams.templateFilename = MainDataModule->getConfigQuery->FieldByName("report_path")->AsString + fileName;

    /* Присоединяем источники данных */
    wordExportParams.addSingleTextDataSet(MainDataModule->getConfigProc, "sysrec_");    // Служебная информация
    wordExportParams.addSingleTextDataSet(otdelenData->DataSet, "otdelen_");    // Общая информация по участку
    wordExportParams.addSingleTextDataSet(fpListData->DataSet, "rec_");         // Информация по реестру


    // Далее фильтруем выделенные и формируем документы
    BeginPrint(fpListData);

    while( !fpListData->DataSet->Eof )
    {

        faDataProc->Close();
        faDataProc->ParamByName("p_fa_pack_id")->Value =  fpListData->DataSet->FieldByName("fa_pack_id")->Value;
        faDataProc->Open();

        if ( !faDataProc->Eof )
        {
            wordExportParams.resultFilename = ExtractFilePath(resultFilename) + ExtractFileName(resultFilename) +
                fpListData->DataSet->FieldByName("fa_pack_id")->AsString;

            documentWriter->ExportToWordTemplate(&wordExportParams);

            result = true;
        }

        fpListData->DataSet->Next();
    }

    EndPrint(fpListData);


    return result;
}


/* Печать уведомлений */
bool __fastcall TDocumentDataModule::getDocumentFaNotices(TDataSetFilter* otdelenData, TDataSetFilter* faPackData, TDataSetFilter* faData)
{
    //String resultFilename = faPackData->DataSet->FieldByName("fa_pack_id")->AsString;

    return getDocument(
        MainDataModule->getOtdelenListFilter,
        MainDataModule->getFaPackInfoFilter,
        MainDataModule->getFpNoticesContentFilter,
        DT_NOTICES_MANUAL);

}

/* Печать списка уведомлений */
void __fastcall TDocumentDataModule::getDocumentFaNoticesList(TDataSetFilter *mergeFields)
{

    String resultFilename = askExcelFileName();
    if (resultFilename == "")
    {
        return;
    }

    TExcelExportParams excelExportParams;
    excelExportParams.templateFilename = MainDataModule->getConfigQuery->FieldByName("report_path")->AsString + "template_document_notice.xltx";
    //excelExportParams.templateFilename = "c:\\PROGRS\\current\\GroupDoc\\report\\template_document_notice.xltx";
    excelExportParams.resultFilename = ChangeFileExt(resultFilename,".xlsx");
    //excelExportParams.resultFilename = ExtractFilePath(resultFilename) + ExtractFileName(resultFilename) + ".xlsx";
    //excelExportParams.table_range_name = "range_body";
    excelExportParams.addSingleDataSet(MainDataModule->getFaPackInfProc, "pack_rec_");     // Общая информация по участку

    excelExportParams.addSingleDataSet(MainDataModule->getOtdelenListFilter->DataSet, "otdelen_rec_");     // Общая информация по участку
    excelExportParams.addTableDataSet(mergeFields->DataSet, "range_body", "");     // Общая информация по участку


    BeginPrint(mergeFields);

    if ( mergeFields->DataSet->RecordCount > 0)
    {
        // Получаем дополнительные данные для полей документа
        //MainDataModule->getFaPackInfo->ParamByName("fa_pack_id")->Value = mergeFields->DataSet->FieldByName("fa_pack_id")->Value;
        //MainDataModule->openOrRefresh(MainDataModule->getFaPackInfo);

        // Формируем документ
        //documentWriter->ExportToExcelTemplate(&excelExportParams, filter->DataSet, MainDataModule->getOtdelenListQuery);
        documentWriter->ExportToExcelTemplate(&excelExportParams);
    }
    EndPrint(mergeFields);
}

/* Печать списка уведомлений для почтового отделения */
bool __fastcall TDocumentDataModule::getDocumentFaNoticesListForPostOffice(TDataSetFilter* otdelenData, TDataSetFilter* faPackData, TDataSetFilter* faData)
{

    //getDocumentFaNoticesListForPostOffice(MainDataModule->getOtdelenListFilter, MainDataModule->getFaPackInfoFilter, MainDataModule->getFpNoticesContentFilter


    return getDocument(
        MainDataModule->getOtdelenListFilter,
        MainDataModule->getFaPackInfoFilter,
        MainDataModule->getFpNoticesContentFilter,
        DT_NOTICES_LIST_FOR_POSTOFFICE);




    /*    if ( faData->DataSet->Eof )
    {
        return false;
    }

    String resultFilename = askWordFileName(faPackData->DataSet->FieldByName("fa_pack_id")->AsString);
    if (resultFilename == "")
    {
        return false;
    }

    TWordExportParams wordExportParams;
    wordExportParams.templateFilename = MainDataModule->getConfigQuery->FieldByName("report_path")->AsString + "notice_pack_post.dotx";     // Путь к шаблону
    wordExportParams.resultFilename = ExtractFilePath(resultFilename) + ExtractFileName(resultFilename)/* +  faPackData->DataSet->FieldByName("fa_pack_id")->AsString*/;     // Путь к результату
    //wordExportParams.pagePerDocument = 500;   // Количество страниц на документ

    /* Присоединяем источники данных */
 /*   wordExportParams.addSingleTextDataSet(otdelenData->DataSet, "otdelen_");     // Общая информация по участку
    wordExportParams.addSingleTextDataSet(faPackData->DataSet, "rec_");  // Информация по реестру
    wordExportParams.addTableDataSet(faData->DataSet, 1, "table_");                  // Информация для таблицы

    // Далее фильтруем выделенные и формируем документы
    BeginPrint(faData);    // Фиксируем исходный набор данных

    documentWriter->ExportToWordTemplate(&wordExportParams);    // Формируем документ

    EndPrint(faData);       // Освобождаем набор данных

    return true;  */
}

/* Печать списка заявок на ограничение */
bool __fastcall TDocumentDataModule::getDocumentStopRequest()
{
    return getDocument(
        MainDataModule->getOtdelenListFilter,
        MainDataModule->getFpStopListFilter,
        MainDataModule->getFpStopContentProc,
        DT_STOP_REQUEST
    );
}

/* Печать списка заявок на отмену остановки */
bool __fastcall TDocumentDataModule::getDocumentCancelRequest()
{
    return getDocument(
        MainDataModule->getOtdelenListFilter,
        MainDataModule->getFpCancelListFilter,
        MainDataModule->getFpCancelContentTmpProc,
        DT_CANCEL_REQUEST);
}

/* Печать списка заявок на ограничение */
bool __fastcall TDocumentDataModule::getDocumentReconnectRequest()
{
    return getDocument(
        MainDataModule->getOtdelenListFilter,
        MainDataModule->getFpReconnectListFilter,
        MainDataModule->getFpReconnectContentTmpProc,
        DT_RECONNECT_REQUEST);
}

/* Печать списка заявок на отмену остановки */
bool __fastcall TDocumentDataModule::getDocumentOverdueRequest()
{
    return getDocument(
        MainDataModule->getOtdelenListFilter,
        MainDataModule->getFpOverdueListFilter,
        MainDataModule->getFpOverdueContentProc,
        DT_OVERDUE_REQUEST);
}





/*
    mergeDataSetProvider->DataSet = mergeFields->DataSet;
    ClientDataSet1->Data = mergeDataSetProvider->Data;

    //mergeDataSet->Assign() = mergeDataSetProvider->DataSet;

    int yyy1 = ClientDataSet1->RecordCount;
    int yyy2 = mergeDataSet->RecordCount;
*/
    //mergeFields->DataSet = TempProvider->DataSet;
    //ClientDataSet1->Data = mergeFields->;
    /*TDataSetProvider* TempProvider = new TDataSetProvider(this);
    TempProvider->DataSet = mergeFields->DataSet;

    ClientDataSet1->Data = TempProvider->Data;
    mergeDataSet = TempProvider->DataSet;
                                           */

    //int xxx = ClientDataSet1->RecordCount;

    /*ClientDataSet1->Data = TempProvider->Data;
    delete TempProvider;
                        */

    //TClientDataSet* mergeDataSet = new TClientDataSet(NULL);
    //mergeDataSet->Assign(mergeFields->DataSet);
    //mergeFields->DataSet->Assign(mergeDataSet);
    //mergeDataSet->Active;




