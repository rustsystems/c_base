##
# Copyright (c) 2020 Apple Inc. All rights reserved.
#
# @APPLE_LICENSE_HEADER_START@
# 
# This file contains Original Code and/or Modifications of Original Code
# as defined in and that are subject to the Apple Public Source License
# Version 2.0 (the 'License'). You may not use this file except in
# compliance with the License. Please obtain a copy of the License at
# http://www.opensource.apple.com/apsl/ and read it before using this
# file.
# 
# The Original Code and all software distributed under the License are
# distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER
# EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
# INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE, QUIET ENJOYMENT OR NON-INFRINGEMENT.
# Please see the License for the specific language governing rights and
# limitations under the License.
# 
# @APPLE_LICENSE_HEADER_END@
##
TESTROOT = ../..
include ${TESTROOT}/include/common.makefile

#  Verify image_suffix option work

run: all

all:
	${CC}  ${CCFLAGS} bar.c -dynamiclib -o libbar_test.dylib
	${PASS_IFF_ERROR} ${CC}  ${CCFLAGS} foo.c -dynamiclib -o libfoo.dylib -Wl,-lbar -L. 2>/dev/null
	${PASS_IFF} ${CC}  ${CCFLAGS} foo.c -dynamiclib -o libfoo.dylib -Wl,-image_suffix,_test -Wl,-lbar -L.
	${PASS_IFF} ${CC}  ${CCFLAGS} foo.c -dynamiclib -o libfoo.dylib -Wl,-image_suffix,_test -Wl,-needed-lbar -L.
	${PASS_IFF} ${CC}  ${CCFLAGS} foo.c -dynamiclib -o libfoo.dylib -Wl,-image_suffix,_test -Wl,-reexport-lbar -L.
	${PASS_IFF} ${CC}  ${CCFLAGS} foo.c -dynamiclib -o libfoo.dylib -Wl,-image_suffix,_test -Wl,-upward-lbar -L.
	${PASS_IFF} ${CC}  ${CCFLAGS} foo.c -dynamiclib -o libfoo.dylib -Wl,-image_suffix,_test -Wl,-hidden-lbar -L.
	${PASS_IFF} ${CC}  ${CCFLAGS} foo.c -dynamiclib -o libfoo.dylib -Wl,-image_suffix,_test -Wl,-weak-lbar -L.

	${PASS_IFF_ERROR} ${CC}  ${CCFLAGS} foo.c -dynamiclib -o libfoo.dylib libbar.dylib 2>/dev/null
	${PASS_IFF} ${CC}  ${CCFLAGS} foo.c -dynamiclib -o libfoo.dylib -Wl,-image_suffix,_test -Wl,libbar.dylib
	${PASS_IFF} ${CC}  ${CCFLAGS} foo.c -dynamiclib -o libfoo.dylib -Wl,-image_suffix,_test -Wl,-needed_library,libbar.dylib
	${PASS_IFF} ${CC}  ${CCFLAGS} foo.c -dynamiclib -o libfoo.dylib -Wl,-image_suffix,_test -Wl,-reexport_library,libbar.dylib
	${PASS_IFF} ${CC}  ${CCFLAGS} foo.c -dynamiclib -o libfoo.dylib -Wl,-image_suffix,_test -Wl,-upward_library,libbar.dylib
	${PASS_IFF} ${CC}  ${CCFLAGS} foo.c -dynamiclib -o libfoo.dylib -Wl,-image_suffix,_test -Wl,-weak_library,libbar.dylib

	mkdir -p Bar.framework
	${CC}  ${CCFLAGS} bar.c -dynamiclib -o Bar.framework/Bar_test
	${PASS_IFF_ERROR} ${CC}  ${CCFLAGS} foo.c -dynamiclib -o libfoo.dylib -Wl,-framework,Bar -F. 2>/dev/null
	${PASS_IFF} ${CC}  ${CCFLAGS} foo.c -dynamiclib -o libfoo.dylib -Wl,-image_suffix,_test -Wl,-framework,Bar -F.
	${PASS_IFF} ${CC}  ${CCFLAGS} foo.c -dynamiclib -o libfoo.dylib -Wl,-image_suffix,_test -Wl,-needed_framework,Bar -F.
	${PASS_IFF} ${CC}  ${CCFLAGS} foo.c -dynamiclib -o libfoo.dylib -Wl,-image_suffix,_test -Wl,-weak_framework,Bar -F.
	${PASS_IFF} ${CC}  ${CCFLAGS} foo.c -dynamiclib -o libfoo.dylib -Wl,-image_suffix,_test -Wl,-reexport_framework,Bar -F.
	${PASS_IFF} ${CC}  ${CCFLAGS} foo.c -dynamiclib -o libfoo.dylib -Wl,-image_suffix,_test -Wl,-upward_framework,Bar -F.
	${PASS_IFF_GOOD_MACHO} libfoo.dylib

clean:
	rm -rf libfoo.dylib libbar_test.dylib Bar.framework
