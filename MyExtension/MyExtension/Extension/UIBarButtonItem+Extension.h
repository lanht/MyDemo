//
//  UIBarButtonItem+Extension.h
//  CheeGu
//
//  Created by Lanht on 16/10/27.
//  Copyright © 2016年 gzfns. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (instancetype)itemWithImage:(NSString *)image title:(NSString *)title target:(id)target action:(SEL)action;
@end
