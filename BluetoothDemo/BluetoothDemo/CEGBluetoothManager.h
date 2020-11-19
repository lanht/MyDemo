//
//  CEGBluetoothManager.h
//  CheeGu
//
//  Created by Lanht on 2020/11/16.
//  Copyright © 2020 gzfns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@class CEGBluetoothManager;
@protocol CEGBluetoothManagerDeletate <NSObject>

- (void)bluetoothManager:(CEGBluetoothManager *)manager didUpdatePeripherals:(NSArray *)peripherals;

@end
@interface CEGBluetoothManager : NSObject

@property (nonatomic, weak) id<CEGBluetoothManagerDeletate> delegate;

+ (instancetype)shareInstance;

- (void)beginScan;
- (void)stopScan;

- (void)connectWithId:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
