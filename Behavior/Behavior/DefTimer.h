//
//  DefTimer.h
//  Behavior
//
//  Created by cp316 on 17/3/1.
//  Copyright © 2017年 lanht. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DefTimer : NSObject

+ (void)timeCount:(NSInteger)count owner:(id)owner progress:(void(^)(NSInteger count, DefTimer * timer))progress complete:(void(^)(DefTimer * timer))complete;

@end
