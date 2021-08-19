# Makefile for TauRounder
####### Compiler, tools and options
# Environment

MKDIR            = mkdir
RM               = rm -f
CP               = cp -p
DEFINES          = -DCPLEXV -DSCIPV -DXPRESSV -DDYNAMIC

32BIT            = true
#32BIT            = false

SWIGDIR          = D:/Peter-Paul/Documents/Thuiswerk/Programmatuur/swigwin-4.0.1

ifeq ($(32BIT), false) # 64 bit assumed
    BITS         = -m64 -D_LP64
    ARCH         = x86_64
    CND_PLATFORM = MinGW-Windows64
    JAVADIR      = ../../../Java/zulu8.52.0.23-ca-jdk8.0.282-win_x64
    GNUDIR       = C:/Progra~1/mingw-w64/x86_64-8.1.0-posix-seh-rt_v6-rev0/mingw64/bin
else                   # 32 bit assumed
    BITS         = -m32
    ARCH         = x86
    CND_PLATFORM = MinGW-Windows
    JAVADIR      = ../../../Java/zulu8.52.0.23-ca-jdk8.0.282-win_i686
    GNUDIR       = C:/Progra~2/mingw-w64/i686-8.1.0-win32-sjlj-rt_v6-rev0/mingw32/bin
endif

JAVAINC          = -I$(JAVADIR)/include -I$(JAVADIR)/include/win32
CC               = $(GNUDIR)/g++
CXX              = $(GNUDIR)/g++
WINDRES          = $(GNUDIR)/windres
SWIG             = $(SWIGDIR)/swig.exe

LIBNAME          = TauRounder
JAVAPACKAGE      = tauargus.extern.taurounder

# Macros
CND_DLIB_EXT     = dll
CND_CONF         = Debug
CND_DISTDIR      = dist
CND_BUILDDIR     = build

CRPDIR           = ../CRP/$(CND_DISTDIR)/$(CND_CONF)/$(CND_PLATFORM)
CRPLIBS          = -L$(CRPDIR) -llibCRP

# Object Directory
OBJECTDIR        = $(CND_BUILDDIR)/$(CND_CONF)/$(CND_PLATFORM)

# Object Files
OBJECTFILES = \
    $(OBJECTDIR)/src/RounderCtrl.o \
    $(OBJECTDIR)/src/RounderCtrl_wrap.o \
    $(OBJECTDIR)/src/Versioninfo.o

# Compiler flags
CXXFLAGS         = -ggdb -g -Og -Wall $(DEFINES) $(BITS)
SFLAGS           = -c++ -I./src -java -package $(JAVAPACKAGE) -outdir $(CND_DISTDIR)/$(CND_CONF)/$(CND_PLATFORM)

all:
	$(MKDIR) -p $(OBJECTDIR)/src
	$(MKDIR) -p $(CND_DISTDIR)/$(CND_CONF)/$(CND_PLATFORM)

	$(WINDRES) ./src/Versioninfo.rc $(CND_BUILDDIR)/$(CND_CONF)/$(CND_PLATFORM)/src/Versioninfo.o
	$(SWIG) $(SFLAGS) -o ./src/RounderCtrl_wrap.cpp RounderCtrl.swg
	$(CXX) -c $(CXXFLAGS) $(JAVAINC) -o $(OBJECTDIR)/src/RounderCtrl.o src/RounderCtrl.cpp
	$(CXX) -c $(CXXFLAGS) -Wno-unused-function $(JAVAINC) -o $(OBJECTDIR)/src/RounderCtrl_wrap.o src/RounderCtrl_wrap.cpp
	$(CXX) -o $(CND_DISTDIR)/$(CND_CONF)/$(CND_PLATFORM)/libtaurounder.$(CND_DLIB_EXT) $(OBJECTFILES) $(CRPLIBS) -Wl,--kill-at -shared
	
	$(CP) $(CND_DISTDIR)/$(CND_CONF)/$(CND_PLATFORM)/libtaurounder.$(CND_DLIB_EXT) ../tauargus/$(LIBNAME).dll
	$(CP) $(CND_DISTDIR)/$(CND_CONF)/$(CND_PLATFORM)/*.java ../tauargus/src/tauargus/extern/taurounder

clean:
	$(RM) -r $(CND_BUILDDIR)/$(CND_CONF)
	$(RM) $(CND_DISTDIR)/$(CND_CONF)/$(CND_PLATFORM)/*.$(CND_DLIB_EXT)
