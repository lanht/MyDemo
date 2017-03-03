//
//  TextFieldBehaior.h
//  Behavior
//
//  Created by cp316 on 17/3/1.
//  Copyright © 2017年 lanht. All rights reserved.
//

#import "ControlBaseBehavior.h"

@interface TextFieldBehaior : ControlBaseBehavior

@property (assign ,nonatomic) IBInspectable NSInteger textLength;
@property (weak ,nonatomic) IBOutlet UITextField *textField;

@end
