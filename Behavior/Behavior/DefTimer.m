//
//  DefTimer.m
//  Behavior
//
//  Created by cp316 on 17/3/1.
//  Copyright © 2017年 lanht. All rights reserved.
//

#import "DefTimer.h"

@implementation DefTimer

+ (void)timeCount:(NSInteger)count owner:(id)owner progress:(void(^)(NSInteger count, DefTimer * timer))progress complete:(void(^)(DefTimer * timer))complete {
    DefTimer *deTimer = [[DefTimer alloc]init];
    __block NSInteger timeOut = count;
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), 1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        if (timeOut <= 0) {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                complete(deTimer);
            });
        } else {
            timeOut--;
            dispatch_async(dispatch_get_main_queue(), ^{
                progress(timeOut,deTimer);
            });
        }
    });
    dispatch_resume(timer);
}
@end
