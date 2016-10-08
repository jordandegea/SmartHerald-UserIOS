# Force Makefile to recompile
#	-B

# How do I select the default version of Xcode to use for my command-line tools?
# 	sudo xcode-select -switch <path/to/>Xcode.app

# Dont forget to ln -s the altool functions
# ln -s /Applications/Xcode.app/Contents/Applications/Application\ Loader.app/Contents/itms/ /usr/local/itms


ALTOOL="/Applications/Application Loader.app/Contents/Frameworks/ITunesSoftwareService.framework/Versions/A/Support/altool"

SRC= $(wildcard dists/standalone/*.xcconfig)
DST= $(SRC:dists/standalone/%.xcconfig=%.make)	
EMAIL="jordan.degea@gmail.com"

help:
	@echo ""
	@echo "\tHow to use this make" 
	@echo ""
	@echo "\tmake publish : publish the shared version"
	@echo "\tmake standalone : compile and publish all standalone version"

shared: publish
	@echo "Shared version uploaded"

standalone: ${DST}
	@echo "Standalone version uploaded"


version:
	xcode-select --print-path

# Then \
simctl install FEDE6969-7CC2-4033-A1AC-E34422174877 build/Build/Products/Debug-iphonesimulator/Sinenco.app \
simctl launch FEDE6969-7CC2-4033-A1AC-E34422174877 com.sinenco.sinenco

####################################################
####        Etapes de publication shared        ####
####################################################



publish: swiftsupport
	${ALTOOL} --upload-app -f "dists/shared/publish/publish.ipa" -u ${EMAIL}


swiftsupport: compile
	./dists/SwiftSupport.sh $*

compile:
	rm -Rf "dists/shared/publish/publish.ipa" "dists/shared/publish/archive.xcarchive" && \
	xcodebuild \
		-alltargets \
		-xcconfig "dists/shared/publish.xcconfig" \
		-scheme "SharedScheme" \
		-archivePath "dists/shared/publish/archive.xcarchive" \
		archive && \
	xcodebuild \
		-exportArchive \
		-exportFormat IPA \
		-xcconfig "dists/shared/publish.xcconfig" \
		-archivePath "dists/shared/publish/archive.xcarchive" \
		-exportPath "dists/shared/publish/publish.ipa" 



########################################################
####        Etapes de publication standalone        ####
########################################################

%.make: %.publish 
	echo "$* done "

%.publish: %.swiftsupport
	${ALTOOL} --upload-app -f "dists/standalone/$*/publish.ipa" -u "jordan.degea@gmail.com"


%.swiftsupport: %.compile
	./dists/SwiftSupport.sh $*

%.compile:
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
		-xcconfig "dists/standalone/$*.xcconfig" \
		-archivePath "dists/standalone/$*/archive.xcarchive" \
		-exportPath "dists/standalone/$*/publish.ipa" 


#####################################################
####        Etapes de tests et simulation        ####
#####################################################

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

