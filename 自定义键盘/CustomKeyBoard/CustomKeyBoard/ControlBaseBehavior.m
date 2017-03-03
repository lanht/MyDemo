//
//  ControlBaseBehavior.m
//  Behavior
//
//  Created by cp316 on 17/3/1.
//  Copyright © 2017年 lanht. All rights reserved.
//

#import "ControlBaseBehavior.h"
#import <objc/message.h>

@implementation ControlBaseBehavior

- (void)setOwner:(id)owner {
    if (_owner != owner ) {
        [self releaseLiftTimeFromObject:_owner];
        _owner = owner;
        [self bindLiftTimeToObject:_owner];
    }
}

- (void)bindLiftTimeToObject:(id)object {
    objc_setAssociatedObject(object, (__bridge void*)self, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)releaseLiftTimeFromObject:(id)object {
    objc_setAssociatedObject(object, (__bridge void*)self, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}


@end
