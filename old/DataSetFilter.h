//---------------------------------------------------------------------------

#ifndef DataSetFilterH
#define DataSetFilterH
//---------------------------------------------------------------------------
#include "VirtualTable.hpp"
#include <SysUtils.hpp>
#include <Controls.hpp>
#include <Classes.hpp>
#include <Forms.hpp>
#include <DBGrids.hpp>
#include <Grids.hpp>
#include <vector>
#include <map>
#include "Ora.hpp"
#include "math.h"


//TDataLink
//virtual void __fastcall SetActiveRecord(int Value);


class TDataSetFilterItem
{
public:
    __fastcall TDataSetFilterItem();
    ~TDataSetFilterItem();
    void setActive(bool active);
    bool isActive() const { return _active; };
    bool isEmpty() const { return _empty; };
    String getText() const;
    void addParameter(const String& paramName, const String& paramValue="");
    void setText(const String& text);
    void setParamValue(const String& paramValue); // Для всех параметров
    void setParamValue(const String& paramName, const String& paramValue);

private:
    bool _active;   // Если фильтр включен пользователем
    bool _empty;    // Если значение фильтра пустое (=="")
    String _text;
    String _textResult; // текст после установки значения
    TReplaceFlags _replaceFlags;
    std::map<String, String> _param;

private:
};

class TDataSetFilter
{
private:
    std::map<String, TDataSetFilterItem>* _items;

public:
    __fastcall TDataSetFilter();
    __fastcall ~TDataSetFilter();
    TDataSetFilterItem* add(const String& filterName, const String& filterStr);
//    void add(void* filterCtrl, const String& filterStr);
    void remove(const String& filterName);
    void clear();
    String getFilterString(const String &glue = "") const;
    void setActive(const String& filterName, bool active);
    void setValue(const String& filterName, const String& paramName, const String& paramValue);
    void clearValue(const String& filterName, const String& paramName);
    //void clearValue(const String& filterName);
    void clearAllValues();
};


//---------------------------------------------------------------------------
#endif

