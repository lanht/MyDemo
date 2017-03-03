//
//  CountBehavior.h
//  Behavior
//
//  Created by cp316 on 17/3/1.
//  Copyright © 2017年 lanht. All rights reserved.
//

#import "ControlBaseBehavior.h"
#import <UIKit/UIKit.h>

@interface CountBehavior : ControlBaseBehavior

@property (assign ,nonatomic) IBInspectable NSInteger count;

@property (weak ,nonatomic) IBOutlet UIButton *eventBtn;

@end
