//---------------------------------------------------------------------------
#pragma hdrstop

#include "FaTypes.h"

  /*
PackType::PackType()

{

}  */

FaPack::FaPack() :
    _faPackId(""),
    _faPackTypeId(0)
{

}

String FaPack::getFaPackId()
{
    return _faPackId;
}

/*String FaPack::getFaPackTypeCd()
{
    return _faPackTypeCd;
}*/

FaTypes::PackTypeId FaPack::getFaPackTypeId()
{
    return _faPackTypeId;
}

void FaPack::setFaPackId(const String& faPackType)
{
    _faPackId = faPackType;
}

/*void FaPack::setFaPackType(const String& faPackTypeCd)
{

    _faPackTypeCd = faPackTypeCd;
} */

void FaPack::setFaPackType(FaTypes::PackTypeId faPackTypeId)
{
    _faPackTypeId = faPackTypeId;
}

void FaPack::clear()
{
    _faPackId = "";
    //_faPackTypeCd = "";
    _faPackTypeId = 0;
}

//---------------------------------------------------------------------------

#pragma package(smart_init)
