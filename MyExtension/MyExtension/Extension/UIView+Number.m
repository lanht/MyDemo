//
//  UIView+Number.m
//  CheeGu
//
//  Created by Lanht on 16/9/11.
//  Copyright © 2016年 gzfns. All rights reserved.
//

#import "UIView+Number.h"
#import "Masonry.h"

@implementation UIView (Number)

- (void)setIconNumber:(NSString *)number color:(UIColor *)color {
    if (!number || [number isEqualToString:@""]) {
        UIView *_coverView = [self viewWithTag:666];
        if (_coverView) {
            [_coverView removeFromSuperview];
        }
        return;
    }
    [self setIconNumber:number color:color size:CGSizeMake(13, 13) offset:CGPointMake(4, 4)];
}

- (void)setIconNumber:(NSString*)number color:(UIColor*)color notEqual:(NSString*)nev {
    if (!number || [number isEqualToString:@""] || [number isEqualToString:nev]) {
        UIView *_coverView = [self viewWithTag:666];
        if (_coverView) {
            [_coverView removeFromSuperview];
        }
        return;
    }
    [self setIconNumber:number color:color size:CGSizeMake(13, 13) offset:CGPointMake(4, 4)];
}

- (void)setIconNumber:(NSString*)number color:(UIColor*)color size:(CGSize)size offset:(CGPoint)offset {
    UIView *_coverView = nil;
    _coverView = [self viewWithTag:666];
    //计算宽度
    NSInteger nCount = [self positionWithNumber:number];
    if (nCount > 1) {
        size.width = size.width + (nCount-1) * (size.height-2) * 0.25f;
    }
    if (_coverView) {
        [_coverView removeFromSuperview];
    }
    
    _coverView = [[NumberBackgroundView alloc]initWithSize:size andColor:color];
    _coverView.backgroundColor = [UIColor clearColor];
    _coverView.tag = 666;
    _coverView.userInteractionEnabled = NO;
    [self addSubview:_coverView];
    
    UILabel *labelNumber = [[UILabel alloc]init];
    [_coverView addSubview:labelNumber];
    labelNumber.text = number;
    labelNumber.textAlignment = NSTextAlignmentCenter;
    labelNumber.textColor = [UIColor whiteColor];
    labelNumber.font = [UIFont boldSystemFontOfSize:10.f];
    labelNumber.backgroundColor = [UIColor clearColor];
    labelNumber.tag = 222;
    
    __weak UIView *weakSelf = self;
    [labelNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_coverView);
    }];
    
    [_coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(size);
        make.top.equalTo(weakSelf).with.offset(-offset.x);
        make.right.equalTo(weakSelf).with.offset(offset.y);
    }];
}

- (void)setIconCircleWithColor:(UIColor *)color size:(CGSize)size offset:(CGPoint)offset {
    UIView *_coverView = [self viewWithTag:666];
    if (_coverView) {
        [_coverView removeFromSuperview];
        _coverView = nil;
    }
    _coverView = [[UIView alloc]init];
    _coverView.tag = 666;
    [self addSubview:_coverView];
    _coverView.layer.cornerRadius = size.height / 2.f;
    _coverView.backgroundColor = color;
    
    __weak UIView *weakSelf = self;
    
    [_coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(size);
        make.top.equalTo(weakSelf).with.offset(-offset.x);
        make.right.equalTo(weakSelf).with.offset(offset.y);
    }];
    
}

- (void)clearIconNumber {
    if ([self viewWithTag:666]) {
        [[self viewWithTag:666] removeFromSuperview];
    }
}

- (NSInteger)positionWithNumber:(NSString*)number {
    NSInteger num = [number integerValue];
    if (num > 0 && num < 10) {
        return 1;
    }
    if (num > 10 && num < 100) {
        return 2;
    }
    if (num > 100 && num < 1000) {
        return 3;
    }
    return 0;
}

@end


//数字的背景
@implementation NumberBackgroundView

- (instancetype)initWithSize:(CGSize)size andColor:(UIColor *)color {
    self = [super init];
    if (self) {
        _bgSize = size;
        _bgColor = color;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    //圆形、椭圆行
    CGRect aRect= CGRectMake(0, 0, _bgSize.width, _bgSize.height);
    CGContextSetFillColorWithColor(context, _bgColor.CGColor);
    //    CGContextAddRect(context, rect); //矩形
    //    CGContextAddEllipseInRect(context, aRect); //椭圆
    CGContextFillEllipseInRect(context, aRect);
    CGContextStrokePath(context);
}

@end
