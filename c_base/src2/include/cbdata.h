
#include "cbcore.h"

typedef enum _cbdatatypekinds_t {
    Void                = 1,
    VoidPtr             = 2,

    Integer             = 3,
    IntegerPtr          = 4,

    UnsignedInteger     = 5,
    UnsignedIntegerPtr  = 6,

    Short               = 7,
    ShortPtr            = 8,
    UnsignedShort       = 9,
    UnsignedShortPtr    = 10,

    Long                = 11,
    LongPtr             = 12,
    UnsignedLong        = 13,
    UnsignedLongPtr     = 14,

    Float               = 15,
    FloatPtr            = 16,

    Double              = 17,
    DoublePtr           = 18,

    Char                = 19,
    CharPtr             = 20,
    String              = 21
} CBDataTypeKinds;

typedef struct _cbdataelement_t {
    CBDataTypeKinds kind;
    CBInteger length;
    CBVoidPtr value;
} CBDataElement;

typedef CBDataElement* CBDataElementPtr; 

CBDataElementPtr CBNewDataElement(CBDataTypeKinds kind, CBInteger length, CBVoidPtr value);