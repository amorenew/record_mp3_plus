//
//  Recorder.h
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

#define kNumberAudioQueueBuffers 3
#define kBufferDurationSeconds 0.1f

@interface Recorder : NSObject {
     //音频输入队列
    AudioQueueRef				_audioQueue;
    //音频输入缓冲区
    AudioQueueBufferRef			_audioBuffers[kNumberAudioQueueBuffers];
    //音频输入数据format
    AudioStreamBasicDescription	_recordFormat;
    
}

@property (nonatomic, assign) BOOL isRecording;
@property (nonatomic, strong) NSMutableArray *recordQueue;

@property (atomic, assign) NSUInteger sampleRate;
@property (atomic, assign) double bufferDurationSeconds;

- (BOOL)startRecording;
- (void)stopRecording;
- (void)pauseRecording;

@end
