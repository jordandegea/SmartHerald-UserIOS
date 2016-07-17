#/bin/sh

DEVELOPER_DIR=`xcode-select --print-path`
IPA="publish"
TEMP_IPA_BUILT="dists/standalone/$1/$1_tmp"
APP="${TEMP_IPA_BUILT}/Payload/*.app"
if [ ! -d "${DEVELOPER_DIR}" ]; then
    echo "No developer directory found!"
    exit 1
fi
#reparing for temp directory
if [ -d "${TEMP_IPA_BUILT}" ];
then
    rm -rf "${TEMP_IPA_BUILT}"
fi  
mkdir ${TEMP_IPA_BUILT}
echo "unzip the ipa"
unzip -q "dists/standalone/$1/${IPA}.ipa" -d "${TEMP_IPA_BUILT}"
echo "+ Adding SWIFT support (if necessary)"
mkdir -p "${TEMP_IPA_BUILT}/SwiftSupport"
for SWIFT_LIB in $(ls -1 ${APP}/Frameworks); do 
    echo "Copying ${SWIFT_LIB}"
    cp "${DEVELOPER_DIR}/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift/iphoneos/${SWIFT_LIB}" "${TEMP_IPA_BUILT}/SwiftSupport"
done
mv "dists/standalone/$1/${IPA}.ipa" "dists/standalone/$1/${IPA}.ipa.old"
cd ${TEMP_IPA_BUILT}
zip -r ../publish.ipa Payload SwiftSupport
cd ..
rm -Rf ${TEMP_IPA_BUILT}