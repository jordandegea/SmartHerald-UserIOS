# Force Makefile to recompile
#	-B

# How do I select the default version of Xcode to use for my command-line tools?
# 	sudo xcode-select -switch <path/to/>Xcode.app

version:
	xcode-select --print-path


%.xcodeprojl:
	xcodebuild -list -project $*.xcodeproj

%.xcodeprojr:
	xcodebuild \
		test \
		-scheme "sinenco_fr" \
		-destination 'platform=iOS Simulator,name=iPad' \
		-xcconfig config.xcconfig

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