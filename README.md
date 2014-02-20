libskia-dev
===========

Scripts to build skia library as a package for Ubuntu

It itended for Ubuntu 12.04 x86_64.

* To build skia execute: ./skia-build.sh
* To build deb package execute: ./skia-make-deb.sh
* Install package with: sudo dpkg -i libskia-dev-0.1+gitc05d2859e10f4e1fb0c6486eebfbe88801202648_amd64.deb (file name will vary depending on the git commit)
* Uninstall with: sudo apt-get remove libskia-deb
* Build your application with the following flags:
	
	 -DSK_ATOMICS_PLATFORM_H=\"SkAtomics_sync.h\" \
   -DSK_MUTEX_PLATFORM_H=\"SkMutex_pthread.h\" \
   -DSK_RELEASE \
   -lskia -lfreetype -lfontconfig -lpthread -lGL -lgif -lpng
	 
	

  
