//---------------------------------------------------------------------------


#ifndef OtdelenComboBoxFrameUnitH
#define OtdelenComboBoxFrameUnitH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Ora.hpp"

//---------------------------------------------------------------------------
class TOtdelenComboBoxFrame : public TFrame
{
__published:	// IDE-managed Components
    TComboBox *OtdelenComboBox;
private:	// User declarations
    static int _counter;
    static TStringList* _descrList;
    static TStringList* _valueList;


public:		// User declarations
    __fastcall TOtdelenComboBoxFrame(TComponent* Owner);
    virtual __fastcall ~TOtdelenComboBoxFrame();
    //void test(TOraQuery* list);
    static void add(const String& descr, const String& value);
    static void addFromQuery(TOraQuery* listQuery);
    String getValue();

};
//---------------------------------------------------------------------------
extern PACKAGE TOtdelenComboBoxFrame *OtdelenComboBoxFrame;
//---------------------------------------------------------------------------
#endif
