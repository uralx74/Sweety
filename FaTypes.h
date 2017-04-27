//---------------------------------------------------------------------------
#ifndef FaTypesH
#define FaTypesH

#include <Classes.hpp>
#include <map>

namespace FaTypes
{
const int typeCount = 4;

enum PackTypeId
{
    PACK_NULL = 0,
    PACK_MANUAL = 1,
    PACK_POST = 2,
    PACK_BLOCK = 3
};

String PackTypeCd[typeCount] = {
    "",
    "UVED-MAN",
    "UVED-POST",
    "UVED-BLOCK"
};
};


/*class PackType
{
public:
    PackType();
    getDescr();

private:
    static std::map<int, String> _typeDescrList;
    FaTypes::PackTypeId _typeId;
};*/


class FaPack
{
private:
    String _faPackId;
    FaTypes::PackTypeId _faPackTypeId;

public:
    FaPack();
    String getFaPackId();
    //String getFaPackTypeCd();
    FaTypes::PackTypeId getFaPackTypeId();
    void setFaPackId(const String& faPackId);
    //void setFaPackType(const String& faPackTypeCd);
    void setFaPackType(FaTypes::PackTypeId faPackTypeId);
    void clear();


};

//---------------------------------------------------------------------------
#endif
