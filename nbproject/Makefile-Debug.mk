#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Environment
MKDIR=mkdir
CP=cp
GREP=grep
NM=nm
CCADMIN=CCadmin
RANLIB=ranlib
CC=gcc
CCC=g++
CXX=g++
FC=gfortran
AS=as

# Macros
CND_PLATFORM=MinGW_64bit-Windows
CND_DLIB_EXT=dll
CND_CONF=Debug
CND_DISTDIR=dist
CND_BUILDDIR=build

# Include project Makefile
include Makefile

# Object Directory
OBJECTDIR=${CND_BUILDDIR}/${CND_CONF}/${CND_PLATFORM}

# Object Files
OBJECTFILES= \
	${OBJECTDIR}/src/RounderCtrl.o \
	${OBJECTDIR}/src/RounderCtrl_wrap.o


# C Compiler Flags
CFLAGS=

# CC Compiler Flags
CCFLAGS=-m32 -ggdb
CXXFLAGS=-m32 -ggdb

# Fortran Compiler Flags
FFLAGS=

# Assembler Flags
ASFLAGS=

# Link Libraries and Options
LDLIBSOPTIONS=-L../CRP/dist/Debug/MinGW-Windows -lCRP

# Build Targets
.build-conf: ${BUILD_SUBPROJECTS}
	"${MAKE}"  -f nbproject/Makefile-${CND_CONF}.mk ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/TauRounder.${CND_DLIB_EXT}

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/TauRounder.${CND_DLIB_EXT}: ${OBJECTFILES}
	${MKDIR} -p ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}
	${LINK.cc} -o ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/TauRounder.${CND_DLIB_EXT} ${OBJECTFILES} ${LDLIBSOPTIONS} -Wl,--kill-at -shared

.NO_PARALLEL:./src/RounderCtrl_wrap.cpp ./src/RounderCtrl_wrap.h
./src/RounderCtrl_wrap.cpp ./src/RounderCtrl_wrap.h: RounderCtrl.swg
	${MKDIR} -p ./src ./src
	@echo Performing Custom Build Step
	D:/Peter-Paul/Documents/Thuiswerk/Programmatuur/swigwin-4.0.1/swig.exe -c++ -I./src -java -package tauargus.extern.taurounder -outdir ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM} -o ./src/RounderCtrl_wrap.cpp RounderCtrl.swg

${OBJECTDIR}/src/RounderCtrl.o: src/RounderCtrl.cpp
	${MKDIR} -p ${OBJECTDIR}/src
	${RM} "$@.d"
	$(COMPILE.cc) -g -DCPLEXV -DDYNAMIC -DSCIPV -DXPRESSV -I../../../Java/zulu8.44.0.13-ca-fx-jdk8.0.242-win_i686/include -I../../../Java/zulu8.44.0.13-ca-fx-jdk8.0.242-win_i686/include/win32  -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/src/RounderCtrl.o src/RounderCtrl.cpp

${OBJECTDIR}/src/RounderCtrl_wrap.o: src/RounderCtrl_wrap.cpp
	${MKDIR} -p ${OBJECTDIR}/src
	${RM} "$@.d"
	$(COMPILE.cc) -g -DCPLEXV -DDYNAMIC -DSCIPV -DXPRESSV -I../../../Java/zulu8.44.0.13-ca-fx-jdk8.0.242-win_i686/include -I../../../Java/zulu8.44.0.13-ca-fx-jdk8.0.242-win_i686/include/win32  -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/src/RounderCtrl_wrap.o src/RounderCtrl_wrap.cpp

# Subprojects
.build-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r ${CND_BUILDDIR}/${CND_CONF}
	${RM} ./src/RounderCtrl_wrap.cpp ./src/RounderCtrl_wrap.h

# Subprojects
.clean-subprojects:

# Enable dependency checking
.dep.inc: .depcheck-impl

include .dep.inc
