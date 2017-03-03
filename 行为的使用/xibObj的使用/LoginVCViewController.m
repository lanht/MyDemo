//
//  LoginVCViewController.m
//  xibObj的使用
//
//  Created by ld on 16/9/14.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "LoginVCViewController.h"

@interface LoginVCViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTf;

@end

@implementation LoginVCViewController

- (IBAction)dismissSelf:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
