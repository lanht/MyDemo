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


@interface ViewController ()<UICollectionViewDelegate ,UICollectionViewDataSource>

@property (strong ,nonatomic) NSMutableArray *images;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"拍摄列表";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CameraViewController *cameraVc = [[CameraViewController alloc]init];
    [self.navigationController pushViewController:cameraVc animated:YES];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (NSMutableArray *)images {
    if (_images) {
        _images = [[NSMutableArray alloc]init];
        
    }
    return _images;
}
@end
