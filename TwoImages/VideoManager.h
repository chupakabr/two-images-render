//
//  VideoManager.h
//  TwoImages
//
//  Created by Valeriy Chevtaev on 25/02/2015.
//  Copyright (c) 2015 Valera Chevtaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol VideoManagerDelegate <NSObject>
@required
- (void)updateLeftBuffer:(NSData *)newData;
- (void)updateRightBuffer:(NSData *)newData;
@end

@interface VideoManager : NSObject
{
    @private
    NSTimer * updateVideoBuffersTimer;
}

@property (strong, atomic) NSObject<VideoManagerDelegate> * delegate;

- (void)start;
- (void)stop;

@end
