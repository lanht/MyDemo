//
//  CheckVinVehavior.h
//  CustomKeyBoard
//
//  Created by cp316 on 17/3/2.
//  Copyright © 2017年 lanht. All rights reserved.
//

#import "ControlBaseBehavior.h"

@interface CheckVinVehavior : ControlBaseBehavior

@property (assign ,nonatomic) IBInspectable NSInteger textLength;

@property (weak ,nonatomic) IBOutlet UITextField *vinTf;

@property (weak ,nonatomic) IBOutlet UILabel *reminderLabel;

@end
