# Force Makefile to recompile
#	-B

# How do I select the default version of Xcode to use for my command-line tools?
# 	sudo xcode-select -switch <path/to/>Xcode.app

# Dont forget to ln -s the altool functions
# ln -s /Applications/Xcode.app/Contents/Applications/Application\ Loader.app/Contents/itms/ /usr/local/itms


ALTOOL="/Applications/Application Loader.app/Contents/Frameworks/ITunesSoftwareService.framework/Versions/A/Support/altool"
	

version:
	xcode-select --print-path


%.xcodeprojl:
	xcodebuild -list -project $*.xcodeproj

dists/standalone/%.xcconfig_simulator: 
		xcrun xcodebuild \
		  -scheme "StandaloneScheme" \
		  -configuration Debug \
		  -xcconfig "dists/standalone/$*.xcconfig" \
		  -destination 'platform=iOS Simulator,name=iPhone 6' \
		  -derivedDataPath \
		  build

# Then \
simctl install FEDE6969-7CC2-4033-A1AC-E34422174877 build/Build/Products/Debug-iphonesimulator/Sinenco.app \
simctl launch FEDE6969-7CC2-4033-A1AC-E34422174877 com.sinenco.sinenco

#########################################################################################

dists/standalone/%.xcconfig: dists/standalone/%.xcconfig_publish
	echo "done"

dists/standalone/%.xcconfig_publish: dists/standalone/%.xcconfig_swiftsupport
	${ALTOOL} --upload-app -f "dists/standalone/$*/publish.ipa" -u "jordan.degea@gmail.com" -p "Bullet4my04"


dists/standalone/%.xcconfig_swiftsupport: dists/standalone/%.xcconfig_compile
	./dists/SwiftSupport.sh $*

dists/standalone/%.xcconfig_compile:
	rm -Rf "dists/standalone/$*/publish.ipa" "dists/standalone/$*/archive.xcarchive" && \
	xcodebuild \
		-alltargets \
		-xcconfig "dists/standalone/$*.xcconfig" \
		-scheme "StandaloneScheme" \
		-archivePath "dists/standalone/$*/archive.xcarchive" \
		archive && \
	xcodebuild \
		-exportArchive \
		-exportFormat IPA \
		-archivePath "dists/standalone/$*/archive.xcarchive" \
		-exportPath "dists/standalone/$*/publish.ipa" \
		-exportSigningIdentity "iPhone Distribution: Jordan DE GEA (K27GN92373)"


#########################################################################################


simulators:
	xcrun simctl list

simulate:
	xcrun simctl boot 2781A5B8-5127-49CD-8B18-3A8BDB94A78F

simulator:
	open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app

test: 
	xcrun simctl launch FEDE6969-7CC2-4033-A1AC-E34422174877 dists/standalone/config/config_tmp/Payload/Sinenco.app
	#xcrun simctl install booted dists/standalone/config/config_tmp/Payload/Sinenco.app && \
	#xcrun simctl launch booted com.sinenco.sinenco




dists/standalone/%.xcconfigp:
	xcrun \
		-sdk iphoneos PackageApplication \
		-v "dists/standalone/$*/Applications/Standalone.app" \
		-o "dists/standalone/$*/Standalone.ipa"

%.xcodeprojr2:
	xcrun xcodebuild \
	  -scheme "sinenco_fr" \
	  -configuration Debug \
	  -destination 'platform=iOS Simulator,name=iPhone 6 Plus' \
	  -xcconfig 'config.xcconfig' \
	  -derivedDataPath \
	  build

%.xcodeproj:
	 xcodebuild -scheme "Shared News" build