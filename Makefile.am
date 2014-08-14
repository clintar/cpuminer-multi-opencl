OPENCL_INCLUDES= -I"$(AMDAPPSDKROOT)//include"

if WANT_JANSSON
JANSSON_INCLUDES= -I$(top_srcdir)/compat/jansson
else
JANSSON_INCLUDES=
endif

EXTRA_DIST	= example-cfg.json nomacro.pl

SUBDIRS		= compat

INCLUDES	= $(PTHREAD_FLAGS) -fno-strict-aliasing $(JANSSON_INCLUDES) $(OPENCL_INCLUDES) 

bin_PROGRAMS	= minerd

dist_man_MANS	= minerd.1

minerd_SOURCES	= elist.h \
		  miner.h \
		  compat.h \
		  gpu.h \
		  gpu.c \
		  cpu-miner.c \
		  util.c \
		  wildkeccak.c

minerd_LDFLAGS	= $(PTHREAD_FLAGS) 
minerd_LDADD	= @LIBCURL@ @JANSSON_LIBS@ @PTHREAD_LIBS@ @WS2_LIBS@ -lOpenCL
minerd_CPPFLAGS = @LIBCURL_CPPFLAGS@
minerd_CFLAGS   = -std=gnu11 -O3 -fPIC -flto 
#-march=native 

if HAVE_WINDOWS
minerd_CFLAGS += -Wl,--stack,10485760 -DCURL_STATICLIB
endif

if !HAVE_WINDOWS
minerd_LDFLAGS	+= -pie
#minerd_CFLAGS += 
endif
