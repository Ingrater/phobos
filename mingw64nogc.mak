# Makefile to build D runtime library phobos.lib for Win32
# Prerequisites:
#	Digital Mars dmc, lib, and make that are unzipped from Digital Mars C:
#	    http://ftp.digitalmars.com/Digital_Mars_C++/Patch/dm850c.zip
#	and are in the \dm\bin directory.
# Targets:
#	make
#		Same as make unittest
#	make phobos.lib
#		Build phobos.lib
#	make clean
#		Delete unneeded files created by build process
#	make unittest
#		Build phobos.lib, build and run unit tests
#	make cov
#		Build for coverage tests, run coverage tests
#	make html
#		Build documentation
# Notes:
#	minit.obj requires Microsoft MASM386.EXE to build from minit.asm,
#	or just use the supplied minit.obj

## Copy command

CP=cp

## Flags for dmc C compiler

CFLAGS=

## Flags for dmd D compiler

#release
#DFLAGS=-O -release -nofloat -w -d -property -version=NOGCSAFE -I..\druntime\import

#debug
DFLAGS=-m64 -g -Wall -fdeprecated -fproperty -fversion=NOGCSAFE -I ..\druntime\import -nostdinc
DFLAGS_RELEASE=-frelease -O2
DFLAGS_DEBUG=-frelease -fbounds-check -fin -fout -fassert

#DFLAGS=-unittest -g -d
#DFLAGS=-unittest -cov -g -d

## Flags for compiling unittests

UDFLAGS=-O -nofloat -w -d -property

## C compiler

CC=gcc
AR=ar
RANLIB=ranlib

## D compiler

GDC=gdc

## Location of druntime tree

DRUNTIME=..\druntime
DRUNTIMELIB_DEBUG=$(DRUNTIME)\lib\libdruntimenogc64d_mingw.a
DRUNTIMELIB_RELEASE=$(DRUNTIME)\lib\libdruntimenogc64_mingw.a

.c.obj:
	$(CC) -c $(CFLAGS) $*

.cpp.obj:
	$(CC) -c $(CFLAGS) $*

.d.obj:
	$(GDC) -c $(DFLAGS) $*

.asm.obj:
	$(CC) -c $*

targets : libphobosnogc64_mingw.lib libphobosnogc64d_mingw.lib

test : test.exe

test.obj : test.d
	$(GDC) -c test -g -unittest

test.exe : test.obj phobosnogc64d.lib
	$(GDC) test.obj -g -L/map

OBJS=
  #Czlib.obj Dzlib.obj Ccurl.obj \
	#oldsyserror.obj \
	#c_stdio.obj

#	ti_bit.obj ti_Abit.obj

# The separation is a workaround for bug 4904 (optlink bug 3372).
# SRCS_1 is the heavyweight modules which are most likely to trigger the bug.
# Do not add any more modules to SRCS_1.
SRCS_11 =
  #std\stdio.d std\stdiobase.d \
	#std\string.d std\format.d \
	#std\algorithm.d std\file.d

SRCS_12 =
  #std\array.d std\functional.d std\range.d \
	#std\path.d std\outbuffer.d std\utf.d

SRCS_2 = std\math.d std\uni.d std\ascii.d std\typetuple.d std\traits.d std\random.d 
    #std\csv.d std\complex.d std\numeric.d std\bigint.d \
    #std\dateparse.d std\date.d std\datetime.d \
    #std\metastrings.d std\bitmanip.d std\typecons.d \
    #std\base64.d std\md5.d std\ctype.d \
    #std\demangle.d std\uri.d std\mmfile.d std\getopt.d \
    #std\signals.d \
    #std\bind.d \
    #std\encoding.d std\xml.d \
    #std\regexp.d \
    #std\contracts.d std\exception.d \
    #std\compiler.d std\cpuid.d \
    #std\process.d std\internal\processinit.d \
    #std\internal\uni.d std\internal\uni_tab.d \
    #std\system.d std\concurrency.d

SRCS_3 = std\stdint.d \
	std\c\process.d \
	std\c\stdarg.d \
	std\c\stddef.d \
	std\c\stdlib.d \
	std\c\string.d \
	std\c\time.d \
	std\c\math.d \
	std\c\windows\stat.d \
	std\c\windows\windows.d \
	std\c\windows\winsock.d \
	#std\variant.d \
	#std\stream.d std\socket.d std\socketstream.d \
	#std\perf.d std\container.d std\conv.d \
	#std\zip.d std\cstream.d std\loader.d \
	#std\__fileinit.d \
	#std\datebase.d \
	#std\regex.d \
	#std\stdarg.d \
	#std\json.d \
	#std\parallelism.d \
	#std\gregorian.d \
	#std\mathspecial.d \
	#std\internal\math\biguintcore.d \
	#std\internal\math\biguintnoasm.d std\internal\math\biguintx86.d \
	#std\internal\math\gammafunction.d std\internal\math\errorfunction.d \
	#std\internal\windows\advapi32.d \
	#crc32.d \
	#std\c\windows\com.d \
	#std\windows\charset.d \
	#std\windows\iunknown.d \
	#std\windows\registry.d \
	#std\windows\syserror.d

# The separation is a workaround for bug 4904 (optlink bug 3372).
# See: http://lists.puremagic.com/pipermail/phobos/2010-September/002741.html
SRCS = $(SRCS_11) $(SRCS_12) $(SRCS_2) $(SRCS_3)

SRC = unittest.d crc32.d index.d

SRC_STD= \
	std\stdint.d \
	std\math.d \
	std\random.d \
	std\typetuple.d std\traits.d
	#std\zlib.d std\zip.d \
	#std\container.d std\conv.d std\utf.d std\uri.d \
	#std\string.d std\path.d std\date.d std\datetime.d \
	#std\ctype.d std\csv.d std\file.d std\compiler.d std\system.d \
	#std\outbuffer.d std\md5.d std\base64.d \
	#std\dateparse.d std\mmfile.d \
	#std\syserror.d \
	#std\regexp.d \
	#std\stream.d std\process.d \
	#std\socket.d std\socketstream.d std\loader.d std\stdarg.d std\format.d \
	#std\stdio.d std\perf.d std\uni.d \
	#std\cstream.d std\demangle.d \
	#std\signals.d std\cpuid.d \
	#std\bind.d \
	#std\metastrings.d std\contracts.d std\getopt.d \
	#std\variant.d std\numeric.d std\bitmanip.d std\complex.d std\mathspecial.d \
	#std\functional.d std\algorithm.d std\array.d std\typecons.d \
	#std\json.d std\xml.d std\encoding.d std\bigint.d std\concurrency.d \
	#std\range.d std\stdiobase.d std\parallelism.d \
	#std\regex.d std\datebase.d \
	#std\__fileinit.d std\gregorian.d std\exception.d std\ascii.d

SRC_STD_NET=
  #std\net\isemail.d

SRC_STD_C=
  std\c\process.d std\c\stdlib.d std\c\time.d std\c\stdio.d \
	std\c\math.d std\c\stdarg.d std\c\stddef.d std\c\fenv.d std\c\string.d \
	std\c\locale.d std\c\wcharh.d

SRC_STD_WIN=
  #std\windows\registry.d \
	#std\windows\iunknown.d std\windows\syserror.d std\windows\charset.d

SRC_STD_C_WIN= \
	std\c\windows\windows.d \
	std\c\windows\winsock.d std\c\windows\stat.d
	#std\c\windows\com.d \

SRC_STD_C_LINUX=
  #std\c\linux\linux.d \
	#std\c\linux\socket.d std\c\linux\pthread.d std\c\linux\termios.d \
	#std\c\linux\tipc.d

SRC_STD_C_OSX= std\c\osx\socket.d

SRC_STD_C_FREEBSD= std\c\freebsd\socket.d

SRC_STD_INTERNAL=
  #std\internal\processinit.d std\internal\uni.d std\internal\uni_tab.d

SRC_STD_INTERNAL_MATH=
  #std\internal\math\biguintcore.d \
	#std\internal\math\biguintnoasm.d std\internal\math\biguintx86.d \
  #std\internal\math\gammafunction.d std\internal\math\errorfunction.d

SRC_STD_INTERNAL_WINDOWS=
  #std\internal\windows\advapi32.d

SRC_ETC=

SRC_ETC_C=
  #etc\c\zlib.d etc\c\curl.d etc\c\sqlite3.d

SRC_ZLIB= \
	etc\c\zlib\crc32.h \
	etc\c\zlib\deflate.h \
	etc\c\zlib\gzguts.h \
	etc\c\zlib\inffixed.h \
	etc\c\zlib\inffast.h \
	etc\c\zlib\inftrees.h \
	etc\c\zlib\inflate.h \
	etc\c\zlib\trees.h \
	etc\c\zlib\zconf.h \
	etc\c\zlib\zlib.h \
	etc\c\zlib\zutil.h \
	etc\c\zlib\adler32.c \
	etc\c\zlib\compress.c \
	etc\c\zlib\crc32.c \
	etc\c\zlib\deflate.c \
	etc\c\zlib\example.c \
	etc\c\zlib\gzclose.c \
	etc\c\zlib\gzlib.c \
	etc\c\zlib\gzread.c \
	etc\c\zlib\gzwrite.c \
	etc\c\zlib\infback.c \
	etc\c\zlib\inffast.c \
	etc\c\zlib\inflate.c \
	etc\c\zlib\inftrees.c \
	etc\c\zlib\minigzip.c \
	etc\c\zlib\trees.c \
	etc\c\zlib\uncompr.c \
	etc\c\zlib\zutil.c \
	etc\c\zlib\algorithm.txt \
	etc\c\zlib\zlib.3 \
	etc\c\zlib\ChangeLog \
	etc\c\zlib\README \
	etc\c\zlib\win32.mak \
	etc\c\zlib\linux.mak \
	etc\c\zlib\osx.mak

libphobosnogc64d_mingw.lib : $(OBJS) $(SRCS) \
	#etc\c\zlib\zlib.lib \
	mingw64nogc.mak
	$(GDC) -c -o phobosnogc64d_mingw.o $(DFLAGS) $(DFLAGS_DEBUG) $(SRCS)
	copy /Y $(DRUNTIMELIB_DEBUG) libphobosnogc64d_mingw.a
	$(AR) -q libphobosnogc64d_mingw.a phobosnogc64d_mingw.o $(OBJS)
	$(RANLIB) libphobosnogc64d_mingw.a
		
libphobosnogc64_mingw.lib : $(OBJS) $(SRCS) \
	#etc\c\zlib\zlib.lib \
	mingw64nogc.mak
	$(GDC) -c -o phobosnogc64_mingw.o $(DFLAGS) $(DFLAGS_RELEASE) $(SRCS)
	copy /Y $(DRUNTIMELIB_RELEASE) libphobosnogc64_mingw.a
	$(AR) -q libphobosnogc64_mingw.a phobosnogc64_mingw.o $(OBJS)
	$(RANLIB) libphobosnogc64_mingw.a

unittest : $(SRCS) phobosnogc64d.lib
	$(GDC) $(UDFLAGS) -L/co -c -unittest -ofunittest11.obj $(SRCS_11)
	$(GDC) $(UDFLAGS) -L/co -c -unittest -ofunittest12.obj $(SRCS_12)
	$(GDC) $(UDFLAGS) -L/co -c -unittest -ofunittest2.obj $(SRCS_2)
	$(GDC) $(UDFLAGS) -L/co -unittest unittest.d $(SRCS_3) unittest11.obj unittest12.obj unittest2.obj \
		etc\c\zlib\zlib.lib $(DRUNTIMELIB_DEBUG)
	unittest

#unittest : unittest.exe
#	unittest
#
#unittest.exe : unittest.d phobos.lib
#	$(GDC) unittest -g
#	dmc unittest.obj -g

cov : $(SRCS) phobosnogc64.lib
	$(GDC) -cov -unittest -ofcov.exe unittest.d $(SRCS) phobosnogc64.lib
	cov

html : $(DOCS)

######################################################

etc\c\zlib\zlib.lib:
	cd etc\c\zlib
	make -f win32.mak zlib.lib
	cd ..\..\..

### std

algorithm.obj : std\algorithm.d
	$(GDC) -c $(DFLAGS) std\algorithm.d

array.obj : std\array.d
	$(GDC) -c $(DFLAGS) std\array.d

ascii.obj : std\ascii.d
	$(GDC) -c $(DFLAGS) std\ascii.d

base64.obj : std\base64.d
	$(GDC) -c $(DFLAGS) -inline std\base64.d

bind.obj : std\bind.d
	$(GDC) -c $(DFLAGS) -inline std\bind.d

bitmanip.obj : std\bitmanip.d
	$(GDC) -c $(DFLAGS) std\bitmanip.d

concurrency.obj : std\concurrency.d
	$(GDC) -c $(DFLAGS) std\concurrency.d

compiler.obj : std\compiler.d
	$(GDC) -c $(DFLAGS) std\compiler.d

complex.obj : std\complex.d
	$(GDC) -c $(DFLAGS) std\complex.d

contracts.obj : std\contracts.d
	$(GDC) -c $(DFLAGS) std\contracts.d

container.obj : std\container.d
	$(GDC) -c $(DFLAGS) std\container.d

conv.obj : std\conv.d
	$(GDC) -c $(DFLAGS) std\conv.d

cpuid.obj : std\cpuid.d
	$(GDC) -c $(DFLAGS) std\cpuid.d -ofcpuid.obj

cstream.obj : std\cstream.d
	$(GDC) -c $(DFLAGS) std\cstream.d

ctype.obj : std\ctype.d
	$(GDC) -c $(DFLAGS) std\ctype.d

csv.obj : std\csv.d
	$(GDC) -c $(DFLAGS) std\csv.d

date.obj : std\dateparse.d std\date.d
	$(GDC) -c $(DFLAGS) std\date.d

dateparse.obj : std\dateparse.d std\date.d
	$(GDC) -c $(DFLAGS) std\dateparse.d

datetime.obj : std\datetime.d
	$(GDC) -c $(DFLAGS) std\datetime.d

demangle.obj : std\demangle.d
	$(GDC) -c $(DFLAGS) std\demangle.d

exception.obj : std\exception.d
	$(GDC) -c $(DFLAGS) std\exception.d

file.obj : std\file.d
	$(GDC) -c $(DFLAGS) std\file.d

__fileinit.obj : std\__fileinit.d
	$(GDC) -c $(DFLAGS) std\__fileinit.d

format.obj : std\format.d
	$(GDC) -c $(DFLAGS) std\format.d

functional.obj : std\functional.d
	$(GDC) -c $(DFLAGS) std\functional.d

getopt.obj : std\getopt.d
	$(GDC) -c $(DFLAGS) std\getopt.d

json.obj : std\json.d
	$(GDC) -c $(DFLAGS) std\json.d

loader.obj : std\loader.d
	$(GDC) -c $(DFLAGS) std\loader.d

math.obj : std\math.d
	$(GDC) -c $(DFLAGS) std\math.d

mathspecial.obj : std\mathspecial.d
	$(GDC) -c $(DFLAGS) std\mathspecial.d

md5.obj : std\md5.d
	$(GDC) -c $(DFLAGS) -inline std\md5.d

metastrings.obj : std\metastrings.d
	$(GDC) -c $(DFLAGS) -inline std\metastrings.d

mmfile.obj : std\mmfile.d
	$(GDC) -c $(DFLAGS) std\mmfile.d

numeric.obj : std\numeric.d
	$(GDC) -c $(DFLAGS) std\numeric.d

outbuffer.obj : std\outbuffer.d
	$(GDC) -c $(DFLAGS) std\outbuffer.d

parallelism.obj : std\parallelism.d
	$(GDC) -c $(DFLAGS) std\parallelism.d

path.obj : std\path.d
	$(GDC) -c $(DFLAGS) std\path.d

perf.obj : std\perf.d
	$(GDC) -c $(DFLAGS) std\perf.d

process.obj : std\process.d
	$(GDC) -c $(DFLAGS) std\process.d

processinit.obj : std\internal\processinit.d
	$(GDC) -c $(DFLAGS) std\internal\processinit.d

random.obj : std\random.d
	$(GDC) -c $(DFLAGS) std\random.d

regexp.obj : std\regexp.d
	$(GDC) -c $(DFLAGS) std\regexp.d

signals.obj : std\signals.d
	$(GDC) -c $(DFLAGS) std\signals.d -ofsignals.obj

socket.obj : std\socket.d
	$(GDC) -c $(DFLAGS) std\socket.d -ofsocket.obj

socketstream.obj : std\socketstream.d
	$(GDC) -c $(DFLAGS) std\socketstream.d -ofsocketstream.obj

stdio.obj : std\stdio.d
	$(GDC) -c $(DFLAGS) std\stdio.d

stream.obj : std\stream.d
	$(GDC) -c $(DFLAGS) -d std\stream.d

string.obj : std\string.d
	$(GDC) -c $(DFLAGS) std\string.d

oldsyserror.obj : std\syserror.d
	$(GDC) -c $(DFLAGS) std\syserror.d -ofoldsyserror.obj

system.obj : std\system.d
	$(GDC) -c $(DFLAGS) std\system.d

traits.obj : std\traits.d
	$(GDC) -c $(DFLAGS) std\traits.d -oftraits.obj

typecons.obj : std\typecons.d
	$(GDC) -c $(DFLAGS) std\typecons.d -oftypecons.obj

typetuple.obj : std\typetuple.d
	$(GDC) -c $(DFLAGS) std\typetuple.d -oftypetuple.obj

uni.obj : std\uni.d
	$(GDC) -c $(DFLAGS) std\uni.d

uri.obj : std\uri.d
	$(GDC) -c $(DFLAGS) std\uri.d

utf.obj : std\utf.d
	$(GDC) -c $(DFLAGS) std\utf.d

variant.obj : std\variant.d
	$(GDC) -c $(DFLAGS) std\variant.d

xml.obj : std\xml.d
	$(GDC) -c $(DFLAGS) std\xml.d

encoding.obj : std\encoding.d
	$(GDC) -c $(DFLAGS) std\encoding.d

Dzlib.obj : std\zlib.d
	$(GDC) -c $(DFLAGS) std\zlib.d -ofDzlib.obj

zip.obj : std\zip.d
	$(GDC) -c $(DFLAGS) std\zip.d

bigint.obj : std\bigint.d
	$(GDC) -c $(DFLAGS) std\bigint.d

biguintcore.obj : std\internal\math\biguintcore.d
	$(GDC) -c $(DFLAGS) std\internal\math\biguintcore.d

biguintnoasm.obj : std\internal\math\biguintnoasm.d
	$(GDC) -c $(DFLAGS) std\internal\math\biguintnoasm.d

biguintx86.obj : std\internal\math\biguintx86.d
	$(GDC) -c $(DFLAGS) std\internal\math\biguintx86.d

gammafunction.obj : std\internal\math\gammafunction.d
	$(GDC) -c $(DFLAGS) std\internal\math\gammafunction.d

errorfunction.obj : std\internal\math\errorfunction.d
	$(GDC) -c $(DFLAGS) std\internal\math\errorfunction.d

### std\net

isemail.obj : std\net\isemail.d
	$(GDC) -c $(DFLAGS) std\net\isemail.d

### std\windows

charset.obj : std\windows\charset.d
	$(GDC) -c $(DFLAGS) std\windows\charset.d

iunknown.obj : std\windows\iunknown.d
	$(GDC) -c $(DFLAGS) std\windows\iunknown.d

registry.obj : std\windows\registry.d
	$(GDC) -c $(DFLAGS) std\windows\registry.d

syserror.obj : std\windows\syserror.d
	$(GDC) -c $(DFLAGS) std\windows\syserror.d

### std\c

stdarg.obj : std\c\stdarg.d
	$(GDC) -c $(DFLAGS) std\c\stdarg.d

c_stdio.obj : std\c\stdio.d
	$(GDC) -c $(DFLAGS) std\c\stdio.d -ofc_stdio.obj

### etc

### etc\c

Czlib.obj : etc\c\zlib.d
	$(GDC) -c $(DFLAGS) etc\c\zlib.d -ofCzlib.obj

Ccurl.obj : etc\c\curl.d
	$(GDC) -c $(DFLAGS) etc\c\curl.d -ofCcurl.obj

### std\c\windows

com.obj : std\c\windows\com.d
	$(GDC) -c $(DFLAGS) std\c\windows\com.d

stat.obj : std\c\windows\stat.d
	$(GDC) -c $(DFLAGS) std\c\windows\stat.d

winsock.obj : std\c\windows\winsock.d
	$(GDC) -c $(DFLAGS) std\c\windows\winsock.d

windows.obj : std\c\windows\windows.d
	$(GDC) -c $(DFLAGS) std\c\windows\windows.d

######################################################

zip : win32.mak posix.mak $(STDDOC) $(SRC) \
	$(SRC_STD) $(SRC_STD_C) $(SRC_STD_WIN) \
	$(SRC_STD_C_WIN) $(SRC_STD_C_LINUX) $(SRC_STD_C_OSX) $(SRC_STD_C_FREEBSD) \
	$(SRC_ETC) $(SRC_ETC_C) $(SRC_ZLIB) $(SRC_STD_NET) \
	$(SRC_STD_INTERNAL) $(SRC_STD_INTERNAL_MATH) $(SRC_STD_INTERNAL_WINDOWS)
	del phobos.zip
	zip32 -u phobos win32.mak posix.mak $(STDDOC)
	zip32 -u phobos $(SRC)
	zip32 -u phobos $(SRC_STD)
	zip32 -u phobos $(SRC_STD_C)
	zip32 -u phobos $(SRC_STD_WIN)
	zip32 -u phobos $(SRC_STD_C_WIN)
	zip32 -u phobos $(SRC_STD_C_LINUX)
	zip32 -u phobos $(SRC_STD_C_OSX)
	zip32 -u phobos $(SRC_STD_C_FREEBSD)
	zip32 -u phobos $(SRC_STD_INTERNAL)
	zip32 -u phobos $(SRC_STD_INTERNAL_MATH)
	zip32 -u phobos $(SRC_STD_INTERNAL_WINDOWS)
	zip32 -u phobos $(SRC_ETC) $(SRC_ETC_C)
	zip32 -u phobos $(SRC_ZLIB)
	zip32 -u phobos $(SRC_STD_NET)

clean:
	cd etc\c\zlib
	make -f win32.mak clean
	cd ..\..\..
	del $(OBJS)
	del $(DOCS)
	del unittest1.obj unittest.obj unittest.map unittest.exe
	del phobosnogc64.lib
	del phobosnogc64d.lib
	del phobosnogc64.json
	del phobosnogc64d.json

cleanhtml:
	del $(DOCS)

install:
	$(CP) phobos.lib $(DIR)\windows\lib\
	$(CP) $(DRUNTIME)\lib\gcstub.obj $(DIR)\windows\lib\
	$(CP) win32.mak posix.mak $(STDDOC) $(DIR)\src\phobos\
	$(CP) $(SRC) $(DIR)\src\phobos\
	$(CP) $(SRC_STD) $(DIR)\src\phobos\std\
	$(CP) $(SRC_STD_NET) $(DIR)\src\phobos\std\net\
	$(CP) $(SRC_STD_C) $(DIR)\src\phobos\std\c\
	$(CP) $(SRC_STD_WIN) $(DIR)\src\phobos\std\windows\
	$(CP) $(SRC_STD_C_WIN) $(DIR)\src\phobos\std\c\windows\
	$(CP) $(SRC_STD_C_LINUX) $(DIR)\src\phobos\std\c\linux\
	$(CP) $(SRC_STD_C_OSX) $(DIR)\src\phobos\std\c\osx\
	$(CP) $(SRC_STD_C_FREEBSD) $(DIR)\src\phobos\std\c\freebsd\
	$(CP) $(SRC_STD_INTERNAL) $(DIR)\src\phobos\std\internal\
	$(CP) $(SRC_STD_INTERNAL_MATH) $(DIR)\src\phobos\std\internal\math\
	$(CP) $(SRC_STD_INTERNAL_WINDOWS) $(DIR)\src\phobos\std\internal\windows\
	#$(CP) $(SRC_ETC) $(DIR)\src\phobos\etc\
	$(CP) $(SRC_ETC_C) $(DIR)\src\phobos\etc\c\
	$(CP) $(SRC_ZLIB) $(DIR)\src\phobos\etc\c\zlib\
	$(CP) $(DOCS) $(DIR)\html\d\phobos\

svn:
	$(CP) win32.mak posix.mak $(STDDOC) $(SVN)\
	$(CP) $(SRC) $(SVN)\
	$(CP) $(SRC_STD) $(SVN)\std\
	$(CP) $(SRC_STD_NET) $(SVN)\std\net\
	$(CP) $(SRC_STD_C) $(SVN)\std\c\
	$(CP) $(SRC_STD_WIN) $(SVN)\std\windows\
	$(CP) $(SRC_STD_C_WIN) $(SVN)\std\c\windows\
	$(CP) $(SRC_STD_C_LINUX) $(SVN)\std\c\linux\
	$(CP) $(SRC_STD_C_OSX) $(SVN)\std\c\osx\
	$(CP) $(SRC_STD_C_FREEBSD) $(SVN)\std\c\freebsd\
	$(CP) $(SRC_STD_INTERNAL) $(SVN)\std\internal\
	$(CP) $(SRC_STD_INTERNAL_MATH) $(SVN)\std\internal\math\
	$(CP) $(SRC_STD_INTERNAL_WINDOWS) $(SVN)\std\internal\windows\
	#$(CP) $(SRC_ETC) $(SVN)\etc\
	$(CP) $(SRC_ETC_C) $(SVN)\etc\c\
	$(CP) $(SRC_ZLIB) $(SVN)\etc\c\zlib\


