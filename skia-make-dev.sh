cd skia
GIT_VERSION=$(git rev-parse HEAD)
cd ..
VERSION="0.1"
REVISION="git$GIT_VERSION"
PACKAGE_NAME="libskia-dev"
PREFIX="usr/local"
ARCH=amd64

rm debian/$PREFIx -rf > /dev/null 2> /dev/null
mkdir debian/DEBIAN -p
mkdir debian/$PREFIX/lib -p
mkdir debian/$PREFIX/include/skia -p

./skia/tools/merge_static_libs.py debian/$PREFIX/lib/libskia.a skia/out/Release/*.a skia/out/Release/obj.target/gyp/*.a skia/out/gyp/Release/obj.target/gyp/libjpeg.a

for i in `find skia/include -iname '*.h'`;
do 
  cp $i debian/$PREFIX/include/skia/;
done

cp skia/src/ports/SkAtomics_sync.h debian/$PREFIX/include/skia/
cp skia/src/ports/SkMutex_pthread.h debian/$PREFIX/include/skia/

echo "Package: libskia-dev" > control
echo "Depends: libfreetype6, libfreetype6-dev, libfontconfig, libfontconfig-dev, libpng12-0, libpng12-dev, libgif-dev, libjpeg-turbo8-dev" >> control
echo "Version: $VERSION+$REVISION" >> control
echo "Section: base" >> control
echo "Priority: optional" >> control
echo "Architecture: $ARCH" >> control
echo "Maintainer: Ignacio Martín Oya <nachooya@gmail.com>" >> control
echo "Description: Skia library - development files - static library only" >> control
echo "Homepage: https://sites.google.com/site/skiadocs/" >> control

mv control debian/DEBIAN/control

# CREATE the packet
PKGNAME=$PACKAGE_NAME-$VERSION"+"$REVISION"_"$ARCH
echo $PKGNAME
mkdir $PKGNAME
cp debian/* $PKGNAME/. -R
# find $PKGNAME -name ".svn" | xargs rm -rf
# find $PKGNAME -name "*~" | xargs rm 2> /dev/null
dpkg-deb -b $PKGNAME
rm -rf $PKGNAME
rm -rf debian

exit 0