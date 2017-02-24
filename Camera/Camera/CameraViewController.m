//
//  CameraViewController.m
//  Camera
//
//  Created by cp316 on 17/2/20.
//  Copyright © 2017年 gzfns. All rights reserved.
//

#import "CameraViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface CameraViewController ()<UINavigationControllerDelegate>

@property(strong ,nonatomic) AVCaptureSession *session;
@property(strong ,nonatomic) AVCaptureDeviceInput *deviceInput;
@property(strong ,nonatomic) AVCaptureStillImageOutput *imageOutput;
@property(strong ,nonatomic) AVCaptureVideoPreviewLayer *previewLayer;
@property(strong ,nonatomic) AVCaptureDevice *device;
@property(nonatomic, strong) UIImageView *focusView;       // 聚焦动画

@property (weak, nonatomic) IBOutlet UIView *sessionLayerView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *shotBtn;
@property (weak, nonatomic) IBOutlet UIButton *reShotBtn;
@property (weak, nonatomic) IBOutlet UIButton *okBtn;
@property (weak, nonatomic) IBOutlet UIButton *lightningBtn;
@property (weak, nonatomic) IBOutlet UIButton *cameraBtn;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.delegate = self;
    self.title = @"照片拍摄";
    [self setUpCaptureSession];
    [self setUpView];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.session) {
        [self.session startRunning];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (self.session) {
        [self.session stopRunning];
    }
}

//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//}
- (IBAction)shotBtnClick {
    [self star];
    
    self.shotBtn.hidden = YES;
    self.reShotBtn.hidden = NO;
    self.okBtn.hidden = NO;
}

- (IBAction)reShotBtnClick {
    if (self.session) {
        [self.session startRunning];
    }
    self.reShotBtn.hidden = YES;
    self.okBtn.hidden = YES;
    self.shotBtn.hidden = NO;
}

- (IBAction)okBtnClick {
    if (self.session) {
        [self.session startRunning];
    }
    self.reShotBtn.hidden = YES;
    self.okBtn.hidden = YES;
    self.shotBtn.hidden = NO;
    
    NSLog(@"self.selectIndex = %zd",self.selectIndex);
    if (_cameraCallBack) {
        self.cameraCallBack(self.imageView.image,self.selectIndex);
        self.imageView.image = nil;
    }
    self.selectIndex += 1;
    if (self.selectIndex > self.totalCount - 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)lightningBtnClick {
     AVCaptureDevice *device = self.device;
    if ([device lockForConfiguration:nil]) {
        if ([device flashMode] == AVCaptureFlashModeOff) {
            device.flashMode = AVCaptureFlashModeOn;
        } else if ([device flashMode] == AVCaptureFlashModeOn) {
            device.flashMode = AVCaptureFlashModeOff;
        }
        [device unlockForConfiguration];
    }
}

- (IBAction)cameraBtnClick {
    [self switchCameras];
}

- (BOOL)canSwitchCameras {
    return [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count] > 1;
}

- (BOOL)switchCameras {
    if (![self canSwitchCameras]) {
        return NO;
    }
    NSError *error;
    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:&error];
    if (videoInput) {
        [self.session beginConfiguration];
        [self.session removeInput:self.deviceInput];
        if ([self.session canAddInput:videoInput]) {
            [self.session addInput:videoInput];
            self.deviceInput = videoInput;
            
        }
        else {
            [self.session addInput:self.deviceInput];
        }
        [self.session commitConfiguration];
        
        //转换摄像头后重新设置视频输出
        [self resetVideoOutput];
    } else {
        return NO;
    }
    if ([self.device hasMediaType:AVMediaTypeVideo]) {
        AVCaptureDevicePosition *position = self.device.position;
        
    }
    return YES;
}

- (void)resetVideoOutput {
    
}

#pragma mark - 聚焦
- (IBAction)tap:(UITapGestureRecognizer *)recognizer {
    AVCaptureDevice *device = [self.session.inputs.lastObject device];
    CGPoint touchPoint = [recognizer locationInView:self.sessionLayerView];
    [self runFocusAnimation:self.focusView point:touchPoint];
    
    CGPoint focusPoint = [self captureDevicePointForPoint:touchPoint];
    if ([device lockForConfiguration:nil]) {
//        CGPoint pointOfInterest = [self pointOfInterestWithTouchPoint:touchPoint];
        device.focusPointOfInterest = focusPoint;
        device.focusMode = AVCaptureFocusModeAutoFocus;
        [device unlockForConfiguration];
    }
}

// 聚焦、曝光动画
-(void)runFocusAnimation:(UIView *)view point:(CGPoint)point{
    view.center = point;
    view.hidden = NO;
    [UIView animateWithDuration:0.15f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        view.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1.0);
    } completion:^(BOOL complete) {
        double delayInSeconds = 0.5f;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            view.hidden = YES;
            view.transform = CGAffineTransformIdentity;
        });
    }];
}

// 将屏幕坐标系的点转换为摄像头坐标系的点
- (CGPoint)captureDevicePointForPoint:(CGPoint)point {
    AVCaptureVideoPreviewLayer *layer = (AVCaptureVideoPreviewLayer *)self.previewLayer;
    return [layer captureDevicePointOfInterestForPoint:point];
}

- (void)star {
    AVCaptureConnection *stillImageConnection = [self.imageOutput connectionWithMediaType:AVMediaTypeVideo];
    [stillImageConnection setVideoScaleAndCropFactor:1];
    
    [self.imageOutput captureStillImageAsynchronouslyFromConnection:stillImageConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        NSData *jpegData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        UIImage *image = [UIImage imageWithData:jpegData];
        self.imageView.image = image;
        if (self.session) {
            [self.session stopRunning];
        }
    }];
}

- (void)setUpView {
    self.imageView.hidden = YES;
    self.reShotBtn.hidden = YES;
    self.okBtn.hidden = YES;
    
    self.reShotBtn.layer.cornerRadius = self.reShotBtn.bounds.size.width / 2.;
    self.reShotBtn.clipsToBounds = YES;
    self.okBtn.layer.cornerRadius = self.okBtn.bounds.size.width / 2.;
    self.okBtn.clipsToBounds = YES;
    
    [self.sessionLayerView addSubview:self.focusView];
}

- (void)setUpCaptureSession {
    //会话
    self.session = [[AVCaptureSession alloc]init];
    
    //设备
    NSError *error;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    [device lockForConfiguration:nil];
    [device setFlashMode:AVCaptureFlashModeOff];
    //自动白平衡
    if ([device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance]) {
        [device setWhiteBalanceMode:AVCaptureWhiteBalanceModeAutoWhiteBalance];
    }
    [device unlockForConfiguration];
    self.device = device;
    
    self.deviceInput = [[AVCaptureDeviceInput alloc]initWithDevice:device error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    
    self.imageOutput = [[AVCaptureStillImageOutput alloc]init];
    NSDictionary * outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey, nil];
    [self.imageOutput setOutputSettings:outputSettings];
    
    if ([self.session canAddInput:self.deviceInput]) {
        [self.session addInput:self.deviceInput];
    }
    if ([self.session canAddOutput:self.imageOutput]) {
        [self.session addOutput:self.imageOutput];
    }
    
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.session];
    [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    self.previewLayer.frame = [UIScreen mainScreen].bounds;
    self.previewLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.sessionLayerView.layer addSublayer:self.previewLayer];
    [self.sessionLayerView bringSubviewToFront:self.bottomView];
    [self.sessionLayerView bringSubviewToFront:self.lightningBtn];
    [self.sessionLayerView bringSubviewToFront:self.cameraBtn];
}

- (UIView *)focusView{
    if (_focusView == nil) {
        _focusView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 150, 150.0f)];
        _focusView.image = [UIImage imageNamed:@"focuseImage"];
        _focusView.hidden = YES;
    }
    return _focusView;
}

@end
