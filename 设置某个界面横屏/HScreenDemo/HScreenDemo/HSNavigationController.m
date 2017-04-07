//
//  HSNavigationController.m
//  HScreenDemo
//
//  Created by Lanht on 17/4/7.
//  Copyright © 2017年 gzfns. All rights reserved.
//

#import "HSNavigationController.h"

@interface HSNavigationController ()


@end

@implementation HSNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate {
    
    return self.topViewController.shouldAutorotate;
    
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {

    return self.topViewController.supportedInterfaceOrientations;;
}

@end
