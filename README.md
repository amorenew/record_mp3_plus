# Record Mp3
[![pub package](https://img.shields.io/pub/v/record_mp3_plus.svg)](https://pub.dartlang.org/packages/record_mp3_plus)

##### Record an MP3 using the platform's native API
##### I made this plugin as record_mp3 is not maintained for a long time and it doesn't work on the iOS simulator 
## Depend on it
Add this to your package's pubspec.yaml file:

```
dependencies:
  record_mp3_plus: check the latest on pub.dev
```

#### On Android Emulator for Android 15 with 16k support if it is intel emulator x86_64 it won't work due to the following issue
https://github.com/amorenew/record_mp3_plus/issues/9

<img src="emulators.png" alt="No support for x86_64 emulators" width="400" />

###### On iOS Simulator use Headphone to record otherwise you may not able to hear your recording
 
## Usage
 
1- Add microphone permission, check the permission sections
2- Check the microphone permission before starting recording
3- Start recording
```
RecordMp3.instance.start(recordFilePath!, (error) {
        statusText = "Record error--->$type";
      });
```
4- Pause recording or resume
```
if (RecordMp3.instance.status == RecordStatus.PAUSE) {
      bool isResumed = RecordMp3.instance.resume();
      if (isResumed) {
        statusText = "Recording...";
      }
    } else {
      bool isPaused = RecordMp3.instance.pause();
      if (isPaused) {
        statusText = "Recording pause...";
      }
    }
```
5- Stop or finish recording
```
bool isStopped = RecordMp3.instance.stop();
 if (isStopped) {
      statusText = "Record complete";
   }
```
 
### iOS or macOS

Make sure you add the following key to Info.plist for iOS
```
<key>NSMicrophoneUsageDescription</key>
<string>Add your description here</string>
```
and if you will use permission_handler library go to Podfile
and after `flutter_additional_ios_build_settings` add the following
Note: I added EXCLUDED_ARCHS to make it work on macOS Intel devices
``` 
 target.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "x86_64"
    config.build_settings["GCC_PREPROCESSOR_DEFINITIONS"] ||= [
       "$(inherited)",

       ## dart: PermissionGroup.microphone
       "PERMISSION_MICROPHONE=1",
    ]
 end
```
for macOS permission_handler doesn't support macOS yet so I used 
`dependency_overrides` which allows me to use an open PR with macOS support
check the example pubspec.yaml

### Example
```
import 'package:record_mp3_plus/record_mp3_plus.dart';

//start record 
RecordMp3.instance.start(recordFilePath, (type) {
       // record fail callback
});
	  
//pause record
RecordMp3.instance.pause();

//resume record
RecordMp3.instance.resume();

//complete record and export a record file
RecordMp3.instance.stop();

```


