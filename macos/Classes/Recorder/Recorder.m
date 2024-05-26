//
//  Recorder.m

#import "Recorder.h"
#import <AVFoundation/AVFoundation.h>

static const int sampleRate = 16000;
static const int bitsPerChannel = 16;

@implementation Recorder

- (id)init
{
    self = [super init];
    if (self) {
        self.sampleRate = kNumberAudioQueueBuffers;
        self.bufferDurationSeconds = kBufferDurationSeconds;
        //设置录音的format数据
        [self setupAudioFormat:kAudioFormatLinearPCM SampleRate:sampleRate]; // 
    }
    return self;
}

// 设置录音格式
- (void)setupAudioFormat:(UInt32)inFormatID SampleRate:(int)sampleRate {
    //重置下
    memset(&_recordFormat, 0, sizeof(_recordFormat));
    
    //采样率的意思是每秒需要采集的帧数
    _recordFormat.mSampleRate = sampleRate;
    
    //设置通道数
    _recordFormat.mChannelsPerFrame = 1;
    
    //设置format
    _recordFormat.mFormatID = inFormatID;
    if (inFormatID == kAudioFormatLinearPCM) {
        // if we want pcm, default to signed 16-bit little-endian
        _recordFormat.mChannelsPerFrame = 1;
        _recordFormat.mFormatFlags = kLinearPCMFormatFlagIsSignedInteger | kLinearPCMFormatFlagIsPacked;
        _recordFormat.mBitsPerChannel = bitsPerChannel;
        _recordFormat.mBytesPerPacket = _recordFormat.mBytesPerFrame = (_recordFormat.mBitsPerChannel / 8) * _recordFormat.mChannelsPerFrame;
        _recordFormat.mFramesPerPacket = 1;
    }
}

// 回调函数
void inputBufferHandler(void *inUserData, AudioQueueRef inAQ, AudioQueueBufferRef inBuffer, const AudioTimeStamp *inStartTime,
                        UInt32 inNumPackets, const AudioStreamPacketDescription *inPacketDesc) {
    
    Recorder *recorder = (__bridge Recorder *)inUserData;
    if (inNumPackets > 0) {
        NSData *pcmData = [[NSData alloc] initWithBytes:inBuffer->mAudioData length:inBuffer->mAudioDataByteSize];
        if (pcmData && pcmData.length > 0) {
            if (!recorder.recordQueue) {
                recorder.recordQueue = [NSMutableArray array];
            }
            [recorder.recordQueue addObject:pcmData];
        }
    }
    
    if (recorder.isRecording > 0) {
        AudioQueueEnqueueBuffer(inAQ, inBuffer, 0, NULL);
    }
}

// 开始录音
- (BOOL)startRecording {
#if TARGET_OS_IPHONE
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    
    //设置audio session的category
    NSError *error = nil;
    BOOL ret = [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    if (!ret) {
        NSLog(@"设置声音环境失败");
        return NO;
    }
    
    //启用audio session
    ret = [[AVAudioSession sharedInstance] overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:&error];
    if (!ret) {
        NSLog(@"启动失败");
        return NO;
    }
#elif TARGET_OS_OSX
    // macOS-specific audio session setup
    // Generally, macOS apps don't need explicit audio session management like iOS
    NSError *error = nil;
    AVAudioEngine *audioEngine = [[AVAudioEngine alloc] init];
    AVAudioInputNode *inputNode = [audioEngine inputNode];
    AVAudioFormat *recordingFormat = [inputNode outputFormatForBus:0];
    [audioEngine inputNode].volume = 1.0;
    [audioEngine startAndReturnError:&error];
    if (error) {
        NSLog(@"启动失败: %@", error.localizedDescription);
        return NO;
    }
#endif
    
    //初始化音频输入队列
    AudioQueueNewInput(&_recordFormat, inputBufferHandler, (__bridge void *)(self), NULL, NULL, 0, &_audioQueue);
    
    //计算估算的缓存区大小
    UInt32 frames = (UInt32)(self.bufferDurationSeconds * (double)_recordFormat.mSampleRate);
    UInt32 bufferByteSize = frames * _recordFormat.mBytesPerFrame;
    NSLog(@"缓冲区大小:%u", (unsigned int)bufferByteSize);
    
    // 创建缓冲器
    for (int i = 0; i < kNumberAudioQueueBuffers; ++i) {
        AudioQueueAllocateBuffer(_audioQueue, bufferByteSize, &_audioBuffers[i]);
        AudioQueueEnqueueBuffer(_audioQueue, _audioBuffers[i], 0, NULL);
    }
    
    // 开始录音
    AudioQueueStart(_audioQueue, NULL);
    
    self.isRecording = YES;
    return YES;
}

// 停止录音
- (void)stopRecording {
    if (_isRecording) {
        _isRecording = NO;
        AudioQueueStop(_audioQueue, true);
        AudioQueueDispose(_audioQueue, true);
    }
}

// 暂停录音
- (void)pauseRecording {
    if (_isRecording) {
        AudioQueuePause(_audioQueue);
    }
}

- (NSMutableArray *)recordQueue {
    if (!_recordQueue) {
        _recordQueue = [NSMutableArray array];
    }
    return _recordQueue;
}

@end
