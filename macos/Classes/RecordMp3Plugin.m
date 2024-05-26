#import "RecordMp3Plugin.h"
#import <record_mp3_plus/record_mp3_plus-Swift.h>

@implementation RecordMp3Plugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftRecordMp3Plugin registerWithRegistrar:registrar];
}
@end
