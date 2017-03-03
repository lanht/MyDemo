//
//  ControlBehavior.h
//  Behavior
//
//  Created by cp316 on 17/3/1.
//  Copyright © 2017年 lanht. All rights reserved.
//

#import "ControlBaseBehavior.h"
#import <UIKit/UIKit.h>

@interface PickerImageBehavior : ControlBaseBehavior

@property (weak ,nonatomic) IBOutlet UIViewController *delege;

@property (weak ,nonatomic) IBOutlet UIImageView *imageView;


@end
