//
//  KeyboardView.h
//  CustomKeyBoard
//
//  Created by cp316 on 17/3/2.
//  Copyright © 2017年 lanht. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyBoardCell.h"

@interface KeyboardView : UIView <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,KeyBoardCellDelegate,UIInputViewAudioFeedback>

{
    BOOL isUp;
}


@property (nonatomic,strong) UICollectionView * topView;

@property (nonatomic,strong) UICollectionView * middleView;

@property (nonatomic,strong) UICollectionView * bottomView;

@property (nonatomic,strong) UIView * inputSource;

@property (nonatomic,strong) UIButton * clearBtn;

@property (nonatomic,strong) UIButton * compeleteBtn;

@property (nonatomic,strong) NSMutableArray * modelArray;

@property (nonatomic,strong) NSArray * letterArray;

@end

