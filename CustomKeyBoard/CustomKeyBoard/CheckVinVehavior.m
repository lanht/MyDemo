//
//  CheckVinVehavior.m
//  CustomKeyBoard
//
//  Created by cp316 on 17/3/2.
//  Copyright © 2017年 lanht. All rights reserved.
//

#import "CheckVinVehavior.h"

@implementation CheckVinVehavior

- (void)setVinTf:(UITextField *)vinTf {
    if (![vinTf isKindOfClass:[UITextField class]]) {
        return;
    }
    _vinTf = vinTf;
    [_vinTf addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)setReminderLabel:(UILabel *)reminderLabel {
    if (![reminderLabel isKindOfClass:[UILabel class]]) {
        return;
    }
    _reminderLabel = reminderLabel;
    _reminderLabel.text = [NSString stringWithFormat:@"已经输入%zd位,还剩%zd位",_vinTf.text.length,self.textLength - _vinTf.text.length];
}

- (void)textFieldChange:(UITextField *)textField {
    NSLog(@"%@",textField.text);
    if (textField.text.length >= self.textLength) {
        textField.text = [textField.text substringToIndex:self.textLength];
    }
    _reminderLabel.text = [NSString stringWithFormat:@"已经输入%zd位,还剩%zd位",textField.text.length,self.textLength - textField.text.length];
}
@end
