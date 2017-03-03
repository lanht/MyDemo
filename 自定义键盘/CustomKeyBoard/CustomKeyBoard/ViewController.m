//
//  ViewController.m
//  CustomKeyBoard
//
//  Created by cp316 on 17/3/2.
//  Copyright © 2017年 lanht. All rights reserved.
//

#import "ViewController.h"
#import "KeyboardView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputTf;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    KeyboardView *kbView = [[KeyboardView alloc]init];
    kbView.inputSource = self.inputTf;
    self.inputTf.inputView = kbView;
}

@end
