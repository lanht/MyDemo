//
//  UIView+Number.h
//  CheeGu
//
//  Created by Lanht on 16/9/11.
//  Copyright © 2016年 gzfns. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Number)
- (void)setIconNumber:(NSString*)number color:(UIColor*)color;
- (void)setIconNumber:(NSString*)number color:(UIColor*)color notEqual:(NSString*)nev;
- (void)setIconCircleWithColor:(UIColor*)color size:(CGSize)size offset:(CGPoint)offset;
- (void)setIconNumber:(NSString*)number color:(UIColor*)color size:(CGSize)size offset:(CGPoint)offset;
- (void)clearIconNumber;

@end

@interface NumberBackgroundView : UIView

@property (nonatomic, assign) CGSize bgSize;
@property (nonatomic, strong) UIColor *bgColor;

- (instancetype)initWithSize:(CGSize)size andColor:(UIColor *)color;

@end
