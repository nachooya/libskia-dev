git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
export PATH="$PATH":`pwd`/depot_tools

mkdir skia
cd skia

gclient config --name . https://skia.googlesource.com/skia.git
gclient sync
git checkout master

python gyp_skia
ln -sf /c/Python27/python.exe /usr/bin/python
make -j skia_lib BUILDTYPE=Release

export PATH=$PATH:/c/Program\ Files\ \(x86\)/MSBuild/12.0/Bin/
export PATH=$PATH:/c/Program\ Files\ \(x86\)/Microsoft\ Visual\ Studio\ 12.0/VC/bin/

cd out/gyp
MSBuild.exe libjpeg.sln /property:Configuration=Release
MSBuild.exe ktx.sln  /property:Configuration=Release
MSBuild.exe etc1.sln  /property:Configuration=Release
cd ../..

lib.exe /OUT:skia.lib out/Release/*.lib out/Release/obj/gyp/*.lib

cp skia.lib /local/lib/

mkdir -p /local/include/skia

for i in `find skia/include -iname '*.h'`; 
do 
	cp $i /local/include/skia/;
done

cp skia/src/ports/SkAtomics_sync.h /local/include/skia/
cp skia/src/ports/SkMutex_pthread.h /local/include/skia/
cp skia/src/ports/SkBarriers_x86.h /local/include/skia/
