//
//  ViewController.h
//  TwoImages
//
//  Created by Valeriy Chevtaev on 19/02/2015.
//  Copyright (c) 2015 Valera Chevtaev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoManager.h"

@interface ViewController : UIViewController<VideoManagerDelegate>
{
    @private
    NSObject * leftDataMutex;
    NSObject * rightDataMutex;
    
    NSTimer * redrawVideoTimer;
    
    VideoManager * videoManager;
}

@property (strong, nonatomic) IBOutlet UIImageView * leftImage;
@property (strong, nonatomic) IBOutlet UIImageView * rightImage;

@property (strong, nonatomic) NSData * leftDataBuffer;
@property (strong, nonatomic) NSData * rightDataBuffer;

@end

