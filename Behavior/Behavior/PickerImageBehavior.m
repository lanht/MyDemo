//
//  ControlBehavior.m
//  Behavior
//
//  Created by cp316 on 17/3/1.
//  Copyright © 2017年 lanht. All rights reserved.
//

#import "PickerImageBehavior.h"

@interface PickerImageBehavior ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation PickerImageBehavior

- (IBAction)imagePickerAction:(id)sender {
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertAction *shotAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self pickerWithSourceType:UIImagePickerControllerSourceTypeCamera];
        }];
        [sheet addAction:shotAction];
    }
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [sheet addAction:photoAction];
    [sheet addAction:cancleAction];
    [self.delege presentViewController:sheet animated:YES completion:nil];
}

- (void)pickerWithSourceType:(UIImagePickerControllerSourceType)type {
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = type;
    picker.allowsEditing = YES;
    picker.delegate = self;
    [self.delege presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];

    UIImage *image = picker.allowsEditing?info[UIImagePickerControllerEditedImage] :info[UIImagePickerControllerOriginalImage];
    NSURL *imageUrl = info[UIImagePickerControllerReferenceURL];
    if (imageUrl) {
        self.imageView.image = image;
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];

}

- (void)setImageView:(UIImageView *)imageView {
    _imageView = imageView;
    if ([imageView isKindOfClass:[UIButton class]]) {
        [(UIButton *)imageView addTarget:self action:@selector(imagePickerAction:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        _imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imagePickerAction:)];
        [_imageView addGestureRecognizer:tap];
    }
}

@end
