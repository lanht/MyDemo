//
//  Peripheral.h
//  BluetoothDemo
//
//  Created by Lanht on 2020/11/18.
//  Copyright © 2020 gzfns. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Peripheral : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *uuid;

@end

NS_ASSUME_NONNULL_END
