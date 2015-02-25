//
//  VideoManager.m
//  TwoImages
//
//  Created by Valeriy Chevtaev on 25/02/2015.
//  Copyright (c) 2015 Valera Chevtaev. All rights reserved.
//

#import "VideoManager.h"

@interface VideoManager()

// Helper for getting image as NSData
- (NSData *)imageByName:(NSString *)imageName;

// Updates both video buffers
- (void)updateVideoBuffers:(NSTimer *)timer;

@end

@implementation VideoManager

#pragma mark - Public interface

- (void)start {
    NSLog(@"VideoManager - starting...");
    // TODO Data updater, should be implemented as a manager class
    updateVideoBuffersTimer = [NSTimer scheduledTimerWithTimeInterval:1/30
                                                               target:self
                                                             selector:@selector(updateVideoBuffers:)
                                                             userInfo:nil
                                                              repeats:YES];
    NSLog(@"VideoManager - is ready");
}

- (void)stop {
    NSLog(@"VideoManager - stopping...");
    
    // Stop video buffers update timer
    if (updateVideoBuffersTimer != nil) {
        [updateVideoBuffersTimer invalidate];
        updateVideoBuffersTimer = nil;
    }

    NSLog(@"VideoManager - released");
}

- (void)dealloc {
    [self stop];
}

#pragma mark - Auxiliary methods

- (void)updateVideoBuffers:(NSTimer *)timer {
    static short i = 0;
    
    NSData * leftData;
    NSData * rightData;
    
    // Just switch two predefined images
    if (i == 0) {
        leftData = [self imageByName:@"img1.jpg"];
        rightData = [self imageByName:@"img2.jpg"];
        
        ++i;
    } else {
        leftData = [self imageByName:@"img2.jpg"];
        rightData = [self imageByName:@"img1.jpg"];
        
        i = 0;
    }
    
    // Update only if available
    if (leftData != nil) {
        [self.delegate updateLeftBuffer:leftData];
    } else {
        NSLog(@"No data for left buffer");
    }
    if (rightData != nil) {
        [self.delegate updateRightBuffer:rightData];
    } else {
        NSLog(@"No data for right buffer");
    }
}

- (NSData *)imageByName:(NSString *)imageName {
    return UIImageJPEGRepresentation([UIImage imageNamed:imageName], 1.0f);
}

@end
