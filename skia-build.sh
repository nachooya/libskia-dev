sudo apt-get install libfreetype6 libfreetype6-dev libfontconfig libfontconfig-dev
sudo apt-get install libpng12-0 libpng12-dev libgif-dev libjpeg-turbo8-dev

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
make -f libjpeg.Makefile BUILDTYPE=Release
cd ../..