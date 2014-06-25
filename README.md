libskia-dev
===========

Scripts to build skia library for Ubuntu, MacOS X and Windows

==For Ubuntu 12.04 x86_64.==

* To build skia execute: ./skia-build-ubuntu.sh
* To build deb package execute: ./skia-make-deb-ubuntu.sh
* Install package with: sudo dpkg -i libskia-dev-0.1+gitc05d2859e10f4e1fb0c6486eebfbe88801202648_amd64.deb (file name will vary depending on the git commit)
* Uninstall with: sudo apt-get remove libskia-deb

==For Windows==
* Install Visual Studio Express 2013
* Install MSYS and MINGW
* Install Python27
* From MSYS execute: ./skia-build-windows.sh
* skya installed on /local/lib/skia.lib. Headers at /local/include (MSYS fs).

== For MacOS X==
* Install XCode
* From Terminal execute: ./skia-build-macosx

==All Platforms==
* Build your application with the following flags:
	
	-DSK_ATOMICS_PLATFORM_H=\"SkAtomics_sync.h\" \
    -DSK_MUTEX_PLATFORM_H=\"SkMutex_pthread.h\" \
    -DSK_BARRIERS_PLATFORM_H=\"SkBarriers_x86.h\" \
    -DSK_RELEASE \
   -lskia -lfreetype -lfontconfig -lpthread -lGL -lgif -lpng
	 
	


