#include <vcl.h>
#pragma hdrstop
#include "DataSetFilter.h"
//---------------------------------------------------------------------------


/*
 TDBGridAltFilterItem class
 @created: 2016-01-16
 @author: vs.ovchinnikov
*/

__fastcall TDataSetFilterItem::TDataSetFilterItem() :
    _active(true),
    _text(""),
    //_paramValue(""),
    _textResult(""),
    _empty(true)

{
    //TReplaceFlags _replaceFlags = TReplaceFlags() << rfReplaceAll << rfIgnoreCase;
    _replaceFlags = TReplaceFlags() << rfReplaceAll;
}

/*
*/
TDataSetFilterItem::~TDataSetFilterItem()
{
}

/*
*/
void TDataSetFilterItem::setActive(bool active)
{
    _active = active;
}

/*
*/
String TDataSetFilterItem::getText() const
{
    return _textResult;
}

/* Добавляет параметр в список
*/
void TDataSetFilterItem::addParameter(const String& paramName, const String& paramValue)
{
    _param[paramName] = paramValue;
}

/* Задает значение параметра, если параметр не был добавлен ранее, добавляет его
*/
void TDataSetFilterItem::setParamValue(const String& paramName, const String& paramValue)
{
    _param[paramName] = paramValue;

    if (_text == "")
    {
        _empty = true;
        return;
    }

    //_paramValue = paramValue;
    //_empty = (paramValue == "" || _text == "");
    //_textResult = StringReplace(_text, ":param", _paramValue, _replaceFlags);

    for (std::map<String, String>::iterator it = _param.begin(); it != _param.end(); it++)
    {
        if (it->second == "")
        {
            _empty = true;
            return;
        }
    }

    _empty = false;
    _textResult = _text;
    for (std::map<String, String>::iterator it = _param.begin(); it != _param.end(); it++)
    {
        if (it->second == "")
        {
        }
        _textResult = StringReplace(_textResult, it->first, it->second, _replaceFlags);
    }
}

/*
*/
void TDataSetFilterItem::setParamValue(const String& paramValue)
{
    for (std::map<String, String>::iterator it = _param.begin(); it != _param.end(); it++)
    {
        setParamValue(it->first);
    }
}

/*
*/
void TDataSetFilterItem::setText(const String& text)
{
    _text = text;
    // чтобы задать первоначальное значение _textResult
    //setParamValue("");
}

/*
 TDBGridAltFilter class
 @created: 2016-01-16
 @author: vs.ovchinnikov
*/


/*
*/
__fastcall TDataSetFilter::TDataSetFilter()
{
    _items = new std::map<String, TDataSetFilterItem>;
}


/*
*/
__fastcall TDataSetFilter::~TDataSetFilter()
{
    _items->clear();
    delete _items;
    _items = NULL;
}


/* Добавляет элемент в фильтр
*/
TDataSetFilterItem* TDataSetFilter::add(const String& filterName, const String& filterStr)
{
    (*_items)[filterName].setText(filterStr);
    return &(*_items)[filterName];
}

/* Добавляет элемент в фильтр
*/
/*void TDBGridAltFilter::add(void* filterCtrl, const String& filterStr)
{
    //std::stringstream ss;
    //ss << filterCtrl;
    //std::string name = ss.str();

    String s = IntToStr(filterCtrl);
    add(s, filterStr);
}*/


/* Удаляет элемент фильтра по имени элемента
*/
void TDataSetFilter::remove(const String& filterName)
{
    _items->erase(filterName);
}

/* Очищает фильтр
*/
void TDataSetFilter::clear()
{
    _items->clear();
}

/*
*/
void TDataSetFilter::setActive(const String& filterName, bool active)
{
    (*_items)[filterName].setActive(active);
}

/* Задает значение элемента фильтра
*/
void TDataSetFilter::setValue(const String& filterName, const String& paramName, const String& paramValue)
{
    /*TDBGridAltFilterItem *item;
    std::pair<const AnsiString, TDBGridAltFilterItem> *it = _items->find(filterName);
    if ( it != _items.end() )
    {
        item->setParamValue(value);
    } */
    (*_items)[filterName].setParamValue(paramName, paramValue);
}

/*
 Замена нескольких значений
*/
/*void TDBGridAltFilter::setValue(const String& filterName, const String& value1, const String& value2)
{
    /*TDBGridAltFilterItem *item;
    std::pair<const AnsiString, TDBGridAltFilterItem> *it = _items->find(filterName);
    if ( it != _items.end() )
    {
        item->setParamValue(value);
    } */
    /*(*_items)[filterName].setParamValue("param1", value1);
    (*_items)[filterName].setParamValue("param2", value2);
}*/


/* Обнуляет текущее значение фильтра (всех подфильтров или выбранного по имени)
*/
void TDataSetFilter::clearValue(const String& filterName, const String& paramName)
{
    (*_items)[filterName].setParamValue(paramName, "");
}

/*void TDBGridAltFilter::clearValue(const String& filterName)
{
    for(...)
    {
        (*_items)[filterName].setParamValue(paramName, "");
    }
}*/


/* Очищает значение всех параметров фильтра
*/
void TDataSetFilter::clearAllValues()
{
    for (std::map<String, TDataSetFilterItem>::iterator it = _items->begin(); it != _items->end(); it++)
    {
        if ( it->second.isActive() && !it->second.isEmpty())   // если фильтр активен
        {
            it->second.setParamValue("");
        }
    }
}


/* Объединяет вектор подстрок в одну строку используя соединитель
*/
String TDataSetFilter::getFilterString(const String &glue) const
{
	String a = "";

    for (std::map<String, TDataSetFilterItem>::iterator it = _items->begin(); it != _items->end(); it++)
    {
        if ( it->second.isActive() && !it->second.isEmpty())   // если фильтр активен
        {
            a += it->second.getText() + glue;
        }
    }

    a = a.SubString(1, a.Length() - glue.Length());

 	return a;
}


/* Удаляет присоединенный фильтр
*//*
void __fastcall TDBGridAlt::OffFilter()
{
    this->BeginUpdate();
    _dataSet->Filter = "";
    //((TOraQuery*)DataSource->DataSet)->FilterSQL = "";
    //(dynamic_cast<TOraQuery*>(DataSource->DataSet))->FilterSQL = "";
    this->EndUpdate();
}*/