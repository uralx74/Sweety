//---------------------------------------------------------------------------

#ifndef FormSpecialModuleUnitH
#define FormSpecialModuleUnitH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ImgList.hpp>
#include <Dialogs.hpp>
//---------------------------------------------------------------------------
class TFormSpecialModule : public TDataModule
{
__published:	// IDE-managed Components
    TImageList *ButtonImageList;
    TImageList *ImageList1;
    TSaveDialog *SaveDialog1;
private:	// User declarations
public:		// User declarations
    __fastcall TFormSpecialModule(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TFormSpecialModule *FormSpecialModule;
//---------------------------------------------------------------------------
#endif
