//%module taurounder
// directors="1" needed for being able to use the director feature
%module(directors="1") taurounder

%include <typemaps.i>
%include <windows.i>
%include <arrays_java.i>
%include <various.i>
%include <std_string.i>

// Defines not covered by the above ".i" files of SWIG
#define FAR                     __far
#define STDMETHOD(method)       HRESULT STDMETHODCALLTYPE method
#define STDMETHODIMP            HRESULT STDMETHODCALLTYPE
#define STDMETHODCALLTYPE       __stdcall

// By default treat method parameters of the following types as simple output variables in Java
// Arrays of size 1 are generated, so output can be retrieved (we can't pass the address of a variable in Java)
%apply bool *OUTPUT { bool * };
%apply long *OUTPUT { long * };
%apply double *OUTPUT { double * };
%apply char **STRING_OUT { char ** };

// Instead of the default, treat these method parameters as array variables in Java...
%apply char **STRING_ARRAY { char* [] }

// Include this block in the generated C++ wrapper code (rounderctrl_wrap.cpp)
%{
#include "RProgressListener.h"
#include "RCallback.h"
#include "RounderCtrl.h"
%}

%feature("director") RProgressListener;
%feature("director") RCallback;

// Turn on director wrapping RProgressListener. This makes it possible to extend this class in Java
// Generate wrapper code for the classes in these header files, so they can be called from Java
%include "RProgressListener.h"
%include "RCallback.h"
%include "RounderCtrl.h"