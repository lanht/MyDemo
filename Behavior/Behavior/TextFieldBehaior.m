//
//  TextFieldBehaior.m
//  Behavior
//
//  Created by cp316 on 17/3/1.
//  Copyright © 2017年 lanht. All rights reserved.
//

#import "TextFieldBehaior.h"

@interface TextFieldBehaior ()<UITextFieldDelegate>

@end

@implementation TextFieldBehaior

- (void)setTextField:(UITextField *)textField {
    if (![textField isKindOfClass:[UITextField class]]) {
        return;
    }
    _textField = textField;
    [_textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldChange:(UITextField *)textField {
    NSLog(@"%@",textField.text);
    if (textField.text.length >= self.textLength) {
        textField.text = [textField.text substringToIndex:self.textLength];
    }
}
@end
