//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "GridFrameUnit.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBGridAlt"
#pragma resource "*.dfm"
TGridFrame *GridFrame;
//---------------------------------------------------------------------------
__fastcall TGridFrame::TGridFrame(TComponent* Owner)
    : TFrame(Owner)
{
}
//---------------------------------------------------------------------------
