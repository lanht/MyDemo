//
//  KeyboardView.m
//  CustomKeyBoard
//
//  Created by cp316 on 17/3/2.
//  Copyright © 2017年 lanht. All rights reserved.
//

#import "KeyboardView.h"
#import "KeyBoardModel.h"
#import "CustomFlowLayout.h"
#import <Masonry/Masonry.h>

#define SCREEN_WIDTH         [UIScreen mainScreen].bounds.size.width

#define BOARDRATIO           (224.0 / 275)           //键盘的高宽比
#define KEYRATIO             (86.0  / 63)            //按键的高宽比

#define KEYBOARD_HEIGHT      (SCREEN_WIDTH * BOARDRATIO)    //键盘的高

#define BTN_WIDTH            (SCREEN_WIDTH-6) / 10.0      //按键的宽
#define BTN_HEIGHT           (BTN_WIDTH * KEYRATIO)         //按键的高
//#define BTN_HEIGHT           50
#define ITEM_HEIGHT          (BTN_HEIGHT + 10)              //item的高

#define TOTAL_HEIGHT         (ITEM_HEIGHT * 4)

#define RGBAlpha(r, g, b, a) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

@implementation KeyboardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, TOTAL_HEIGHT);
        
        [self setData];
        [self setup];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView == self.topView) {
        return 2;
    }
    
    if (collectionView == self.middleView) {
        return 1;
    }
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.topView) {
        return 10;
    }
    
    if (collectionView == self.middleView) {
        return 9;
    }
    
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //重用cell
    KeyBoardCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([KeyBoardCell class]) forIndexPath:indexPath];
    
    NSInteger index = indexPath.section * 10 + indexPath.item ;
    if (collectionView == self.middleView) {
        index = 20 + indexPath.section * 10 + indexPath.item ;
    }
    else if (collectionView == self.bottomView) {
        index = 29 + indexPath.section * 10 + indexPath.item ;
    }
    cell.tag = index + 100;
    cell.keyboardBtn.tag = index;
    if (index == 10 || index == 17 || index == 18) {
        cell.keyboardBtn.enabled = NO;
        cell.imageView.image = [UIImage imageNamed:@"keyboard_unenble"];
    }
    
    cell.delegate = self;
    KeyBoardModel * model = (KeyBoardModel *)[self.modelArray objectAtIndex:index];
    KeyBoardModel * newmodel = [KeyBoardModel new];
    newmodel.key = model.key;
    newmodel.isUpper = isUp;
    
    cell.model = newmodel;
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@",NSStringFromCGSize(CGSizeMake(BTN_WIDTH , ITEM_HEIGHT)));
    return CGSizeMake(BTN_WIDTH , ITEM_HEIGHT);
}

#pragma mark - 设置每个UICollectionView最小垂直间距

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - 设置每个UICollectionView最小水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - UIInputViewAudioFeedback
//遵循这个协议，并实现这个方法才能播放键盘输入声音  [[UIDevice currentDevice] playInputClick];

- (BOOL) enableInputClicksWhenVisible {
    return YES;
}

#pragma mark - KeyBoardCellDelgate
- (void)KeyBoardCellBtnClick:(NSInteger)Tag {
    KeyBoardModel * model = (KeyBoardModel *)[self.modelArray objectAtIndex:Tag];
    if (!isUp && Tag > 9) {
        NSString * string = [model.key lowercaseString];
        [self inputString:string];
    }
    else {
        [self inputString:model.key];
    }
}

#pragma mark - Response Events
- (void)compeleteBtnClick:(UIButton *)sender {
//    sender.userInteractionEnabled = NO;
//    isUp = !isUp;
//    UIImage * image = isUp ? [UIImage imageNamed:@"up_a"] : [UIImage imageNamed:@"up_b"];
//    [sender setImage:image forState:UIControlStateNormal];
//    
//    [self.topView reloadData];
//    [self.middleView reloadData];
//    [self.bottomView reloadData];
//    sender.userInteractionEnabled = YES;
    [self.inputSource resignFirstResponder];
}

- (void)clearBtnClick:(UIButton *)sender {
    if (self.inputSource) {
        if ([self.inputSource isKindOfClass:[UITextField class]]) {
            UITextField *tmp = (UITextField *)self.inputSource;
            [tmp deleteBackward];
        }
        else if ([self.inputSource isKindOfClass:[UITextView class]]) {
            UITextView *tmp = (UITextView *)self.inputSource;
            [tmp deleteBackward];
        }
        else if ([self.inputSource isKindOfClass:[UISearchBar class]]) {
            UISearchBar *tmp = (UISearchBar *)self.inputSource;
            NSMutableString *info = [NSMutableString stringWithString:tmp.text];
            if (info.length > 0) {
                NSString *s = [info substringToIndex:info.length-1];
                [tmp setText:s];
            }
        }
    }
}

#pragma mark - Private Events
- (void)setData {
    isUp = YES;
    
    for (NSInteger i = 1 ; i < 10 ; i ++) {
        KeyBoardModel * model = [KeyBoardModel new];
        model.isUpper = YES;
        model.key = [NSString stringWithFormat:@"%ld",(long)i];
        [self.modelArray addObject:model];
    }
    
    KeyBoardModel * model = [KeyBoardModel new];
    model.isUpper = YES;
    model.key = @"0";
    [self.modelArray addObject:model];
    
    for (NSInteger i = 0 ; i < 26 ; i ++ ) {
        KeyBoardModel * model = [KeyBoardModel new];
        model.isUpper = YES;
        model.key = self.letterArray[i];
        
        [self.modelArray addObject:model];
    }
}

- (NSMutableArray *)modelArray {
    if (!_modelArray) {
        _modelArray = [NSMutableArray new];
    }
    return _modelArray;
}

- (NSArray *)letterArray {
    if (!_letterArray) {
        _letterArray = [NSArray arrayWithObjects:@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P",@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"Z",@"X",@"C",@"V",@"B",@"N",@"M", nil];
    }
    return _letterArray;
}

- (UIButton *)clearBtn {
    if (!_clearBtn) {
        _clearBtn = [UIButton new];
        [_clearBtn setBackgroundImage:[UIImage imageNamed:@"return_key"] forState:UIControlStateNormal];
        [_clearBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_clearBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _clearBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_clearBtn addTarget:self action:@selector(clearBtnClick:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:_clearBtn];
        [_clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-3);
            make.bottom.mas_equalTo(-5);
            make.size.mas_equalTo(CGSizeMake(BTN_HEIGHT, ITEM_HEIGHT - 10));
        }];
    }
    return _clearBtn;
}

- (UIButton *)compeleteBtn {
    if (!_compeleteBtn) {
        _compeleteBtn = [UIButton new];
        _compeleteBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_compeleteBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_compeleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_compeleteBtn setBackgroundImage:[UIImage imageNamed:@"return_key"] forState:UIControlStateNormal];
        [_compeleteBtn addTarget:self action:@selector(compeleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_compeleteBtn];
        [_compeleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(3);
            make.bottom.mas_equalTo(-5);
            make.size.mas_equalTo(CGSizeMake(BTN_HEIGHT, ITEM_HEIGHT - 10));
        }];
    }
    return _compeleteBtn;
}

- (void)setup {
    self.backgroundColor = RGBAlpha(254, 254, 254, .2);
    
    [self compeleteBtn];
    [self clearBtn];
    
    //topView
    UICollectionViewFlowLayout * topflowLayout = [[UICollectionViewFlowLayout alloc]init];
    //    topflowLayout.sectionInset = UIEdgeInsetsMake(0, 3, 0, 3);
    [topflowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.topView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , ITEM_HEIGHT * 2) collectionViewLayout:topflowLayout];
    [self addSubview:self.topView];
    self.topView.delegate = self;
    self.topView.dataSource = self;
    self.topView.backgroundColor = [UIColor clearColor];
    [self.topView registerClass:[KeyBoardCell class] forCellWithReuseIdentifier:NSStringFromClass([KeyBoardCell class])];
    
    
    //middleView
    UICollectionViewFlowLayout * middleflowLayout = [[UICollectionViewFlowLayout alloc]init];
    //    middleflowLayout.sectionInset = UIEdgeInsetsMake(0, 3, 0, 3);
    [middleflowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.middleView = [[UICollectionView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 20.0, ITEM_HEIGHT * 2, SCREEN_WIDTH / 10.0 * 9, ITEM_HEIGHT) collectionViewLayout:middleflowLayout];
    [self addSubview:self.middleView];
    self.middleView.delegate = self;
    self.middleView.dataSource = self;
    self.middleView.backgroundColor = [UIColor clearColor];
    [self.middleView registerClass:[KeyBoardCell class] forCellWithReuseIdentifier:NSStringFromClass([KeyBoardCell class])];
    
    //bottomView
    UICollectionViewFlowLayout * bottomflowLayout = [[UICollectionViewFlowLayout alloc]init];
    //    bottomflowLayout.sectionInset = UIEdgeInsetsMake(0, 3, 0, 3);
    [bottomflowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.bottomView = [[UICollectionView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 3.0 / 20.0, ITEM_HEIGHT * 3, SCREEN_WIDTH / 10.0 * 7.0, ITEM_HEIGHT) collectionViewLayout:bottomflowLayout];
    [self addSubview:self.bottomView];
    self.bottomView.delegate = self;
    self.bottomView.dataSource = self;
    self.bottomView.backgroundColor = [UIColor clearColor];
    [self.bottomView registerClass:[KeyBoardCell class] forCellWithReuseIdentifier:NSStringFromClass([KeyBoardCell class])];
    
    self.topView.clipsToBounds = NO;
    self.middleView.clipsToBounds = NO;
    self.bottomView.clipsToBounds = NO;
}

- (void)inputString:(NSString *)string {
    if (self.inputSource) {
        //UITextField
        if ([self.inputSource isKindOfClass:[UITextField class]]) {
            UITextField * tmp = (UITextField *)self.inputSource;
            if (tmp.delegate && [tmp.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
                NSRange range = NSMakeRange(tmp.text.length, 1);
                BOOL ret = [tmp.delegate textField:tmp shouldChangeCharactersInRange:range replacementString:string];
                if (ret) {
                    [tmp insertText:string];
                }
            }
            else {
                [tmp insertText:string];
            }
            
        }
        
        //UITextView
        else if ([self.inputSource isKindOfClass:[UITextView class]]) {
            UITextView * tmp = (UITextView *)self.inputSource;
            if (tmp.delegate && [tmp.delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
                NSRange range = NSMakeRange(tmp.text.length, 1);
                BOOL ret = [tmp.delegate textView:tmp shouldChangeTextInRange:range replacementText:string];
                if (ret) {
                    [tmp insertText:string];
                }
            }
            else {
                [tmp insertText:string];
            }
            
        }
        
        //UISearchBar
        else if ([self.inputSource isKindOfClass:[UISearchBar class]]) {
            UISearchBar *tmp = (UISearchBar *)self.inputSource;
            NSMutableString * info = [NSMutableString stringWithString:tmp.text];
            [info appendString:string];
            if (tmp.delegate && [tmp.delegate respondsToSelector:@selector(searchBar:shouldChangeTextInRange:replacementText:)]) {
                NSRange range = NSMakeRange(tmp.text.length, 1);
                BOOL ret = [tmp.delegate searchBar:tmp shouldChangeTextInRange:range replacementText:string];
                if (ret) {
                    [tmp setText:[info copy]];
                }
            }
            else {
                [tmp setText:[info copy]];
            }
        }
    }
}

@end
