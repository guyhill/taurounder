# Makefile for TauRounder

####### Compiler, tools and options
# Environment

MKDIR            = mkdir -p
RM               = rm -f
CP               = cp -p

32BIT            = false

BITS         = -m64 -D_LP64
ARCH         = x86_64
CND_PLATFORM = gcc
JAVADIR      = /usr/lib/jvm/java-21-openjdk-amd64

JAVAINC          = -I$(JAVADIR)/include -I$(JAVADIR)/include/linux
CC	             = g++
CXX              = g++
WINDRES          = x86_64-w64-mingw32-windres
SWIG             = swig

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

BUILD = build
BUILDSRC = $(BUILD)/src
BUILDOBJ = $(BUILD)/obj

# Compiler flags
#CXXFLAGS         = -g -O2 -Wall $(DEFINES) $(BITS) -fPIC -fno-strict-aliasing
CXXFLAGS         = -g -O2 -Wall $(BITS) -fPIC -fno-strict-aliasing
SFLAGS           = -c++ -I./src -I/usr/local/share/swig/4.4.1 -I/usr/local/share/swig/4.4.1/java -java -package $(JAVAPACKAGE) -outdir $(BUILDSRC)

INCLUDE = -I./src

$(BUILDSRC)/RounderCtrl_wrap.cpp: RounderCtrl.swg
	$(MKDIR) $(BUILDSRC)
	$(SWIG) $(SFLAGS) -o $(BUILDSRC)/RounderCtrl_wrap.cpp RounderCtrl.swg

$(BUILDOBJ)/RounderCtrl_wrap.o: $(BUILDSRC)/RounderCtrl_wrap.cpp
	$(MKDIR) $(BUILDOBJ)
	$(CXX) -c $(CXXFLAGS) -Wno-unused-function $(JAVAINC) $(INCLUDE) -o $(BUILDOBJ)/RounderCtrl_wrap.o $(BUILDSRC)/RounderCtrl_wrap.cpp

$(BUILDOBJ)/RounderCtrl.o: src/RounderCtrl.cpp
	$(MKDIR) $(BUILDOBJ)
	$(CXX) -c $(CXXFLAGS) $(JAVAINC) $(INCLUDE) -o $(BUILDOBJ)/RounderCtrl.o src/RounderCtrl.cpp

$(BUILDOBJ)/Versioninfo.o: src/Versioninfo.rc
	$(WINDRES) ./src/Versioninfo.rc $(BUILDOBJ)/Versioninfo.o

$(BUILDLIB)/libtaurounder.$(CND_DLIB_EXT): $(BUILDOBJ)/*.o
	$(CXX) -o $(BUILDLIB)/libtaurounder.$(CND_DLIB_EXT) $(BUILDOBJ)/*.o $(CRPLIBS) -Wl,--kill-at -shared

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
	$(RM) -r $(BUILD)
	$(RM) $(CND_DISTDIR)/$(CND_CONF)/$(CND_PLATFORM)/*.$(CND_DLIB_EXT)
