/* Модуль окна ожидания */

#ifndef WaitFormUnitH
#define WaitFormUnitH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ExtCtrls.hpp>
#include <ImgList.hpp>
#include <DateUtils.hpp>
#include <Graphics.hpp>
#include "TTrayIcon.h"

//---------------------------------------------------------------------------
class TWaitForm : public TForm
{
__published:	// IDE-managed Components
    TImage *Image1;
    TLabel *MessageLabel;
    TBevel *Bevel1;
    TLabel *StatusLabel;
    TSpeedButton *SpeedButton1;
    TSpeedButton *CancelBtn;
    TImageList *ImageList1;
    TTimer *Timer1;
    TTimer *ShowTimer;
    void __fastcall Timer1Timer(TObject *Sender);
    void __fastcall FormCreate(TObject *Sender);
    void __fastcall FormCloseQuery(TObject *Sender, bool &CanClose);
    void __fastcall SpeedButton1Click(TObject *Sender);
    void __fastcall ShowTimerTimer(TObject *Sender);

private:	// User declarations
    bool _canClose;
    TForm* _parentForm;
    int _waitBeforeShow;    // Ожидать секунд перед отображением формы
    TDateTime _startTime;  // Время начала
    void __fastcall MyWndProc(Messages::TMessage &Message);

    TTrayIcon* trayIcon;


    //bool __fastcall TaskBarAddIcon(HWND hWindow, Cardinal ID, hicon ICON, Cardinal CallbackMessage, String Tip);
    //bool TaskBarAddIcon(HICON hIcon, LPSTR lpszTip);
    //bool TaskBarAddIcon(HWND MsgWnd, WORD _IconID, HICON icon, String hint, UINT message);

public:		// User declarations
    __fastcall TWaitForm(TComponent* Owner);
    void __fastcall Execute(int waitBeforeShow = 0);
    void __fastcall StopWait();


    void __fastcall SetStatus(const String& text);
    void __fastcall SetMessage(const String& text);

};
//---------------------------------------------------------------------------
extern PACKAGE TWaitForm *WaitForm;
//---------------------------------------------------------------------------
#endif
