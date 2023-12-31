/*
 * CDDL HEADER START
 *
 * The contents of this file are subject to the terms of the
 * Common Development and Distribution License (the "License").
 * You may not use this file except in compliance with the License.
 *
 * You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
 * or http://www.opensolaris.org/os/licensing.
 * See the License for the specific language governing permissions
 * and limitations under the License.
 *
 * When distributing Covered Code, include this CDDL HEADER in each
 * file and include the License file at usr/src/OPENSOLARIS.LICENSE.
 * If applicable, add the following below this CDDL HEADER, with the
 * fields enclosed by brackets "[]" replaced with your own identifying
 * information: Portions Copyright [yyyy] [name of copyright owner]
 *
 * CDDL HEADER END
 */
/*
 * Copyright 2006 Sun Microsystems, Inc.  All rights reserved.
 * Use is subject to license terms.
 */

/*
 * Utility functions
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <libelf.h>
#include <gelf.h>
#include <errno.h>
#include <stdarg.h>
#include <pthread.h>
#include <unistd.h>
#include <sys/param.h>

#include "ctftools.h"
#include "memory.h"

static void (*terminate_cleanup)() = NULL;

/* returns 1 if s1 == s2, 0 otherwise */
int
streq(const char *s1, const char *s2)
{
	if (s1 == NULL) {
		if (s2 != NULL)
			return (0);
	} else if (s2 == NULL)
		return (0);
	else if (strcmp(s1, s2) != 0)
		return (0);

	return (1);
}

int
findelfsecidx(Elf *elf, const char *file, const char *tofind)
{
	Elf_Scn *scn = NULL;
	GElf_Ehdr ehdr;
	GElf_Shdr shdr;

	if (gelf_getehdr(elf, &ehdr) == NULL)
		elfterminate(file, "Couldn't read ehdr");

	while ((scn = elf_nextscn(elf, scn)) != NULL) {
		char *name;

		if (gelf_getshdr(scn, &shdr) == NULL) {
			elfterminate(file,
			    "Couldn't read header for section %d",
			    elf_ndxscn(scn));
		}

		if ((name = elf_strptr(elf, ehdr.e_shstrndx,
		    (size_t)shdr.sh_name)) == NULL) {
			elfterminate(file,
			    "Couldn't get name for section %d",
			    elf_ndxscn(scn));
		}

		if (strcmp(name, tofind) == 0)
			return (elf_ndxscn(scn));
	}

	return (-1);
}

size_t
elf_ptrsz(Elf *elf)
{
	GElf_Ehdr ehdr;

	if (gelf_getehdr(elf, &ehdr) == NULL) {
		terminate("failed to read ELF header: %s\n",
		    elf_errmsg(-1));
	}

	if (ehdr.e_ident[EI_CLASS] == ELFCLASS32)
		return (4);
	else if (ehdr.e_ident[EI_CLASS] == ELFCLASS64)
		return (8);
	else
		terminate("unknown ELF class %d\n", ehdr.e_ident[EI_CLASS]);

	/*NOTREACHED*/
	return (0);
}

/*PRINTFLIKE2*/
__printflike(2, 0)
static void
whine(char *type, const char *format, va_list ap)
{
	int error = errno;

	fprintf(stderr, "%s: %s: ", type, progname);
	vfprintf(stderr, format, ap);

	if (format[strlen(format) - 1] != '\n')
		fprintf(stderr, ": %s\n", strerror(error));
}

void
set_terminate_cleanup(void (*cleanup)())
{
	terminate_cleanup = cleanup;
}

/*PRINTFLIKE1*/
__printflike(1, 2)
void
terminate(const char *format, ...)
{
	va_list ap;

	va_start(ap, format);
#if !defined(__APPLE__)
	whine("ERROR", format, ap);
#else
    /*
     * Supress the error message if the format is empty
     */
    if (format[0] != 0) {
        whine("ERROR", format, ap);
    }
#endif
	va_end(ap);

	if (terminate_cleanup)
		terminate_cleanup();

	if (getenv("CTF_ABORT_ON_TERMINATE") != NULL)
		abort();
	exit(1);
}

/*PRINTFLIKE1*/
__printflike(1, 2)
void
aborterr(char *format, ...)
{
	va_list ap;

	va_start(ap, format);
	whine("ERROR", format, ap);
	va_end(ap);

#if !defined(__APPLE__)
	abort();
#else
	/*
	 * On Mac OS X, unhandled SIGABRT raised by abort() invokes the CrashReporter
	 * mechanism. That's way more heavyweight than needed. And as there are no SIGABRT
	 * signal handlers in ctfconvert and friends, we may as well just exit().
	 */
	exit(1);
#endif /* __APPLE__ */
}

/*PRINTFLIKE1*/
__printflike(1, 2)
void
warning(char *format, ...)
{
	va_list ap;

	va_start(ap, format);
	whine("WARNING", format, ap);
	va_end(ap);

	if (debug_level >= 3)
		terminate("Termination due to warning\n");
}

/*PRINTFLIKE2*/
__printflike(2, 0)
void
vadebug(int level, char *format, va_list ap)
{
	if (level > debug_level)
		return;

	(void) fprintf(DEBUG_STREAM, "DEBUG: ");
	(void) vfprintf(DEBUG_STREAM, format, ap);
	fflush(DEBUG_STREAM);
}

/*PRINTFLIKE2*/
__printflike(2, 3)
void
debug(int level, char *format, ...)
{
	va_list ap;

	if (level > debug_level)
		return;

	va_start(ap, format);
	(void) vadebug(level, format, ap);
	va_end(ap);
}

char *
mktmpname(const char *origname, const char *suffix)
{
	char *newname;

	newname = xmalloc(strlen(origname) + strlen(suffix) + 1);
	(void) strcpy(newname, origname);
	(void) strcat(newname, suffix);
	return (newname);
}

/*PRINTFLIKE2*/
__printflike(2, 3)
void
elfterminate(const char *file, const char *fmt, ...)
{
	static char msgbuf[BUFSIZ];
	va_list ap;

	va_start(ap, fmt);
	vsnprintf(msgbuf, sizeof (msgbuf), fmt, ap);
	va_end(ap);

	terminate("%s: %s: %s\n", file, msgbuf, elf_errmsg(-1));
}

const char *
tdesc_name(tdesc_t *tdp)
{
	return atom_pretty(tdp->t_name, "(anon)");
}
