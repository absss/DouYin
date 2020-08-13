//
//  DYVideoRecordView.m
//  CSFVideoRecord
//
//  Created by hehaichi on 2020/5/1.
//  Copyright © 2020 hehaichi. All rights reserved.
//

#import "DYVideoRecordView.h"

@interface DYVideoRecordView ()<AVCaptureFileOutputRecordingDelegate>
@property (strong, nonatomic) AVCaptureSession * captureSession;  //负责输入和输出设备之间的连接会话
@property (nonatomic, strong) AVCaptureDeviceInput *captureDeviceInput; // 输入源
@property (strong, nonatomic) AVCaptureVideoPreviewLayer * previewLayer;//捕获到的视频呈现的layer
@property (strong, nonatomic) AVCaptureDeviceInput * audioMicInput;//麦克风输入
@property (strong, nonatomic) AVCaptureConnection * videoConnection;//视频录制连接
@property (strong,nonatomic) AVCaptureMovieFileOutput * captureMovieFileOutput;//视频输出流
@property (nonatomic, assign) AVCaptureFlashMode mode;//设置聚焦曝光
@property (nonatomic, strong) AVCaptureDevice *captureDevice;   // 输入设备
@property (nonatomic, strong) NSURL *fileUrl;//设置焦点
@property (nonatomic, strong) CATextLayer *watermarkLayer;
@end
@implementation DYVideoRecordView

- (void)dealloc
{
    NSLog(@"%s",__func__);
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.layer insertSublayer:self.previewLayer atIndex:0];
    }
    return self;
}

-(void)layoutSubviews{
   [super layoutSubviews];
    self.previewLayer.frame = self.bounds;
    [self startRunning];
}

/// 开始运行
-(void)startRunning {
    [self.captureSession startRunning];
     self.videoConnection.videoOrientation = AVCaptureVideoOrientationPortrait;
     self.videoConnection.videoMirrored = YES;
}

/// 停止运行
-(void)stopRunning {
    [self.captureSession stopRunning];
}

/// 获取视频方向
- (AVCaptureVideoOrientation)getCaptureVideoOrientation {
    AVCaptureVideoOrientation result;
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    switch (deviceOrientation) {
        case UIDeviceOrientationPortrait:
        case UIDeviceOrientationFaceUp:
        case UIDeviceOrientationFaceDown:
            result = AVCaptureVideoOrientationPortrait;
            break;
        case UIDeviceOrientationPortraitUpsideDown: //如果这里设置成AVCaptureVideoOrientationPortraitUpsideDown，则视频方向和拍摄时的方向是相反的。
            result = AVCaptureVideoOrientationPortrait;
            break;
        case UIDeviceOrientationLandscapeLeft:
            result = AVCaptureVideoOrientationLandscapeRight;
            break;
        case UIDeviceOrientationLandscapeRight:
            result = AVCaptureVideoOrientationLandscapeLeft;
            break;
        default:
            result = AVCaptureVideoOrientationPortrait;
            break;
    }
   return result;
}

//开始录制
- (void)startCapture
{
    if(self.captureMovieFileOutput.isRecording){
        return ;
    }
    NSString *defultPath = [self getVideoPathCache];
    NSString *outputFielPath=[defultPath stringByAppendingPathComponent:[self getVideoNameWithType:@"mov"]];
    NSURL *fileUrl=[NSURL fileURLWithPath:outputFielPath];
    self.fileUrl = fileUrl;
  
    [self.captureMovieFileOutput startRecordingToOutputFileURL:fileUrl recordingDelegate:self];
}

///停止录制
- (void) stopCapture {
    [self.captureMovieFileOutput stopRecording];//停止录制
}

/// setter
- (void)setLight:(BOOL)on {
    if (on) {
        if (self.mode == AVCaptureFlashModeOff) {
            [self setMode:AVCaptureFlashModeOn];
        }
        
    } else {
        if (self.mode == AVCaptureFlashModeOn) {
            [self setMode:AVCaptureFlashModeOff];
        }
    }
}

- (void)setDevicePosition:(AVCaptureDevicePosition)devicePosition {
    AVCaptureDevice *device = [self createAVCaptureDevice:devicePosition];
   if (device) {
        self.captureDevice = device;
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:self.captureDevice error:nil];
        [self.captureSession beginConfiguration];
        [self.captureSession removeInput:self.captureDeviceInput];
        if ([self.captureSession canAddInput:input]) {
            [self.captureSession addInput:input];
            self.captureDeviceInput = input;
            [self.captureSession commitConfiguration];
        }
    }
}

#pragma mark getter
- (BOOL)isLightOn {
    return (self.mode == AVCaptureFlashModeOn);
}

- (AVCaptureDevicePosition)devicePosition {
    return self.captureDevice.position;
}



/// 视频输出代理开始录制
-(void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections{
    
}


/// 录制完成回调
-(void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error{
    if (self.recordCompletion) {
        self.recordCompletion(outputFileURL,error);
    }
}

/// 视频地址
- (NSString *)getVideoPathCache
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * videoCache = [[paths firstObject] stringByAppendingPathComponent:@"videos"];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:videoCache isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) ) {
        [fileManager createDirectoryAtPath:videoCache withIntermediateDirectories:YES attributes:nil error:nil];
    };
    return videoCache;
}

/// 拼接视频文件名称
- (NSString *)getVideoNameWithType:(NSString *)fileType
{
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)([[NSDate date] timeIntervalSince1970]*1000)];
    NSString *fileName = [NSString stringWithFormat:@"%@.%@",timeSp,fileType];
    return fileName;
}

/// 设置相机画布
-(AVCaptureVideoPreviewLayer *)previewLayer{
    if (!_previewLayer) {
        _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
        _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }
    return _previewLayer;
}

/// 创建会话
-(AVCaptureSession *)captureSession{
    if (!_captureSession) {
        _captureSession = [[AVCaptureSession alloc] init];
        _captureSession.sessionPreset = AVCaptureSessionPresetMedium; // 画质
        // 5. 连接输入与会话
        if ([_captureSession canAddInput:self.captureDeviceInput]) {
            [_captureSession addInput:self.captureDeviceInput];
        }
        if ([_captureSession canAddInput:self.audioMicInput]) {
            [_captureSession addInput:self.audioMicInput];
        }
        // 6. 连接输出与会话
        if ([_captureSession canAddOutput:self.captureMovieFileOutput]) {
           [_captureSession addOutput:self.captureMovieFileOutput];
        }
    }
    return _captureSession;
}

/// 创建输入源
-(AVCaptureDeviceInput *)captureDeviceInput{
    if (!_captureDeviceInput) {
        _captureDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:self.captureDevice error:nil];
    }
    return _captureDeviceInput;
}

//麦克风输入
- (AVCaptureDeviceInput *)audioMicInput {
    if (_audioMicInput == nil) {
        AVCaptureDevice *mic = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
        NSError *error;
        _audioMicInput = [AVCaptureDeviceInput deviceInputWithDevice:mic error:&error];
        if (error) {
          //  NSLog(@"获取麦克风失败~%d",[self isAvailableWithMic]);
        }
    }
    return _audioMicInput;
}

/// 初始化设备输出对象，用于获得输出数据
- (AVCaptureMovieFileOutput *)captureMovieFileOutput
{
    if(_captureMovieFileOutput == nil)
    {
        _captureMovieFileOutput = [[AVCaptureMovieFileOutput alloc]init];
        _captureMovieFileOutput.movieFragmentInterval = kCMTimeInvalid;

   }
    return _captureMovieFileOutput;
}

/// 创建输入设备
-(AVCaptureDevice *)captureDevice{
    if (!_captureDevice) {
        // 默认使用前置摄像头
        _captureDevice = [self createAVCaptureDevice:AVCaptureDevicePositionFront];
    }
    return _captureDevice;
}

// 创建AVCaptureDevice
- (AVCaptureDevice *)createAVCaptureDevice:(AVCaptureDevicePosition)position {
    
    if (@available(iOS 10.0, *)) {
        return  [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionFront];
    } else {
        NSString *str = @"Front";
        if (position == AVCaptureDevicePositionBack) {
            str = @"Back";
        }
       NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
       for (AVCaptureDevice *device in devices) {
           if ([device.localizedName containsString:str]) {
               return device;
               break;
           }
       }
    }
    return nil;
}

- (BOOL)isDeviceSupport {
    return self.captureDevice != nil;
}

/// 视频连接
- (AVCaptureConnection *)videoConnection {
    _videoConnection = [self.captureMovieFileOutput connectionWithMediaType:AVMediaTypeVideo];
    if ([_videoConnection isVideoStabilizationSupported ]) {   _videoConnection.preferredVideoStabilizationMode=AVCaptureVideoStabilizationModeAuto;
    }
    return _videoConnection;
}
@end
