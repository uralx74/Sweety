//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "WaitFormUnit.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TWaitForm *WaitForm;
//---------------------------------------------------------------------------
__fastcall TWaitForm::TWaitForm(TComponent* Owner)
    //: TForm( (TComponent*)(NULL))
    : TForm(Owner),
    _waitBeforeShow(0)
{
    _parentForm = (TForm*)Owner;
    SetMessage("");
    SetStatus("");
    this->WindowProc = MyWndProc;

}

/**/
void __fastcall TWaitForm::Timer1Timer(TObject *Sender)
{

    static int FrameIndex = 0;
    if (++FrameIndex >= ImageList1->Count)
    {
        FrameIndex=0;
    }

    Image1->Canvas->Lock();

    Image1->Canvas->FillRect(Image1->ClientRect); // Очищаем от старой картинки
    ImageList1->GetBitmap(FrameIndex, Image1->Picture->Bitmap);
    this->Refresh();

}

/**/
void __fastcall TWaitForm::FormCreate(TObject *Sender)
{
    this->DoubleBuffered = true;
}


/**/
void __fastcall TWaitForm::FormCloseQuery(TObject *Sender, bool &CanClose)
{
    CanClose = _canClose;
}

/**/
void __fastcall TWaitForm::SpeedButton1Click(TObject *Sender)
{
    SendMessage(Application->MainForm->Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
}

/* Отображает форму ожидания */
void __fastcall TWaitForm::Execute(int waitBeforeShow)
{
    //((TForm*)this->Owner)->Enabled = false;
    Timer1->Enabled = true;
    ShowTimer->Enabled = true;
    _parentForm->Enabled = false;
    _canClose = false;

    _startTime = Now();

    _waitBeforeShow = waitBeforeShow;
    
    Application->ProcessMessages();
}

/* Закрывает форму ожидания */
void __fastcall TWaitForm::StopWait()
{
    _parentForm->Enabled = true;
    Timer1->Enabled = false;
    ShowTimer->Enabled = false;
    _canClose = true;
    Close();
}

/**/
void __fastcall TWaitForm::SetStatus(const String& text)
{
    StatusLabel->Caption = text;
}

/**/
void __fastcall TWaitForm::SetMessage(const String& text)
{
    MessageLabel->Caption = text;
}

/* Обеспечивает задержку перед отображением окна */
void __fastcall TWaitForm::ShowTimerTimer(TObject *Sender)
{
    if ( _waitBeforeShow <= SecondsBetween(Now(), _startTime) )
    {
        _parentForm->Enabled = false;
        Show();
        ShowTimer->Enabled = false;
    }
}

/* Перехватываем оконное сообщение для обработки ситуации, когда разворачивается
   уже закрытое будучи свернутым окно */
void __fastcall TWaitForm::MyWndProc(Messages::TMessage &Message)
{
    // WM_SHOWWINDOW
    // wParam
    // Indicates whether a window is being shown. If wParam is TRUE, the window is being shown. If wParam is FALSE, the window is being hidden.

    if (Message.Msg == WM_SHOWWINDOW )
    {
        if (Message.WParam == 1 && !this->Showing)
        {
        }
        else
        {
            WndProc(Message);
        }
    }
    else
    {
        WndProc(Message);
    }
}

