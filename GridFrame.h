//---------------------------------------------------------------------------


#ifndef GridFrameH
#define GridFrameH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "DBGridAlt.h"
#include <DBGrids.hpp>
#include <Grids.hpp>
//---------------------------------------------------------------------------
class TFrame1 : public TFrame
{
__published:	// IDE-managed Components
    TDBGridAlt *DBGridAlt1;
private:	// User declarations
public:		// User declarations
    __fastcall TFrame1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TFrame1 *Frame1;
//---------------------------------------------------------------------------
#endif
