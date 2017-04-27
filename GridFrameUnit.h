//---------------------------------------------------------------------------


#ifndef GridFrameUnitH
#define GridFrameUnitH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "DBGridAlt.h"
#include <DBGrids.hpp>
#include <Grids.hpp>
//---------------------------------------------------------------------------
class TGridFrame : public TFrame
{
__published:	// IDE-managed Components
private:	// User declarations
public:		// User declarations
    __fastcall TGridFrame(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TGridFrame *GridFrame;
//---------------------------------------------------------------------------
#endif
