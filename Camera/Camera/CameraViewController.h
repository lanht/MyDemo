//
//  CameraViewController.h
//  Camera
//
//  Created by cp316 on 17/2/20.
//  Copyright © 2017年 gzfns. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CameraCallBack)(UIImage *image,NSUInteger index);

@interface CameraViewController : UIViewController

@property (copy ,nonatomic) CameraCallBack cameraCallBack;

@property (assign ,nonatomic) NSInteger selectIndex;

@property (assign ,nonatomic) NSInteger totalCount;

@property (strong ,nonatomic) NSMutableArray *imageMs;

@end
