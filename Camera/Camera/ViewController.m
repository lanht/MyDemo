//
//  ViewController.m
//  Camera
//
//  Created by cp316 on 16/12/14.
//  Copyright © 2016年 gzfns. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "CameraViewController.h"


@interface ViewController ()<UIScrollViewDelegate>

@property(strong ,nonatomic) AVCaptureSession *session;
@property(strong ,nonatomic) AVCaptureDeviceInput *deviceInput;
@property(strong ,nonatomic) AVCaptureStillImageOutput *imageOutput;
@property(strong ,nonatomic) AVCaptureVideoPreviewLayer *previewLayer;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *sessionLayerView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *reShotBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setUpCaptureSession];
    self.scrollView.minimumZoomScale = 1.f;
    self.scrollView.maximumZoomScale = 2.f;
    
    self.reShotBtn.hidden = YES;
    self.nextBtn.hidden = YES;
    self.sessionLayerView.hidden = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CameraViewController *cameraVc = [[CameraViewController alloc]init];
    [self.navigationController pushViewController:cameraVc animated:YES];
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

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)setUpCaptureSession {
    self.session = [[AVCaptureSession alloc]init];
    NSError *error;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    [device lockForConfiguration:nil];
    [device setFlashMode:AVCaptureFlashModeAuto];
    [device unlockForConfiguration];
    
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
    self.previewLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 164);
    self.previewLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.sessionLayerView.layer addSublayer:self.previewLayer];
    [self.view bringSubviewToFront:self.bottomView];
}

- (void)star {
    AVCaptureConnection *stillImageConnection = [self.imageOutput connectionWithMediaType:AVMediaTypeVideo];
//    UIDeviceOrientation curDeviceOrientation = [[UIDevice currentDevice] orientation];
//    AVCaptureVideoOrientation avcaptureOrientation = [self avOrientationForDeviceOrientation:curDeviceOrientation];
//    [stillImageConnection setVideoOrientation:avcaptureOrientation];
    [stillImageConnection setVideoScaleAndCropFactor:1];
    
    [self.imageOutput captureStillImageAsynchronouslyFromConnection:stillImageConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        NSData *jpegData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        CFDictionaryRef attachments = CMCopyDictionaryOfAttachments(kCFAllocatorDefault,imageDataSampleBuffer,kCMAttachmentMode_ShouldPropagate);
        
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied){
            //无权限
            return ;
        }
        UIImage *image = [UIImage imageWithData:jpegData];
        self.imageView.image = image;
        [self.view bringSubviewToFront:self.scrollView];
//        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//        [library writeImageDataToSavedPhotosAlbum:jpegData metadata:(__bridge id)attachments completionBlock:^(NSURL *assetURL, NSError *error) {
//            
//        }];
        if (self.session) {
            [self.session stopRunning];
        }
    }];

}

- (IBAction)entureBtnClick:(id)sender {
    [self star];
    self.reShotBtn.hidden = NO;
    self.nextBtn.hidden = NO;
}

- (IBAction)nextImage:(id)sender {
    if (self.session) {
        [self.session startRunning];
    }
    self.reShotBtn.hidden = YES;
    self.nextBtn.hidden = YES;
}

- (IBAction)reShot:(id)sender {
    if (self.session) {
        [self.session startRunning];
    }
    self.reShotBtn.hidden = YES;
    self.nextBtn.hidden = YES;
}


- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}
@end
