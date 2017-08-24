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

    // ������ ��� ������ ���������� �����
    // ������ getCheckedFilter �� MainDataModule
    getCheckedFilter->add("checked", "check_data = :param"); // ����������

}

__fastcall TDocumentDataModule::~TDocumentDataModule()
{
    delete documentWriter;
}

/* ������� ��� ���������� � ������ ������
   ��������� dataset �������� ������ ���������� */
void __fastcall TDocumentDataModule::BeginPrint(TDataSetFilter* dsFilter)
{
    dsFilter->LockDataSetPos();      // ���������� ������� � dataset
    //mergeFields->DisableControls();     // ��������� ����������� ��������� dataset

    // ��������, �����, ������������ ��������� ������
    //MainDataModule->getCheckedFilter->setValue("group", "param", ""); //
    getCheckedFilter->setValue("checked", "param", "1"); //
    getCheckedFilter->DataSet = dsFilter->DataSet;   // ������������ ������ � dataset
    dsFilter->DataSet->First(); // �� ������ ������ 2017-08-24
}

/* �������, ���������� ��� ���������� ������ ������ */
void __fastcall TDocumentDataModule::EndPrint(TDataSetFilter* dsFilter)
{
    getCheckedFilter->DataSet = NULL;

    //mergeFields->EnableControls();
    dsFilter->UnlockDataSetPos();
}


/* �������� ���� � �������� ���� ���������� Excel */
String __fastcall TDocumentDataModule::askExcelFileName()
{
    // ����� ���� ���������� ���������
    SaveDialog1->Options.Clear();
    SaveDialog1->Options << ofFileMustExist;
    SaveDialog1->Filter = "MS Excel ����� (*.xlsx)|*.xlsx|��� ����� (*.*)|*.*";
    SaveDialog1->FilterIndex = 1;
    SaveDialog1->DefaultExt = "xlsx";

    //AnsiString filename;
    if ( SaveDialog1->Execute() )
    {
        return SaveDialog1->FileName;
    }
}

/* �������� ���� � �������� ���� ���������� Word */
String __fastcall TDocumentDataModule::askWordFileName(const String &defaultFileName)
{
    /*#ifndef NDEBUG
    return "c:\\test_" + FormatDateTime("yyyy.mm.dd_hh.MM.ss", Now()) + "_";
    #endif */


    SaveDialog1->Options.Clear();
    SaveDialog1->Options << ofFileMustExist;
    SaveDialog1->Filter = "MS Word ����� (*.doc)|*.doc|��� ����� (*.*)|*.*";
    SaveDialog1->FilterIndex = 1;
    SaveDialog1->DefaultExt = "";
    SaveDialog1->FileName = defaultFileName;

    if ( SaveDialog1->Execute() )
    {
        return ChangeFileExt(SaveDialog1->FileName, "");
    }
}


/* ������ ������. ������������� �������.
   ��� ��������� ������ ���� �������, �������� ���� ��� ����� �������
   ��� 1 - ������� ����������, �������� ����������� � ������ �������
*/
bool __fastcall TDocumentDataModule::getDocument(TDataSetFilter* otdelenData, TDataSetFilter* fpListData, TDataSetFilter* faDataFilter, TDocTypeCd docTypeCd)
{
    bool result = false;
    String resultFilename = askWordFileName();
    if (resultFilename == "")
    {
        return result;
    }

    TWordExportParams wordExportParams;     // ��������� ���������
    wordExportParams.pagePerDocument = 500;

    String fileName = "";

    // ����������. ������� ������� � ��.
    switch (docTypeCd)
    {
    case DT_NOTICES_MANUAL:
    {
        fileName = "notice_manual.dotx";
        wordExportParams.addMergeDataSet(faDataFilter->DataSet);   // ���������� �� ���������
        break;
    }
    case DT_NOTICES_LIST_FOR_POSTOFFICE:
    {
        fileName = "notice_pack_post.dotx";
        wordExportParams.addTableDataSet(faDataFilter->DataSet, 1, "table_");                  // ���������� ��� �������
        break;
    }
    };

    wordExportParams.templateFilename = MainDataModule->getConfigQuery->FieldByName("report_path")->AsString + fileName;

    /* ������������ ��������� ������ */
    wordExportParams.addSingleTextDataSet(MainDataModule->getConfigProc, "sysrec_");    // ��������� ����������
    wordExportParams.addSingleTextDataSet(otdelenData->DataSet, "otdelen_");    // ����� ���������� �� �������
    wordExportParams.addSingleTextDataSet(fpListData->DataSet, "rec_");         // ���������� �� �������


    // ����� ��������� ���������� � ��������� ���������
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

/* ������ ������. ������������� �������.
   ��� ��������� ������ ���� �������, �������� ���� ��� ����� �������
   ��� 2 - ������ ������
*/
bool __fastcall TDocumentDataModule::getDocument(TDataSetFilter* otdelenData, TDataSetFilter* fpListData, TOraStoredProc* faDataProc, TDocTypeCd docTypeCd)
{
    bool result = false;
    String resultFilename = askWordFileName();
    if (resultFilename == "")
    {
        return result;
    }

    TWordExportParams wordExportParams;     // ��������� ���������
    wordExportParams.pagePerDocument = 500;

    String fileName = "";
    int mode = 0;

    // ����������. ������� ������� � ��.
    switch (docTypeCd)
    {
    case DT_STOP_REQUEST:
    {
        // ������ ��� ����� ������� � ����������� �� ����, ���� ������������� ������
        if ( fpListData->DataSet->FieldByName("rt_type")->AsString == "OTDELEN" ||
            (fpListData->DataSet->FieldByName("rt_type")->IsNull && fpListData->DataSet->FieldByName("rt_cd")->IsNull) )
        {
            // ������������ �������
            fileName = "stop_request_self.dotx";
        }
        else
        {
            // ������ ���������� �����
            fileName = "stop_request.dotx";
        }
        wordExportParams.addTableDataSet(faDataProc, 3, "table_");                  // ���������� ��� �������  // !!!!!!!!!!! ������� ������������� ������� ��� �������� ������� �������
        break;
    }
    case DT_CANCEL_REQUEST:
    {
        fileName = "cancel_request.dotx";
        wordExportParams.addTableDataSet(faDataProc, 3, "table_");                  // ���������� ��� �������  // !!!!!!!!!!! ������� ������������� ������� ��� �������� ������� �������
        break;
    }
    case DT_RECONNECT_REQUEST:
    {
        fileName = "reconnect_request.dotx";
        wordExportParams.addTableDataSet(faDataProc, 3, "table_");                  // ���������� ��� �������  // !!!!!!!!!!! ������� ������������� ������� ��� �������� ������� �������
        break;
    }
    case DT_OVERDUE_REQUEST:
    {
        fileName = "overdue_request.dotx";
        wordExportParams.addTableDataSet(faDataProc, 3, "table_");                  // ���������� ��� �������  // !!!!!!!!!!! ������� ������������� ������� ��� �������� ������� �������
        break;
    }
    };

    wordExportParams.templateFilename = MainDataModule->getConfigQuery->FieldByName("report_path")->AsString + fileName;

    /* ������������ ��������� ������ */
    wordExportParams.addSingleTextDataSet(MainDataModule->getConfigProc, "sysrec_");    // ��������� ����������
    wordExportParams.addSingleTextDataSet(otdelenData->DataSet, "otdelen_");    // ����� ���������� �� �������
    wordExportParams.addSingleTextDataSet(fpListData->DataSet, "rec_");         // ���������� �� �������


    // ����� ��������� ���������� � ��������� ���������
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


/* ������ ����������� */
bool __fastcall TDocumentDataModule::getDocumentFaNotices(TDataSetFilter* otdelenData, TDataSetFilter* faPackData, TDataSetFilter* faData)
{
    //String resultFilename = faPackData->DataSet->FieldByName("fa_pack_id")->AsString;

    return getDocument(
        MainDataModule->getOtdelenListFilter,
        MainDataModule->getFaPackInfoFilter,
        MainDataModule->getFpNoticesContentFilter,
        DT_NOTICES_MANUAL);

}

/* ������ ������ ����������� */
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
    excelExportParams.addSingleDataSet(MainDataModule->getFaPackInfProc, "pack_rec_");     // ����� ���������� �� �������

    excelExportParams.addSingleDataSet(MainDataModule->getOtdelenListFilter->DataSet, "otdelen_rec_");     // ����� ���������� �� �������
    excelExportParams.addTableDataSet(mergeFields->DataSet, "range_body", "");     // ����� ���������� �� �������


    BeginPrint(mergeFields);

    if ( mergeFields->DataSet->RecordCount > 0)
    {
        // �������� �������������� ������ ��� ����� ���������
        //MainDataModule->getFaPackInfo->ParamByName("fa_pack_id")->Value = mergeFields->DataSet->FieldByName("fa_pack_id")->Value;
        //MainDataModule->openOrRefresh(MainDataModule->getFaPackInfo);

        // ��������� ��������
        //documentWriter->ExportToExcelTemplate(&excelExportParams, filter->DataSet, MainDataModule->getOtdelenListQuery);
        documentWriter->ExportToExcelTemplate(&excelExportParams);
    }
    EndPrint(mergeFields);
}

/* ������ ������ ����������� ��� ��������� ��������� */
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
    wordExportParams.templateFilename = MainDataModule->getConfigQuery->FieldByName("report_path")->AsString + "notice_pack_post.dotx";     // ���� � �������
    wordExportParams.resultFilename = ExtractFilePath(resultFilename) + ExtractFileName(resultFilename)/* +  faPackData->DataSet->FieldByName("fa_pack_id")->AsString*/;     // ���� � ����������
    //wordExportParams.pagePerDocument = 500;   // ���������� ������� �� ��������

    /* ������������ ��������� ������ */
 /*   wordExportParams.addSingleTextDataSet(otdelenData->DataSet, "otdelen_");     // ����� ���������� �� �������
    wordExportParams.addSingleTextDataSet(faPackData->DataSet, "rec_");  // ���������� �� �������
    wordExportParams.addTableDataSet(faData->DataSet, 1, "table_");                  // ���������� ��� �������

    // ����� ��������� ���������� � ��������� ���������
    BeginPrint(faData);    // ��������� �������� ����� ������

    documentWriter->ExportToWordTemplate(&wordExportParams);    // ��������� ��������

    EndPrint(faData);       // ����������� ����� ������

    return true;  */
}

/* ������ ������ ������ �� ����������� */
bool __fastcall TDocumentDataModule::getDocumentStopRequest()
{
    return getDocument(
        MainDataModule->getOtdelenListFilter,
        MainDataModule->getFpStopListFilter,
        MainDataModule->getFpStopContentProc,
        DT_STOP_REQUEST
    );
}

/* ������ ������ ������ �� ������ ��������� */
bool __fastcall TDocumentDataModule::getDocumentCancelRequest()
{
    return getDocument(
        MainDataModule->getOtdelenListFilter,
        MainDataModule->getFpCancelListFilter,
        MainDataModule->getFpCancelContentTmpProc,
        DT_CANCEL_REQUEST);
}

/* ������ ������ ������ �� ����������� */
bool __fastcall TDocumentDataModule::getDocumentReconnectRequest()
{
    return getDocument(
        MainDataModule->getOtdelenListFilter,
        MainDataModule->getFpReconnectListFilter,
        MainDataModule->getFpReconnectContentTmpProc,
        DT_RECONNECT_REQUEST);
}

/* ������ ������ ������ �� ������ ��������� */
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




