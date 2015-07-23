//
//  GroupSendController.h
//  moment
//
//  Created by 张鹤楠 on 15/7/20.
//  Copyright (c) 2015年 张鹤楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>


@interface GroupSendController : UIViewController
{
    AVAudioRecorder *recorder;
    NSTimer *timer;
    NSURL *urlPlay;
    NSTimer *recordTimer;
    NSTimer *removeShowSecondHint;
}
@property (retain, nonatomic) AVAudioPlayer *avPlay;

@end
