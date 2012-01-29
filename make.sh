#!/bin/sh

txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
badgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

DMD=dmd
CC=dmc
IMPLIB=implib

DOCDIR=doc
IMPDIR=include

DRUNTIME="..\\druntime"
DRUNTIMELIB="${DRUNTIME}\\lib\\druntimenogcdllimp.lib"

DFLAGS="-g -nofloat -w -d -property -version=NOGCSAFE -I${DRUNTIME}\\import"
UDFLAGS="-debug -g -nofloat -w -d -property"

DLL="phobosnogc.dll"
LIB="phobosnogcdll.lib"
DEFDLL=phobosdll.def
DEFLIB=phoboslib.def
DEFEMPTY=phobosdllempty.def

PHOBOS_BASE=phobosnogc

SRCS="dllmain.d std\typetuple.d std\traits.d"

LIBS="snn.lib"

echo -e "${bldgrn}creating phobos object file${txtrst}"	
echo "$DMD -c $SRCS $DFLAGS -of${PHOBOS_BASE}.obj -version=DLL -defaultlib="" -debuglib="""
$DMD -c $SRCS $DFLAGS -of${PHOBOS_BASE}.obj -version=DLL -defaultlib="" -debuglib=""
if [ $? -ne 0 ]; then
  exit 1
fi

echo -e "${bldgrn}creating linker map file${txtrst}"
echo "$DMD ${PHOBOS_BASE}.obj $OBJS $DEFEMPTY $DFLAGS -of${DLL} -map ${PHOBOS_BASE}.map $DRUNTIMELIB $LIBS"
$DMD ${PHOBOS_BASE}.obj $OBJS $DEFEMPTY $DFLAGS -of${DLL} -map ${PHOBOS_BASE}.map $DRUNTIMELIB $LIBS
if [ $? -ne 0 ]; then
  exit 1
fi

#run def generator here
echo -e "${bldgrn}generating .def files${txtrst}"
StartLine=`grep -n "Address       Export                  Alias" ${PHOBOS_BASE}.map | awk '{ print $1 }'`
EndLine=`grep -n "Address         Publics by Name               Rva+Base" ${PHOBOS_BASE}.map | awk '{ print $1 }'`
echo "Start: '$StartLine' End: '$EndLine'"

cp $DEFEMPTY $DEFDLL

#replace PRELOAD DISCARDABLE with SHARED EXECUTE
rm $DEFLIB
cat $DEFEMPTY | while read line
do
  echo ${line/"PRELOAD DISCARDABLE"/"SHARED EXECUTE"} >> $DEFLIB
done

echo -e "\nEXPORTS" >> $DEFDLL
echo -e "\nEXPORTS" >> $DEFLIB

cat forcedExports.txt | while read line
do
  echo -e "\t$line" >> $DEFDLL
  echo -e "\t_$line = $line " >> $DEFLIB
  echo "forced: $line"
done

if [ ! -z "$StartLine" ]; then
	StartLine=${StartLine:0:${#StartLine}-1}
	EndLine=${EndLine:0:${#EndLine}-1}
	((StartLine++))
	((EndLine--))
	lineNum=1
	cat ${PHOBOS_BASE}.map | while read line && [ $lineNum -lt $EndLine ]
	do
	  if [ $lineNum -gt $StartLine ]; then
		symbol=`echo $line | awk '{ print $2 }'`
		echo -e "\t$symbol" >> $DEFDLL
		echo -e "\t_$symbol = $symbol " >> $DEFLIB
		echo "exported: $symbol"
	  fi
	  ((lineNum++))
	done
fi

echo -e "${bldgrn}linking dll${txtrst}"
$DMD ${PHOBOS_BASE}.obj $OBJS $DEFDLL $DFLAGS -of${DLL} ${DRUNTIMELIB} $LIBS
if [ $? -ne 0 ]; then
  exit 1
fi

echo -e "${bldgrn}creating import .lib${txtrst}"
$IMPLIB /noi $LIB $DEFLIB
if [ $? -ne 0 ]; then
  exit 1
fi