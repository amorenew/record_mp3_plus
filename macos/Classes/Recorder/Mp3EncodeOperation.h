//
//  Mp3EncodeOperation.h
//

#import <Foundation/Foundation.h>

@interface Mp3EncodeOperation : NSOperation

@property (nonatomic, assign) BOOL setToStopped ;

@property (nonatomic, assign) NSMutableArray *recordQueue;
@property (nonatomic, strong) NSString *currentMp3File;
@property (nonatomic, copy)  void (^onRecordError)(NSInteger);



@end
