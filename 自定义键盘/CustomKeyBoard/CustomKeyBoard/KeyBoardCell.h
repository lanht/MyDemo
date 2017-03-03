//
//  KeyBoardCell.h
//  CustomKeyBoard
//
//  Created by cp316 on 17/3/2.
//  Copyright © 2017年 lanht. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyBoardModel.h"
#import "KeyButton.h"

@protocol KeyBoardCellDelegate <NSObject>

@optional
- (void)KeyBoardCellBtnClick:(NSInteger)Tag;

@end

@interface KeyBoardCell : UICollectionViewCell

@property (nonatomic,weak) id <KeyBoardCellDelegate> delegate;

@property (nonatomic,strong) KeyButton * keyboardBtn;

@property (nonatomic,strong) KeyBoardModel * model;

@property (weak ,nonatomic) UIImageView *imageView;

@end
