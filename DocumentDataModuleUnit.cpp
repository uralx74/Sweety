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
void __fastcall TDocumentDataModule::BeginPrint(TDataSetFilter* mergeFields)
{
    mergeFields->LockDataSetPos();      // Запоминаем позицию в dataset
    //mergeFields->DisableControls();     // Блокируем отображение изменений dataset

    // Внимание, здесь, использовать локальный фильтр
    //MainDataModule->getCheckedFilter->setValue("group", "param", ""); //
    getCheckedFilter->setValue("checked", "param", "1"); //
    getCheckedFilter->DataSet = mergeFields->DataSet;   // Присоединяем фильтр к dataset
}

/* Функция, вызываемая при завершении вывода данных */
void __fastcall TDocumentDataModule::EndPrint(TDataSetFilter* mergeFields)
{
    getCheckedFilter->DataSet = NULL;

    //mergeFields->EnableControls();
    mergeFields->UnlockDataSetPos();
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
String __fastcall TDocumentDataModule::askWordFileName()
{
    /*#ifndef NDEBUG
    return "c:\\test_" + FormatDateTime("yyyy.mm.dd_hh.MM.ss", Now()) + "_";
    #endif */


    SaveDialog1->Options.Clear();
    SaveDialog1->Options << ofFileMustExist;
    SaveDialog1->Filter = "MS Word файлы (*.doc)|*.doc|Все файлы (*.*)|*.*";
    SaveDialog1->FilterIndex = 1;
    SaveDialog1->DefaultExt = "";

    if ( SaveDialog1->Execute() )
    {
        return ChangeFileExt(SaveDialog1->FileName, "");
    }
}


/* Печать уведомлений */
void __fastcall TDocumentDataModule::getDocumentFaNotices(TDataSetFilter* mergeFields)
{
    String resultFilename = askWordFileName();
    if (resultFilename == "")
    {
        return;
    }

    #define _DEBUG
    TWordExportParams wordExportParams;
    wordExportParams.resultFilename = ExtractFilePath(resultFilename) + ExtractFileName(resultFilename) + "_[:counter].doc";


    wordExportParams.pagePerDocument = 500;
    /* Присоединяем источники данных */
    wordExportParams.templateFilename = MainDataModule->getConfigQuery->FieldByName("report_path")->AsString + "\\template_document_notice.dotx";
    wordExportParams.addSingleImageDataSet(MainDataModule->getOtdelenListQuery, "image_");     // Общая информация по участку
    wordExportParams.addSingleTextDataSet(MainDataModule->getOtdelenListQuery, "otdelen_");     // Общая информация по участку
    //wordExportParams.addSingleTextDataSet(MainDataModule->getPackStopListFilter->DataSet, "rec_");  // Информация по реестру
    //wordExportParams.addMergeDataSet(mergeFields->DataSet); // 2017-03-23 наглядней когда запрос указывается однозначно
    wordExportParams.addMergeDataSet(MainDataModule->getFaPackFilter->DataSet);   // Информация по абонентам

    //wordExportParams.addSingleDataSet(MainDataModule->getPackStopListFilter->DataSet, "rec_");  // Информация по реестру
    //wordExportParams.addTableDataSet(MainDataModule->getFaPackStopQuery, 1, "table_");                  // Информация для таблицы


    // Далее фильтруем выделенные и формируем документы
    BeginPrint(mergeFields);

    mergeFields->DataSet->First();

    if ( mergeFields->DataSet->RecordCount > 0)
    {
        // Получаем дополнительные данные для полей документа
        //MainDataModule->getFaPackInfo->ParamByName("fa_pack_id")->Value = mergeFields->DataSet->FieldByName("fa_pack_id")->Value;
        //MainDataModule->openOrRefresh(MainDataModule->getFaPackInfo);

        // Формируем документ
        documentWriter->ExportToWordTemplate(&wordExportParams);
    }

    EndPrint(mergeFields);

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
    excelExportParams.addSingleDataSet(MainDataModule->getFaPackInfo, "pack_rec_");     // Общая информация по участку

    excelExportParams.addSingleDataSet(MainDataModule->getOtdelenListQuery, "otdelen_rec_");     // Общая информация по участку
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

/* Печать списка заявок на ограничение - устаревшая */
void __fastcall TDocumentDataModule::getDocumentStopService(TDataSetFilter *mergeFields)
{
/*    #ifdef NDEBUG
    String resultFilename = askWordFileName();
    if (resultFilename == "")
    {
        return;
    }
    #else
    String resultFilename = "c:\\hello.doc";
    #endif

    TWordExportParams wordExportParams;
    wordExportParams.templateFilename = "c:\\PROGRS\\current\\GroupDoc\\report\\template_document_stop.dotx";
    wordExportParams.pagePerDocument = 500;

    MainDataModule->getFaPackStopInfoQuery->Close();
    MainDataModule->getFaPackStopInfoQuery->ParamByName("fa_pack_id")->Value = mergeFields->DataSet->FieldByName("fa_pack_id")->Value;
    MainDataModule->getFaPackStopInfoQuery->Open();
    //OpenOrRefresh(MainDataModule->getFaPackStopInfoQuery);

    /* Присоединяем источники данных * /
    wordExportParams.addSingleDataSet(MainDataModule->getOtdelenListQuery, "otdelen_");     // Общая информация по участку
    wordExportParams.addSingleDataSet(MainDataModule->getFaPackStopInfoQuery, "rec_");  // Информация по реестру
    wordExportParams.addTableDataSet(mergeFields->DataSet, 1, "table_");                  // Информация для таблицы

    // Далее фильтруем выделенные и формируем документы
    BeginPrint(mergeFields);
    MainDataModule->getCheckedFilter->setValue("group", "param", "1"); //

    if ( mergeFields->DataSet->RecordCount > 0)
    {
        // здесь дополнительный фильтр для формирования разных документов
        // в разные сетевые организации
        //

        int grp = 1;
        while ( true )
        {
            wordExportParams.resultFilename = ExtractFilePath(resultFilename) + ExtractFileName(resultFilename) + IntToStr(grp) + ".doc";
            MainDataModule->getCheckedFilter->setValue("group", "param", IntToStr(grp++)); //

            String ss = MainDataModule->getCheckedFilter->getFilterString();

            if (!mergeFields->DataSet->Eof )
            {
                documentWriter->ExportToWordTemplate2(&wordExportParams);
                //documentWriter->ExportToWordTemplate(&wordExportParams, mergeFields->DataSet);
            }
            else
            {
                break;
            }
        }



        //MainDataModule->getFaPackInfo->ParamByName("fa_pack_id")->Value = mergeFields->DataSet->FieldByName("fa_pack_id")->Value;
        //MainDataModule->openOrRefresh(MainDataModule->getFaPackInfo);


    }

    EndPrint(mergeFields);


  /*  Variant tables = Document.OlePropertyGet("Tables");
    Variant table = tables.OleFunction("Item", 1);

    MainDataModule->Raion->Open();
    msword.writeDataSetToTable(table, MainDataModule->Raion);  */
}


/* Печать списка заявок на ограничение */
void __fastcall TDocumentDataModule::getDocumentStopService()
{
    String resultFilename = askWordFileName();
    if (resultFilename == "")
    {
        return;
    }

    TWordExportParams wordExportParams;
    wordExportParams.templateFilename = MainDataModule->getConfigQuery->FieldByName("report_path")->AsString + "\\template_document_stop.dotx";
    //wordExportParams.templateFilename = "c:\\PROGRS\\current\\Sweety\\report\\template_document_stop.dotx";
    wordExportParams.pagePerDocument = 500;

    //MainDataModule->getFaPackStopInfoQuery->Close();
    //OpenOrRefresh(MainDataModule->getFaPackStopInfoQuery);
    //MainDataModule->getFaPackStopInfoQuery->ParamByName("fa_pack_id")->Value = mergeFields->DataSet->FieldByName("fa_pack_id")->Value;
    //MainDataModule->getFaPackStopInfoQuery->Open();

    /* Присоединяем источники данных */
    wordExportParams.addSingleTextDataSet(MainDataModule->getOtdelenListQuery, "otdelen_");     // Общая информация по участку
    wordExportParams.addSingleTextDataSet(MainDataModule->getPackStopListFilter->DataSet, "rec_");  // Информация по реестру
    wordExportParams.addTableDataSet(MainDataModule->getFaPackStopQuery, 3, "table_");                  // Информация для таблицы

    // Далее фильтруем выделенные и формируем документы
    BeginPrint(MainDataModule->getPackStopListFilter);

    while( !MainDataModule->getPackStopListFilter->DataSet->Eof )
    {

        MainDataModule->getFaPackStopQuery->Close();
        MainDataModule->getFaPackStopQuery->ParamByName("fa_pack_id")->Value =  MainDataModule->getPackStopListFilter->DataSet->FieldByName("fa_pack_id")->Value;
        MainDataModule->getFaPackStopQuery->Open();

        if ( !MainDataModule->getFaPackStopQuery->Eof )
        {
            wordExportParams.resultFilename = ExtractFilePath(resultFilename) + ExtractFileName(resultFilename) +
                MainDataModule->getPackStopListFilter->DataSet->FieldByName("fa_pack_id")->AsString;
            documentWriter->ExportToWordTemplate(&wordExportParams);
             //documentWriter->ExportToWordTemplate(&wordExportParams, mergeFields->DataSet);
        }

        MainDataModule->getPackStopListFilter->DataSet->Next();
    }

    EndPrint(MainDataModule->getPackStopListFilter);
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




