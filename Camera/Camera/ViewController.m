//
//  ViewController.m
//  Camera
//
//  Created by cp316 on 16/12/14.
//  Copyright © 2016年 gzfns. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "CameraViewController.h"
#import "ImageCell.h"
#import "ImageM.h"

#define kScreen_Width [UIScreen mainScreen].bounds.size.width
@interface ViewController ()<UICollectionViewDelegate ,UICollectionViewDataSource>

@property (strong ,nonatomic) NSMutableArray *images;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

static NSString *const cellId = @"imageCell";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"拍摄列表";
    [self setUpUI];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    CameraViewController *cameraVc = [[CameraViewController alloc]init];
//    [self.navigationController pushViewController:cameraVc animated:YES];
//}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    ImageM *imageM = self.images[indexPath.row];
    NSLog(@"indexPath.row = %zd,imageM.image = %@",indexPath.row,imageM.image);
    cell.imageView.image = imageM.image;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CameraViewController *cameraVc = [[CameraViewController alloc]init];
    cameraVc.selectIndex = indexPath.row;
    cameraVc.totalCount = self.images.count;
    cameraVc.cameraCallBack = ^(UIImage *image, NSUInteger index){
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        ImageM *imageM = self.images[index];
        imageM.image = image;
        NSLog(@"self.images[index] = %@",self.images[index]);
        [collectionView reloadItemsAtIndexPaths:@[indexPath]];
        
    };
    [self.navigationController pushViewController:cameraVc animated:YES];

}

- (void)setUpUI {
    UICollectionViewFlowLayout *ly = [[UICollectionViewFlowLayout alloc]init];
    CGFloat borderInterval = 10;
    CGFloat hInterval = 10;
    CGFloat vInterval = 30;
    CGFloat itemW = kScreen_Width / 3 - 20;
    CGFloat itemH = 120;
    ly.scrollDirection = UICollectionViewScrollDirectionVertical;
    ly.sectionInset = UIEdgeInsetsMake(borderInterval, borderInterval, 0, borderInterval);
    ly.itemSize = CGSizeMake(itemW, itemH);
    ly.minimumLineSpacing = vInterval;
    ly.minimumInteritemSpacing = hInterval;
    [self.collectionView setCollectionViewLayout:ly];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ImageCell" bundle:nil] forCellWithReuseIdentifier:cellId];

}

- (NSMutableArray *)images {
    if (!_images) {
        _images = [[NSMutableArray alloc]init];
        for (int i = 0; i< 40; i++) {
            ImageM *imageM = [[ImageM alloc]init];
            imageM.index = i;
            [_images addObject:imageM];
        }
    }
    return _images;
}

@end
