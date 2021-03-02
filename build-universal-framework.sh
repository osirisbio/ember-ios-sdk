# create folder where we place built frameworks
mkdir build
# build framework for simulators
xcodebuild clean build \
  -workspace EMBERSDK.xcworkspace \
  -scheme EMBERSDK \
  -configuration Release \
  -sdk iphonesimulator \
  -derivedDataPath derived_data
# create folder to store compiled framework for simulator
mkdir build/simulator
# copy compiled framework for simulator into our build folder
cp -r derived_data/Build/Products/Release-iphonesimulator/EMBERSDK.framework build/simulator
#build framework for devices
xcodebuild clean build \
  -workspace EMBERSDK.xcworkspace \
  -scheme EMBERSDK \
  -configuration Release \
  -sdk iphoneos \
  -derivedDataPath derived_data
# create folder to store compiled framework for simulator
mkdir build/devices
# copy compiled framework for simulator into our build folder
cp -r derived_data/Build/Products/Release-iphoneos/EMBERSDK.framework build/devices
# create folder to store compiled universal framework
mkdir build/universal
####################### Create universal framework #############################
# copy device framework into universal folder
cp -r build/devices/EMBERSDK.framework build/universal/
# create framework binary compatible with simulators and devices, and replace binary in unviersal framework
lipo -create \
  build/simulator/EMBERSDK.framework/EMBERSDK \
  build/devices/EMBERSDK.framework/EMBERSDK \
  -output build/universal/EMBERSDK.framework/EMBERSDK
# copy simulator Swift public interface to universal framework
cp build/simulator/EMBERSDK.framework/Modules/EMBERSDK.swiftmodule/* build/universal/EMBERSDK.framework/Modules/EMBERSDK.swiftmodule
