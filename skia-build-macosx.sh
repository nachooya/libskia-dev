ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

brew install libpng

git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
export PATH="$PATH":`pwd`/depot_tools

mkdir skia
cd skia

gclient config --name . https://skia.googlesource.com/skia.git
gclient sync
git checkout master

./gyp_skia
make -j skia_lib BUILDTYPE=Release

cd out/gyp
xcodebuild  -project ktx.xcodeproj/  -configuration Release
xcodebuild  -project libjpeg.xcodeproj/  -configuration Release
xcodebuild  -project etc1.xcodeproj/  -configuration Release
cd ../..

./skia/tools/merge_static_libs.py /usr/local/lib/libskia.a skia/out/Release/*.a skia/xcodebuild/Release/*.a

mkdir -p /usr/local/include/skia
for i in `find skia/include -iname '*.h'`;
do
  cp $i /usr/local/include/skia/;
done

cp skia/src/ports/SkAtomics_sync.h /usr/local/include/skia/
cp skia/src/ports/SkMutex_pthread.h /usr/local/include/skia/
cp skia/src/ports/SkBarriers_x86.h /usr/local/include/skia/
