


#ifndef CBCORE_MEMORY_H
#define CBCORE_MEMORY_H

#include "cbcore.h"
#include "cbdata.h"


CBSize SizeOfType(CBDataTypeKinds typeKind);

CBSize SizeOfObject(CBVoidPtr object);


CBVoidPtr Allocate(CBInteger size);


CBVoidPtr AllocateType(CBDataTypeKinds typeKind);


CBVoidPtr AllocateObject(CBVoidPtr object);

#endif // CBCORE_MEMORY_H
