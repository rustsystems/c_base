
#include <stdlib.h>

#include "cbcore.h"
#include "cbdata.h"


CBSize SizeOfType(CBDataTypeKinds typeKind) {
    CBSize size;
    switch (typeKind) {
        case Void:
            size = sizeof(CBVoid);
            break;
        case VoidPtr:
            size = sizeof(CBVoidPtr);
            break;

        case Integer:
            size = sizeof(CBInteger);
            break;
        case IntegerPtr:
            size = sizeof(CBIntegerPtr);
            break;

        case UnsignedInteger:
            size = sizeof(CBUnsignedInteger);
            break;
        case UnsignedIntegerPtr:
            size = sizeof(CBUnsignedIntegerPtr);
            break;

        case Short:
            size = sizeof(CBShort);
            break;
        case ShortPtr:
            size = sizeof(CBShortPtr);
            break;

        case UnsignedShort:
            size = sizeof(CBUnsignedShort);
            break;
        case UnsignedShortPtr:
            size = sizeof(CBUnsignedShortPtr);
            break;

        case Long:
            size = sizeof(CBLong);
            break;
        case LongPtr:
            size = sizeof(CBLongPtr);
            break;

        case UnsignedLong:
            size = sizeof(CBUnsignedLong);
            break;
        case UnsignedLongPtr:
            size = sizeof(CBUnsignedLongPtr);
            break;

        case Float:
            size = sizeof(CBFloat);
            break;
        case FloatPtr:
            size = sizeof(CBFloatPtr);
            break;

        case Double:
            size = sizeof(CBDouble);
            break;
        case DoublePtr:
            size = sizeof(CBDoublePtr);
            break;

        case Char:
            size = sizeof(CBChar);
            break;
        case CharPtr:
            size = sizeof(CBCharPtr);
            break;



        default: 
            size = -1;
    }
    return size;
}


CBSize SizeOfObject(CBVoidPtr object) {
    CBSize size = sizeof object;
    return size;
}


CBVoidPtr Allocate(CBSize size) {
    CBVoidPtr allocatedSpace = malloc(size);
    return allocatedSpace;
}


CBVoidPtr AllocateType(CBDataTypeKinds typeKind) {
    CBSize size = SizeOfType(typeKind);
    CBVoidPtr allocatedSpace = Allocate(size);
    return allocatedSpace;
}


CBVoidPtr AllocateObject(CBVoidPtr object) {
    CBSize size = SizeOfObject(object);
    CBVoidPtr allocatedSpace = Allocate(size);
    return allocatedSpace;
}


