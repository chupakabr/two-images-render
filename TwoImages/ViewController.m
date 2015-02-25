//
//  ViewController.m
//  TwoImages
//
//  Created by Valeriy Chevtaev on 19/02/2015.
//  Copyright (c) 2015 Valera Chevtaev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// Call every 1/30 seconds to redraw images
- (void)redrawScreen:(NSTimer *)timer;

@end

@implementation ViewController

@synthesize leftDataBuffer = _leftDataBuffer;
@synthesize rightDataBuffer = _rightDataBuffer;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"View did load");
    
    // Init mutexes
    leftDataMutex = [[NSObject alloc] init];
    rightDataMutex = [[NSObject alloc] init];
    
    // Init video redraw timer
    redrawVideoTimer = [NSTimer scheduledTimerWithTimeInterval:1/30
                                                   target:self
                                                      selector:@selector(redrawScreen:)
                                                 userInfo:nil
                                                  repeats:YES];
    
    // Start video streaming
    videoManager = [[VideoManager alloc] init];
    videoManager.delegate = self;
    [videoManager start];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    NSLog(@"View will disappear");
    
    // Stop video redraw timer
    [redrawVideoTimer invalidate];
    redrawVideoTimer = nil;
    
    // Stop video streaming
    [videoManager stop];
    videoManager.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)redrawScreen:(NSTimer *)timer {
    NSData * leftData = self.leftDataBuffer;
    NSData * rightData = self.rightDataBuffer;
    
    dispatch_async(dispatch_get_main_queue(), ^ {
        self.leftImage.image = [UIImage imageWithData:leftData];
        self.rightImage.image = [UIImage imageWithData:rightData];
    });
}

#pragma mark - VideoManagerDelegate implementation

- (void)updateLeftBuffer:(NSData *)newData {
    if (newData != nil) {
        self.leftDataBuffer = newData;
    }
}

- (void)updateRightBuffer:(NSData *)newData {
    if (newData != nil) {
        self.rightDataBuffer = newData;
    }
}

#pragma mark - Getters/Setters override

- (void)setLeftDataBuffer:(NSData *)leftDataBuffer {
    @synchronized(leftDataMutex) {
        _leftDataBuffer = [NSData dataWithData:leftDataBuffer];
    }
}

- (NSData *)leftDataBuffer {
    @synchronized(leftDataMutex) {
        return _leftDataBuffer;
    }
}

- (void)setRightDataBuffer:(NSData *)rightDataBuffer {
    @synchronized(rightDataMutex) {
        _rightDataBuffer = [NSData dataWithData:rightDataBuffer];
    }
}

- (NSData *)rightDataBuffer {
    @synchronized(rightDataMutex) {
        return _rightDataBuffer;
    }
}

@end
