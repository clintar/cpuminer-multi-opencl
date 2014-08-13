CPUMiner-Multi-OpenCL
==============

This is a multi-threaded OpenCL/CPU miner,
fork of [pooler](//github.com/pooler)'s cpuminer.

#### Table of contents

* [Algorithms](#algorithms)
* [Dependencies](#dependencies)
* [Download](#download)
* [Build](#build)
* [Usage instructions](#usage-instructions)
* [Donations](#donations)
* [Credits](#credits)
* [License](#license)

Algorithms
==========
 * ✓ __wildkeccak__ (Boolberry [BBR])

Dependencies
============
* libcurl			http://curl.haxx.se/libcurl/
* jansson			http://www.digip.org/jansson/ (jansson is included in-tree)
* openssl           https://www.openssl.org/

Build
=====

Important: edit 1st line of Makefile.am if you have OpenCL headers in different directory.

#### Basic *nix build instructions:
```sh
./autogen.sh	# only needed if building from git repo
./nomacro.pl	# only needed if building on Mac OS X or with Clang
./configure CFLAGS="-O3 -march=native"
# Use -march=native if building for a single machine
make
```

#### Notes for AIX users:
 * To build a 64-bit binary, `export OBJECT_MODE=64`
 * GNU-style long options are not supported, but are accessible via configuration file

#### Basic Windows build instructions, using MinGW:
 * Install MinGW and the MSYS Developer Tool Kit (http://www.mingw.org/)
   * Make sure you have mstcpip.h in MinGW\include
 * If using MinGW-w64, install pthreads-w64
 * Install libcurl devel (http://curl.haxx.se/download.html)
   * Make sure you have libcurl.m4 in MinGW\share\aclocal
   * Make sure you have curl-config in MinGW\bin
 * Install openssl devel (https://www.openssl.org/related/binaries.html)
 * In the MSYS shell, run:
```sh
./autogen.sh	# only needed if building from git repo
LIBCURL="-lcurldll" ./configure CFLAGS="-O3 *-march=native*"
# Use -march=native if building for a single machine
make
```

#### Basic cross-compile instructions, compiling for win64 on Linux Fedora:
```sh
yum install mingw\*
./autogen.sh    # only needed if building from git repo
./configure CC=x86_64-w64-mingw32-gcc RANLIB=x86_64-w64-mingw32-ranlib --target x86_64-w64-mingw32 
make
```

#### Architecture-specific notes:
 * ARM:
   * No runtime CPU detection. The miner can take advantage of some instructions specific to ARMv5E and later processors, but the decision whether to use them is made at compile time, based on compiler-defined macros.
   * To use NEON instructions, add "-mfpu=neon" to CFLAGS.
 * x86:
   * The miner checks for SSE2 instructions support at runtime, and uses them if they are available.
 * x86-64:	
   * The miner can take advantage of AVX, AVX2 and XOP instructions, but only if both the CPU and the operating system support them.
     * Linux supports AVX starting from kernel version 2.6.30.
     * FreeBSD supports AVX starting with 9.1-RELEASE.
     * Mac OS X added AVX support in the 10.6.8 update.
     * Windows supports AVX starting from Windows 7 SP1 and Windows Server 2008 R2 SP1.
   * The configure script outputs a warning if the assembler doesn't support some instruction sets. In that case, the miner can still be built, but unavailable optimizations are left off.

Usage instructions
==================

Copy *.cl kernel files to executable's directory.
```sh
./minerd -a wildkeccak_ocl -o stratum+tcp://url_to_server:7778 -u 1L1ZPC9XodC6g5BX8j8m3vcdkXPiZrVF7RcERWE879coQDWiztUbkkVZ86o43P27Udb3qxL4B41gbaGpvj3nS7DgFZauAZE  -p x -t 1 -d 0 -i 20 -k https://raw.githubusercontent.com/scratchpadbbr/scratchpad/master/scratchpad.bin -l scratchpad.bin
```
Run "minerd --help" to see options.



### Connecting through a proxy



Use the --proxy option.

To use a SOCKS proxy, add a socks4:// or socks5:// prefix to the proxy host  
Protocols socks4a and socks5h, allowing remote name resolving, are also available since libcurl 7.18.0.

If no protocol is specified, the proxy is assumed to be a HTTP proxy.  
When the --proxy option is not used, the program honors the http_proxy and all_proxy environment variables.

Donations
=========
Donations for the work done in this fork by mbk are accepted at
* BBR: `@mbk`
* BTC: `1Lns6UjL3sw77DJ5z1EKJZy6SnqriqvVGK`

Credits
=======
CPUMiner-Multi-OpenCL was forked from Cryptozoidberg's cpuminer-multi, and has been developed by Mikhail Kuperman (mbk.git@gmail.com).

License
=======
GPLv2.  See COPYING for details.
