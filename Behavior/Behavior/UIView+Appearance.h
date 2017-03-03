//
//  UIView+Appearance.h
//  Behavior
//
//  Created by cp316 on 17/3/1.
//  Copyright © 2017年 lanht. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Appearance)

@property (nonatomic, strong) IBInspectable UIColor *hr_BorderColor;

@property (nonatomic, assign) IBInspectable CGFloat hr_BorderWidth;

@property (nonatomic, assign) IBInspectable CGFloat hr_CornerRadius;

@property (nonatomic, strong) IBInspectable UIColor *hr_DisableColor;

@property (nonatomic, strong) IBInspectable UIColor *hr_EnabledColor;

+ (instancetype)loadNibView;

@end
