//
//  KeyButton.m
//  CustomKeyBoard
//
//  Created by cp316 on 17/3/2.
//  Copyright © 2017年 lanht. All rights reserved.
//

#import "KeyButton.h"

#define kFont [UIFont fontWithName:@"GurmukhiMN" size:22]

enum {
    PKNumberPadViewImageLeft = 0,
    PKNumberPadViewImageInner,
    PKNumberPadViewImageRight,
    PKNumberPadViewImageMax
};

@implementation KeyButton

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self addPopupToButton:self];

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [[[self subviews] objectAtIndex:1] removeFromSuperview];
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (void)addPopupToButton:(UIButton *)b {
    UIImageView *keyPop = nil;
    NSInteger tag = self.tag;
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 52, 60)];
    
    if (tag == 0 || tag == 10) {
        keyPop = [[UIImageView alloc] initWithImage:[self createiOS7KeytopImageWithKind:PKNumberPadViewImageRight]];
        keyPop.frame = CGRectMake(-16, -71, keyPop.frame.size.width, keyPop.frame.size.height);
    }
    else if (tag == 9 || tag == 19) {
        keyPop = [[UIImageView alloc] initWithImage:[self createiOS7KeytopImageWithKind:PKNumberPadViewImageLeft]];
        keyPop.frame = CGRectMake(-38, -71, keyPop.frame.size.width, keyPop.frame.size.height);
    }
    else {
        keyPop = [[UIImageView alloc] initWithImage:[self createiOS7KeytopImageWithKind:PKNumberPadViewImageInner]];
        keyPop.frame = CGRectMake(-27, -71, keyPop.frame.size.width, keyPop.frame.size.height);
    }
    
    [text setFont:[UIFont fontWithName:kFont.fontName size:44]];
    [text setTextAlignment:NSTextAlignmentCenter];
    [text setBackgroundColor:[UIColor clearColor]];
    [text setAdjustsFontSizeToFitWidth:YES];
    [text setText:b.titleLabel.text];
    
    keyPop.layer.shadowColor = [UIColor colorWithWhite:0.1 alpha:1.0].CGColor;
    keyPop.layer.shadowOffset = CGSizeMake(0, 2.0);
    keyPop.layer.shadowOpacity = 0.30;
    keyPop.layer.shadowRadius = 3.0;
    keyPop.clipsToBounds = NO;
    
    [keyPop addSubview:text];
    [b addSubview:keyPop];

}

#define __UPPER_WIDTH   (52.0 * [[UIScreen mainScreen] scale])
#define __LOWER_WIDTH   (30.0 * [[UIScreen mainScreen] scale])
//#define __LOWER_WIDTH  self.bounds.size.width - 6

#define __PAN_UPPER_RADIUS  (10.0 * [[UIScreen mainScreen] scale])
#define __PAN_LOWER_RADIUS  (5.0 * [[UIScreen mainScreen] scale])

#define __PAN_UPPDER_WIDTH   (__UPPER_WIDTH-__PAN_UPPER_RADIUS*2)
#define __PAN_UPPER_HEIGHT    (52.0 * [[UIScreen mainScreen] scale])

#define __PAN_LOWER_WIDTH     (__LOWER_WIDTH-__PAN_LOWER_RADIUS*2)
#define __PAN_LOWER_HEIGHT    (47.0 * [[UIScreen mainScreen] scale])

#define __PAN_UL_WIDTH        ((__UPPER_WIDTH-__LOWER_WIDTH)/2)

#define __PAN_MIDDLE_HEIGHT    (2.0 * [[UIScreen mainScreen] scale])

#define __PAN_CURVE_SIZE      (10.0 * [[UIScreen mainScreen] scale])

#define __PADDING_X     (16 * [[UIScreen mainScreen] scale])
#define __PADDING_Y     (15 * [[UIScreen mainScreen] scale])
#define __WIDTH   (__UPPER_WIDTH + __PADDING_X*2)
#define __HEIGHT   (__PAN_UPPER_HEIGHT + __PAN_MIDDLE_HEIGHT + __PAN_LOWER_HEIGHT + __PADDING_Y*2)


#define __OFFSET_X    -25 * [[UIScreen mainScreen] scale])
#define __OFFSET_Y    59 * [[UIScreen mainScreen] scale])


- (UIImage *)createiOS7KeytopImageWithKind:(int)kind {
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPoint p = CGPointMake(__PADDING_X, __PADDING_Y);
    CGPoint p1 = CGPointZero;
    CGPoint p2 = CGPointZero;
    
    p.x += __PAN_UPPER_RADIUS;
    CGPathMoveToPoint(path, NULL, p.x, p.y);
    
    p.x += __PAN_UPPDER_WIDTH;
    CGPathAddLineToPoint(path, NULL, p.x, p.y);
    
    p.y += __PAN_UPPER_RADIUS;
    CGPathAddArc(path, NULL,
                 p.x, p.y,
                 __PAN_UPPER_RADIUS,
                 3.0*M_PI/2.0,
                 4.0*M_PI/2.0,
                 false);
    
    p.x += __PAN_UPPER_RADIUS;
    p.y += __PAN_UPPER_HEIGHT - __PAN_UPPER_RADIUS - __PAN_CURVE_SIZE;
    CGPathAddLineToPoint(path, NULL, p.x, p.y);
    
    p1 = CGPointMake(p.x, p.y + __PAN_CURVE_SIZE);
    switch (kind) {
        case PKNumberPadViewImageLeft:
            p.x -= __PAN_UL_WIDTH*2;
            break;
            
        case PKNumberPadViewImageInner:
            p.x -= __PAN_UL_WIDTH;
            break;
            
        case PKNumberPadViewImageRight:
            break;
    }
    
    p.y += __PAN_MIDDLE_HEIGHT + __PAN_CURVE_SIZE*2;
    p2 = CGPointMake(p.x, p.y - __PAN_CURVE_SIZE);
    CGPathAddCurveToPoint(path, NULL,
                          p1.x, p1.y,
                          p2.x, p2.y,
                          p.x, p.y);
    
    p.y += __PAN_LOWER_HEIGHT - __PAN_CURVE_SIZE - __PAN_LOWER_RADIUS;
    CGPathAddLineToPoint(path, NULL, p.x, p.y);
    
    p.x -= __PAN_LOWER_RADIUS;
    CGPathAddArc(path, NULL,
                 p.x, p.y,
                 __PAN_LOWER_RADIUS,
                 4.0*M_PI/2.0,
                 1.0*M_PI/2.0,
                 false);
    
    p.x -= __PAN_LOWER_WIDTH;
    p.y += __PAN_LOWER_RADIUS;
    CGPathAddLineToPoint(path, NULL, p.x, p.y);
    
    p.y -= __PAN_LOWER_RADIUS;
    CGPathAddArc(path, NULL,
                 p.x, p.y,
                 __PAN_LOWER_RADIUS,
                 1.0*M_PI/2.0,
                 2.0*M_PI/2.0,
                 false);
    
    p.x -= __PAN_LOWER_RADIUS;
    p.y -= __PAN_LOWER_HEIGHT - __PAN_LOWER_RADIUS - __PAN_CURVE_SIZE;
    CGPathAddLineToPoint(path, NULL, p.x, p.y);
    
    p1 = CGPointMake(p.x, p.y - __PAN_CURVE_SIZE);
    
    switch (kind) {
        case PKNumberPadViewImageLeft:
            break;
            
        case PKNumberPadViewImageInner:
            p.x -= __PAN_UL_WIDTH;
            break;
            
        case PKNumberPadViewImageRight:
            p.x -= __PAN_UL_WIDTH*2;
            break;
    }
    
    p.y -= __PAN_MIDDLE_HEIGHT + __PAN_CURVE_SIZE*2;
    p2 = CGPointMake(p.x, p.y + __PAN_CURVE_SIZE);
    CGPathAddCurveToPoint(path, NULL,
                          p1.x, p1.y,
                          p2.x, p2.y,
                          p.x, p.y);
    
    p.y -= __PAN_UPPER_HEIGHT - __PAN_UPPER_RADIUS - __PAN_CURVE_SIZE;
    CGPathAddLineToPoint(path, NULL, p.x, p.y);
    
    p.x += __PAN_UPPER_RADIUS;
    CGPathAddArc(path, NULL,
                 p.x, p.y,
                 __PAN_UPPER_RADIUS,
                 2.0*M_PI/2.0,
                 3.0*M_PI/2.0,
                 false);
    //----
    CGContextRef context;
    UIGraphicsBeginImageContext(CGSizeMake(__WIDTH,
                                           __HEIGHT));
    context = UIGraphicsGetCurrentContext();
    
    switch (kind) {
        case PKNumberPadViewImageLeft:
            CGContextTranslateCTM(context, 6.0, __HEIGHT);
            break;
            
        case PKNumberPadViewImageInner:
            CGContextTranslateCTM(context, 0.0, __HEIGHT);
            break;
            
        case PKNumberPadViewImageRight:
            CGContextTranslateCTM(context, -6.0, __HEIGHT);
            break;
    }
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextAddPath(context, path);
    CGContextClip(context);
    
    //----
    
    CGRect frame = CGPathGetBoundingBox(path);
    CGContextSetFillColorWithColor(context, [[UIColor colorWithRed:0.973 green:0.976 blue:0.976 alpha:1.000] CGColor]);
    CGContextFillRect(context, frame);
    
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    
    UIImage * image = [UIImage imageWithCGImage:imageRef scale:[[UIScreen mainScreen] scale] orientation:UIImageOrientationDown];
    CGImageRelease(imageRef);
    
    UIGraphicsEndImageContext();
    
    
    CFRelease(path);
    
    return image;
}


@end
