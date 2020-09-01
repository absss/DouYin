//
//  DYVideoRecordView.h
//  CSFVideoRecord
//
//  Created by hehaichi on 2020/5/1.
//  Copyright © 2020 hehaichi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface DYVideoRecordView : UIView
@property(nonatomic, assign,readwrite) AVCaptureDevicePosition devicePosition; //前置 or 后置摄像头
@property (nonatomic, copy) void(^recordCompletion)(NSURL *url,NSError *error); // 录制完成
@property (nonatomic, assign,readwrite,getter=isLightOn) BOOL light; //是否打开闪光灯
//停止运行
-(void)stopRunning;

//开始运行
-(void)startRunning;

//开始录制
- (void)startCapture;

//停止录制,如果你strong持有该对象，在completion内部，你应该使用weakSelf
- (void) stopCapture;

// 设备是否支持
- (BOOL)isDeviceSupport;
@end


