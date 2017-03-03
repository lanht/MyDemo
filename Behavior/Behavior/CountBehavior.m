//
//  CountBehavior.m
//  Behavior
//
//  Created by cp316 on 17/3/1.
//  Copyright © 2017年 lanht. All rights reserved.
//

#import "CountBehavior.h"
#import "DefTimer.h"

@interface CountBehavior ()

@property (copy ,nonatomic) NSString *originalName;

@end

@implementation CountBehavior

- (void)setEventBtn:(UIButton *)eventBtn {
    if (![eventBtn isKindOfClass:[UIButton class]]) {
        return;
    }
    _eventBtn = eventBtn;
    [_eventBtn addTarget:self action:@selector(eventBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)eventBtnClick:(UIButton *)btn {
    self.originalName = btn.titleLabel.text;
    [DefTimer timeCount:self.count owner:self progress:^(NSInteger count, DefTimer *timer) {
        [btn setTitle:[NSString stringWithFormat:@"还剩：%zd",count] forState:UIControlStateNormal];
        
    } complete:^(DefTimer *timer) {
        [btn setTitle:self.originalName forState:UIControlStateNormal];
        
    }];
}

@end
