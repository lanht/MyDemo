//
//  UIView+ShowEmptyView.m
//  CheeGu
//
//  Created by wxh on 2016/10/27.
//  Copyright © 2016年 gzfns. All rights reserved.
//

#import "UIView+ShowEmptyView.h"
#define CEGViewTag 888

@implementation UIView (ShowEmptyView)

- (void)showWithTitle:(NSString *)title image:(UIImage *)image {
    UIView *view = [self viewWithTag:CEGViewTag];
    if (view) {
        [view removeFromSuperview];
    }
    UIView *showView = [[UIView alloc] initWithFrame:self.bounds];
//    showView.backgroundColor = [UIColor yellowColor];
    showView.tag = CEGViewTag;
    showView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imgV = [[UIImageView alloc] init];
    imgV.height = CEGRealValue(200);
    imgV.width = CEGRealValue(240);
    imgV.center = showView.center;
//    imgV.backgroundColor = [UIColor blueColor];
    if (image) {
        imgV.image = image;
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.numberOfLines = 0;
    [label sizeToFit];
    label.y = CGRectGetMaxY(imgV.frame) + 25;
    label.centerX = self.width * 0.5;
    
    [showView addSubview:imgV];
    [showView addSubview:label];
    [self addSubview:showView];
}

- (void)dismiss {
    for (UIView *view in self.subviews) {
        if (view.tag == CEGViewTag) {
            [view removeFromSuperview];
        }
    }
}

@end
